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

@property (nonatomic) NSArray *feeds;

@end

@implementation FeedListTableDefaultDataSource

#pragma mark - Modify feed list

- (void)addFeeds:(NSArray *)feeds {
    [self setFeeds:[self.feeds arrayByAddingObjectsFromArray:feeds]];
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return [self.feeds count];
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
    [cell setFeed:self.feeds[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Feed *feed = self.feeds[indexPath.row];
    NSNotification *notification = [NSNotification notificationWithName:FeedListTableDataSourceDidSelectCardNotification
                                                                 object:feed];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
