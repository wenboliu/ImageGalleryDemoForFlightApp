//
//  ClassViewController.m
//  ImageGalleryDemo
//
//  Created by wenbo on 11/2/12.
//  Copyright (c) 2012 wenbo. All rights reserved.
//

#import "ClassViewController.h"
#import "HomeView.h"

@interface ClassViewController ()
{
    HomeView *homeView;
}

@end

@implementation ClassViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    homeView = [[HomeView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    self.view = homeView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
