//
//  Feed.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/20/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "Feed.h"


@implementation Feed

@dynamic imageUrl;
@dynamic publishedDate;
@dynamic sourceDomainName;
@dynamic sourceUrl;
@dynamic summary;
@dynamic title;

#pragma mark - MDShareable protocol methods

- (NSString *)textToShare {
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleDisplayName = appInfo[@"CFBundleDisplayName"];
    return [NSString stringWithFormat:@"%@\n%@\n\nShared via %@", self.title, self.sourceUrl, bundleDisplayName];
}

@end
