//
//  DataBuilder.m
//  Demo_dynamic_section
//
//  Created by 赵学良 on 2017/7/8.
//  Copyright © 2017年 zhaoxueliang. All rights reserved.
//

#import "DataBuilder.h"
#import "UserModel.h"
#import "HouseMode.h"
#import "CityModel.h"


@implementation DataBuilder

/*
 动态setion、动态row工具解析
 
 Section : {
 ENUM____0
 ENUM____1
 ENUM____3 该枚举有 未知数量个分区
 ENUM____4
 ENUM____5
 ENUM____6 该枚举有 未知数量个分区
 ENUM____7
 ENUM____8
 }
 问题一：当前分区属于哪个枚举
 问题二：当前分区在该动态区域枚举下的第几个
 问题三：总分区数如何制定
 问题四：动态分区的indexPath使用，和普通分区的indexPath使用，如何区分
 
 
 
 Row 动态化 : 
 Row : {
 stype 1
 stype 4
 stype 2 未知个
 stype 1
 stype 4
 stype 1
 stype 3 未知个
 stype 2
 }
 
 问题一：当前row属于第几行
 问题二：当前row属于哪个cell
 问题三：如何属于动态row区域，当前row属于动态区域的第几个
 问题四：如何规划数据不同row的数据存储结构
 问题五：总cell数如何制定
 问题六：每个分区内的内容如何区分与关联

 
 ENUM____3 动态分区模块下
 重庆 section 1   
     张三
         房子1：两室一厅
         房子2：一室一厅    
     李四
         房子1：一室一厅
     王五             
         房子1：五室两厅    
         房子2：两室一厅    
         房子3：一室一厅
 
 北京 section 2
     张三
         房子1：两室一厅
         房子2：一室一厅
     李四
         房子1：一室一厅
     王五
         房子1：五室两厅
         房子2：两室一厅
         房子3：一室一厅
 */


+ (NSMutableArray *)simulatedDataArray{
    
    /* 模拟数据 */
    NSMutableArray *arrayDynamicSectionDataOne = [NSMutableArray array];
    
    [arrayDynamicSectionDataOne addObject:({
        CityModel *city1 = [CityModel new];
        city1.cityName = @"北京";
        NSMutableArray *arrayUser = [NSMutableArray array];
        UserModel *user1 = [UserModel new];
        user1.userName = @"张三";
        NSMutableArray *arrayHouse = [NSMutableArray array];
        HouseMode *house1 = [HouseMode new];
        house1.houseType = @"住宅";
        house1.roomType = @"两室一厅";
        HouseMode *house2 = [HouseMode new];
        house2.houseType = @"别墅";
        house2.roomType = @"五室三厅";
        [arrayHouse addObject:house1];
        [arrayHouse addObject:house2];
        user1.arrayHouse = arrayHouse;
        
        UserModel *user2 = [UserModel new];
        user2.userName = @"李四";
        NSMutableArray *arrayHouse2 = [NSMutableArray array];
        HouseMode *house11 = [HouseMode new];
        house11.houseType = @"平楼";
        house11.roomType = @"一室一厅";
        HouseMode *house22 = [HouseMode new];
        house22.houseType = @"学区楼";
        house22.roomType = @"三室一厅";
        [arrayHouse2 addObject:house11];
        [arrayHouse2 addObject:house22];
        user2.arrayHouse = arrayHouse;
        
        [arrayUser addObject:user1];
        [arrayUser addObject:user2];
        city1.arrayUsers = arrayUser;
        city1;
    })];
    
    [arrayDynamicSectionDataOne addObject:({
        CityModel *city2 = [CityModel new];
        city2.cityName = @"北京";
        NSMutableArray *arrayUser = [NSMutableArray array];
        UserModel *user1 = [UserModel new];
        user1.userName = @"王五";
        NSMutableArray *arrayHouse = [NSMutableArray array];
        HouseMode *house1 = [HouseMode new];
        house1.houseType = @"住宅";
        house1.roomType = @"两室一厅";
        HouseMode *house2 = [HouseMode new];
        house2.houseType = @"别墅";
        house2.roomType = @"五室三厅";
        [arrayHouse addObject:house1];
        [arrayHouse addObject:house2];
        user1.arrayHouse = arrayHouse;
        
        UserModel *user2 = [UserModel new];
        user2.userName = @"赵六";
        NSMutableArray *arrayHouse2 = [NSMutableArray array];
        HouseMode *house11 = [HouseMode new];
        house11.houseType = @"平楼";
        house11.roomType = @"一室一厅";
        HouseMode *house22 = [HouseMode new];
        house22.houseType = @"学区楼";
        house22.roomType = @"三室一厅";
        [arrayHouse2 addObject:house11];
        [arrayHouse2 addObject:house22];
        user2.arrayHouse = arrayHouse;
        
        [arrayUser addObject:user1];
        [arrayUser addObject:user2];
        city2.arrayUsers = arrayUser;
        city2;
    })];
    
    return arrayDynamicSectionDataOne;
}


@end
