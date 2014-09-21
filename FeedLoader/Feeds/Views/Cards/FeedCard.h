//
//  FeedCard.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import UIKit;
@class Feed;

@interface FeedCard : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (NSString *)nibName;

- (void)setFeed:(Feed *)feed;

@end
