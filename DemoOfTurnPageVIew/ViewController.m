//
//  ViewController.m
//  DemoOfTurnPageVIew
//
//  Created by 吴 吴 on 16/10/20.
//  Copyright © 2016年 JackWu. All rights reserved.
//

#import "ViewController.h"
#import "WaterFlowLayout.h"
#import "CollectionHeaderView.h"
#import "CollectionViewCell.h"

/**
 *  页面展示状态
 */
typedef NS_ENUM(NSInteger , TWDA03ShowType) {
    /**
     *  不展示商品
     */
    isHide = 0,
    /**
     *  展示商品
     */
    isShow = 1
};

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterFlowLayoutDelegate>
{
    /**
     *  展示类型
     */
    TWDA03ShowType showType;
    
    /**
     *  myContentSize
     */
    CGSize myContentSize;
}
/**
 *  collectionView
 */
@property (nonatomic , strong) UICollectionView *myCollectionView;

/**
 *  flowLayout
 */
@property (nonatomic , strong) WaterFlowLayout *flowLayout;

/**
 *  页面数据源
 */
@property (nonatomic , strong) NSMutableDictionary *dataDic;

/**
 *  商品数据源
 */
@property (nonatomic , strong) NSMutableArray *dataArray;


@end

@implementation ViewController

- (id)init {
    self = [super init];
    if (self) {
        _dataDic = [NSMutableDictionary dictionary];
        _dataArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"", nil];
        showType = isHide;
        myContentSize = CGSizeMake(-CGFLOAT_MAX, -CGFLOAT_MAX);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 创建UI

- (void)setupUI {
    _flowLayout = [[WaterFlowLayout alloc]init];
    _flowLayout.columnNum = 2;
    _flowLayout.horizontalItemSpacing = 5;
    _flowLayout.verticalItemSpacing = 10;
    _flowLayout.contentInset = UIEdgeInsetsMake(10, 10, 0, 10);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _flowLayout.headerHeight = self.view.height;
    
    _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.view.width,self.view.height) collectionViewLayout:_flowLayout];
    _myCollectionView.backgroundColor = [UIColor clearColor];
    _myCollectionView.showsVerticalScrollIndicator = NO;
    _myCollectionView.alwaysBounceVertical = YES;
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    [self.view addSubview:_myCollectionView];
    
    /**
     *  注册cell
     */
    [_myCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [_myCollectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView"];
    
    /**
     *  添加观察机制
     */
    [_myCollectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - KVO 

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (_myCollectionView.contentSize.height != myContentSize.height)
    {
        if (showType == isHide)
        {
            /**
             *  不展示商品
             */
            _myCollectionView.contentInset = UIEdgeInsetsMake(0, 0, -(_myCollectionView.contentSize.height - self.view.height), 0);
        }
        else
        {
            /**
             *  展示商品
             */
            _myCollectionView.contentInset = UIEdgeInsetsMake(-(self.view.height - 64.0), 0, 0, 0);
        }
    }
}

#pragma mark - UICollectionViewDataSource && Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = [[UICollectionReusableView alloc]init];
    if (kind == UICollectionElementKindSectionHeader)
    {
        CollectionHeaderView *tpHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView" forIndexPath:indexPath];
        tpHeaderView.backgroundColor = [UIColor whiteColor];
        reusableview = tpHeaderView;
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(WaterFlowLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemWidth = (self.view.width - 10.0*2.0 - 5.0)/2.0;
    CGFloat itemHeight = itemWidth + 5.0 + 30.0 + 5.0 + 12.0 + 8.0;
    return CGSizeMake(itemWidth, itemHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - UIScrollViewDelegate


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //此处数值可以控制上拉或者下拉多少执行翻页动画
    if (showType == isHide && scrollView.contentOffset.y > 40)
    {
        /**
         *  执行展示动效
         */
        [self exchangeState:YES];
    }
    if (showType == isShow && scrollView.contentOffset.y < (self.view.height - 160))
    {
        /**
         *  执行收回动效
         */
        [self exchangeState:NO];
    }
}

/**
 *  页面状态切换
 *
 *  @param open 是否要打开:YES，则会打开商品列表页；NO则关闭商品列表页
 */
- (void)exchangeState:(BOOL)open
{
    if (open == YES)
    {
        showType = isShow;
        [UIView animateWithDuration:0.25 animations:^{
            _myCollectionView.contentInset = UIEdgeInsetsMake(-(self.view.height - 64.0), 0, 0, 0);
            _myCollectionView.bounces = NO;
        }completion:^(BOOL finished) {
            _myCollectionView.bounces = YES;
        }];
    }
    else
    {
        showType = isHide;
        [UIView animateWithDuration:0.25 animations:^{
            _myCollectionView.contentInset = UIEdgeInsetsMake(0, 0, -(_myCollectionView.contentSize.height - self.view.height), 0);
            _myCollectionView.bounces = NO;
        }completion:^(BOOL finished) {
            _myCollectionView.bounces = YES;
        }];
    }
}



@end
