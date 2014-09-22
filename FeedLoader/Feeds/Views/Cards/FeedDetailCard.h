//
//  FeedDetailCard.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import UIKit;
@class Feed;

extern NSString *const FeedDetailCardDidSelectViewSourceNotification;

@interface FeedDetailCard : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (NSString *)nibName;

- (void)setFeed:(Feed *)feed;
- (void)setTableView:(UITableView *)tableView;

@end
