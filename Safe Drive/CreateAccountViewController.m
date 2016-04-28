//
//  CreateAccountViewController.m
//  Safe Drive
//
//  Created by Andrew Roach on 4/25/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import "CreateAccountViewController.h"
#import <KinveyKit/KinveyKit.h>

@interface CreateAccountViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
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
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.reEnterPasswordTextField resignFirstResponder];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)createAccountButtonPress:(UIButton *)sender {
    
    NSArray *textFields = [[NSArray alloc] initWithObjects:self.firstNameTextField, self.lastNameTextField, self.emailTextField, self.passwordTextField, nil];
    [textFields enumerateObjectsUsingBlock:^(UITextField *textField, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([textField.text isEqualToString:@""]) {
            [self showErrorAlertWithMessage:@"You must fill out all fields!" andTextField:nil];
            *stop = YES;
        }
        else if ([textField.text containsString:@" "]) {
            textField.text = @"";
            
            [self showErrorAlertWithMessage:@"Properties can't contain spaces!" andTextField:nil];
            return;
        }
    }];
    
    
    
    if (![self.passwordTextField.text isEqualToString:self.reEnterPasswordTextField.text]){
        [self.passwordTextField setText:@""];
        [self.reEnterPasswordTextField setText:@""];
        [self showErrorAlertWithMessage:@"Passwords do not Match" andTextField:self.passwordTextField];
    }
    else {
        NSString *userType;
        switch (self.userTypeSegmentedControl.selectedSegmentIndex) {
            case 0:
                userType = @"Child";
                break;
            case 1:
                userType = @"Parent";
                break;
            default:
                break;
        }
        
        
        [KCSUser userWithUsername:self.emailTextField.text
                         password:self.passwordTextField.text
                  fieldsAndValues:@{KCSUserAttributeEmail : self.emailTextField.text, KCSUserAttributeGivenname :self.firstNameTextField.text, KCSUserAttributeSurname : self.lastNameTextField.text , @"User Type" : userType}
              withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
                  if (errorOrNil == nil) {
                      NSLog(@"Created new user!");
                      NSString *userType = [[KCSUser activeUser] getValueForAttribute:@"User Type"];
                      NSLog(@"%@",userType);
                      if ([userType isEqualToString:@"Parent"]) {
                          [self performSegueWithIdentifier:@"startAsParent" sender:nil];
                      }
                      else { //child
                          [self performSegueWithIdentifier:@"startAsChild" sender:nil];
                      }
                      
                  } else {
                      //there was an error with the update save
                      NSLog(@"%@",errorOrNil);
                  };
              }];
        
    }
}

-(void)showErrorAlertWithMessage:(NSString * )message andTextField: (UITextField *) textField{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Error"
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             if (textField != nil) {
                                 [textField becomeFirstResponder];
                             }
                         }];
    
    [alert addAction:ok];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ( [string isEqualToString:@" "] ){
        return NO;
    }
    else {
        return YES;
    }
}


@end
