//
//  RDPlanViewController.m
//  rallydev client
//
//  Created by Sergey on 1/14/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import "AppDelegate.h"
#import "RDPlanViewController.h"
#import "RDRestClient.h"
#import "RDLoginViewController.h"
#import "RDProject.h"

@interface RDPlanViewController ()
{

}

@end

@implementation RDPlanViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

-(void) onProjectChanged:(NSNotification *)notification {
    [AppDelegate.clientInstance
        setDefaultProject:(RDProject *)notification.object];
    [self updateHeader];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter]
     addObserver:self selector: @selector(onProjectChanged:)
     name: @"project_changed" object: NULL];

    [self updateHeader];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear :animated];
}

-(void)updateHeader {
    RDProject *project = [AppDelegate clientInstance].defaultProject;
    if (project != NULL) {
        [self.workspaceName setText: project.workspace.name];
        [self.projectName setText: project.name];
    } else {
        [self.workspaceName setText: @"None"];
        [self.projectName setText: @"None"];
    }
}

@end
