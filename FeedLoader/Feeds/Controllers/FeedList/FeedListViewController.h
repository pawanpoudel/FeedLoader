//
//  FeedListViewController.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FeedListTableDataSource.h"
#import "FeedManagerDelegate.h"

@import UIKit;
@class FeedManager;
@class FeedDataManager;

@interface FeedListViewController : UIViewController <FeedManagerDelegate>

/**
    @description A data source object that creates table view
                 cells and configures them with feed data. This
                 data source also acts as a delegate for the table
                 view.
 */
@property (nonatomic) id <FeedListTableDataSource> dataSource;

/**
    @description An object that acts as a façade providing access 
                 to the Feed service.
    @param feedManager A FeedManager object.
 */
- (void)setFeedManager:(FeedManager *)feedManager;

/**
    @description Sets the feed data manager that knows how to create,
                 update, delete and retrieve Feed objects.
    @param feedDataManager A FeedDataManager object.
 */
- (void)setFeedDataManager:(FeedDataManager *)feedDataManager;

@end
