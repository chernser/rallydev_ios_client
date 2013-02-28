//
//  RDRestClient.m
//  rallydev client
//
//  Created by Sergey on 1/13/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import "RDRestClient.h"
#import "RDUserStory.h"
#import "RDSubscription.h"


#define CACHE_COUNT_LIMIT 1000

#define CACHE_WRITE 1
#define CACHE_READ 0

/*!
 @class ClientRequester
 @discussion This class is simple wrap to do requests
 
 */

@interface  ClientRequest : NSObject<NSURLConnectionDataDelegate>
{
    NSURLConnection *connection;
    NSMutableData *responseData;
    RDAPIObject *apiObject;
    NSString *notificatorKey;
}

-(id) initWithUrl: (NSURL*)url andNotificator:(NSString *)key;
-(id) initWithObject: (RDAPIObject *)object andNotificator:(NSString *)key;
-(void) start;


// NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;


// NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end

@implementation ClientRequest


-(id)initWithUrl:(NSURL *)url andNotificator:(NSString *)key{
    self = [super init];
    
    if (self) {
        responseData = [[NSMutableData alloc] init];
        notificatorKey = key;
        apiObject = NULL;
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
        NSLog(@"request: %@", request.description);
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:FALSE];
    }
    
    return self;
}

-(id) initWithObject:(RDAPIObject *)object andNotificator:(NSString *)key{
    NSURL* url = [NSURL URLWithString: object.getRef];
    self = [self initWithUrl: url andNotificator: key];
    
    if (self) {
        apiObject = object;
    }
    
    return self;    
}

-(void)start {
    [connection start];
}

#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error while connecting: %@", [error description]);
}


- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    if ([challenge previousFailureCount] > 0) {
        NSLog(@"prev attempt failed");
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName: @"auth_challenge" object: challenge];      
    }
}


#pragma mark NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"response received");
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"data received");
    [responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"load finished");
    
    @try {
        NSError* jsonError = NULL;
        NSDictionary* result = [NSJSONSerialization JSONObjectWithData: responseData
                                                               options:NSJSONReadingMutableLeaves
                                                                 error: &jsonError];
        (void)result;
//        NSLog(@"result: %@", [result description]);
        
        NSObject *object = NULL;
        if (apiObject) {
            [apiObject update: result];
            object = apiObject;            
        } else {
            object = [[RDAPIObject alloc] initWithDictionary: result];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:notificatorKey object: object];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception while parsing data: %@", exception.description);
    }
    
}

@end


/*!
    @class RDRestClient
    @discussion RallyDev REST API client wrapping simple http request in async calls

 */
@implementation RDRestClient
{
    

}

@synthesize nextChallangeCredential;
@synthesize defaultProject;

-(id) init {
    self = [super init];
    if (self) {
        clientDelegate = NULL;
        nextChallangeCredential = NULL;
        defaultProject = NULL;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAuthChallenge:)
                                                     name: @"auth_challenge" object:NULL];
        
    }
    
    return self;
}

-(void) onAuthChallenge :(NSNotification *)notification {
    
    NSURLAuthenticationChallenge *challenge = [notification object];
    if (nextChallangeCredential) {
        NSLog(@"using credential: %@ ", nextChallangeCredential.description);
        [challenge.sender useCredential : nextChallangeCredential forAuthenticationChallenge:challenge];
        nextChallangeCredential = NULL;
    } else {
        [clientDelegate didReceiveAuthChallange: challenge];
    }
}

-(id) initWith:(NSObject<RDRestClientDelegate> *)delegate {
    self = [self init];
    if (self) {
        clientDelegate = delegate;
    }
    
    return self;
}


-(void)loadObject:(RDAPIObject *)obj andNotifyWith:(NSString *)key {
    ClientRequest *request = [[ClientRequest alloc]initWithObject: obj andNotificator: key];
    [request start];
}

-(void) loadSubscription {
    RDSubscription *subscription = [[RDSubscription alloc] init];
    [self loadObject: subscription andNotifyWith:@"subscription_loaded"];
}

-(void) loadWorkspace:(RDWorkspace *)workspace {
    [self loadObject: workspace andNotifyWith: @"workspace_loaded"];
}

-(void) loadProject:(RDProject *)project {
    [self loadObject: project andNotifyWith:@"project_loaded"];
}


-(void)loadUser {
//    NSURL *url = [RDRestClient getResourceUrl: @"user"];
  //  (void)[[ClientRequest alloc] initWithClient: self url:url andNotificationKey:@"user:ready" ];
}

-(void)executeQuery:(NSString *)query andNotifyWith:(NSString *)key {
//    ClientRequest *request = [[ClientRequest alloc] initWithObject:<#(RDAPIObject *)#> andNotificator:<#(NSString *)#>]
    
}
@end




