//
//  HomeView.m
//  ImageGalleryDemo
//
//  Created by wenbo on 11/2/12.
//  Copyright (c) 2012 wenbo. All rights reserved.
//

#import "HomeView.h"

@interface HomeView()
{
    UIWebView *webView;
    NSString *url;
}

@end

@implementation HomeView


- (id)initWithFrame:(CGRect)frame andWebViewDelegate:(id<UIWebViewDelegate>)deletegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        url = @"http://10.18.10.2:8080";
//        url = @"http://www.realestate.com.au/home-ideas/";
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.width)];
        webView.delegate = deletegate;
        webView.scalesPageToFit = YES;
        webView.autoresizesSubviews = YES;
        
        [self loadWebView];
        [self addSubview:webView];
    }
    return self;
}

- (void) loadWebView
{
    NSLog(@"###########loading url :%@", url);
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];

    [webView loadRequest:request];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
