//
//  FeedListTableDataSource.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import UIKit;

@protocol FeedListTableDataSource <UITableViewDataSource, UITableViewDelegate>

/**
    @description Sets feed objects whose information will be used to
                 configure FeedCard views.
    @param feeds An array of Feed objects.
 */
- (void)setFeeds:(NSArray *)feeds;

@end
