//
//  XLGKPictureCell.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/18.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKPictureCell.h"
#import "UIImageView+AFNetworking.h"

@implementation XLGKPictureCell

-(void)showInfoFromDic:(NSDictionary *)everyDic
{
    NSString * content = everyDic[@"content"];
    NSString * title = everyDic[@"title"];
    NSString * pic = [NSString stringWithFormat:@"http://imgcdn.guoku.com/%@",everyDic[@"cover"]];
    NSString * time = [NSString stringWithFormat:@"%@",everyDic[@"creator"][@"like_count"]];
    self.pictureTitleLabel.text = title;
    self.pictureDetailLabel.text = content;
    [self.pictureImageView setImageWithURL:[NSURL URLWithString:pic]];
    self.pictureTime.text = time;
    
    self.collectionLbl.text = NSLocalizedStringFromTable(@"Collection", @"InfoPList", @"ok");
    
}
@end
