//
//  ClassViewController.m
//  ImageGalleryDemo
//
//  Created by wenbo on 11/2/12.
//  Copyright (c) 2012 wenbo. All rights reserved.
//

#import "ClassViewController.h"

@interface ClassViewController ()

@end

@implementation ClassViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    view.backgroundColor = [UIColor greenColor];
    
    self.view = view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
