//
//  ViewController.m
//  Safe Drive
//
//  Created by Andrew Roach on 4/25/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import "LoginViewController.h"
#import <KinveyKit/KinveyKit.h>
#import "KinveyDownloader.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;
@property (strong, nonatomic) KinveyDownloader *kD;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[KCSUser activeUser]logout];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loginIfUserExists) userInfo:nil repeats:NO];
    self.kD = [[KinveyDownloader alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(segugeAsChild) name:@"SettingsDownloaded" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SettingsDownloaded" object:nil];
}


-(void)loginIfUserExists{
    if ([KCSUser activeUser] != nil) {
        NSLog(@"Logged in as: %@",[[KCSUser activeUser] username]);
        NSString *userType = [[KCSUser activeUser] getValueForAttribute:@"User Type"];
        if ([userType isEqualToString:@"Parent"]) {
            [self performSegueWithIdentifier:@"startAsParent" sender:nil];
        }
        else { //child
            [self.kD downloadSettingsAsChild];
        }
    }
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    NSString *userName = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [KCSUser loginWithUsername:userName password:password withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
        if (errorOrNil != nil) {
            NSLog(@"Error logging in: %@", errorOrNil.description);
        }
        else {
            NSLog(@"Logged In as: %@", userName);
            NSString *userType = [[KCSUser activeUser] getValueForAttribute:@"User Type"];
            NSLog(@"%@",userType);
            if ([userType isEqualToString:@"Parent"]) {
                [self performSegueWithIdentifier:@"startAsParent" sender:nil];
            }
            else { //child
                [self.kD downloadSettingsAsChild];
            }
        }
    }];
}

-(void)segugeAsChild{
    
    if ([self.kD.settings count] > 0) {
        [self performSegueWithIdentifier:@"startTest" sender:nil];

    }
    else {
        
        [self performSegueWithIdentifier:@"startAsChild" sender:nil];
    }

    
}


@end
