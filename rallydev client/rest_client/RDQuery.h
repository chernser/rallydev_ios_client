//
//  RDQuery.h
//  rallydev client
//
//  Created by Sergey on 2/17/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import "RDAPIObject.h"

@interface RDQuery : RDAPIObject


@property NSInteger pageSize;

-(id) initWithCriteria: (NSString *)criteria objectClass: (Class)objectClass;

-(BOOL) hasErrors;
-(BOOL) hasWarnings;
-(NSInteger)getTotalCount;
-(NSArray *)getResults;


@end
