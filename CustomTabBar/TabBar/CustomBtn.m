//
//  CustomBtn.m
//  CustomTabBar
//
//  Created by 互娱盘古 on 2020/4/2.
//  Copyright © 2020 互娱盘古. All rights reserved.
//

#import "CustomBtn.h"

@implementation CustomBtn


-(void)setTxtRect:(CGRect)txtRect{
    _txtRect = txtRect;
}
-(void)setImgRect:(CGRect)imgRect{
    _imgRect = imgRect;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (_txtRect.size.width != 0) {
        self.titleLabel.frame = _txtRect;
    }
    if (_imgRect.size.width != 0) {
        self.imageView.frame = _imgRect;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
