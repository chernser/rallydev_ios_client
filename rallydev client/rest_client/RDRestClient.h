//
//  RDRestClient.h
//  rallydev client
//
//  Created by Sergey on 1/13/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDWorkspace.h"
#import "RDProject.h"


@protocol RDRestClientDelegate <NSObject>

- (void) didReceiveAuthChallange:(NSURLAuthenticationChallenge*)challange;

@end

enum RD_OBJECT_TYPE {
    RD_SUBSCRIPTION = 1,
    RD_WORKSPACE,
    RD_PROJECT,
    RD_RELEASE,
    RD_INTERATION,
    RD_USERSTORY,
    RD_DEFECT,
    RD_USER
};

@interface RDRestClient : NSObject<NSURLConnectionDataDelegate>
{
    @private
    NSObject<RDRestClientDelegate> *clientDelegate;
}


@property(strong, atomic) NSURLCredential *nextChallangeCredential;
@property(strong, atomic) RDProject *defaultProject;

// Instance methods
-(id) init;
-(id) initWith:(NSObject<RDRestClientDelegate>*)delegate;

-(void) onAuthChallenge:(NSNotification *)notification;

-(void) loadObject:(RDAPIObject *)obj andNotifyWith:(NSString *)key;
-(void) loadSubscription;
-(void) loadWorkspace:(RDWorkspace *)workspace;
-(void) loadProject:(RDProject *)project;
-(void) loadUser;

-(void) executeQuery:(NSString *)query andNotifyWith:(NSString *)key;


// Class methods


@end

