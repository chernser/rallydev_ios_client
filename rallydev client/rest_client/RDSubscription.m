//
//  RDSubscription.m
//  rallydev client
//
//  Created by Sergey on 1/20/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import "RDSubscription.h"
#import "RDWorkspace.h"

#define SUBCRIPTION_RESOURCE @"subscription"

@implementation RDSubscription


-(id) init {
    NSString *url = [RDAPIObject getResourceUrlString: SUBCRIPTION_RESOURCE];
    self = [super initWithRefUrl: url];
    
    if (self) {
        
    }
    
    return self;
}

-(NSArray *)getWorkspaces {
    static NSString *key = @"Workspaces";
    return [RDAPIObject objectsFromArray: [_dictionary objectForKey: key] ofClass: [RDWorkspace class]];
}

@end
