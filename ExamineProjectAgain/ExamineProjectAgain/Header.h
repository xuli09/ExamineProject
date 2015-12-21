//
//  Header.h
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/21.
//  Copyright © 2015年 xuli. All rights reserved.
//

#ifndef Header_h
#define Header_h

//商品页接口
#define GOODSPATH @"http://api.guoku.com/mobile/v4/selection/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&count=30&rcat=0&sign=b65e2e01c27a4c5d8eaf872d87fe3995&timestamp=1450167649.621674"
//图文页接口
#define PICTUREPATH @"http://api.guoku.com/mobile/v4/articles/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&page=1&sign=6952ddea075ba4e27f3ba809d80430ad&size=20&timestamp=1450168570.667858"

//图文详情页
#define PICTUREDETAILPATH @"http://m.guoku.com/articles/1296/"

//搜索页接口
#define SEARCHPATH @"http://api.guoku.com/mobile/v4/discover/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&sign=b6fbc461c473452b1fa344ae6d1af2c2"

//搜索页广告栏详情
#define ADDETAILPATH @"http://api.guoku.com/mobile/v4/entity/1571696/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&sign=b6fbc461c473452b1fa344ae6d1af2c2"

//居家列表 根据 第二页请求下来的推荐品类的id来拼接URL

#define RECOMMENDDETAILPATH @"http://api.guoku.com/mobile/v4/category/1/selection/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&page=1&sign=2a42c35005f57af37a930629b5e00aa5&sort=time"

//热门图文详情
#define HOTPICTUREDETAILPATH @"http://m.guoku.com/articles/1279/"


#endif /* Header_h */
