//
//  CoreDataStack.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/20/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface CoreDataStack : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

- (BOOL)save:(NSError **)error;

@end
