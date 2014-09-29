//
//  FeedBuilder.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import Foundation;
@class Feed;

/**
    @description Fills in data for the specified feed object
                 from JSON dictionary.
    @note The format of the JSON is driven by the feed service.
    @see Feed
 */
@interface FeedBuilder : NSObject

/**
    @description Fills in data for the specified feed from the given
                 feed JSON.
    @param feed The Feed object whose data needs to be filled in.
    @param feedJSON The feed JSON from which the data will be read.
 */
- (void)fillInDetailsForFeed:(Feed *)feed
                    fromJSON:(NSDictionary *)feedJSON;

@end
