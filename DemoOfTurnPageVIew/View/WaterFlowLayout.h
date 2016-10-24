//
//  WaterFlowLayout.h
//  DemoOfWatterFlow
//
//  Created by JackWu on 16/3/7.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFlowLayout : UICollectionViewFlowLayout

/**
 *  瀑布流有多少列
 */
@property (nonatomic , assign) NSUInteger columnNum;

/**
 *  cell与cell之间的水平间距
 */
@property (nonatomic , assign) CGFloat horizontalItemSpacing;

/**
 *  cell与cell之间的垂直间距
 */
@property (nonatomic , assign) CGFloat verticalItemSpacing;

/**
 *  内容缩进
 */
@property (nonatomic) UIEdgeInsets contentInset;

/**
 *  头视图的高度，默认为0；为0时，不显示头视图
 */
@property (nonatomic , assign) CGFloat headerHeight;

/**
 *  尾部视图的高度，默认为0；为0时，不显示尾部视图
 */
@property (nonatomic , assign) CGFloat footerHeight;

@end

@protocol WaterFlowLayoutDelegate <UICollectionViewDelegate>

@required
- (CGSize)collectionView:(UICollectionView *)collectionView
                   layout:(WaterFlowLayout *)layout
 sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
