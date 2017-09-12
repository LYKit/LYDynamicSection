# LYDynamicSection
tableView 动态分区化
</br>

</br>

### section动态化
当遇见较复杂页面时，一般会选择使用tableView去处理，如果页面层次结构复杂，tableView的使用也会变得繁琐。
tableView的分区最常用的做法是枚举化，使用枚举来标示分区的位置，会极大的简化分区的辨别。 

但是，如果某一块甚至多块区域的分区数量未知，使用枚举来标示分区的位置就会变得困难，分区的使用也会变得麻烦和易错，因为需要对前面所有未知分区数量进行判断。

</br>
</br>

<pre><code>
typedef NS_ENUM(NSUInteger, EnumDynamicSection) {
    EnumDynamicSection_1 = 0,
    EnumDynamicSection_2,   // 未知区域数量
    EnumDynamicSection_3,
    EnumDynamicSection_4,   // 未知区域数量
    EnumDynamicSection_5,
    EnumDynamicSection_6,   // 未知区域数量
};
</code></pre>

</br>
使用LYDynamicSection可将section与枚举动态化，却仍然可以使用枚举来标识固定或者动态的分区， 


<pre><code>
_tableView.delegateDynamic = self;

// 配置动态分区的信息
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
</pre></code>

<pre><code>
// 使用 DynamicPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
dynamicPath:(LYTableViewDynamicPath *)dynamicPath{
    UITableViewCell *cell = [UITableViewCell new];
    switch (dynamicPath.enumIndex) {
        case EnumDynamicSection_1: {
            cell.textLabel.text = @"固定分区";
        } break;
        case EnumDynamicSection_2: {
            cell.textLabel.text = [NSString stringWithFormat:@"动态分区一 - %ld",dynamicPath.index];
        } break;
        case EnumDynamicSection_3: {
            cell.textLabel.text = @"固定分区";
        } break;
        case EnumDynamicSection_4: {
            cell.textLabel.text = [NSString stringWithFormat:@"动态分区二 - %ld",dynamicPath.index];
        } break;
        case EnumDynamicSection_5: {
            cell.textLabel.text = @"固定分区";
        } break;
        case EnumDynamicSection_6: {
            cell.textLabel.text = [NSString stringWithFormat:@"动态分区三 - %ld",dynamicPath.index];
        } break;
        default:
            break;
    }
    return cell;
}
</pre></code>

<pre><code>
@interface LYTableViewDynamicPath : NSObject
@property (nonatomic, assign) NSInteger enumIndex;      // 动态分区所在枚举
@property (nonatomic, assign) NSInteger index;          // 分区在该动态区域的第几个

@end
</pre></code>

效果：  
![](https://github.com/LYKit/LYDynamicSection/raw/master/image/section.png)


</br>
</br>

### cell动态化
有时间会上传



