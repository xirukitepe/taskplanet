//
//  DetailViewController.m
//  TodoList
//
//  Created by Shiela S on 2/11/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "DetailViewController.h"
#import "Constants.h"

@interface DetailViewController ()
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *desc;
@property (strong, nonatomic) UILabel *dueDate;
@end

@implementation DetailViewController
-(void)viewDidLoad{
    
    [self.view addSubview:self.name];
    [self.view addSubview:self.desc];
    [self.view addSubview:self.dueDate];
    [self setUpNavigationBar];
    [self backgroundImage];
}

#pragma mark - properties

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 30)];
        _name.center = CGPointMake(SCREEN_CENTER_X, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + ELEM_MARGIN);
        _name.frame = CGRectMake(_name.frame.origin.x, _name.frame.origin.y, _name.frame.size.width, _name.frame.size.height);
        _name.text = [self.task valueForKey:@"name"];
        
    }
    return _name;
}

-(UILabel *)desc{
    if (!_desc) {
        _desc = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 30)];
        _desc.center = CGPointMake(SCREEN_CENTER_X, self.name.frame.origin.y + self.name.frame.size.height + DETAIL_MARGIN);
        _desc.frame = CGRectMake(_desc.frame.origin.x, _desc.frame.origin.y, _desc.frame.size.width, _name.frame.size.height);
        _desc.text = [self.task valueForKey:@"desc"];
        
    }
    return _desc;
}

-(UILabel *)dueDate{
    if (!_dueDate) {
        _dueDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 30)];
        _dueDate.center = CGPointMake(SCREEN_CENTER_X, self.desc.frame.origin.y + self.desc.frame.size.height + DETAIL_MARGIN);
        _dueDate.frame = CGRectMake(_dueDate.frame.origin.x, _dueDate.frame.origin.y, _dueDate.frame.size.width, _name.frame.size.height);
        
        NSDate *date = [self.task valueForKey:@"due_date"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        NSString *dateString = [formatter stringFromDate:date];
        
        _dueDate.text = dateString;
        
    }
    return _dueDate;
}

#pragma mark - methods
-(void)backgroundImage{
    UIImage *image = [UIImage imageNamed:@"paper"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

-(void)setUpNavigationBar{
    [self.navigationItem setTitle:[self.task valueForKey:@"name"]];
}
@end
