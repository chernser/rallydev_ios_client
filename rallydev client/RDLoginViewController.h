//
//  RDLoginViewController.h
//  rallydev client
//
//  Created by Sergey on 1/15/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDLoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *login;
@property (strong, nonatomic) IBOutlet UITextField *password;


@property (strong, nonatomic) NSURLAuthenticationChallenge *challenge;
- (IBAction)onLoginBtnDown;


@end
