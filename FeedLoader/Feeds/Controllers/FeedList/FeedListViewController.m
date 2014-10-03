//
//  FeedListViewController.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FeedListViewController.h"
#import "FeedListTableDefaultDataSource.h"
#import "FeedManager.h"
#import "FeedDetailViewController.h"
#import "FeedDetailTableDefaultDataSource.h"
#import "FeedDataManager.h"
#import "ObjectConfigurator.h"

@interface FeedListViewController () <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (nonatomic) FeedManager *feedManager;
@property (nonatomic) FeedDataManager *feedDataManager;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation FeedListViewController

#pragma mark - Accessors

- (id <FeedListTableDataSource>)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[FeedListTableDefaultDataSource alloc] init];
        [_dataSource setFetchedResultsController:self.fetchedResultsController];
    }
    
    return _dataSource;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Feed List";
    
    self.feedTableView.dataSource = self.dataSource;
    self.feedTableView.delegate = self.dataSource;
    
    [self.feedManager fetchFeeds];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didSelectFeedNotification:)
                                                 name:FeedListTableDataSourceDidSelectCardNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:FeedListTableDataSourceDidSelectCardNotification
                                                  object:nil];
}

#pragma mark - Notification handling

- (void)didSelectFeedNotification:(NSNotification *)notification {
    FeedDetailTableDefaultDataSource *detailTableDataSource = [[FeedDetailTableDefaultDataSource alloc] init];
    [detailTableDataSource setFeed:[notification object]];
    
    FeedDetailViewController *feedDetailViewController = [[FeedDetailViewController alloc] init];
    feedDetailViewController.dataSource = detailTableDataSource;
    
    [self.navigationController pushViewController:feedDetailViewController
                                         animated:YES];
}

#pragma mark - Feed manager delegate methods

- (void)feedManager:(FeedManager *)manager
    didReceiveFeeds:(NSArray *)feeds
{
    NSLog(@"Feed manager did receive %ld feeds", (long)[feeds count]);
}

- (void)feedManager:(FeedManager *)manager
    failedToFetchFeedsWithError:(NSError *)error
{
    NSLog(@"Feed manager failed to retrieve feeds.");
    NSLog(@"Error domain: %@", error.domain);
    NSLog(@"Error code: %ld", (long)error.code);
    NSLog(@"Error userInfo: %@", [error userInfo]);
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController == nil) {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Feed"];
        NSSortDescriptor *sortByPublishedDate = [[NSSortDescriptor alloc] initWithKey:@"publishedDate"
                                                                            ascending:NO];
        
        fetchRequest.sortDescriptors = @[sortByPublishedDate];
        fetchRequest.fetchBatchSize = 10;
        
        NSManagedObjectContext *context = self.feedDataManager.managedObjectContext;
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
        _fetchedResultsController.delegate = self;
    }
    
    return _fetchedResultsController;
}

#pragma mark - NSFetchedResultController delegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications,
    // so prepare the table view for updates.
    [self.feedTableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.feedTableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            if (newIndexPath == nil) {
                [tableView reloadRowsAtIndexPaths:@[indexPath]
                                 withRowAnimation:UITableViewRowAnimationNone];
            }
            else {
                [tableView deleteRowsAtIndexPaths:@[indexPath]
                                 withRowAnimation:UITableViewRowAnimationNone];
                [tableView insertRowsAtIndexPaths:@[indexPath]
                                 withRowAnimation:UITableViewRowAnimationNone];
            }
            
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            
            [tableView insertRowsAtIndexPaths:@[newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id )sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.feedTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                              withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.feedTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                              withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications,
    // so tell the table view to process all updates.
    [self.feedTableView endUpdates];
}

@end
