//
//  FeedDetailCard.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FeedDetailCard.h"
#import "Feed.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FeedDetailTableDataSource.h"

static NSString *const kNibName = @"FeedDetailCard";
NSString *const FeedDetailCardDidSelectViewSourceNotification = @"FeedDetailCardDidSelectViewSourceNotification";

@interface FeedDetailCard() <UIWebViewDelegate>

@property (nonatomic) Feed *feed;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *publishedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceDomainNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *feedImageView;
@property (weak, nonatomic) IBOutlet UILabel *separator1Label;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *separator2Label;
@property (weak, nonatomic) IBOutlet UIWebView *summaryWebView;
@property (weak, nonatomic) IBOutlet UIButton *readFullArticleButton;
@property (weak, nonatomic) UITableView *tableView;

@end

@implementation FeedDetailCard

#pragma mark - Setup

+ (NSString *)reuseIdentifier {
    return kNibName;
}

+ (NSString *)nibName {
    return kNibName;
}

- (void)awakeFromNib {
    CGFloat initialHeight = [self heightBeforeSummaryWebViewHasRendered];
    [self tellDataSourceAboutHeight:initialHeight];
    [self addBordersToReadFullArticleButton];
    [self addBordersToContainerView];
}

- (void)addBordersToContainerView {
    self.containerView.layer.cornerRadius = 3.0f;
    self.containerView.layer.borderWidth = 0.5f;
    self.containerView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
}

- (void)addBordersToReadFullArticleButton {
    self.readFullArticleButton.layer.cornerRadius = 5.0f;
    self.readFullArticleButton.layer.borderWidth = 1.0f;
    
    UIColor *titleColor = [self.readFullArticleButton titleColorForState:UIControlStateNormal];
    self.readFullArticleButton.layer.borderColor =  [titleColor CGColor];
}

#pragma mark - Setting feed

- (void)setFeed:(Feed *)feed {
    _feed = feed;
    
    self.publishedDateLabel.text = [self publishedDateString];
    self.sourceDomainNameLabel.text = feed.sourceDomainName;
    self.titleLabel.text = feed.title;
    
    [self.feedImageView sd_setImageWithURL:[NSURL URLWithString:feed.imageUrl]
                          placeholderImage:[UIImage imageNamed:@"feedPlaceholderImage"]];
    
    [self.summaryWebView loadHTMLString:[self addMissingHtmlElementsToSummary:feed.summary]
                                baseURL:nil];
}

- (NSString *)addMissingHtmlElementsToSummary:(NSString *)summary {
    NSString *cssStylePath = [[NSBundle mainBundle] pathForResource:@"feedSummaryStyle"
                                                             ofType:@"css"];
    NSError *error = nil;
    NSString *cssStyle = [NSString stringWithContentsOfFile:cssStylePath
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
    if (error) {
        NSLog(@"Error reading feedSummaryStyle.css file content");
    }
    
    NSString *htmlStyling = summary;
    
    if (cssStyle) {
        htmlStyling = [NSString stringWithFormat:@"<html>"
                       "<style type=\"text/css\">"
                       "%@"
                       "</style>"
                       "<body>"
                       "<p>%@</p>"
                       "</body></html>", cssStyle, summary];
    }
    
    return htmlStyling;
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

- (IBAction)readFullArticleButtonTapped:(id)sender {
    NSNotification *notification = [NSNotification notificationWithName:FeedDetailCardDidSelectViewSourceNotification
                                                                 object:self.feed];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

#pragma mark - UIWebView delegate methods

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    
    // Ask web view to calculate and return the size
    // that best fits its subviews.
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    
    [self tellDataSourceAboutHeight:[self heightByAddingFinalSummaryWebViewHeight:fittingSize.height]];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

#pragma mark - Compute height

- (CGFloat)heightWithoutSummaryWebView {
    // White space between container view's subviews
    CGFloat whiteSpaceBetweenSubviews = 57.0f;
    
    CGFloat height =
    self.publishedDateLabel.frame.size.height +
    self.titleLabel.frame.size.height +
    self.feedImageView.frame.size.height +
    self.separator1Label.frame.size.height +
    self.shareButton.frame.size.height +
    self.separator2Label.frame.size.height +
    self.readFullArticleButton.frame.size.height +
    whiteSpaceBetweenSubviews;
    
    return height;
}

- (CGFloat)heightBeforeSummaryWebViewHasRendered {
    CGSize approximateSummaryWebViewSize = [self.feed.summary sizeWithFont:[UIFont fontWithName:@"Helvetica-Neue" size:13.0f]
                                                         constrainedToSize:CGSizeMake(self.summaryWebView.frame.size.width, MAXFLOAT)
                                                             lineBreakMode:NSLineBreakByWordWrapping];
    
    return [self heightWithoutSummaryWebView] + approximateSummaryWebViewSize.height;
}

- (CGFloat)heightByAddingFinalSummaryWebViewHeight:(CGFloat)finalSummaryWebViewHeight {
    return [self heightWithoutSummaryWebView] + finalSummaryWebViewHeight;
}

- (void)tellDataSourceAboutHeight:(CGFloat)height {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:self];
    id <FeedDetailTableDataSource> dataSource = (id <FeedDetailTableDataSource>)self.tableView.dataSource;
    
    if ([dataSource respondsToSelector:@selector(setHeight:forIndexPath:)]) {
        [dataSource setHeight:height
                 forIndexPath:indexPath];
    }
}

@end
