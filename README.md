# ZSSegmentSlider
## 简介
轻量级的滑动选项卡，只需要了解两个类ZSSegmentBar、ZSSegmentBarVC即可
## 示例
![image](https://github.com/zsling01/ZSSegmentSlider/raw/master/Images/segmentSlider.gif
)
## 使用说明
### 项目使用
```
NSArray *items = @[@"标题1", @"标题2", @"标题3", @"标题4", @"标题5", @"标题6"];

NSMutableArray *childVCs = [NSMutableArray arrayWithCapacity:items.count];
    
[items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = MCRandomColor;
        [childVCs addObject:vc];
        
    }];
    
[self.segmentBarVC setUpItems:items childVCs:childVCs];
```
### 修改SegmentBar属性
```
[self.segmentBarVC.segmentBar updateSegmentConfig:^(ZSSegmentBarConfig *segmentConfig) {
        segmentConfig.c_itemNColor([UIColor greenColor]).c_itemSColor([UIColor purpleColor]).c_indicatorEW(10).c_indicatorH(4).c_indicatorC([UIColor purpleColor]);
    }];
```

