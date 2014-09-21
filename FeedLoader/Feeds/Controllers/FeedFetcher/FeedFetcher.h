//
//  FeedFetcher.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import Foundation;

@protocol FeedFetcher <NSObject>

- (void)fetchFeedWithCompletionHandler:(void(^)(id JSON, NSError *error))handler;

@end
