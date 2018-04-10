//
//  LYTableView.m
//  Demo_dynamic_section
//
//  Created by 赵学良 on 2017/7/8.
//  Copyright © 2017年 zhaoxueliang. All rights reserved.
//

#import "LYTableView.h"

@interface LYTableView ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@end


@implementation LYTableView

- (void)setDelegateDynamic:(id<LYTableViewDynamicDelegate>)delegateDynamic{
    _delegateDynamic = delegateDynamic;
    self.delegate = self;
    self.dataSource = self;
}

- (void)reloadData {
    [super reloadData];
}


#pragma mark - 分区动态化规则
// 返回对应的枚举分区
- (NSInteger)getMainSectionTypeWithSection:(NSInteger)section{
    NSInteger enumIndex = NSNotFound;
    NSMutableArray *sections = [_delegateDynamic optionsOfDynamicSectionInTableView];
    NSInteger allExceedCount = 0;
    for (LYTableViewDynamicSectionInfo *info in sections) {
        if (section < info.indexOfEnum + allExceedCount) {
            enumIndex = section - allExceedCount;
            allExceedCount += (info.length -1);
            break;
        } else if (section < info.indexOfEnum + info.length  + allExceedCount) {
            enumIndex = info.indexOfEnum;
            allExceedCount += (info.length -1);
            break;
        } else {
            allExceedCount += (info.length -1);
            continue;
        }
    }
    if (enumIndex == NSNotFound) {
        enumIndex = section - allExceedCount;
    }
    
    return enumIndex;
}

// 返回该分区在动态分区中的第几个
- (NSInteger)getIndexAtDynamicSectionWithSection:(NSInteger)section{
    NSInteger index = 0;
    NSMutableArray *sections = [_delegateDynamic optionsOfDynamicSectionInTableView];
    NSInteger allDynamicCount = 0;
    for (LYTableViewDynamicSectionInfo *info in sections) {
        if (info.indexOfEnum == [self getMainSectionTypeWithSection:section]) {
            index = section - info.indexOfEnum - allDynamicCount;
        }
        allDynamicCount += (info.length -1);
    }
    return index;
}

- (LYTableViewDynamicPath *)analysisDynamicSectionRuleWithSection:(NSInteger)section{
    if (![_delegateDynamic respondsToSelector:@selector(optionsOfDynamicSectionInTableView)])
        return nil;
    LYTableViewDynamicPath *dynamicInfo = [[LYTableViewDynamicPath alloc] init];
    dynamicInfo.enumIndex = [self getMainSectionTypeWithSection:section];
    dynamicInfo.index = [self getIndexAtDynamicSectionWithSection:section];
    return dynamicInfo;
}





#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([_delegateDynamic respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [_delegateDynamic numberOfSectionsInTableView:tableView];
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_delegateDynamic respondsToSelector:@selector(tableView:numberOfRowsInSection:dynamicPath:)]) {
        LYTableViewDynamicPath *dynamicInfo = [self analysisDynamicSectionRuleWithSection:section];
        return [_delegateDynamic tableView:tableView numberOfRowsInSection:section dynamicPath:dynamicInfo];
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegateDynamic respondsToSelector:@selector(tableView:cellForRowAtIndexPath:dynamicPath:)]) {
        LYTableViewDynamicPath *dynamicInfo = [self analysisDynamicSectionRuleWithSection:indexPath.section];
        return [_delegateDynamic tableView:tableView cellForRowAtIndexPath:indexPath dynamicPath:dynamicInfo];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegateDynamic respondsToSelector:@selector(tableView:heightForRowAtIndexPath:dynamicPath:)]) {
        LYTableViewDynamicPath *dynamicInfo = [self analysisDynamicSectionRuleWithSection:indexPath.section];
        return [_delegateDynamic tableView:tableView heightForRowAtIndexPath:indexPath dynamicPath:dynamicInfo];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([_delegateDynamic respondsToSelector:@selector(tableView:heightForHeaderInSection:dynamicPath:)]) {
        LYTableViewDynamicPath *dynamicInfo = [self analysisDynamicSectionRuleWithSection:section];
        return [_delegateDynamic tableView:tableView heightForHeaderInSection:section dynamicPath:dynamicInfo];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([_delegateDynamic respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        LYTableViewDynamicPath *dynamicInfo = [self analysisDynamicSectionRuleWithSection:section];
        return [_delegateDynamic tableView:tableView heightForFooterInSection:section dynamicPath:dynamicInfo];
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([_delegateDynamic respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        LYTableViewDynamicPath *dynamicInfo = [self analysisDynamicSectionRuleWithSection:section];
        return [_delegateDynamic tableView:tableView viewForHeaderInSection:section dynamicPath:dynamicInfo];
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([_delegateDynamic respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        LYTableViewDynamicPath *dynamicInfo = [self analysisDynamicSectionRuleWithSection:section];
        return [_delegateDynamic tableView:tableView viewForFooterInSection:section dynamicPath:dynamicInfo];
    }
    return nil;
}


@end





@implementation LYTableViewDynamicPath

@end


@implementation LYTableViewDynamicSectionInfo

@end

@implementation LYBaseModel

@end

