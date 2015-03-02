//
//  CreateToDoViewController.m
//  TodoList
//
//  Created by Shiela S on 2/9/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "CreateToDoViewController.h"
#import "Constants.h"
#import "TableViewController.h"

@interface CreateToDoViewController()
@property (strong, nonatomic) UITextField *taskName;
@property (strong, nonatomic) UILabel *pageTitle;
@property (strong, nonatomic) UITextView *taskDescription;
@property (strong, nonatomic) UIButton *doneBtn;
@property (strong, nonatomic) UIView *wrapper;
@property (strong, nonatomic) UIDatePicker *dueDate;
@property (strong, nonatomic) UITextField *dateSelected;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UIView *pickerHolder;
@end

@implementation CreateToDoViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    // tab configs
    UIImage *addIcon = [UIImage imageNamed:@"add-icon"];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Add" image:nil selectedImage:nil];
    [self.tabBarItem setImage: [addIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.pageTitle];
    //[self.view addSubview:self.wrapper];
    [self.view addSubview:self.taskName];
    [self.view addSubview:self.taskDescription];
    [self.view addSubview:self.doneBtn];
    [self.view addSubview:self.dateSelected];
    [self.view addSubview:self.dueDate];
    
    [self setUpConstraints];

    [self backgroundImage];
    [self setUpNavigationBar];
    
     self.wrapper.center = CGPointMake(SCREEN_CENTER_X, self.taskName.frame.size.height + self.taskDescription.frame.size.height + self.doneBtn.frame.size.height + self.dueDate.frame.size.height - self.taskName.frame.origin.y + (ELEM_MARGIN));
    self.wrapper.frame = CGRectMake(self.wrapper.frame.origin.x, self.wrapper.frame.origin.y, self.wrapper.frame.size.width, self.wrapper.frame.size.height);
}

#pragma mark - properties

-(UILabel *)pageTitle{
    if (!_pageTitle) {
        _pageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.wrapper.frame.size.width - SCREEN_MARGIN, 30)];
        _pageTitle.center = CGPointMake(SCREEN_CENTER_X, (SCREEN_MARGIN * 2));
        _pageTitle.frame = CGRectMake(_pageTitle.frame.origin.x, _pageTitle.frame.origin.y, _pageTitle.frame.size.width, _pageTitle.frame.size.height);
        _pageTitle.text = @"New Task";
        _pageTitle.textColor = [UIColor whiteColor];
        _pageTitle.layer.shadowColor = [UIColor blackColor].CGColor;
        _pageTitle.layer.shadowOpacity = 0.8;
        _pageTitle.layer.shadowRadius = 15;
        _pageTitle.layer.shadowOffset = CGSizeMake(15.0f, 15.0f);
        [_pageTitle setFont:[UIFont boldSystemFontOfSize:24]];
    }
    return _pageTitle;
}

-(UIView *)wrapper{
    if (!_wrapper) {
        _wrapper = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 350)];
       
        
        UIImage *image = [UIImage imageNamed:@"paper"];
        _wrapper.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    return _wrapper;
}



-(UITextField *)taskName{
    if(!_taskName){
        _taskName = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.wrapper.frame.size.width - SCREEN_MARGIN, TEXTFIELD_HEIGHT)];
        _taskName.center = CGPointMake(SCREEN_CENTER_X, self.pageTitle.frame.origin.y + self.pageTitle.frame.size.height + (ELEM_MARGIN));
        _taskName.frame = CGRectMake(_taskName.frame.origin.x, _taskName.frame.origin.y, _taskName.frame.size.width, _taskName.frame.size.height);
        _taskName.layer.borderWidth = 2.0f;
        _taskName.layer.borderColor = LIGHTGRAY_TEXTCOLOR.CGColor;
        _taskName.backgroundColor = [UIColor whiteColor];
        _taskName.placeholder = @"Task Name";
        _taskName.textColor = LIGHTGRAY_TEXTCOLOR;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, _taskName.frame.size.height)];
        _taskName.leftView = leftView;
        _taskName.leftViewMode = UITextFieldViewModeAlways;
        _taskName.layer.cornerRadius = 3.0f;
        _taskName.delegate = self;
    }
    return _taskName;
}

