//
//  NSString+Addition.m
//  HierarchyView
//
//  Created by 谢鹏翔 on 16/8/26.
//  Copyright © 2016年 ime. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

- (CGSize )sizeWithFont:(UIFont *)font AndWidth:(CGFloat)width{
    
    CGSize size = CGSizeZero;
    NSDictionary * dict = @{NSFontAttributeName:font};
    
    size = [self boundingRectWithSize:CGSizeMake(width, 99999)
                              options:
            NSStringDrawingUsesLineFragmentOrigin|
            NSStringDrawingUsesFontLeading
                           attributes:dict context:nil].size;
    
    return size;
}

- (CGSize )sizeWithFont:(UIFont *)font AndHeight:(CGFloat)height{
    
    CGSize size = CGSizeZero;
    NSDictionary * dict = @{NSFontAttributeName:font};
    
    size = [self boundingRectWithSize:CGSizeMake(99999, height)
                              options:
            NSStringDrawingUsesLineFragmentOrigin|
            NSStringDrawingUsesFontLeading
                           attributes:dict context:nil].size;
    
    return size;
}

@end
