//
//  FeedListTableDataSource.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import UIKit;
@import CoreData;

@protocol FeedListTableDataSource <UITableViewDataSource, UITableViewDelegate>

/*!
    @description Sets a fetched results controller that efficiently manages the
                 results returned from a Core Data fetch request to provide data
                 for the feed table view.
    @param controller A NSFetchedResultsController object.
 */
- (void)setFetchedResultsController:(NSFetchedResultsController *)controller;

@end
