//
//  FeedDataManager.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import Foundation;
@import CoreData;

@class CoreDataStack;
@class Feed;

@interface FeedDataManager : NSObject

/*!
    @description The managed object context used to fetch objects.
    @discussion Managed object context's primary responsibility is to
                manage a collection of managed objcts. Although the
                underlying managed object context can be accessed through
                this property, it is highly recommended to use other
                methods in this class for creating, updating and deleting
                data. This property exists so that @aNSFetchedResultsController
                objects can directly register to listen to change notification
                on this context and properly update their result set and
                section information.
 */
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

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

/**
    @description Returns every single feed in database.
 */
- (NSArray *)allFeed;

/**
    @description Returns all news feed stored in database sorted
                 by the specified key in specified order.
    @param key Name of the attribute to sort against.
    @param ascending Indicates whether the sorting should be
                     in ascending or descending order.
    @return An array of Feed objects.
 */
- (NSArray *)allFeedSortedByKey:(NSString *)key
                      ascending:(BOOL)ascending;

@end
