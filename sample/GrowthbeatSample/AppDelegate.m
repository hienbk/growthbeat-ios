//
//  AppDelegate.m
//  GrowthbeatSample
//
//  Created by Kataoka Naoyuki on 2014/08/10.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <Growthbeat/GBPreference.h>
#import <Growthbeat/GPClient.h>

@implementation AppDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[[GrowthPush sharedInstance] httpClient] setBaseUrl:[NSURL URLWithString:@"https://api.stg.growthpush.com/"]];
    [[GrowthPush sharedInstance] initializeWithApplicationId:@"PIaD6TaVt7wvKwao" credentialId:@"RtYOQo4QaSaFHNYdZSddSeoeEiJ2kboW" environment:kGrowthPushEnvironment];
    [[Growthbeat sharedInstance] addIntentHandler:[[GBCustomIntentHandler alloc] initWithBlock:^BOOL(GBCustomIntent *customIntent) {
        NSDictionary *extra = customIntent.extra;
        NSLog(@"extra: %@", extra);
        if([extra objectForKey:@"type"]) {
            [[GrowthPush sharedInstance] requestDeviceToken];
        }
        return YES;
    }]];
    [[GrowthLink sharedInstance] initializeWithApplicationId:@"PIaD6TaVt7wvKwao" credentialId:@"FD2w93wXcWlb68ILOObsKz5P3af9oVMo"];

    [[GrowthPush sharedInstance] setDeviceTags];
    [[GrowthPush sharedInstance] trackEvent:@"Launch" value:nil messageHandler:^(void(^renderMessage)()){
        renderMessage();
    } failureHandler:nil];
    
    [[GrowthPush sharedInstance] trackEvent:@"AllowPushPermission"];
    
    return YES;
}

- (BOOL) application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler{
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *webpageURL = userActivity.webpageURL;
        [[GrowthLink sharedInstance] handleUniversalLinks:webpageURL];
    }
    return true;
}

- (void) applicationDidBecomeActive:(UIApplication *)application {
}

- (void) applicationWillResignActive:(UIApplication *)application {
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[GrowthLink sharedInstance] handleOpenUrl:url];
    return YES;
}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[GrowthPush sharedInstance] setDeviceToken:deviceToken];
}

- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"didFailToRegisterForRemoteNotification : %@", error);
}

@end
