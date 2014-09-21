//
//  FeedDataManager.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import Foundation;

@class CoreDataStack;
@class Feed;

@interface FeedDataManager : NSObject

/**
    @description Creates and returns a new FeedDataManager object.
    @param coreDataStack An object that knows how to create full Core Data stack.
    @return A new DHCFeedDataManager object.
 */
- (instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack;

/**
    @description Save all objects that are being managed.
 */
- (void)saveData;

/**
    @description Create a new Feed object.
    @return A new managed Feed object.
 */
- (Feed *)newFeed;

/**
    @description Checks the list of all existing Feed object to see 
                 if one exists with the specified source url.
    @param sourceUrl Source url string for the feed object in question.
    @return YES if a Feed object with specified source url exists in 
            the database, otherwise NO.
 */
- (BOOL)feedExistsWithSourceUrl:(NSString *)sourceUrl;

@end
