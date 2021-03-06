//
//  GrowthLink.h
//  GrowthLink
//
//  Created by Naoyuki Kataoka on 2015/05/29.
//  Copyright (c) 2015年 SIROK, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Growthbeat.h"
#import "GLSynchronization.h"
#import "GLSynchronizationHandler.h"


@interface GrowthLink : NSObject {

    NSString *applicationId;
    NSString *credentialId;

    NSString *synchronizationUrl;
    void(^ synchronizationCallback)(GLSynchronization *);

}

@property (nonatomic, strong) NSString *applicationId;
@property (nonatomic, strong) NSString *credentialId;

@property (nonatomic, strong) NSString *synchronizationUrl;
@property (nonatomic, strong) NSString *host;
@property (nonatomic, copy)void(^ synchronizationCallback)(GLSynchronization *);
@property (nonatomic, strong) GLSynchronizationHandler *synchronizationHandler;

+ (instancetype)sharedInstance;

- (void)initializeWithApplicationId:(NSString *)applicationId credentialId:(NSString *)credentialId;

- (GBLogger *)logger;
- (GBHttpClient *)httpClient;
- (GBPreference *)preference;

- (void)handleUniversalLinks:(NSURL *)url;
- (void)handleOpenUrl:(NSURL *)url;

@end
