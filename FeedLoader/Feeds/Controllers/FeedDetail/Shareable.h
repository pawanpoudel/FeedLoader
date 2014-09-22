//
//  Shareable.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

@import Foundation;

/**
 @description The Shareable protocol is used to provide information
              that needs sharing. To use this protocol, you can adopt 
              it in any custom objects and provide shareable text. 
              Objects that adopt this protocol are not required to implement
              the sharing functionality itself.
 */
@protocol Shareable <NSObject>

/**
    @description The string containing shareable text.
    @return A NSString object representing text that needs sharing.
 */
- (NSString *)textToShare;

@end
