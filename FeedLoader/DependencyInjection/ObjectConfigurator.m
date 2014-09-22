//
//  ObjectConfigurator.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "ObjectConfigurator.h"
#import "FeedManager.h"
#import "FileFeedFetcher.h"
#import "FeedBuilder.h"
#import "FeedDataManager.h"
#import "CoreDataStack.h"

@implementation ObjectConfigurator

+ (ObjectConfigurator *)sharedInstance {
    static ObjectConfigurator *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (FeedManager *)feedManager {
    FeedManager *feedManager = [[FeedManager alloc] init];
    [feedManager setFeedFetcher:[[FileFeedFetcher alloc] init]];
    [feedManager setFeedBuilder:[self feedBuilder]];
    
    return feedManager;
}

- (FeedBuilder *)feedBuilder {
    FeedBuilder *feedBuilder = [[FeedBuilder alloc] init];
    [feedBuilder setFeedDataManager:[self feedDataManager]];
    
    return feedBuilder;
}

- (FeedDataManager *)feedDataManager {
    return [[FeedDataManager alloc] initWithCoreDataStack:[self coreDataStack]];
}

- (CoreDataStack *)coreDataStack {
    static CoreDataStack *coreDataStack = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        coreDataStack = [[CoreDataStack alloc] init];
    });
    
    return coreDataStack;
}

@end
