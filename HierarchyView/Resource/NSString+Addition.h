//
//  NSString+Addition.h
//  HierarchyView
//
//  Created by 谢鹏翔 on 16/8/26.
//  Copyright © 2016年 ime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Addition)

- (CGSize )sizeWithFont:(UIFont *)font AndWidth:(CGFloat)width;

- (CGSize )sizeWithFont:(UIFont *)font AndHeight:(CGFloat)height;

@end
