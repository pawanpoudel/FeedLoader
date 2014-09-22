//
//  ObjectConfigurator.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import Foundation;

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

@end
