//
//  RDLoginViewController.m
//  rallydev client
//
//  Created by Sergey on 1/15/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import "RDLoginViewController.h"
#import "AppDelegate.h"

@interface RDLoginViewController ()

@end

@implementation RDLoginViewController

@synthesize login;
@synthesize password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.challenge = NULL;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginBtnDown {
    
    if (self.challenge) {
        NSString *user_login = login.text;
        NSString *user_password = password.text;
        NSLog(@"authenticating: %@: %@", user_login, user_password);
        NSURLCredential *credential = [[NSURLCredential alloc]
                                       initWithUser: user_login password:user_password
                                       persistence: NSURLCredentialPersistenceForSession];
        [AppDelegate clientInstance].nextChallangeCredential = credential;
        [[self.challenge sender] useCredential:credential forAuthenticationChallenge:self.challenge];
    }
    
    [self.presentingViewController
        dismissViewControllerAnimated:TRUE completion:NULL];
}
@end
