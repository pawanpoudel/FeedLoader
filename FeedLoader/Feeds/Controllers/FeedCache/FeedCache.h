//
//  FeedCache.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/28/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import Foundation;
@class FeedBuilder;
@class FeedDataManager;

@interface FeedCache : NSObject

/**
    @description Sets the builder object responsible for creating
                 Feed objects from JSON retrieved from the Feed
                 service.
    @param feedBuilder A FeedBuilder object.
 */
- (void)setFeedBuilder:(FeedBuilder *)feedBuilder;

/**
    @description Sets the feed data manager that knows how to create,
                 update, delete and retrieve Feed objects.
    @param feedDataManager A FeedDataManager object.
 */
- (void)setFeedDataManager:(FeedDataManager *)feedDataManager;

/**
    @description Returns all cached feed.
    @return An array of Feed objects.
 */
- (NSArray *)cachedFeed;

/**
    @description Adds feeds to the cache from JSON array.
    @discussion If a feed already exists in cache, it won't 
                be added again.
    @param feedJSON An array of feed dictionaries.
    @return An array of Feed objects.
 */
- (NSArray *)addFeedToCacheFromJSON:(NSArray *)feedJSON;

@end
