//
//  CityModel.h
//  Demo_dynamic_section
//
//  Created by 赵学良 on 2017/7/7.
//  Copyright © 2017年 zhaoxueliang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;

@interface CityModel : NSObject

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, strong) NSMutableArray<UserModel *> *arrayUsers;

@end
