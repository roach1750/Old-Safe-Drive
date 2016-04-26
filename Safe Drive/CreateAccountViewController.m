//
//  CreateAccountViewController.m
//  Safe Drive
//
//  Created by Andrew Roach on 4/25/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import "CreateAccountViewController.h"

@interface CreateAccountViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *reEnterPasswordTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *userTypeSegmentedControl;

@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)createAccountButtonPress:(UIButton *)sender {
    
}

@end
