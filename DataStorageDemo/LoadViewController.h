//
//  LoadViewController.h
//  DataStorageDemo
//
//  Created by x8f on 16/11/25.
//  Copyright © 2016年 xbk. All rights reserved.
//




/*
 *
 *  放了三张图片，演示轮播图效果(NSUserDefaults相关)
 *
 *
 */


#import <UIKit/UIKit.h>

@interface LoadViewController : UIViewController

{
    UIScrollView *scrollview;
    UIPageControl *pagecontrol;
    NSTimer *timer;
    UIView *containerView;
}


@end
