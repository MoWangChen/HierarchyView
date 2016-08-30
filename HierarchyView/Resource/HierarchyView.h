//
//  HierarchyView.h
//  HierarchyView
//
//  Created by 谢鹏翔 on 16/8/18.
//  Copyright © 2016年 ime. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ConfigCollectionCellBlock)(UICollectionViewCell *aCell,id item, NSIndexPath *indexPath, BOOL isEnd);

typedef void(^SelectedHandler)(id item ,NSIndexPath *indexPath);

@interface HierarchyViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) NSArray<NSString *> *titleArray;

@end

@interface CollectionViewArrayDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, copy) NSString *reuseIdentifier;

@property (nonatomic, copy) ConfigCollectionCellBlock cellConfigBlock;

@property (nonatomic, strong) NSArray *items;

@end

@interface HierarchyViewCell : UICollectionViewCell

@end

/**
 *  使用注意：
 *  视图中使用CollectionView,在导航视图中，会出现自动偏移
 *  self.automaticallyAdjustsScrollViewInsets = NO;
 */
@interface HierarchyView : UIView

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, copy) SelectedHandler selectedHandler;

@end
