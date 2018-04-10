//
//  LYTableView.h
//  Demo_dynamic_section
//
//  Created by 赵学良 on 2017/7/8.
//  Copyright © 2017年 zhaoxueliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYTableViewDynamicSectionInfo;
@class LYTableViewDynamicPath;



@protocol LYTableViewDynamicDelegate<NSObject>

@required
// 配置动态分区的具体信息
- (NSMutableArray <LYTableViewDynamicSectionInfo*>*)optionsOfDynamicSectionInTableView;


/* 
 以下为UITableView原代理方法对应的带有动态信息的新方法，默认常用的几个代理方法，并未给全所有，如果有其他方法需要，可以自行添加
 ***考虑使用的方便性和关联性，在原方法中添加了dynamicPath属性***
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; // 总分区数不需要动态化
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section dynamicPath:(LYTableViewDynamicPath *)dynamicPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath dynamicPath:(LYTableViewDynamicPath *)dynamicPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath dynamicPath:(LYTableViewDynamicPath *)dynamicPath;

@optional
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section dynamicPath:(LYTableViewDynamicPath *)dynamicPath;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section dynamicPath:(LYTableViewDynamicPath *)dynamicPath;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section dynamicPath:(LYTableViewDynamicPath *)dynamicPath;
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section dynamicPath:(LYTableViewDynamicPath *)dynamicPath;



@end






@interface LYTableView : UITableView
@property (nonatomic, weak) id<LYTableViewDynamicDelegate> delegateDynamic;

@end










#pragma mark - model class
@interface LYTableViewDynamicPath : NSObject
@property (nonatomic, assign) NSInteger enumIndex;      // 动态分区所在枚举
@property (nonatomic, assign) NSInteger index;          // 分区在该动态区域的第几个

@end


@interface LYTableViewDynamicSectionInfo : NSObject
@property (nonatomic, assign) NSInteger indexOfEnum;    // 动态分区所在枚举
@property (nonatomic, assign) NSInteger length;         // 动态分区的长度

@end


@interface LYBaseModel : NSObject
@property (nonatomic, assign) NSUInteger modelType;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) id model;

@end


