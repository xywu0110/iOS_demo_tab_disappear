//
//  TabBarController.m
//  demo_tabbar_disappear
//
//  Created by xywu on 2024/8/14.
//

#import "TabBarController.h"
#import "ViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ViewController *firstVc = [[ViewController alloc] initWithLayerCount:0];
    UINavigationController *firstNavController = [[UINavigationController alloc] initWithRootViewController:firstVc];
    firstNavController.tabBarItem.title = @"tab0";
    
    ViewController *secondVc = [[ViewController alloc] initWithLayerCount:0];
    UINavigationController *secondNavController = [[UINavigationController alloc] initWithRootViewController:secondVc];
    secondNavController.tabBarItem.title = @"tab1";
    
    self.viewControllers = @[firstNavController, secondNavController];
}


@end
