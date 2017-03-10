//
//  ViewController.m
//  UI_10_02
//
//  Created by 刘嘉豪 on 2016/10/18.
//  Copyright © 2016年 Rick_Liu. All rights reserved.
//

#import "ViewController.h"
#import "WaterFlowLayout.h"
#define CellIdentifier @"CellIdentifier"

@interface ViewController ()<UICollectionViewDataSource,WaterFlowLayoutDelegate>
@property (nonatomic,strong)UICollectionView  *collectionView;

@end

@implementation ViewController

- (UICollectionView *)collectionView{
    
    if(!_collectionView){
        
        WaterFlowLayout *layout = [[WaterFlowLayout alloc] init];
        layout.delegate = self;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
        
        //注册单元格
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.collectionView];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark WaterFlowLayoutDelegate
- (CGFloat)waterFlowLayout:(WaterFlowLayout *)waterFlowLayout heightForRowAtIndex:(NSInteger)index itemWidth:(CGFloat)width{
    
    return arc4random_uniform(300);
}

- (NSInteger)columnCountInWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout{
    return 2;
}

- (CGFloat)rowMarginInWaterFlowLayout:(WaterFlowLayout *)waterFlowLayout{
    return 20;
}


@end























































































