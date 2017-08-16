//
//  UserModel.h
//  Demo_dynamic_section
//
//  Created by 赵学良 on 2017/7/7.
//  Copyright © 2017年 zhaoxueliang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HouseMode;

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userAge;

@property (nonatomic, strong) NSMutableArray<HouseMode*> *arrayHouse;

@end
