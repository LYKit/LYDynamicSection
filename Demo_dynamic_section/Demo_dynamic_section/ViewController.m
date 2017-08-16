//
//  ViewController.m
//  Demo_dynamic_section
//
//  Created by 赵学良 on 2017/7/6.
//  Copyright © 2017年 zhaoxueliang. All rights reserved.
//

#import "ViewController.h"
#import "UserModel.h"
#import "HouseMode.h"
#import "CityModel.h"
#import "DataBuilder.h"
#import "LYTableView.h"

typedef NS_ENUM(NSUInteger, EnumDynamicSection) {
    EnumDynamicSection_1 = 0,
    EnumDynamicSection_2,   // 未知区域数量
    EnumDynamicSection_3,
    EnumDynamicSection_4,   // 未知区域数量
    EnumDynamicSection_5,
    EnumDynamicSection_6,   // 未知区域数量
};


@interface ViewController ()
<
    LYTableViewDynamicDelegate
>
@property (weak, nonatomic) IBOutlet LYTableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayDynamicSectionDataOne; // EnumDynamicSection_2
@property (nonatomic, strong) NSMutableArray *arrayDynamicSectionDataTwo; // EnumDynamicSection_4
@property (nonatomic, strong) NSMutableArray *arrayDynamicSectionDataThree; // EnumDynamicSection_6

@end

@implementation ViewController



#pragma mark - delegate

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegateDynamic = self;
    
    // 添加假数据
    self.arrayDynamicSectionDataOne = [NSMutableArray arrayWithObjects:@"分区1",@"分区2", nil];
    self.arrayDynamicSectionDataTwo = [NSMutableArray arrayWithObjects:@"分区1",@"分区2",@"分区3",@"分区4",@"分区5", nil];
    self.arrayDynamicSectionDataThree = [NSMutableArray arrayWithObjects:@"分区1",@"分区2", nil];
}


// 配置动态分区信息
- (NSMutableArray <LYTableViewDynamicSectionInfo*>*)optionsOfDynamicSectionInTableView
{
    NSMutableArray *arrayEnum = [NSMutableArray array];
    // 动态分区 区域一
    LYTableViewDynamicSectionInfo *enumInfo1 = [[LYTableViewDynamicSectionInfo alloc] init];
    enumInfo1.indexOfEnum = EnumDynamicSection_2;
    enumInfo1.length = self.arrayDynamicSectionDataOne.count;
    [arrayEnum addObject:enumInfo1];
    // 动态分区 区域二
    LYTableViewDynamicSectionInfo *enumInfo2 = [[LYTableViewDynamicSectionInfo alloc] init];
    enumInfo2.indexOfEnum = EnumDynamicSection_4;
    enumInfo2.length = self.arrayDynamicSectionDataTwo.count;
    [arrayEnum addObject:enumInfo2];
    // 动态分区 区域三
    LYTableViewDynamicSectionInfo *enumInfo3 = [[LYTableViewDynamicSectionInfo alloc] init];
    enumInfo3.indexOfEnum = EnumDynamicSection_6;
    enumInfo3.length = self.arrayDynamicSectionDataThree.count;
    [arrayEnum addObject:enumInfo3];
    
    return arrayEnum;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return EnumDynamicSection_6 + 1 + (self.arrayDynamicSectionDataOne.count-1) + (self.arrayDynamicSectionDataTwo.count-1) + (self.arrayDynamicSectionDataThree.count-1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section dynamicPath:(LYTableViewDynamicPath *)dynamicPath{
    switch (dynamicPath.enumIndex) {
        case EnumDynamicSection_1:
        {
            return 1;
        }
            break;
        case EnumDynamicSection_2:
        {
            return 1;
        }
            break;
        case EnumDynamicSection_3:
        {
            return 1;
        }
            break;
        case EnumDynamicSection_4:
        {
            return 1;
        }
            break;
        case EnumDynamicSection_5:
        {
            return 1;
        }
            break;
        case EnumDynamicSection_6:
        {
            return 1;
        }
            break;
        default:
            break;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath dynamicPath:(LYTableViewDynamicPath *)dynamicPath{
    UITableViewCell *cell = [UITableViewCell new]; // demo而已，不要在意细节
    switch (dynamicPath.enumIndex) {
        case EnumDynamicSection_1:
        {
            cell.textLabel.text = @"固定分区";
        }
            break;
        case EnumDynamicSection_2:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"动态分区一 - %ld",dynamicPath.index];
        }
            break;
        case EnumDynamicSection_3:
        {
            cell.textLabel.text = @"固定分区";
        }
            break;
        case EnumDynamicSection_4:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"动态分区二 - %ld",dynamicPath.index];
        }
            break;
        case EnumDynamicSection_5:
        {
            cell.textLabel.text = @"固定分区";
        }
            break;
        case EnumDynamicSection_6:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"动态分区三 - %ld",dynamicPath.index];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath dynamicPath:(LYTableViewDynamicPath *)dynamicPath{
    switch (dynamicPath.enumIndex) {
        case EnumDynamicSection_1:
        {
            
        }
            break;
        case EnumDynamicSection_2:
        {
            
        }
            break;
        case EnumDynamicSection_3:
        {
            
        }
            break;
        case EnumDynamicSection_4:
        {
            
        }
            break;
        case EnumDynamicSection_5:
        {
            
        }
            break;
        case EnumDynamicSection_6:
        {
            
        }
            break;
        default:
            break;
    }
    return 50;
}


@end
