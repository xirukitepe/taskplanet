//
//  ViewController.m
//  TodoList
//
//  Created by Shiela S on 2/9/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "CreateToDoViewController.h"

@interface ViewController ()
@property (strong,nonatomic) UILabel *greetings;
@property (strong,nonatomic) UITextField *name;
@property (strong,nonatomic) UIButton *submitName;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.greetings];
    [self.view addSubview:self.name];
    [self.view addSubview:self.submitName];
  

    
    
    [self backgroundImage];
}


#pragma mark - properties
-(UILabel *)greetings{
    if(!_greetings){
        _greetings = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, FULL_WIDTH, TEXTFIELD_HEIGHT)];
        _greetings.center = CGPointMake(SCREEN_CENTER_X, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + SCREEN_MARGIN);
        _greetings.frame = CGRectMake(_greetings.frame.origin.x, _greetings.frame.origin.y, _greetings.frame.size.width, _greetings.frame.size.height);
        _greetings.text = nil;
    }
    return _greetings;
}

-(UITextField *)name{
    if(!_name){
        _name = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, TEXTFIELD_HEIGHT)];
        _name.center = CGPointMake(SCREEN_CENTER_X,self.greetings.frame.origin.y + self.greetings.frame.size.height + ELEM_MARGIN);
        _name.frame = CGRectMake(_name.frame.origin.x, _name.frame.origin.y, _name.frame.size.width, _name.frame.size.height);
        _name.placeholder = @"Write your name here";
        _name.layer.borderWidth = 2.0f;
        _name.layer.borderColor = [UIColor lightGrayColor].CGColor;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, _name.frame.size.height)];
        _name.leftView = leftView;
        _name.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return _name;
}

-(UIButton *)submitName{
    if(!_submitName){
        _submitName = [[UIButton alloc] initWithFrame:CGRectMake(0,0, FULL_WIDTH, BUTTON_HEIGHT)];
        _submitName.center = CGPointMake(SCREEN_CENTER_X, self.name.frame.origin.y + self.name.frame.size.height + ELEM_MARGIN);
        _submitName.frame = CGRectMake(self.submitName.frame.origin.x, self.submitName.frame.origin.y, self.submitName.frame.size.width, self.submitName.frame.size.height);
        
        [_submitName setTitle:@"Submit" forState:(UIControlStateNormal)];
        _submitName.backgroundColor = [UIColor blackColor];
        [_submitName addTarget:self action:@selector(submitTextField) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitName;
}

#pragma mark - methods

-(void)backgroundImage{
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"geometry"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

-(void)submitTextField{
    if([self.name.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please input your name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        self.greetings.text = [NSString stringWithFormat:@"Hello %@!", self.name.text];
        self.name.text = @"";
        CreateToDoViewController *createTaskPage = [[CreateToDoViewController alloc] init];
        [self presentViewController:createTaskPage animated:YES completion:nil];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
