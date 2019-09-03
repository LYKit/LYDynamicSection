//
//  ViewControllerTwo.m
//  Demo_dynamic_section
//
//  Created by 赵学良 on 2019/9/3.
//  Copyright © 2019 zhaoxueliang. All rights reserved.
//

#import "ViewControllerTwo.h"
#import "LYTableView.h"

@interface HeaderView : UIView
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy) dispatch_block_t clickBlock;

@end

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createBaseView];
    }
    return self;
}

- (void)createBaseView {
    _button = [[UIButton alloc] initWithFrame:self.frame];
    [self addSubview:_button];
    [_button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}
- (void)click {
    if (_clickBlock) {
        _clickBlock();
    }
}
@end

@interface ViewControllerTwo () <LYTableViewDynamicDelegate>
@property (weak, nonatomic) IBOutlet LYTableView *tableView;
@property (nonatomic, strong) NSArray *arrayData;

@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegateDynamic = self;
    self.arrayData = @[@[[@[@"0",@"0"] mutableCopy],[@[@"0",@"0"] mutableCopy]],@[[@[@"0",@"0"] mutableCopy],[@[@"0",@"0"] mutableCopy]],@[[@[@"0",@"0"] mutableCopy],[@[@"0",@"0"] mutableCopy]]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (NSMutableArray <LYTableViewDynamicSectionInfo*>*)optionsOfDynamicSectionInTableView {
    NSMutableArray *arrayEnum = [NSMutableArray array];
    [self.arrayData enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *subArray = obj.firstObject;
        // 展开判断， 临时依据子元素来判断展开收起, 具体展开收起及展示逻辑根据model来。
        BOOL isExend = [subArray.firstObject boolValue];
        LYTableViewDynamicSectionInfo *enumInfo = [[LYTableViewDynamicSectionInfo alloc] init];
        enumInfo.indexOfEnum = idx;
        enumInfo.length = isExend ? 1 : obj.count+1;
        [arrayEnum addObject:enumInfo];
    }];
    return arrayEnum;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self sectionCountWithPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section dynamicPath:(LYTableViewDynamicPath *)dynamicPath {
    if (dynamicPath.index > 0) {
        // 展开判断， 临时依据子元素来判断展开收起, 具体展开收起及展示逻辑根据model来。
        NSArray *array = _arrayData[dynamicPath.enumIndex];
        NSMutableArray *cellArray = array[dynamicPath.index-1];
        BOOL isExpend = [cellArray.lastObject boolValue];
        return isExpend ? 0 : array.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath dynamicPath:(LYTableViewDynamicPath *)dynamicPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (dynamicPath.index > 0) {
        NSArray *array = _arrayData[dynamicPath.enumIndex];
        NSMutableArray *cellArray = array[dynamicPath.index-1];
        NSLog(@"当前cell元素： %@",cellArray[indexPath.row]);
        cell.textLabel.text = [NSString stringWithFormat:@"                         三级列表%ld",indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath dynamicPath:(LYTableViewDynamicPath *)dynamicPath {
    if (dynamicPath.index == 0) {
        return 0.01;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section dynamicPath:(LYTableViewDynamicPath *)dynamicPath {
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section dynamicPath:(LYTableViewDynamicPath *)dynamicPath {
    UIView *view = [UIView new];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    [view addSubview:label];
    HeaderView *rightBtn = [[HeaderView alloc] initWithFrame:label.frame];
    [view addSubview:rightBtn];
    __weak typeof(self) weakSelf = self;
    rightBtn.clickBlock = ^{
        [weakSelf headerViewClick:dynamicPath];
    };
    if (dynamicPath.index == 0) {
        label.text = @"一级列表title >";
    } else {
        label.text = @"             二级列表title >";
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath dynamicPath:(LYTableViewDynamicPath *)dynamicPath {
    
}

- (void)headerViewClick:(LYTableViewDynamicPath *)dynamicPath {
    // 展开判断， 临时依据子元素来判断展开收起, 具体展开收起及展示逻辑根据model来。
    if (dynamicPath.index > 0) {
        NSArray *array = _arrayData[dynamicPath.enumIndex];
        NSMutableArray *cellArray = array[dynamicPath.index-1];
        BOOL isExpend = [cellArray.lastObject boolValue];
        if (isExpend) {
            cellArray[1] = @"0";
        } else {
            cellArray[1] = @"1";
        }
    } else {
        NSArray *array = _arrayData[dynamicPath.enumIndex];
        NSMutableArray *cellArray = array.firstObject;
        BOOL isExpend = [cellArray.firstObject boolValue];
        if (isExpend) {
            cellArray[0] = @"0";
        } else {
            cellArray[0] = @"1";
        }
    }
    [self.tableView reloadData];
}

// 展开判断， 临时依据子元素来判断展开收起, 具体展开收起及展示逻辑根据model来。
- (NSInteger)sectionCountWithPath {
    NSInteger count = 0;
    for (NSArray *array in self.arrayData) {
        NSArray *subArray = array.firstObject;
        if ([subArray.firstObject boolValue]) {
            count += 1;
        } else {
            count += array.count+1;
        }
    }
    return count;
}

@end
