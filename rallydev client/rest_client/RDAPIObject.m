//
//  RDAPIObject.m
//  rallydev client
//
//  Created by Sergey on 1/20/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import "RDAPIObject.h"

@implementation RDAPIObject

@synthesize ref = _refUrl;

-(id)initWithRefUrl:(NSString *)refUrl {
    self = [super init];
    
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
        _refUrl = refUrl;
    }
    
    return self;
}

-(id) initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];
    
    if (self) {
        dictionary = [self.class unwrap: dictionary];
        _dictionary = [[NSMutableDictionary alloc]
                       initWithDictionary: dictionary copyItems: FALSE];
        
        _refUrl = [_dictionary objectForKey: @"_ref"];
    }
    
    return self;
}

-(void) update:(NSDictionary *)dictionary {
    dictionary = [self.class unwrap: dictionary];
    _dictionary = [[NSMutableDictionary alloc] initWithDictionary: dictionary copyItems: FALSE];
}

-(NSInteger) countChilds:(NSString *)attribute {
    return [[_dictionary objectForKey:attribute] count];
}

-(NSString *)getName {
    NSString *objectName = [_dictionary valueForKey: @"Name"];
    if (objectName == NULL) {
        objectName = [_dictionary valueForKey: @"_refObjectName"];
    }
    return objectName;
}


-(NSString *)getFormattedId {
    GET_FIELD_AND_RETURN(@"FormattedId")
}

+(NSArray *)objectsFromArray:(NSArray *)array ofClass:(Class)clazz {
    NSEnumerator *arrayEnum = [array objectEnumerator];
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity: array.count];
    
    // TODO: add check for class type 
    id obj = NULL;
    while (obj = [arrayEnum nextObject]) {
        if ([[obj class] isSubclassOfClass: NSString.class]) {
            [objects addObject: [[clazz alloc] initWithRefUrl: obj ]];
        } else {
            [objects addObject: [[clazz alloc] initWithDictionary: obj ]];
        }    
    }
    
    return objects;
}

+(NSDictionary *)unwrap:(NSDictionary *)dictionary {
 
    if (dictionary.count == 1) {
        return [[dictionary allValues] objectAtIndex: 0];
    }
    
    return dictionary;
}

+(NSString *)getResourceUrlString:(NSString *)resourceName {
    return [NSString stringWithFormat:@"%@%@.js", RESOURCE_URL_PREFIX, resourceName];
}


+(NSURL *)getResourceUrl:(NSString *)resourceName {
    return [NSURL URLWithString :[NSString stringWithFormat:@"%@%@.js", RESOURCE_URL_PREFIX, resourceName]];
}



@end
