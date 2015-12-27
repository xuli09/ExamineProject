//
//  Path.h
//  iOS4.5AFNetWorking进行POST请求
//
//  Created by MS on 15-10-15.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#ifndef iOS4_5AFNetWorking__POST___Path_h
#define iOS4_5AFNetWorking__POST___Path_h

//服务器接口
#define SERVERPATH @"http://10.0.8.8/sns"
//登录接口
#define LOGINPATH (SERVERPATH@"/my/login.php")
//上传图片到指定分组
#define UPLOADPATH (SERVERPATH@"/my/upload_photo.php")
//下载相册名称
#define ALBUMPATH (SERVERPATH@"/my/album_list.php")


#endif
