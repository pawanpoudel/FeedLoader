//
//  FeedBuilder.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FeedBuilder.h"
#import "FeedDataManager.h"
#import "Feed.h"

@interface FeedBuilder()

@property (nonatomic) FeedDataManager *feedDataManager;

@end

@implementation FeedBuilder

#pragma mark - Build feed objects

- (NSArray *)feedsFromJSON:(NSArray *)JSON {
    NSParameterAssert(JSON != nil);
    NSMutableArray *feedsArray = [NSMutableArray array];
    
    for (NSDictionary *feedDict in JSON) {
        if ([self feedExistsInDatabase:feedDict]) {
            continue;
        }
        
        Feed *feed = [self.feedDataManager newFeed];
        [self fillInDetailsForFeed:feed
                    fromDictionary:feedDict];
        
        [feedsArray addObject:feed];
    }
    
    [self.feedDataManager saveData];
    return [feedsArray copy];
}

- (BOOL)feedExistsInDatabase:(NSDictionary *)feed {
    if (feed[@"link"] == nil) {
        return NO;
    }
    
    return [self.feedDataManager feedExistsWithSourceUrl:feed[@"link"]];
}

- (void)fillInDetailsForFeed:(Feed *)feed
              fromDictionary:(NSDictionary *)feedDict
{
    feed.imageUrl = feedDict[@"image_url"];
    feed.publishedDate = [self dateFromString:feedDict[@"published_date"]];
    feed.summary = feedDict[@"summary"];
    feed.title = feedDict[@"title"];
    feed.sourceUrl = feedDict[@"link"];
    feed.sourceDomainName = [self domainNameFromUrlString:feedDict[@"link"]];
}

#pragma mark - Date formatting

- (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:gmt];
    
    return [formatter dateFromString:dateString];
}

#pragma mark - Source domain name formatting

- (NSString *)domainNameFromUrlString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *host = [self removeWWWFromHost:url.host];
    return [self removeDotComFromHost:host];
}

- (NSString *)removeWWWFromHost:(NSString *)host {
    NSRange range = [host rangeOfString:@"www."];
    
    if ((range.location != NSNotFound) && (range.location == 0)) {
        host = [host stringByReplacingOccurrencesOfString:@"www." withString:@""];
    }
    
    return host;
}

- (NSString *)removeDotComFromHost:(NSString *)host {
    NSString *dotCom = @".com";
    NSRange range = [host rangeOfString:dotCom];
    
    NSUInteger dotComLocation = host.length - dotCom.length;
    if ((range.location != NSNotFound) && (range.location == dotComLocation)) {
        host = [host stringByReplacingOccurrencesOfString:dotCom withString:@""];
    }
    
    return host;
}

@end
