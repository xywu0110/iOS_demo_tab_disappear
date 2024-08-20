//
//  ViewController.m
//  demo_tabbar_disappear
//
//  Created by xywu on 2024/8/14.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)initWithLayerCount:(NSInteger)count
{
    self = [super init];
    if (self) {
        self.layerCount = count;
    }
    return self;
}

#pragma mark UI & UX
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupLabel];
    [self setupButtons];
}

- (void)setupLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"current page index: %ld", self.layerCount];
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    CGRect labelFrame = label.frame;
    labelFrame.origin.y = 100;
    labelFrame.origin.x = (self.view.frame.size.width - labelFrame.size.width) / 2;
    label.frame = labelFrame;
    [self.view addSubview:label];
}

- (void)setupButtons
{
    UIButton *pushButton = [self setupButtonWithTitle:@"Push" yOffset:250];
    [pushButton addTarget:self action:@selector(onTapPush:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *presentButton = [self setupButtonWithTitle:@"Present and then close self" yOffset:350];
    [presentButton addTarget:self action:@selector(onTapPresentAndCloseSelf:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *dismissButton = [self setupButtonWithTitle:@"Dismiss current page" yOffset:500];
    [dismissButton addTarget:self action:@selector(onTapDismiss:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIButton *)setupButtonWithTitle:(NSString *)title yOffset:(CGFloat)offset
{
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button sizeToFit];
    
    [button addTarget:self action:@selector(onButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(onButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect buttonFrame = button.frame;
    buttonFrame.origin.y = offset;
    buttonFrame.origin.x = (self.view.frame.size.width - buttonFrame.size.width) / 2;
    button.frame = buttonFrame;
    
    [self.view addSubview:button];
    
    return button;
}

- (void)onButtonTouchDown:(UIButton *)button {
    button.alpha = 0.5;
}

- (void)onButtonTouchUpInside:(UIButton *)button {
    button.alpha = 1.0;
}


#pragma mark actions
- (void)onTapPush:(UIButton *)sender
{
    NSLog(@"push button tapped at page %ld", self.layerCount);
    ViewController *nextVc = [[ViewController alloc] initWithLayerCount:(self.layerCount+1)];
    nextVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVc animated:YES];
}

- (void)onTapPresentAndCloseSelf:(UIButton *)sender
{
    NSLog(@"present button tapped at page %ld", self.layerCount);
    ViewController *nextVc = [[ViewController alloc] initWithLayerCount:(self.layerCount+1)];
    nextVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nextVc animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        /// using animation here will make tabbar disappear after returning to initial page
        [self.navigationController popViewControllerAnimated:YES];
        
        /// while forbidding animation will not cause any problem
//        [self.navigationController popViewControllerAnimated:NO];
        
        /// simply manipulating the navigation stack may be a better way to avoid such problem
//        NSMutableArray *vcs = self.navigationController.viewControllers.mutableCopy;
//        if ([vcs containsObject:self]) {
//            [vcs removeObject:self];
//        }
//        [self.navigationController setViewControllers:vcs animated:NO];
    });
}

- (void)onTapDismiss:(UIButton *)sender
{
    NSLog(@"dismiss button tapped at page %ld", self.layerCount);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