-(UITextView *)taskDescription{
    if(!_taskDescription){
        _taskDescription = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.wrapper.frame.size.width - SCREEN_MARGIN, 100)];
        _taskDescription.center = CGPointMake(SCREEN_CENTER_X, self.taskName.frame.origin.y + self.taskName.frame.size.height + (ELEM_MARGIN * 2));
        _taskDescription.frame = CGRectMake(_taskDescription.frame.origin.x, _taskDescription.frame.origin.y, _taskDescription.frame.size.width, _taskDescription.frame.size.height);
        _taskDescription.layer.borderWidth = 2.0f;
        _taskDescription.layer.borderColor = LIGHTGRAY_TEXTCOLOR.CGColor;
        _taskDescription.text = @"Task Description";
        [_taskDescription setFont:[UIFont systemFontOfSize:17]];
        _taskDescription.textColor = [UIColor lightGrayColor];
        _taskDescription.layer.cornerRadius = 3.0f;
        _taskDescription.delegate = self;
    }
    return _taskDescription;
}

-(UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH - SCREEN_MARGIN, BUTTON_HEIGHT)];
        _doneBtn.center = CGPointMake(SCREEN_CENTER_X, self.tabBarController.tabBar.frame.origin.y - self.tabBarController.tabBar.frame.size.height - (SCREEN_MARGIN * 2) - 25);
        _doneBtn.frame = CGRectMake(_doneBtn.frame.origin.x, _doneBtn.frame.origin.y, _doneBtn.frame.size.width, _doneBtn.frame.size.height);
        [_doneBtn setTitle:@"Submit" forState:UIControlStateNormal];
        _doneBtn.layer.borderWidth = 2.0f;
        _doneBtn.layer.borderColor = BUTTON_BG_GREEN.CGColor;
        _doneBtn.backgroundColor = BUTTON_BG_GREEN;
        [_doneBtn addTarget:self action:@selector(submitTask) forControlEvents:UIControlEventTouchUpInside];
        _doneBtn.layer.cornerRadius = 3.0f;
        _doneBtn.layer.masksToBounds = NO;
        _doneBtn.layer.shadowColor = BUTTON_BG_GREEN.CGColor;
        _doneBtn.layer.shadowOpacity = 0.8;
        _doneBtn.layer.shadowRadius = 20;
        _doneBtn.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
    }
    return _doneBtn;
}

-(UITextField *)dateSelected{
    if(!_dateSelected){
        _dateSelected = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH - SCREEN_MARGIN, TEXTFIELD_HEIGHT)];
        _dateSelected.center = CGPointMake(SCREEN_CENTER_X, self.taskDescription.frame.origin.y + self.taskDescription.frame.size.height + ELEM_MARGIN + 5);
        _dateSelected.frame = CGRectMake(_dateSelected.frame.origin.x, _dateSelected.frame.origin.y, _dateSelected.frame.size.width, _dateSelected.frame.size.height);
        _dateSelected.layer.borderWidth = 2.0f;
        _dateSelected.layer.borderColor = LIGHTGRAY_TEXTCOLOR.CGColor;
        _dateSelected.backgroundColor = [UIColor whiteColor];
        _dateSelected.placeholder = @"Due Date";
        _dateSelected.textColor = LIGHTGRAY_TEXTCOLOR;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, _taskName.frame.size.height)];
        _dateSelected.leftView = leftView;
        _dateSelected.leftViewMode = UITextFieldViewModeAlways;
        _dateSelected.layer.cornerRadius = 3.0f;
        _dateSelected.enabled = NO;
        _dateSelected.text = [self formattedDate];
        
    }
    return _dateSelected;
}

-(UIDatePicker *)dueDate{
    if (!_dueDate) {
        _dueDate = [[UIDatePicker alloc] initWithFrame:CGRectMake(SCREEN_MARGIN,  self.dateSelected.frame.origin.y + self.dateSelected.frame.size.height - ELEM_MARGIN, FULL_WIDTH, 10)];
        _dueDate.backgroundColor = [UIColor clearColor];
        [_dueDate addTarget:self action:@selector(dateChanged:)
         forControlEvents:UIControlEventValueChanged];
        [_dueDate sizeThatFits:CGSizeZero];
        _dueDate.transform = CGAffineTransformMakeScale(0.95f, 0.75f);
    }
    return _dueDate;
}

