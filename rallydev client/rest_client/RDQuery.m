//
//  RDQuery.m
//  rallydev client
//
//  Created by Sergey on 2/17/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import "RDQuery.h"
#import "RDAPIObject.h"


@implementation RDQuery
{
    @private
    Class resultObjectClass;
    NSString *queryString;
}

-(id)initWithCriteria:(NSString *)criteria objectClass:(Class)objectClass {
    self = [super init];
    
    if (self) {
        if (![objectClass isSubclassOfClass: [RDAPIObject class]]) {
            return nil;
        }
        resultObjectClass = objectClass;
        queryString = criteria;
    }
    
    return self;
}


-(BOOL)hasErrors {
    static NSString *field = @"Errors";
    NSDictionary *queryResult = [self getQueryResult];
    return ((NSArray *)[queryResult objectForKey:field]).count > 0;
}

-(BOOL)hasWarnings {
    static NSString *field = @"Warnings";
    NSDictionary *queryResult = [self getQueryResult];
    return ((NSArray *)[queryResult objectForKey:field]).count > 0;
}

-(NSInteger)getTotalCount {
    static NSString *field = @"TotalResultCount";
    NSDictionary *queryResult = [self getQueryResult];
    return [queryResult objectForKey: field];
}

- (NSArray *)getResults {
    return [self getResultsWrappedInto: [RDAPIObject class]];
}

- (NSArray *)getResultsWrappedInto:(Class)objectClass {
    static NSString *resultsField = @"Results";
    NSArray *results = (NSArray *)[_dictionary objectForKey: resultsField];    
    return [RDAPIObject objectsFromArray:results ofClass: objectClass];
}

- (NSDictionary *)getQueryResult {
    static NSString *field = @"QueryResult";
    
    return [_dictionary objectForKey:field];
}

@end
