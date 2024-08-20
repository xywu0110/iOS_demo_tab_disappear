//
//  ViewController.h
//  demo_tabbar_disappear
//
//  Created by xywu on 2024/8/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewController : UIViewController

@property (nonatomic, assign) NSInteger layerCount;

- (instancetype)initWithLayerCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
