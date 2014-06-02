//
//  tabbarViewController.m
//  tabbarTest
//
//  Created by Kevin Lee on 13-5-6.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//

#import "tabbarViewController.h"
#import "tabbarView.h"

#define SELECTED_VIEW_CONTROLLER_TAG 98456345
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface tabbarViewController ()

@end

@implementation tabbarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGFloat orginHeight = self.view.frame.size.height;
    if (iPhone5) {
        orginHeight = self.view.frame.size.height- 60 + addHeight;
    }
    _tabbar = [[tabbarView alloc]initWithFrame:CGRectMake(0,  orginHeight, self.view.frame.size.width, 60)];
    _tabbar.delegate = self;
    [self.view addSubview:_tabbar];
    
    _arrayViewcontrollers = [self getViewcontrollers];
    [self touchBtnAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchBtnAtIndex:(NSInteger)index
{
    UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
    [currentView removeFromSuperview];
    
    
    NSDictionary* data = [_arrayViewcontrollers objectAtIndex:index];
    
    UIViewController *viewController = data[@"viewController"];
    viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
    viewController.view.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height- 50);
    
    [self.view insertSubview:viewController.view belowSubview:_tabbar];
    
}

-(NSArray *)getViewcontrollers
{
    NSArray* tabBarItems = nil;
    
    DPAPhotoController *first = [[DPAPhotoController alloc]initWithNibName:@"DPAPhotoController" bundle:nil];

    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [aFlowLayout setItemSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    DPAPhotoCollectionControllerViewController *second = [[DPAPhotoCollectionControllerViewController alloc] initWithCollectionViewLayout:aFlowLayout];
    
    
    UINavigationController* Nav = [[UINavigationController alloc] initWithRootViewController:second];
    
    [Nav.navigationBar setBarTintColor: UIColorFromRGB(0x0281ab)];
    [Nav.navigationBar setTintColor:[UIColor whiteColor]];
    
    tabBarItems = [NSArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", first, @"viewController",@"主页",@"title", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", Nav, @"viewController",@"主页",@"title", nil],nil];
    return tabBarItems;
    
}

@end
