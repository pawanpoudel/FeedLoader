//
//  FeedCache.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/28/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FeedCache.h"
#import "FeedDataManager.h"
#import "Feed.h"
#import "FeedBuilder.h"

@interface FeedCache ()

@property (nonatomic) FeedBuilder *feedBuilder;
@property (nonatomic) FeedDataManager *feedDataManager;

@end

@implementation FeedCache

- (NSArray *)cachedFeed {
    return [self.feedDataManager allFeedSortedByKey:@"publishedDate"
                                          ascending:NO];
}

- (NSArray *)addFeedToCacheFromJSON:(NSArray *)feedJSON {
    NSMutableArray *feeds = [NSMutableArray array];
    
    for (NSDictionary *feedDict in feedJSON) {
        if ([self feedExistsInDatabase:feedDict]) {
            continue;
        }
        
        Feed *feed = [self.feedDataManager newFeed];
        [self.feedBuilder fillInDetailsForFeed:feed
                                      fromJSON:feedDict];
        [feeds addObject:feed];
    }
    
    [self.feedDataManager saveData];
    [self sortFeedsByPublishedDate:feeds];
    
    return [feeds copy];
}

- (BOOL)feedExistsInDatabase:(NSDictionary *)feed {    
    return [self.feedDataManager feedExistsWithSourceUrl:feed[@"link"]];
}

- (void)sortFeedsByPublishedDate:(NSMutableArray *)feeds {
    [feeds sortUsingComparator:^NSComparisonResult(Feed *feed1, Feed *feed2) {
        // The minus sign here has the effect of reversing
        // order from ascending to descending.
        return -[feed1.publishedDate compare:feed2.publishedDate];
    }];
}
             
@end
