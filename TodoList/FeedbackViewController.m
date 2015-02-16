//
//  FeedbackViewController.m
//  TaskPlanet
//
//  Created by Shiela S on 2/16/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "FeedbackViewController.h"
#import "Constants.h"

@interface FeedbackViewController ()
@property (strong, nonatomic) UITextField *recipient;
@property (strong, nonatomic) UILabel *recipientLabel;
@property (strong, nonatomic) UILabel *subjectLabel;
@property (strong, nonatomic) UITextField *subject;
@property (strong, nonatomic) UITextView *body;
@property (strong, nonatomic) UILabel *msgLabel;
@property (strong, nonatomic) UIButton *submit;
@property (strong, nonatomic) UIButton *cancel;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor: [UIColor lightGrayColor]];
    self.title = @"Send Feedback";
    [self.view addSubview:self.recipientLabel];
    [self.view addSubview:self.recipient];
    [self.view addSubview:self.subjectLabel];
    [self.view addSubview:self.subject];
    [self.view addSubview:self.msgLabel];
    [self.view addSubview:self.body];
    [self.view addSubview:self.submit];
    [self.view addSubview:self.cancel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UILabel *)recipientLabel{
    if (!_recipientLabel) {
        _recipientLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 30)];
        _recipientLabel.center = CGPointMake(SCREEN_CENTER_X, self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y + (ELEM_MARGIN));
        _recipientLabel.frame = CGRectMake(_recipientLabel.frame.origin.x, _recipientLabel.frame.origin.y, _recipientLabel.frame.size.width, _recipientLabel.frame.size.height);
        _recipientLabel.text = @"TO:";
    }
    
    return _recipientLabel;
}

-(UITextField *)recipient{
    if(!_recipient){
        _recipient = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, TEXTFIELD_HEIGHT)];
        _recipient.center = CGPointMake(SCREEN_CENTER_X, self.recipientLabel.frame.origin.y + self.recipientLabel.frame.size.height + ELEM_MARGIN);
        _recipient.frame = CGRectMake(_recipient.frame.origin.x, _recipient.frame.origin.y, _recipient.frame.size.width, _recipient.frame.size.height);
        _recipient.layer.borderWidth = 2.0f;
        _recipient.layer.borderColor = LIGHTGRAY_TEXTCOLOR.CGColor;
        _recipient.backgroundColor = [UIColor whiteColor];
        _recipient.text = @"shielas@sourcepad.com";
        _recipient.textColor = LIGHTGRAY_TEXTCOLOR;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, _recipient.frame.size.height)];
        _recipient.leftView = leftView;
        _recipient.leftViewMode = UITextFieldViewModeAlways;
        _recipient.layer.cornerRadius = 3.0f;
        _recipient.enabled= NO;
    }
    return _recipient;
}

-(UILabel *)subjectLabel{
    if (!_subjectLabel) {
        _subjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 30)];
        _subjectLabel.center = CGPointMake(SCREEN_CENTER_X, self.recipient.frame.origin.y + self.recipient.frame.size.height + ELEM_MARGIN);
        _subjectLabel.frame = CGRectMake(_subjectLabel.frame.origin.x, _subjectLabel.frame.origin.y, _subjectLabel.frame.size.width, _recipientLabel.frame.size.height);
        _subjectLabel.text = @"SUBJECT:";
    }
    
    return _subjectLabel;
}

-(UITextField *)subject{
    if(!_subject){
        _subject = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, TEXTFIELD_HEIGHT)];
        _subject.center = CGPointMake(SCREEN_CENTER_X, self.subjectLabel.frame.origin.y + self.subjectLabel.frame.size.height + ELEM_MARGIN);
        _subject.frame = CGRectMake(_subject.frame.origin.x, _subject.frame.origin.y, _subject.frame.size.width, _subject.frame.size.height);
        _subject.layer.borderWidth = 2.0f;
        _subject.layer.borderColor = LIGHTGRAY_TEXTCOLOR.CGColor;
        _subject.backgroundColor = [UIColor whiteColor];
        _subject.text = @"Feedback about Task Planet app";
        _subject.textColor = LIGHTGRAY_TEXTCOLOR;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, _subject.frame.size.height)];
        _subject.leftView = leftView;
        _subject.leftViewMode = UITextFieldViewModeAlways;
        _subject.layer.cornerRadius = 3.0f;
        _subject.enabled= NO;
    }
    return _subject;
}

