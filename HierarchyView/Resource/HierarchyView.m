//
//  HierarchyView.m
//  HierarchyView
//
//  Created by 谢鹏翔 on 16/8/18.
//  Copyright © 2016年 ime. All rights reserved.
//

#import "HierarchyView.h"
#import "NSString+Addition.h"

#define CellHorizontalSping 5
#define CellTitleFont       [UIFont systemFontOfSize:15]

NSString * const hierarchyViewCellReuseIdentifier = @"hierarchyViewCellReuseIdentifier";

#pragma mark - HierarchyViewFlowLayout
@interface HierarchyViewFlowLayout ()

@property (nonatomic, strong) NSMutableArray *itemsAttributes;

@property (nonatomic, assign) NSUInteger columnWidth;

@end

@implementation HierarchyViewFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareLayout
{
    NSUInteger itemCounts = [[self collectionView] numberOfItemsInSection:0];
    self.itemsAttributes = [NSMutableArray arrayWithCapacity:itemCounts];
    self.columnWidth = 0;
    
    for (NSUInteger index = 0; index < _titleArray.count; index++) {
        
        NSString *title = [_titleArray objectAtIndex:index];
        
        NSUInteger originX = self.columnWidth + CellHorizontalSping;
        NSUInteger originY = CellHorizontalSping;
        
        CGSize size = [title sizeWithFont:CellTitleFont AndHeight:16];
        
        NSUInteger sizeHeight = [self columnHeight];
        NSUInteger sizeWidth = size.width + sizeHeight;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(originX, originY, sizeWidth, sizeHeight);
        [self.itemsAttributes addObject:attributes];
        
        self.columnWidth = self.columnWidth + sizeWidth + CellHorizontalSping;
    }
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemsAttributes;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.columnWidth + CellHorizontalSping, self.collectionView.bounds.size.height);
}

#pragma mark Private Method
- (float)columnHeight
{
    return roundf(self.collectionView.bounds.size.height - 2 * CellHorizontalSping);
}

@end

#pragma mark - CollectionViewArrayDataSource
@implementation  CollectionViewArrayDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_reuseIdentifier forIndexPath:indexPath];
    if (_cellConfigBlock) {
        id item = [_items objectAtIndex:indexPath.row];
        _cellConfigBlock(cell, item, indexPath);
    }
    return cell;
}

@end

#pragma mark - HierarchyViewCell
@interface HierarchyViewCell ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HierarchyViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self loadBackView];
        [self loadTitleLabel];
    }
    return self;
}

- (void)setupUI
{
    
}

- (void)loadBackView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _backView.backgroundColor = [UIColor purpleColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = self.frame.size.height / 2;
        [self.contentView addSubview:_backView];
    }
}

- (void)loadTitleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _titleLabel.text = @"text";
        _titleLabel.font = CellTitleFont;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
}

@end

#pragma mark - HierarchyView
@interface HierarchyView ()<UICollectionViewDelegate>

@property (nonatomic, strong) HierarchyViewFlowLayout *flowLayout;

@property (nonatomic, strong) CollectionViewArrayDataSource *dataSource;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HierarchyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadDataSource];
        [self loadFlowLayout];
        [self loadCollectionView];
    }
    return self;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - lazy load
- (void)loadFlowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[HierarchyViewFlowLayout alloc] init];
        _flowLayout.titleArray = @[].mutableCopy;
    }
    _flowLayout.titleArray = _dataSource.items;
}

- (void)loadDataSource
{
    if (!_dataSource) {
        _dataSource = [[CollectionViewArrayDataSource alloc] init];
        _dataSource.reuseIdentifier = hierarchyViewCellReuseIdentifier;
        _dataSource.cellConfigBlock = ^(UICollectionViewCell *aCell, id item, NSIndexPath *indexPath){
        
            HierarchyViewCell *cell = (HierarchyViewCell *)aCell;
            cell.backgroundColor = [UIColor redColor];
            cell.backView.backgroundColor = [UIColor cyanColor];
            cell.titleLabel.text = item;
        };
        _dataSource.items = @[@"11111",@"222222222222",@"3333",@"4",@"555",@"666666",@"7777777",@"888888888888888"];
    }
}

- (void)loadCollectionView
{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
                                             collectionViewLayout:_flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = _dataSource;
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_collectionView];
        
        [_collectionView registerClass:[HierarchyViewCell class] forCellWithReuseIdentifier:hierarchyViewCellReuseIdentifier];
    }
}

- (void)dealloc
{
    NSLog(@"HierarchyView dealloc");
}

@end
