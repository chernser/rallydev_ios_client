//
//  RDProjectSelectViewController.m
//  rallydev client
//
//  Created by Sergey on 1/20/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import "RDProjectSelectViewController.h"
#import "AppDelegate.h"
#import "RDRestClient.h"
#import "RDSubscription.h"
#import "RDWorkspace.h"


@interface RDProjectSelectViewController ()
{
    NSMutableArray *workspaces;
}

@end

@implementation RDProjectSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"select project view loaded");
    
    [self.projects setDelegate: self];
    [self.projects setDataSource: self];

    workspaces = [[NSMutableArray alloc] initWithCapacity: 10];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(onSubscriptionLoaded:) name:@"subscription_loaded" object: NULL];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(onWorkspaceLoaded:) name:@"workspace_loaded" object: NULL];

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    RDRestClient *client = [AppDelegate clientInstance];
    [client loadSubscription];

}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
    
    [workspaces removeAllObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCancel:(id)sender {
    
    [[self presentingViewController] dismissViewControllerAnimated: TRUE completion: NULL];
}

-(void) onSubscriptionLoaded:(NSNotification *)notification {
    NSLog(@"Subscription ready:");
    
    RDSubscription *subscription = notification.object;
    NSArray *wsList = [subscription getWorkspaces];
    RDRestClient *client = [AppDelegate clientInstance];
    
    for (RDWorkspace *workspace in wsList) {
        [client loadWorkspace: workspace];
    }
}

-(void) onWorkspaceLoaded:(NSNotification *)notification {
    RDWorkspace *ws = notification.object;
    NSLog(@"Workspace ready: %@", ws.name);
    [workspaces addObject: ws];
    
    [self.projects reloadData];
}


#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
    (NSIndexPath *)indexPath {
    
    RDWorkspace *workspace = [workspaces objectAtIndex: indexPath.section];
    RDProject *project = [[workspace getProjects] objectAtIndex:indexPath.row];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"project_changed" object: project];
    [[self presentingViewController]
     dismissViewControllerAnimated: TRUE completion: NULL];
}


#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return workspaces.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
    (NSInteger)section {
    
    return [[workspaces objectAtIndex: section] getName];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
    (NSInteger)section {
    
    return [[workspaces objectAtIndex: section] countChilds:@"Projects"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
    (NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"ProjectCell";
    UITableViewCell *projectCell = [self.projects
                                    dequeueReusableCellWithIdentifier: cellIdentifier];
    
    NSArray *projects =
        [((RDWorkspace *)[workspaces objectAtIndex: indexPath.section])
         getProjects];
    
    RDProject *project = (RDProject *)[projects objectAtIndex: indexPath.row];
    
    [projectCell.textLabel setText: project.getName];

    return projectCell;
}

@end
