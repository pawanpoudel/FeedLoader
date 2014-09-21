//
//  FeedManagerDelegate.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import Foundation;
@class FeedManager;

/*!
    @description The delegate protocol for FeedManager class.
    @discussion FeedManager uses this delegate protocol to indicate
                when information becomes available, and to report any
                errors that might occur while retrieving the information.
 */
@protocol FeedManagerDelegate <NSObject>

@optional

/*!
    @description Indicates that FeedManager was unable to retrieve feeds
                 from remote server.
    @param manager A FeedManager object that initiated fetching of feeds.
    @param error Contains a pointer to an error object (if any) indicating
                 why FeedManager was unable to retrieve feed.
 */
- (void)feedManager:(FeedManager *)manager
    failedToFetchFeedsWithError:(NSError *)error;

/*!
    @description Indicates that FeedManager retrieved a list of feed from
                 remote server.
    @param manager A FeedManager object that initiated fetching of feeds.
    @param feeds An array of Feed objects.
 */
- (void)feedManager:(FeedManager *)manager
    didReceiveFeeds:(NSArray *)feeds;

@end
