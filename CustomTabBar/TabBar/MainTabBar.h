//
//  MainTabBar.h
//  TabBarDemo
//
//  Created by 互娱盘古 on 2020/3/25.
//  Copyright © 2020 互娱盘古. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MainTabBarDelegate <NSObject>

-(void)changeIndex:(NSInteger)index;

@end

@interface MainTabBar : UITabBar

@property(nonatomic,assign)NSInteger tabIndex;

@property(nonatomic,weak)id delegate;

- (instancetype)initWithTitArr:(NSArray *)titArr imgArr:(NSArray *)imgArr sImgArr:(NSArray *)sImgArr;

@end

NS_ASSUME_NONNULL_END
