//
//  FeedDetailTableDefaultDataSource.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FeedDetailTableDefaultDataSource.h"
#import "FeedDetailCard.h"
#import "Feed.h"

@interface FeedDetailTableDefaultDataSource()

@property (nonatomic) Feed *feed;
@property (nonatomic) NSMutableDictionary *rowHeights;

@end

@implementation FeedDetailTableDefaultDataSource

#pragma mark - Accessors

- (NSMutableDictionary *)rowHeights {
    if (_rowHeights == nil) {
        _rowHeights = [NSMutableDictionary dictionary];
    }
    
    return _rowHeights;
}

#pragma mark - Compute height

- (NSString *)rowHeightsKeyForIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%ld%ld", (long)indexPath.section, (long)indexPath.row];
}

- (void)setHeight:(CGFloat)height
     forIndexPath:(NSIndexPath *)indexPath
{
    [self.rowHeights setObject:@(height)
                        forKey:[self rowHeightsKeyForIndexPath:indexPath]];
}

- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = [self.rowHeights objectForKey:[self rowHeightsKeyForIndexPath:indexPath]];
    return [height floatValue];
}

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self heightForIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSParameterAssert(indexPath.section == 0);
    NSParameterAssert(indexPath.row == 0);
    
    FeedDetailCard *cell = (FeedDetailCard *)[tableView dequeueReusableCellWithIdentifier:[FeedDetailCard reuseIdentifier]];
    if (cell == nil) {
        cell = [self loadFeedDetailCardFromNib];
        [cell setTableView:tableView];
    }
    
    [self configureCell:cell
            atIndexPath:indexPath];
    
    return cell;
}

- (FeedDetailCard *)loadFeedDetailCardFromNib {
    FeedDetailCard *feedDetailCard = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:[FeedDetailCard nibName]
                                                             owner:nil
                                                           options:nil];
    for (id currentObject in topLevelObjects) {
        if ([currentObject isKindOfClass:[FeedDetailCard class]]) {
            feedDetailCard = (FeedDetailCard *)currentObject;
            break;
        }
    }
    
    return feedDetailCard;
}

- (void)configureCell:(FeedDetailCard *)cell
          atIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setFeed:self.feed];
}

@end
