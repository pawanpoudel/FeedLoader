//
//  FileFeedFetcher.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FileFeedFetcher.h"

@implementation FileFeedFetcher

- (void)fetchFeedWithCompletionHandler:(void (^)(id JSON, NSError *error))handler {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"feeds"
                                                         ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData
                                                           options:0
                                                             error:&error];
    if (jsonObjects == nil) {
        NSLog(@"Unable to parse feeds JSON: %@", error.description);
        handler(nil, error);
    }
    else {
        handler(jsonObjects, nil);
    }
}

@end
