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
    homeView = [[HomeView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame andWebViewDelegate:self];
    
    self.view = homeView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *currentUrl = request.URL.absoluteString;
    if (!currentUrl) {
        return NO;
    }
    NSLog(@"===url:%@", currentUrl);

    NSLog(@"===YES");
    return YES;
}

@end
