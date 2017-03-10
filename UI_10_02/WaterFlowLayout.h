//
//  WaterFlowLayout.h
//  UI_10_02
//
//  Created by 刘嘉豪 on 2016/10/18.
//  Copyright © 2016年 Rick_Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterFlowLayout;

@protocol WaterFlowLayoutDelegate <NSObject>
@required
- (CGFloat)waterFlowLayout:(WaterFlowLayout *)waterFlowLayout heightForRowAtIndex:(NSInteger)index itemWidth:(CGFloat)width;

@optional
- (NSInteger)columnCountInWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout;

- (CGFloat)columnMarginInWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout;

- (CGFloat)rowMarginInWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout;

- (UIEdgeInsets)edgeInsetInWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout;
@end

@interface WaterFlowLayout : UICollectionViewLayout

//代理
@property (nonatomic,assign)id<WaterFlowLayoutDelegate>  delegate;

@end






































































