-(UILabel *)msgLabel{
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 30)];
        _msgLabel.center = CGPointMake(SCREEN_CENTER_X, self.subject.frame.origin.y + self.subject.frame.size.height + ELEM_MARGIN);
        _msgLabel.frame = CGRectMake(_msgLabel.frame.origin.x, _msgLabel.frame.origin.y, _msgLabel.frame.size.width, _msgLabel.frame.size.height);
        _msgLabel.text = @"MESSAGE:";
    }
    
    return _msgLabel;
}

-(UITextView *)body{
    if(!_body){
        _body = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 180)];
        _body.center = CGPointMake(SCREEN_CENTER_X, self.msgLabel.frame.origin.y + self.msgLabel.frame.size.height + (ELEM_MARGIN * 3));
        _body.frame = CGRectMake(_body.frame.origin.x, _body.frame.origin.y, _body.frame.size.width, _body.frame.size.height);
        _body.layer.borderWidth = 2.0f;
        _body.layer.borderColor = LIGHTGRAY_TEXTCOLOR.CGColor;
        [_body setFont:[UIFont systemFontOfSize:17]];
        _body.textColor = [UIColor lightGrayColor];
        _body.layer.cornerRadius = 3.0f;
    }
    return _body;
}

-(UIButton *)submit{
    if (!_submit) {
        _submit = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, BUTTON_HEIGHT)];
        _submit.center = CGPointMake(SCREEN_CENTER_X, self.body.frame.origin.y + self.body.frame.size.height + ELEM_MARGIN);
        _submit.frame = CGRectMake(_submit.frame.origin.x, _submit.frame.origin.y, _submit.frame.size.width, _submit.frame.size.height);
        [_submit setTitle:@"Send" forState:UIControlStateNormal];
        _submit.layer.borderWidth = 2.0f;
        _submit.layer.borderColor = BUTTON_BG_GREEN.CGColor;
        _submit.backgroundColor = BUTTON_BG_GREEN;
        //[_submit addTarget:self action:@selector(sendFeedback) forControlEvents:UIControlEventTouchUpInside];
        _submit.layer.cornerRadius = 3.0f;
        _submit.layer.masksToBounds = NO;
        _submit.layer.shadowColor = BUTTON_BG_GREEN.CGColor;
        _submit.layer.shadowOpacity = 0.8;
        _submit.layer.shadowRadius = 20;
        _submit.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
    }
    return _submit;
}

-(UIButton *)cancel{
    if (!_cancel) {
        _cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, BUTTON_HEIGHT)];
        _cancel.center = CGPointMake(SCREEN_CENTER_X, self.submit.frame.origin.y + self.submit.frame.size.height + ELEM_MARGIN);
        _cancel.frame = CGRectMake(_cancel.frame.origin.x, _cancel.frame.origin.y, _cancel.frame.size.width, _cancel.frame.size.height);
        [_cancel setTitle:@"Cancel" forState:UIControlStateNormal];
        _cancel.layer.borderWidth = 2.0f;
        _cancel.layer.borderColor = BUTTON_BG_GREEN.CGColor;
        _cancel.backgroundColor = BUTTON_BG_GREEN;
        [_cancel addTarget:self action:@selector(cancelFeedback) forControlEvents:UIControlEventTouchUpInside];
        _cancel.layer.cornerRadius = 3.0f;
        _cancel.layer.masksToBounds = NO;
        _cancel.layer.shadowColor = BUTTON_BG_GREEN.CGColor;
        _cancel.layer.shadowOpacity = 0.8;
        _cancel.layer.shadowRadius = 20;
        _cancel.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
    }
    return _cancel;
}

#pragma mark - methods



-(void)cancelFeedback{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