-(UIView *)pickerHolder{
    if (!_pickerHolder) {
        

    }
    return _pickerHolder;
}

#pragma mark - methods

-(void)setUpConstraints{
    //9. Text field Constraints
    NSLayoutConstraint *textFieldTopConstraint = [NSLayoutConstraint
                                                  constraintWithItem:self.dateSelected attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.view
                                                  attribute:NSLayoutAttributeTop multiplier:1.0 constant:60.0f];
    NSLayoutConstraint *textFieldBottomConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.dateSelected attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.taskDescription
                                                     attribute:NSLayoutAttributeTop multiplier:0.8 constant:-60.0f];
    NSLayoutConstraint *textFieldLeftConstraint = [NSLayoutConstraint
                                                   constraintWithItem:self.dateSelected attribute:NSLayoutAttributeLeft
                                                   relatedBy:NSLayoutRelationEqual toItem:self.view attribute:
                                                   NSLayoutAttributeLeft multiplier:1.0 constant:30.0f];
    NSLayoutConstraint *textFieldRightConstraint = [NSLayoutConstraint 
                                                    constraintWithItem:self.dateSelected attribute:NSLayoutAttributeRight
                                                    relatedBy:NSLayoutRelationEqual toItem:self.view attribute:
                                                    NSLayoutAttributeRight multiplier:1.0 constant:-30.0f];
    [self.view addConstraints:@[textFieldBottomConstraint ,
                                textFieldLeftConstraint, textFieldRightConstraint, 
                                textFieldTopConstraint]];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void) dateChanged:(id)sender{
    self.dateSelected.text = [self formattedDate];
}

-(NSString * )formattedDate{
    NSDate *date = self.dueDate.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    NSLog(@"%@", dateString);
    
    return dateString;
}


-(void)backgroundImage{
    UIImage *image = [UIImage imageNamed:@"greencup"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

-(void)setUpNavigationBar{
    UIBarButtonItem *nextBtn = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextPage)];
    self.navigationItem.rightBarButtonItems = @[nextBtn];
    [self.navigationItem setTitle:@"New Task"];
}


-(void)nextPage{
    TableViewController *allTasks = [[TableViewController alloc] init];
    [[self navigationController] pushViewController:allTasks animated:YES];
}

-(void)submitTask{
    
    if([self.taskName.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please input your task name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([self.taskDescription.text isEqualToString:@"Task Description"] || [self.taskDescription.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please input your task description." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:self.managedObjectContext];
        
        // Initialize Record
        NSManagedObject *record = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        
        // Populate Record
        [record setValue:self.taskName.text forKey:@"name"];
        [record setValue:self.taskDescription.text forKey:@"desc"];
        [record setValue:self.dueDate.date forKey:@"due_date"];
        
        // Save Record
        NSError *error = nil;
        
        if ([self.managedObjectContext save:&error]) {
            UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"Task is saved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [successAlert show];
            
        } else {
            if (error) {
                NSLog(@"Unable to save record.");
                NSLog(@"%@, %@", error, error.localizedDescription);
            }
            
            // Show Alert View
            [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do could not be saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        
        [self scheduleNotification];
    }
    
}



#pragma mark - delegate methods

-(void)scheduleNotification{
    // Get the current date
    NSDate *pickerDate = [self.dueDate date];
    
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = pickerDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = self.taskName.text;
    localNotification.alertAction = @"check todo item!";
    localNotification.alertLaunchImage = @"AppIcon";
    localNotification.category = @"COUNTER_CATEGORY";
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    //[[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    
    if(localNotification){
        self.taskName.text = @"";
        self.taskDescription.text = @"";
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.taskDescription.text = nil;
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"Should Clear");
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.taskName) {
        [self.taskName resignFirstResponder];
        [self.taskDescription becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
     if([text isEqualToString:@"\n"]) {
         [textView resignFirstResponder];
         return NO;
     }
    return YES;
}

@end
