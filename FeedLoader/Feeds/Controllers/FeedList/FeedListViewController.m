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

@interface FeedListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (nonatomic) FeedManager *feedManager;

@end

@implementation FeedListViewController

#pragma mark - Accessors

- (id <FeedListTableDataSource>)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[FeedListTableDefaultDataSource alloc] init];
    }
    
    return _dataSource;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Feed List";
    
    self.feedTableView.dataSource = self.dataSource;
    self.feedTableView.delegate = self.dataSource;
    
    [self fetchFeeds];
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

#pragma mark - Fetch feeds

- (void)fetchFeeds {
    NSArray *feeds = [self.feedManager fetchFeeds];
    [self.dataSource setFeeds:feeds];
    [self.feedTableView reloadData];
}

#pragma mark - Feed manager delegate methods

- (void)feedManager:(FeedManager *)manager
    didReceiveFeeds:(NSArray *)feeds
{
    NSLog(@"Feed manager did receive %ld feeds", (long)[feeds count]);
    [self.dataSource addFeeds:feeds];
    [self insertFeedsIntoTableView:feeds];
}

- (void)insertFeedsIntoTableView:(NSArray *)feeds {
    if ([feeds count] > 0) {
        NSMutableArray *newRows = [NSMutableArray array];
        for (int i = 0; i < [feeds count]; i++) {
            [newRows addObject:[NSIndexPath indexPathForRow:i
                                                  inSection:0]];
        }
        
        [self.feedTableView insertRowsAtIndexPaths:newRows
                                  withRowAnimation:UITableViewRowAnimationTop];
    }
}

- (void)feedManager:(FeedManager *)manager
    failedToFetchFeedsWithError:(NSError *)error
{
    NSLog(@"Feed manager failed to retrieve feeds.");
    NSLog(@"Error domain: %@", error.domain);
    NSLog(@"Error code: %ld", (long)error.code);
    NSLog(@"Error userInfo: %@", [error userInfo]);
}

@end
