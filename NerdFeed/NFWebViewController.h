//
// Created by 吕晴阳 on 2018/9/16.
// Copyright (c) 2018 Lv Qingyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NFWebViewController : UIViewController
@property (strong, nonatomic) NSString *url;
@property (nonatomic) BOOL goBackEnable;
@property (nonatomic) BOOL goForwardEnable;
@end