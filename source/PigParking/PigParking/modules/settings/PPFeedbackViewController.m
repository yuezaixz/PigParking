//
//  PPFeedbackViewController.m
//  PigParking
//
//  Created by VincentLi on 14-7-6.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPFeedbackViewController.h"

@interface PPFeedbackViewController ()

@end

@implementation PPFeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"意见反馈";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTheme];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack
                                                                                         target:self
                                                                                         action:@selector(btnBackClick:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
