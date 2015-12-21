//
//  XLGKPictureCell.h
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/18.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLGKPictureCell : UITableViewCell
//显示图文的图片
@property (strong, nonatomic) IBOutlet UIImageView *pictureImageView;
//显示图文的标题
@property (strong, nonatomic) IBOutlet UILabel *pictureTitleLabel;
//显示图文的详细描述
@property (strong, nonatomic) IBOutlet UILabel *pictureDetailLabel;
//显示图文的发表时间
@property (strong, nonatomic) IBOutlet UILabel *pictureTime;

@end
