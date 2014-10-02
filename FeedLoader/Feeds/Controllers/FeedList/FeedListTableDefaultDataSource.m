//
//  FeedListTableDataSource.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FeedListTableDefaultDataSource.h"
#import "FeedCard.h"

NSString *const FeedListTableDataSourceDidSelectCardNotification =
    @"FeedListTableDataSourceDidSelectCardNotification";

@interface FeedListTableDefaultDataSource ()

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSArray *feeds;

@end

@implementation FeedListTableDefaultDataSource

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.fetchedResultsController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    NSArray *sections = self.fetchedResultsController.sections;
    return [sections[section] numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 211.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedCard *cell = (FeedCard *)[tableView dequeueReusableCellWithIdentifier:[FeedCard reuseIdentifier]];
    if (cell == nil) {
        cell = [self loadFeedCardFromNib];
    }
    
    [self configureCell:cell
            atIndexPath:indexPath];
    
    return cell;
}

- (FeedCard *)loadFeedCardFromNib {
    FeedCard *feedCard = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:[FeedCard nibName]
                                                             owner:nil
                                                           options:nil];
    for (id currentObject in topLevelObjects) {
        if ([currentObject isKindOfClass:[FeedCard class]]) {
            feedCard = (FeedCard *)currentObject;
            break;
        }
    }
    
    return feedCard;
}

- (void)configureCell:(FeedCard *)cell
          atIndexPath:(NSIndexPath *)indexPath
{
    Feed *feed = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell setFeed:feed];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Feed *feed = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSNotification *notification = [NSNotification notificationWithName:FeedListTableDataSourceDidSelectCardNotification
                                                                 object:feed];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
