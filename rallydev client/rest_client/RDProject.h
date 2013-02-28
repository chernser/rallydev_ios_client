//
//  RDProject.h
//  rallydev client
//
//  Created by Sergey on 1/22/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import "RDAPIObject.h"
#import "RDWorkspace.h"

@interface RDProject : RDAPIObject

@property (strong, atomic) RDWorkspace *workspace;

@end
