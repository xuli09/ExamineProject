//
//  XLGKLoadViewController.h
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/25.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLGKLoadViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
- (IBAction)start:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)resume:(id)sender;

@property (nonatomic,copy) NSString * imagePath;

@end
