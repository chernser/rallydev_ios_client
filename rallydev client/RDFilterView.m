//
//  RDFilterView.m
//  rallydev client
//
//  Created by Sergey on 2/10/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import "RDFilterView.h"

@interface RDFilterView ()
{
    @private
    NSMutableArray *result;
    NSMutableArray *filterQueries;
}

@end

@implementation RDFilterView

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        result = [[NSMutableArray alloc] init];
        filterQueries = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addFilterQuery:(NSString *)query {
    [filterQueries addObject:query];
}

-(void)resetFilter {
    [filterQueries removeAllObjects];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [result count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"FilterResultItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];

    [cell.textLabel setText: @"US0000"];
    [cell.detailTextLabel setText: @"Here is long long title (name) of US0000 "];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
