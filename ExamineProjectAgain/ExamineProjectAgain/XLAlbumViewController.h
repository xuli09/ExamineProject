//
//  XLAlbumViewController.h
//  iOS4.5AFNetWorking进行POST请求
//
//  Created by MS on 15-10-15.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLAlbumViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//UIImagePickerControllerDelegate,UINavigationControllerDelegate必须同时出现才能调用设备的相机功能(拍照、摄像、相册)


//接收token值
@property (nonatomic,copy) NSString * albumToken;

@end
