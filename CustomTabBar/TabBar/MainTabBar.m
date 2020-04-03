//
//  MainTabBar.m
//  TabBarDemo
//
//  Created by 互娱盘古 on 2020/3/25.
//  Copyright © 2020 互娱盘古. All rights reserved.
//

#import "MainTabBar.h"
#import "CustomBtn.h"

#define KW [UIScreen mainScreen].bounds.size.width

//全面屏适配
#define KDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define KDevice_Is_iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define KDevice_Is_iPhoneXMAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define KDevice_Is_FullPhone ((KDevice_Is_iPhoneX==YES||KDevice_Is_iPhoneXR==YES||KDevice_Is_iPhoneXMAX==YES) ? YES : NO)
#define KTABBAR_H     (KDevice_Is_FullPhone ? 83.0f : 49.0f) //标签高度


@interface MainTabBar ()

@property(nonatomic,strong)CustomBtn *centerBtn;
@property(nonatomic,strong)NSMutableArray *btnArr;
@property(nonatomic,copy)NSArray *titArr;
@property(nonatomic,copy)NSArray *imgArr;
@property(nonatomic,copy)NSArray *sImgArr;

@end

@implementation MainTabBar

@dynamic delegate;


- (instancetype)initWithTitArr:(NSArray *)titArr imgArr:(NSArray *)imgArr sImgArr:(NSArray *)sImgArr
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.btnArr = [NSMutableArray array];
        
        self.titArr = titArr;
        self.imgArr = imgArr;
        self.sImgArr = sImgArr;
        
        [self creatSubView];
    }
    return self;
}
-(void)creatSubView{
    
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, -1, KW, KTABBAR_H)];
    backV.backgroundColor = [UIColor whiteColor];
    [self addSubview:backV];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KW, 0.7)];
    line.backgroundColor = [UIColor colorWithRed:215/255.0 green:213/255.0 blue:214/255.0 alpha:1];
    [backV addSubview:line];
    
    CGFloat btnW = KW/self.titArr.count;
    for (NSInteger index = 0; index < self.titArr.count; index ++) {
        
        CustomBtn *btn = [CustomBtn new];
        [btn setTitle:self.titArr[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:self.sImgArr[index]] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:self.imgArr[index]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (index == 1) {
            btn.frame = CGRectMake(btnW*index, 0, btnW, 100);
            btn.imgRect = CGRectMake((btnW-80)/2, 0, 80, 80);
            btn.txtRect = CGRectZero;
            self.centerBtn = btn;
        }else{
            btn.frame = CGRectMake(btnW*index, 0, btnW, KTABBAR_H);
            btn.imgRect = CGRectMake((btnW-30)/2, 3, 30, 30);
            btn.txtRect = CGRectMake(0, 37, btnW, 10);
        }
        btn.tag = 2020 +index;
        [self addSubview:btn];
        [self.btnArr addObject:btn];
        if (index == 0) {
            btn.selected = YES;
        }
    }
    
}
#pragma mark -调整中间凸起按钮的frame
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.centerBtn.center = CGPointMake(KW/2, 12);
    
}
#pragma mark -切换索引
-(void)btnAction:(CustomBtn *)btn{
    for (CustomBtn *indexBtn in self.btnArr) {
        indexBtn.selected = btn.tag == indexBtn.tag ? YES:NO;
    }

    if ([self.delegate respondsToSelector:@selector(changeIndex:)]) {
        [self.delegate changeIndex:btn.tag - 2020];
    }
}
-(void)setTabIndex:(NSInteger)tabIndex{
    _tabIndex = tabIndex;
    [self.btnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CustomBtn *btn = obj;
        btn.selected = idx == _tabIndex ? YES:NO;
    }];
}
#pragma mark -重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {

        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.centerBtn];

        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.centerBtn pointInside:newP withEvent:event]) {
            return self.centerBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了

            return [super hitTest:point withEvent:event];
        }
    }

    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}
#pragma mark -彻底干掉系统UITabBarItem
- (NSArray<UITabBarItem *> *)items {
    return @[];
}
- (void)setItems:(NSArray<UITabBarItem *> *)items {
}
- (void)setItems:(NSArray<UITabBarItem *> *)items animated:(BOOL)animated {
}




@end
