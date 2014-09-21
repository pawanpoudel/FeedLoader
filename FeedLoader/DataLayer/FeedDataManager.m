//
//  FeedDataManager.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FeedDataManager.h"
#import "CoreDataStack.h"

@interface FeedDataManager()

@property (nonatomic) CoreDataStack *coreDataStack;

@end

@implementation FeedDataManager

#pragma mark - Initializers

- (instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack {
    self = [super init];
    if (self) {
        _coreDataStack = coreDataStack;
    }
    
    return self;
}

#pragma mark - Managed object context

- (NSManagedObjectContext *)managedObjectContext {
    return self.coreDataStack.managedObjectContext;
}

#pragma mark - Save Data

- (void)saveData {
    NSError *error = nil;
    if ([self.coreDataStack save:&error] == NO) {
        NSLog(@"Error occurred while saving data: %@", error.localizedDescription);
    }
}

#pragma mark - Data operations

- (Feed *)newFeed {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Feed"
                                         inManagedObjectContext:[self managedObjectContext]];
}

- (BOOL)feedExistsWithSourceUrl:(NSString *)sourceUrl {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"DHCFeed"];
    request.predicate = [NSPredicate predicateWithFormat:@"sourceUrl like %@", sourceUrl];
    
    NSError *error = nil;
    NSArray *feedList = [[self managedObjectContext] executeFetchRequest:request
                                                                   error:&error];
    if (error) {
        NSLog(@"Error occurred while checking the existence of feeds with source url: %@",
              error.localizedDescription);
    }
    
    if ([feedList count] > 0) {
        return YES;
    }
    
    return NO;
}

@end
