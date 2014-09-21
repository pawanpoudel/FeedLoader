//
//  FeedBuilder.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import Foundation;
@class FeedDataManager;

/*!
    @description Construct Feed objects from JSON array.
    @note The format of the JSON is driven by the feed service.
    @see Feed
 */
@interface FeedBuilder : NSObject

/*!
    @description Sets the feed data manager that knows how to create,
                 update, delete and retrieve Feed objects.
    @param feedDataManager A FeedDataManager object.
 */
- (void)setFeedDataManager:(FeedDataManager *)feedDataManager;

/*!
    @description Given an array containing JSON dictionaries, returns a list
                 of Feed objects.
    @param JSON The deserialized JSON object in NSArray format.
    @return An array of Feed objects.
 */
- (NSArray *)feedsFromJSON:(NSArray *)JSON;

@end
