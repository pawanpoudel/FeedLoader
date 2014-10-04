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
@class FeedBuilder;

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
    @description Sets the feed builder object responsible for creating
                 Feed objects from JSON retrieved from feed service.
    @param feedBuilder A FeedBuilder object.
 */
- (void)setFeedBuilder:(FeedBuilder *)feedBuilder;

/**
    @description Initiates retrieval of feeds.
    @discussion This method fetches feeds asynchronously. You need to
                implement delegate methods in FeedManagerDelegate protocol
                to find out if the fetching was successful or not.
 */
- (void)fetchFeeds;

@end
