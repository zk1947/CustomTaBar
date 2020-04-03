//
//  TestVC.m
//  CustomTabBar
//
//  Created by 互娱盘古 on 2020/4/3.
//  Copyright © 2020 互娱盘古. All rights reserved.
//

#import "TestVC.h"
#import "MainTabBarController.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"popToRoot" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 50)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"更改tabBar索引" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
}

-(void)btnAction{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)btn2Action{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MainTabBarController *mainVC = (MainTabBarController *)window.rootViewController;
    mainVC.tabIndex = 2;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
