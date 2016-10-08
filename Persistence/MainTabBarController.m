//
//  MainTabViewController.m
//  Persistence
//
//  Created by Jerry Yang on 9/28/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "MainTabBarController.h"
#import "UIColor+PS.h"

@interface MainTabBarController ()

@property (nonatomic) UIColor *selectedColor;
@property (nonatomic) UIColor *unSelectedColor;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setup{
    _selectedColor = [UIColor whiteColor];
    _unSelectedColor = [UIColor ps_white50];
    [[UITabBar appearance] setTintColor: _selectedColor];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName: _selectedColor }
                                             forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName: _unSelectedColor}
                                             forState: UIControlStateNormal];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
