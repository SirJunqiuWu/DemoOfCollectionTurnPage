//
//  CollectionViewCell.m
//  DemoOfTurnPageVIew
//
//  Created by 吴 吴 on 16/10/20.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
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
    icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.contentView.width,self.contentView.height)];
    icon.backgroundColor = [UIColor yellowColor];
    [self addSubview:icon];
}


@end
