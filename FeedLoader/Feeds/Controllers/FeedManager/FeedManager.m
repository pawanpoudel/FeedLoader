//
//  FeedManager.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FeedManager.h"
#import "FeedBuilder.h"

@interface FeedManager()

@property (nonatomic) id<FeedFetcher> feedFetcher;
@property (nonatomic) FeedBuilder *feedBuilder;

@end

@implementation FeedManager

- (void)fetchFeeds {
    [self.feedFetcher fetchFeedWithCompletionHandler:^(id JSON, NSError *error) {
        if (error) {
            NSLog(@"Unable to fetch feeds.");
        }
        else {
            [self buildFeedsFromJSON:JSON];
        }
    }];
}

- (void)tellDelegateAboutError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(feedManager:failedToFetchFeedsWithError:)]) {
        [self.delegate feedManager:self failedToFetchFeedsWithError:error];
    }
}

- (void)buildFeedsFromJSON:(NSArray *)JSON {
    NSArray *newlyFetchedFeeds = [self.feedBuilder feedsFromJSON:JSON];
    
    if ([self.delegate respondsToSelector:@selector(feedManager:didReceiveFeeds:)]) {
        [self.delegate feedManager:self didReceiveFeeds:newlyFetchedFeeds];
    }
}

@end
