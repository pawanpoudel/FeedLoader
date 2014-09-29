//
//  FeedManager.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//


#import "FeedManagerDelegate.h"
#import "FeedFetcher.h"

@import Foundation;
@class FeedCache;
@class FeedDataManager;

/**
    @description A façade providing access to the Feed service.
                 Application code should only use this class to
                 get at feed service innards.
 */
@interface FeedManager : NSObject

/**
    @description The delegate object to receive feed retrieval events.
    @see FeedManagerDelegate
 */
@property (nonatomic, weak) id <FeedManagerDelegate> delegate;

/**
    @description An object that knows how to fetch feed.
    @param feedFetcher An object that conforms to FeedFetcher protocol.
 */
- (void)setFeedFetcher:(id<FeedFetcher>)feedFetcher;

/**
    @description Sets the feed cache object responsible for adding
                 new feeds to the cache and retrieving them from
                 cache when asked.
    @param feedCache A FeedCache object.
 */
- (void)setFeedCache:(FeedCache *)feedCache;

/**
    @description Sets the feed data manager that knows how to create,
                 update, delete and retrieve Feed objects.
    @param feedDataManager A FeedDataManager object.
 */
- (void)setFeedDataManager:(FeedDataManager *)feedDataManager;

/**
    @description Initiates retrieval of feeds.
    @discussion This method returns immediately with feed objects
                that were cached previously. It then initiates the retrieval
                of feeds from an external source. Once the feeds have been
                retrieved from an external source, the delegate
                will be notified with the latest feeds.
    @return An array of cached Feed objects.
 */
- (NSArray *)fetchFeeds;

@end
