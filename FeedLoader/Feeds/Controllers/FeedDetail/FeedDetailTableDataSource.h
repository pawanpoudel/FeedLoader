//
//  FeedDetailTableDataSource.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import UIKit;
@class Feed;

@protocol FeedDetailTableDataSource <UITableViewDataSource, UITableViewDelegate>

/**
    @description Sets the feed object whose detail needs to be displayed.
    @param feed A Feed object.
 */
- (void)setFeed:(Feed *)feed;

@optional

/**
    @description Sets the height to use for a row in a specified location.
    @param height A nonnegative floating-point value that specifies
                  the height (in points) that row should be.
    @param indexPath An index path locating a row in tableView.
 */
- (void)setHeight:(CGFloat)height
     forIndexPath:(NSIndexPath *)indexPath;

@end
