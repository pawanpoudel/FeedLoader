//
//  FeedDetailViewController.h
//  FeedLoader
//
//  Created by Pawan Poudel on 9/21/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#import "FeedDetailTableDataSource.h"

@import UIKit;

@interface FeedDetailViewController : UIViewController

@property (nonatomic) id <FeedDetailTableDataSource> dataSource;

@end
