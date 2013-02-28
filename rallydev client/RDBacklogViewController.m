//
//  RDBacklogViewController.m
//  rallydev client
//
//  Created by Sergey on 2/9/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import "RDBacklogViewController.h"
#import "RDFilterView.h"

@interface RDBacklogViewController ()

@end

@implementation RDBacklogViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *filterViewIdentifier = @"UserstoryListView";
    RDFilterView *listView =
    [self.storyboard instantiateViewControllerWithIdentifier: filterViewIdentifier];
    
    static NSString *userstoriesQuery =
        @"/HierarchicalRequirement.js/((Project.Name = \"Apollo.Team 9\") AND (Iteration = null))";
    static NSString *defectsQuery =
        @"/Defect.js/((Project.Name = \"Apollo.Team 9\") AND (Iteration = null))";
    switch(indexPath.section) {
        case 0:
            [listView addFilterQuery:userstoriesQuery];
            break;
        case 1:
            [listView addFilterQuery:defectsQuery];
            break;
        case 2:
            [listView addFilterQuery:userstoriesQuery];
            [listView addFilterQuery:defectsQuery];
            break;

    }
    [self.navigationController pushViewController: listView animated: YES];
    
}

@end
