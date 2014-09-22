//
//  FeedDetailViewController.m
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FeedDetailViewController.h"
#import "Feed.h"
#import "FeedDetailCard.h"
#import "PBWebViewcontroller.h"

@interface FeedDetailViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FeedDetailViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
}

- (void)configureTableView {
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didSelectViewSource:)
                                                 name:FeedDetailCardDidSelectViewSourceNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:FeedDetailCardDidSelectViewSourceNotification
                                                  object:nil];
}

#pragma mark - Notification handling

- (void)didSelectViewSource:(NSNotification *)notification {
    Feed *feed = [notification object];
    PBWebViewController *webViewController = [[PBWebViewController alloc] init];
    webViewController.URL = [NSURL URLWithString:feed.sourceUrl];
    
    [self.navigationController pushViewController:webViewController
                                         animated:YES];
}

@end
