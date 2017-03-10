//
//  WaterFlowLayout.m
//  UI_10_02
//
//  Created by 刘嘉豪 on 2016/10/18.
//  Copyright © 2016年 Rick_Liu. All rights reserved.
//

#import "WaterFlowLayout.h"

/**  列数*/
static const CGFloat columCount = 2;
/**  每一列间距*/
static const CGFloat columMargin = 10;
/**  每一行间距*/
static const CGFloat rowMargin = 10;
/**  边缘间距*/
//这里不能这样写,因为UIEdgeInsetsMake(10, 10, 10, 10)调用的是函数,是在运行时执行的,而编译时不能做此操作
//static const  UIEdgeInsets  defaultEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
static const UIEdgeInsets defaultEdgeInsets = {10,10,10,10};

@interface WaterFlowLayout ()

@property (nonatomic,strong)NSMutableArray  *attrsArray;
/**  存放所有列当前的高度*/
@property (nonatomic,strong)NSMutableArray  *columnHeight;

- (NSInteger)columCount;
- (CGFloat)columMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)defaultEdgeInsets;

@end

@implementation WaterFlowLayout

- (NSInteger)columCount{
    
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterFlowLayout:)]) {
        return [self.delegate columnCountInWaterFlowLayout:self];
    }
    else{
        return columCount;
    }
}

- (CGFloat)columMargin{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFlowLayout:)]) {
        return [self.delegate columnMarginInWaterFlowLayout:self];
    }
    else{
        return columMargin;
    }
}

- (CGFloat)rowMargin{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFlowLayout:)]) {
        return [self.delegate rowMarginInWaterFlowLayout:self];
    }
    else{
        return rowMargin;
    }
}

- (UIEdgeInsets)defaultEdgeInsets{
    if ([self.delegate respondsToSelector:@selector(edgeInsetInWaterFlowLayout:)]) {
        return [self.delegate edgeInsetInWaterFlowLayout:self];
    }
    else{
        return defaultEdgeInsets;
    }
}

- (NSMutableArray *)attrsArray{
    
    if(!_attrsArray){
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (NSMutableArray *)columnHeight{
    
    if(!_columnHeight){
        _columnHeight = [NSMutableArray array];
    }
    return _columnHeight;
}

/*
 1. 重写prepareLayout方法
 -作用:在这个方法做一些初始化操作
 -注意:一定要调用 [super prepareLayout]
 */
- (void)prepareLayout{
    [super prepareLayout];
    
    [self.columnHeight removeAllObjects];
    for (NSInteger i = 0; i < self.columCount; i++) {
        
        [self.columnHeight addObject:@(self.defaultEdgeInsets.top)];
    }
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        //获取indexPath 对应cell 的布局属性
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attr];
    }
}

/*
 2.重写layoutAttributesForItemAtIndexPath:方法
 -作用:返回indexPath 位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //找出高度最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeight[0] doubleValue];
    
    for (int i = 1; i < self.columCount; i++) {
        
        CGFloat columnHeight =[self.columnHeight[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat w = (self.collectionView.frame.size.width - self.defaultEdgeInsets.left - self.defaultEdgeInsets.right - (self.columCount - 1)*self.columMargin) / self.columCount;
    
//    CGFloat h = 100;
//    CGFloat h = arc4random_uniform(300);
    CGFloat h = [self.delegate waterFlowLayout:self heightForRowAtIndex:indexPath.item itemWidth:w];
    
    CGFloat x = self.defaultEdgeInsets.left + destColumn*(w+self.columMargin);
    CGFloat y = minColumnHeight;
    
    if (y != self.defaultEdgeInsets.top) {
        y += self.rowMargin;
    }
    
    attr.frame = CGRectMake(x, y, w, h);
    
    self.columnHeight[destColumn] = @(y+h);
    return attr;
}

/*
 3. 重写layoutAttributesForElementsInRect:方法
 -作用:
 这个方法的返回值是个数组
 这个数组中存放的是UICollectionViewLayoutAttributes对象
 UICollectionViewLayoutAttributes 对象决定了cell的排布方式
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    return self.attrsArray;
}

/*
 4.重写collectionViewContentSize方法
 -作用:决定collectionView的可滚动范围
 */
- (CGSize)collectionViewContentSize{

    CGFloat maxHeight = [self.columnHeight[0] doubleValue];
    for (int i = 0; i < self.columCount; i++) {
        CGFloat value = [self.columnHeight[i] doubleValue];
        
        if (maxHeight < value) {
            maxHeight = value;
        }
    }
    return CGSizeMake(0, maxHeight + self.defaultEdgeInsets.bottom);
}


@end





































































































