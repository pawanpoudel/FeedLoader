//
//  FeedListTableDataSource.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import UIKit;
#import "FeedListTableDataSource.h"

/**
    @description This notification is posted when a row in feeds
                 table is tapped. It will pass the Feed object
                 associated with the row inside the notification.
 */
extern NSString *const FeedListTableDataSourceDidSelectCardNotification;

@interface FeedListTableDefaultDataSource : NSObject <FeedListTableDataSource>

@end
