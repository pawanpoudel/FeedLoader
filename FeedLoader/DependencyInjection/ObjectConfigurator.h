//
//  ObjectConfigurator.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import Foundation;
@class FeedManager;
@class FeedListViewController;

@interface ObjectConfigurator : NSObject

/**
    @description Returns a shared instance of ObjectConfigurator.
    @discussion Call this method instead of alloc, init if you need
                the same instance that was created before. For most
                use cases, you shouldn't have to create multiple
                instances of this class since we generally need only
                one object configurator for the entire app.
 */
+ (ObjectConfigurator *)sharedInstance;

/**
    @description A fully configured FeedManager object. The delegate
                 for this object is not set here. The delegate should
                 be set to the object that wishes to use feed manager.
 */
- (FeedManager *)feedManager;

/**
    @description A fully configured feed list view controller.
 */
- (FeedListViewController *)feedListViewController;

@end
