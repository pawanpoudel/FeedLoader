//
//  CoreDataStack.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/20/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import UIKit;
#import "CoreDataStack.h"

static NSString * const kPersistentStoreFileName = @"FeedLoader.sqlite";

@interface CoreDataStack() <UIAlertViewDelegate>

@property (nonatomic) NSManagedObjectModel *managedObjectModel;
@property (nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CoreDataStack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Save context

- (BOOL)save:(NSError **)error {
    return [self.managedObjectContext save:error];
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext == nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel == nil) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FeedLoader"
                                                  withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator == nil) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        NSError *error = nil;
        
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                       configuration:nil
                                                                 URL:[self persistentStoreURL]
                                                             options:[self autoMigrateOptions]
                                                               error:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showFatalAlert];
            });
        }
    }
    return _persistentStoreCoordinator;
}

- (NSDictionary *)autoMigrateOptions {
    return @{ NSMigratePersistentStoresAutomaticallyOption: @YES,
              NSInferMappingModelAutomaticallyOption: @YES };
}

- (void)showFatalAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"A fatal error occurred"
                                                    message:@"This app will quit when you tap OK. Please re-launch the app."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - UIAlertView delegate methods

- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex
{
    abort();
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory {
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                           inDomains:NSUserDomainMask];
    return [urls lastObject];
}

- (NSURL *)persistentStoreURL {
    return [self.applicationDocumentsDirectory URLByAppendingPathComponent:kPersistentStoreFileName];
}

@end
