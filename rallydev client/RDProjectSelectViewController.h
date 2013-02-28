//
//  RDProjectSelectViewController.h
//  rallydev client
//
//  Created by Sergey on 1/20/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDProjectSelectViewController :
    UIViewController<UITableViewDataSource, UITableViewDelegate>

- (IBAction)onCancel:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *projects;


-(void) onSubscriptionLoaded:(NSNotification *)notification;
-(void) onWorkspaceLoaded:(NSNotification *)notification;


// Table datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
    (NSInteger)section;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
    (NSInteger)section;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

// TableView controller
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
    (NSIndexPath *)indexPath;

@end
