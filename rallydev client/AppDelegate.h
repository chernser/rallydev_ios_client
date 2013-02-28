//
//  AppDelegate.h
//  rallydev client
//
//  Created by Sergey on 1/11/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDRestClient.h"

@class RDRestClient;
@interface AppDelegate : UIResponder <UIApplicationDelegate, RDRestClientDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)didReceiveAuthChallange:(NSURLAuthenticationChallenge *)challange;
+ (RDRestClient *) clientInstance;

@end
