//
//  ViewController.m
//  HierarchyView
//
//  Created by 谢鹏翔 on 16/8/18.
//  Copyright © 2016年 ime. All rights reserved.
//

#import "ViewController.h"
#import "HierarchyView.h"
#import "AViewController.h"
@interface ViewController ()

@property (nonatomic, strong) HierarchyView *topView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _topView = [[HierarchyView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, 100)];
    _topView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_topView];
    
}
- (IBAction)push:(id)sender {
    
    [self.navigationController pushViewController:[AViewController new] animated:YES];
}

- (void)test
{
    NSArray *stringArray = @[@"11111",
                             @"",
                             @"22222",
                             @"",
                             @"33333"];
    
    NSMutableString *jsonStr = [NSMutableString string];
    [jsonStr appendString:@"["];
    for (NSString *str in stringArray) {
        if (!str || [str isEqualToString:@""]) {
            continue;
        }
        NSString * tempStr = [NSString stringWithFormat:@"\"%@\"",str];
        [jsonStr appendFormat:@"%@,",tempStr];
    }
    if (jsonStr.length > 1) {
        jsonStr = [NSMutableString stringWithFormat:@"%@",[jsonStr substringToIndex:jsonStr.length - 1]];
    }
    [jsonStr appendString:@"]"];
    
    NSLog(@"%@",jsonStr);
    
    // 先测试一下  用jsonStr 行不行 ，如果不行 再加下面这一行
    NSString *resultJSON = [self JSONString:jsonStr];
    NSLog(@"%@",resultJSON);
}

- (NSString *)JSONString:(NSString *)aString {
    
    NSMutableString *s = [NSMutableString stringWithString:aString];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
