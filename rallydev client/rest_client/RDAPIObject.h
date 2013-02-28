//
//  RDAPIObject.h
//  rallydev client
//
//  Created by Sergey on 1/20/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RESOURCE_URL_PREFIX @"https://rally1.rallydev.com/slm/webservice/1.40/"


#define GET_FIELD_AND_RETURN(Field) \
    static NSString *fieldName = Field; \
    return [_dictionary valueForKey: fieldName];


@interface RDAPIObject : NSObject
{
    @protected
    NSString *_refUrl;
    NSMutableDictionary *_dictionary;
}

@property (strong, getter = getRef) NSString *ref;
@property (strong, readonly, getter = getName) NSString *name;
@property (strong, readonly, getter = getFormattedId) NSString *formattedId;

-(id) initWithRefUrl:(NSString *) refUrl;
-(id) initWithDictionary:(NSDictionary *)dictionary;
-(void) update:(NSDictionary *)dictionary;
-(NSInteger) countChilds:(NSString *)attribute;

+(NSArray *) objectsFromArray:(NSArray *) array ofClass: (Class) clazz;
+(NSDictionary *) unwrap:(NSDictionary *)dictionary;
+(NSString *) getResourceUrlString: (NSString *)resourceName;
+(NSURL *) getResourceUrl :(NSString *)resourceName;

@end
