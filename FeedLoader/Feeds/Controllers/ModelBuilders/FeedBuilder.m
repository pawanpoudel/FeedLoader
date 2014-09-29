//
//  FeedBuilder.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FeedBuilder.h"
#import "Feed.h"

@implementation FeedBuilder

#pragma mark - Fill in feed detail

- (void)fillInDetailsForFeed:(Feed *)feed
                    fromJSON:(NSDictionary *)feedJSON
{
    feed.imageUrl = feedJSON[@"image_url"];
    feed.publishedDate = [self dateFromString:feedJSON[@"published_date"]];
    feed.summary = feedJSON[@"summary"];
    feed.title = feedJSON[@"title"];
    feed.sourceUrl = feedJSON[@"link"];
    feed.sourceDomainName = [self domainNameFromUrlString:feedJSON[@"link"]];
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
