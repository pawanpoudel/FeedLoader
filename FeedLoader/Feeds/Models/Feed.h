//
//  Feed.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/20/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Feed : NSManagedObject

@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSDate * publishedDate;
@property (nonatomic, retain) NSString * sourceDomainName;
@property (nonatomic, retain) NSString * sourceUrl;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * title;

@end
