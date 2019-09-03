//
//  ViewController.m
//  Demo_dynamic_section
//
//  Created by 赵学良 on 2017/7/6.
//  Copyright © 2017年 zhaoxueliang. All rights reserved.
//

#import "ViewController.h"
#import "LYTableView.h"
#import "DataBuilder.h"
#import "ViewControllerTwo.h"

typedef NS_ENUM(NSUInteger, EnumDynamicSection) {
    EnumDynamicSection_1 = 0,
    EnumDynamicSection_2,
    EnumDynamicSection_3,
    EnumDynamicSection_4,   // 未知区域数量
    EnumDynamicSection_5,
    EnumDynamicSection_6,   // 未知区域数量
    EnumDynamicSectionEnd
};

typedef NS_ENUM(NSUInteger, EnumCellStyle) {
    EnumCellStyle_1 = 0,
    EnumCellStyle_2,
    EnumCellStyle_3,
    EnumCellStyle_4,
    EnumCellStyle_5,
    EnumCellStyle_6,
    EnumCellStyleEnd
};


@interface ViewController ()
<
    LYTableViewDynamicDelegate
>
@property (weak, nonatomic) IBOutlet LYTableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayDynamicSectionDataOne; // EnumDynamicSection_2
@property (nonatomic, strong) NSMutableArray *arrayDynamicSectionDataThree; // EnumDynamicSection_6

@property (nonatomic,strong) DataBuilder *responseData;

@end

@implementation ViewController



#pragma mark - delegate

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegateDynamic = self;
    
    // 添加假数据
    self.responseData = [DataBuilder builderData];
    self.arrayDynamicSectionDataOne = self.responseData.tripList;
    self.arrayDynamicSectionDataThree = [NSMutableArray arrayWithObjects:@"分区1",@"分区2",@"分区2",@"分区2",@"分区2", nil];
}


// 配置cell 结构
- (NSMutableArray *)optionsOfDynamicCellInIndexPath:(NSIndexPath *)indexPath dynamicPath:(LYTableViewDynamicPath *)dynamicPath
{
    NSMutableArray *array = [NSMutableArray array];
    if (dynamicPath.enumIndex == EnumDynamicSection_4) {
        TripModel *tripModel = self.responseData.tripList[dynamicPath.index];
        LYBaseModel *style_one = [LYBaseModel new];
        style_one.modelType = EnumCellStyle_1;
        style_one.model = tripModel;
        [array addObject:style_one];
        for (FlightInfo *flightInfo in tripModel.flightList) {
            LYBaseModel *style_two = [LYBaseModel new];
            style_two.modelType = EnumCellStyle_2;
            style_two.model = flightInfo;
            [array addObject:style_two];
            for (int i = 0; i < flightInfo.voyageList.count; i++) {
                VoyageModel *voyageModel = flightInfo.voyageList[i];
                LYBaseModel *style_three = [LYBaseModel new];
                style_three.modelType = EnumCellStyle_3;
                style_three.model = voyageModel;
                [array addObject:style_three];
                if (i < flightInfo.transferList.count) {
                    TransferModel *transfer = flightInfo.transferList[i];
                    LYBaseModel *style_four = [LYBaseModel new];
                    style_four.modelType = EnumCellStyle_4;
                    style_four.model = transfer;
                    [array addObject:style_four];
                }
            }
        }
        LYBaseModel *style_five = [LYBaseModel new];
        style_five.modelType = EnumCellStyle_5;
        style_five.model = nil;
        [array addObject:style_five];
    }

    return array;
}





// 配置动态分区信息
- (NSMutableArray <LYTableViewDynamicSectionInfo*>*)optionsOfDynamicSectionInTableView
{
    NSMutableArray *arrayEnum = [NSMutableArray array];
    // 动态分区 区域一
    LYTableViewDynamicSectionInfo *enumInfo1 = [[LYTableViewDynamicSectionInfo alloc] init];
    enumInfo1.indexOfEnum = EnumDynamicSection_4;
    enumInfo1.length = self.arrayDynamicSectionDataOne.count;
    [arrayEnum addObject:enumInfo1];

    // 动态分区 区域二
    LYTableViewDynamicSectionInfo *enumInfo2 = [[LYTableViewDynamicSectionInfo alloc] init];
    enumInfo2.indexOfEnum = EnumDynamicSection_6;
    enumInfo2.length = self.arrayDynamicSectionDataThree.count;
    [arrayEnum addObject:enumInfo2];
    
    return arrayEnum;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return EnumDynamicSectionEnd + 1 + (self.arrayDynamicSectionDataOne.count-1) +  (self.arrayDynamicSectionDataThree.count-1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section dynamicPath:(LYTableViewDynamicPath *)dynamicPath{
    switch (dynamicPath.enumIndex) {
        case EnumDynamicSection_1:
        case EnumDynamicSection_2:
        case EnumDynamicSection_3:
        case EnumDynamicSection_5:
        case EnumDynamicSectionEnd:
        {
            return 1;
        }
            break;
        case EnumDynamicSection_4:
        {
            return [[self optionsOfDynamicCellInIndexPath:nil dynamicPath:dynamicPath] count];
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath dynamicPath:(LYTableViewDynamicPath *)dynamicPath{
    UITableViewCell *cell = [UITableViewCell new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (dynamicPath.enumIndex) {
        case EnumDynamicSection_1:
        case EnumDynamicSection_2:
        case EnumDynamicSection_3:
        case EnumDynamicSection_5:
        case EnumDynamicSectionEnd:
        {
            cell.textLabel.text = @"固定分区";
            cell.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.2];
        }
            break;
        case EnumDynamicSection_6:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"动态分区三 - %ld",dynamicPath.index];
            cell.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.2];
        }
            break;
        case EnumDynamicSection_4:
        {
            LYBaseModel *baseModel = [self optionsOfDynamicCellInIndexPath:nil dynamicPath:dynamicPath][indexPath.row];
            switch (baseModel.modelType) {
                case EnumCellStyle_1: {
                    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个动态分区，含%ld个动态cell） ",dynamicPath.index+1, [[self optionsOfDynamicCellInIndexPath:nil dynamicPath:dynamicPath] count]];
                    cell.textLabel.textColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
                    break;
                }
                case EnumCellStyle_2: {
                    FlightInfo *model = (FlightInfo *)baseModel.model;
                    cell.textLabel.text = [NSString stringWithFormat:@"  %@ - %@        %@",model.departCity,model.arriveCity,model.allTime];
                    cell.textLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
                    break;
                }
                case EnumCellStyle_3: {
                    VoyageModel *model = (VoyageModel *)baseModel.model;
                    cell.textLabel.text = [NSString stringWithFormat:@"         %@ - %@        %@",model.departAir,model.arriveAir,model.cabin];
                    cell.textLabel.textColor = [[UIColor magentaColor] colorWithAlphaComponent:0.7];
                    break;
                }
                case EnumCellStyle_4: {
                    TransferModel *model = (TransferModel *)baseModel.model;
                    cell.textLabel.text = [NSString stringWithFormat:@"                中转：%@ %@",model.city,model.time];
                    cell.textLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
                    break;
                }
                case EnumCellStyle_5: {
                    cell.textLabel.text = @"                              收起";
                    cell.textLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
                    break;
                }
                    
                default:
                    break;
            }
            cell.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.2];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath dynamicPath:(LYTableViewDynamicPath *)dynamicPath{
    // ...
    return 50;
}

- (IBAction)didPressedTwo:(id)sender {
    [self.navigationController pushViewController:[ViewControllerTwo new] animated:YES];
}

@end
