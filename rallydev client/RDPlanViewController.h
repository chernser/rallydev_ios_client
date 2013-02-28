//
//  RDPlanViewController.h
//  rallydev client
//
//  Created by Sergey on 1/14/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDPlanViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UILabel *workspaceName;
@property (strong, nonatomic) IBOutlet UILabel *projectName;


-(void) onProjectChanged:(NSNotification *)notification;

@end
