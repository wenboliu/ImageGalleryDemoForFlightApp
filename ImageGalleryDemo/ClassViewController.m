//
//  ClassViewController.m
//  ImageGalleryDemo
//
//  Created by wenbo on 11/2/12.
//  Copyright (c) 2012 wenbo. All rights reserved.
//

#import "ClassViewController.h"
#import "HomeView.h"
#import "EGOPhotoGlobal.h"
#import "MyPhotoSource.h"
#import "MyPhoto.h"
#import <FacebookSDK/FacebookSDK.h>

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface ClassViewController ()
{
    HomeView *homeView;
    NSString *currentResultUrl;
    FBRequestConnection *requestConnection;
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
    if(contained(currentUrl, @"gallery-"))
    {
        NSString *apiUrl = [currentResultUrl stringByReplacingOccurrencesOfString:@"home-ideas" withString:@"home-ideas/api"];
        NSLog(@"===apiUrl:%@", apiUrl);
        [self showGallery:apiUrl andImageUrl:currentUrl];
        NSLog(@"===NO");
        return NO;
    }
    else if (contained(currentUrl, @"results-"))
    {
        currentResultUrl = currentUrl;
    }
    else if (contained(currentUrl, @"facebook-login"))
    {
        
    }
    
    
    NSLog(@"===YES");
    return YES;
}

-(void) showGallery:(NSString*) pageUrl andImageUrl:(NSString*) imageUrl
{
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString:pageUrl]];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    [json enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop){
        NSString *keyValue = key;
        NSLog(@"======================%@", keyValue);
    }];
    
    NSArray* images = [json objectForKey:@"images"]; 
    
    NSMutableArray *photos = [[NSMutableArray alloc] initWithCapacity:[images count]];
    for (NSDictionary *image in images) {
        NSString *imageUrl = [image objectForKey:@"imageUrl"];
        MyPhoto *myPhoto = [[MyPhoto alloc] initWithImageURL:[NSURL URLWithString:imageUrl]];
        [photos addObject:myPhoto];
        NSLog(@"====%@", imageUrl);
    }
    
    MyPhotoSource *source = [[MyPhotoSource alloc] initWithPhotos:photos];
    EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoController];
    navController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentModalViewController:navController animated:YES];
}



-(void) facebookLogin
{
    NSLog(@"The button was tapped\n");
    if (FBSession.activeSession.isOpen)
    {
        [self sendRequests];
    }
    else
    {
        //         NSArray *permissions = [[NSArray alloc] initWithObjects:@"picture",nil];
        [FBSession openActiveSessionWithReadPermissions:nil
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session,
                                                          FBSessionState status,
                                                          NSError *error) {
                                          
                                          NSLog(@"==openActiveSessionWithReadPermissions");
                                          if (error) {
                                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                              message:error.localizedDescription
                                                                                             delegate:nil
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil];
                                              [alert show];
                                          } else if (FB_ISSESSIONOPENWITHSTATE(status)) {
                                              
                                              [self sendRequests];
                                          }
                                      }];
    }
}

- (void) sendRequests
{
    NSLog(@"==sendRequests");
    [FBSettings setLoggingBehavior:[NSSet setWithObjects:
                                    FBLoggingBehaviorFBRequests, nil]];
    FBRequestHandler handler =
    ^(FBRequestConnection *connection, id result, NSError *error) {
        [self requestCompleted:connection andResult:result andError:error];
    };
    [FBRequestConnection
     startForMeWithCompletionHandler:handler];
    
}

- (void) requestCompleted: (FBRequestConnection*)connection andResult: (id<FBGraphUser>)user andError: (NSError*)error
{
    if (requestConnection && connection != requestConnection) {
        return;
    }
    requestConnection = nil;
    NSMutableString *userInfo = [[NSMutableString alloc] initWithCapacity:7];
//    [userInfo appendString:[self base64Encode:@"-9999"]];
    NSString *separator = @"|";
    [userInfo appendString:separator];
//    [userInfo appendFormat:[self base64Encode:[@"http://graph.facebook.com/user/picture" stringByReplacingOccurrencesOfString:@"user" withString:user.id]]];
    [userInfo appendString:separator];
//    [userInfo appendString:[self base64Encode:user.username]];
    [userInfo appendString:separator];
//    [userInfo appendString:[self base64Encode:user.name]];
    [userInfo appendString:separator];
//    [userInfo appendString:[self base64Encode:[user objectForKey:@"email"]]];
    [userInfo appendString:separator];
//    [userInfo appendString:[self base64Encode:user.id]];
    [userInfo appendString:separator];
//    [userInfo appendString:[self base64Encode:@"loggedInIp"]];
    NSLog(@"============");
    NSLog(@"id :%@", user.id);
    NSLog(@"name :%@", user.name);
    NSLog(@"username :%@", user.username);
    NSLog(@"link :%@", [user objectForKey:@"email"]);
    NSLog(@"test :%@", userInfo);
    NSLog(@"============");
//    [self setHomeIdeasCookie:userInfo andVanityUrl:user.username];
    //    [self loadUrl:_url];
    //    NSLog(@"------------");
    //
    //    NSHTTPCookie *cookie;
    //    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //    for (cookie in [cookieJar cookies]) {
    //        NSLog(@"------%@", cookie);
    //    }
}


static BOOL contained(NSString* string, NSString* sequence)
{
    NSRange find = [string rangeOfString:sequence];
    return  find.location != NSNotFound;
}
@end
