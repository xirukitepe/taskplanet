//
//  TableViewController.m
//  TodoList
//
//  Created by Shiela S on 2/9/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "TableViewController.h"
#import <CoreData/CoreData.h>
#import "Constants.h"
#import "DetailViewController.h"

@interface TableViewController()
@end

@implementation TableViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    // tab configs
    UIImage *listIcon = [UIImage imageNamed:@"list"];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"List" image:nil selectedImage:nil];
    [self.tabBarItem setImage: [listIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    return self;
}

-(void)viewDidLoad{
    self.tasks = [self readData];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellTask"];
    [self.tableView setBackgroundColor:LIGHTGRAY_TEXTCOLOR];
    
    [self setUpNavigationBar];
    
   }

-(void)viewDidAppear:(BOOL)animated{
   self.tasks =  [self readData];
    [self.tableView reloadData];
}

-(NSMutableArray *)readData{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
   
    NSMutableArray *fetchedObjects  = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"displayOrder" ascending: YES];
    NSArray *sortedObjects =  [fetchedObjects sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    
    //NSLog(@"%@", fetchedObjects);
    
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"%@", localNotifications);
    
    return [sortedObjects mutableCopy];
}

#pragma mark - Table view data source
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tasks.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // delete from core data
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [context deleteObject:[self.tasks objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't delete!");
            return;
        }
        
        // Remove the row from data model
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // Request table view to reload
        [tableView reloadData];
        
    }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSMutableArray *item = [self.tasks objectAtIndex:sourceIndexPath.row];
    [self.tasks removeObject:item];
    [self.tasks insertObject:item atIndex:[destinationIndexPath row]];
    
    int i = 0;
    for (NSManagedObject *mo in self.tasks)
    {
        [mo setValue:[NSNumber numberWithInt:i++] forKey:@"displayOrder"];
    }
    
    [context save:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellTask";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSManagedObject *taskList = [self.tasks objectAtIndex:indexPath.row];
    
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [taskList valueForKey:@"name"];
        cell.detailTextLabel.text = [taskList valueForKey:@"desc"];
        
    }
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.backgroundColor = BUTTON_BG_GREEN;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DetailViewController *detailView = [[DetailViewController alloc] init];
    detailView.task = [self.tasks objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailView animated:YES];
}

#pragma mark - methods
-(void)setUpNavigationBar{
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationItem setTitle:@"All Tasks"];
}
@end
