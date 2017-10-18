//
//  POView.m
//  POUDP_Client
//
//  Created by Polo on 2017/10/18.
//  Copyright © 2017年 Polo. All rights reserved.
//

#import "POView.h"

@implementation POView
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self setup];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        _extentRadius=15;
        [self setup];
    }
    return self;
}
-(void)setup{
    self.layer.cornerRadius = _extentRadius ;
    [self.layer setMasksToBounds:YES];
}

@end
