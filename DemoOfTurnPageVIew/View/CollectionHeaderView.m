//
//  CollectionHeaderView.m
//  DemoOfTurnPageVIew
//
//  Created by 吴 吴 on 16/10/20.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderView
{
    UIImageView *icon;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 创建UI

- (void)setupUI {
    icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,klScreenWidth, klScreenHeight)];
    icon.backgroundColor = [UIColor redColor];
    [self addSubview:icon];
}

#pragma mark - 数据源

- (void)initViewWithDic:(NSDictionary *)dic {
    
}

@end
