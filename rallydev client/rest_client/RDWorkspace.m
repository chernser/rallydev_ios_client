//
//  RDWorkspace.m
//  rallydev client
//
//  Created by Sergey on 1/21/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import "RDWorkspace.h"
#import "RDProject.h"

@implementation RDWorkspace


-(NSArray *)getProjects {
    static NSString *key = @"Projects";
    NSArray *projects = [RDAPIObject objectsFromArray: [_dictionary objectForKey: key]
                                              ofClass: [RDProject class]];
    for (RDProject *project in projects) {
        project.workspace = self;
    }
    return projects;
}
@end
