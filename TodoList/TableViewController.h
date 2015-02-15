//
//  TableViewController.h
//  TodoList
//
//  Created by Shiela S on 2/9/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData/CoreData.h"

@interface TableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSMutableArray *tasks;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
