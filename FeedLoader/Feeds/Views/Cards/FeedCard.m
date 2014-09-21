//
//  FeedCard.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FeedCard.h"
#import "Feed.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kNibName = @"FeedCard";

@interface FeedCard()

@property (nonatomic) Feed *feed;
@property (weak, nonatomic) IBOutlet UILabel *publishedDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *sourceDomainNameButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *feedImageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation FeedCard

+ (NSString *)reuseIdentifier {
    return kNibName;
}

+ (NSString *)nibName {
    return kNibName;
}

- (void)awakeFromNib {
    [self addBordersToContainerView];
}

- (void)addBordersToContainerView {
    self.containerView.layer.cornerRadius = 3.0f;
    self.containerView.layer.borderWidth = 0.5f;
    self.containerView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
}

- (void)setFeed:(Feed *)feed {
    _feed = feed;
    
    self.publishedDateLabel.text = [self publishedDateString];
    [self.sourceDomainNameButton setTitle:feed.sourceDomainName
                                 forState:UIControlStateNormal];
    
    self.titleLabel.text = feed.title;
    [self.feedImageView sd_setImageWithURL:[NSURL URLWithString:feed.imageUrl]
                          placeholderImage:[UIImage imageNamed:@"feedPlaceholderImage"]];
}

- (NSString *)publishedDateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *dateString = nil;
    NSDate *publishedDate = self.feed.publishedDate;
    
    if ([self isDateToday:publishedDate]) {
        dateFormatter.dateFormat = @"h:mma";
        dateString = [[dateFormatter stringFromDate:publishedDate] stringByAppendingString:@" Today"];
    }
    else {
        dateFormatter.dateFormat = @"h:mma M/dd/yyyy";
        dateString = [dateFormatter stringFromDate:publishedDate];
    }
    
    return dateString;
}

- (BOOL)isDateToday:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *todayDatecomponents = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)
                                                        fromDate:[NSDate date]];
    
    NSDate *today = [calendar dateFromComponents:todayDatecomponents];
    NSDateComponents *publishedDateComponents = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)
                                                            fromDate:date];
    
    NSDate *otherDate = [calendar dateFromComponents:publishedDateComponents];
    
    if([today isEqualToDate:otherDate]) {
        return YES;
    }
    
    return NO;
}

@end
