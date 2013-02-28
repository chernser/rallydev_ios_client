//
//  RDFilterView.h
//  rallydev client
//
//  Created by Sergey on 2/10/13.
//  Copyright (c) 2013 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDFilterView : UITableViewController


-(void) addFilterQuery: (NSString *)query;
-(void) resetFilter;

@end
