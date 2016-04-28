//
//  TakeReadingViewController.m
//  Safe Drive
//
//  Created by Andrew Roach on 4/25/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import "ConfirmParentViewController.h"
#import "KinveyDownloader.h"
#import "Settings.h"
#import "KinveyUploader.h"


@interface ConfirmParentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *confirmationStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) KinveyDownloader *kD;
@property (strong, nonatomic) Settings *matchingSetting;
@end

@implementation ConfirmParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.kD = [[KinveyDownloader alloc]init];
    [self.kD downloadSettingsAsChild];
    
    self.confirmButton.hidden = FALSE;
    self.confirmationStatusLabel.hidden = FALSE;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureView) name:@"SettingsDownloaded" object:nil];
    
}

-(void)configureView {
    
    for (Settings *setting in self.kD.settings) {
        if ([setting.childUserName isEqualToString:[KCSUser activeUser].email]) {
            self.matchingSetting = setting;
            [self updateButtonsToFoundParent:setting.parentUserName];
            return;
        }
    }
    [self updateButtonToNotFound];
}

-(void)updateButtonsToFoundParent:(NSString *)parentEmail{
    NSString *titleString = [NSString stringWithFormat:@"%@ has listed you as their child, please confirm", parentEmail];
    [self.confirmationStatusLabel setText:titleString];
    [self.confirmButton setTitle: @"Confirm" forState:UIControlStateNormal];
    self.confirmButton.hidden = FALSE;
    self.confirmationStatusLabel.hidden = FALSE;
}

-(void)updateButtonToNotFound{
    [self.confirmationStatusLabel setText:@"No parent found, please have your parent create an account"];
    self.confirmButton.titleLabel.text = @"Reload";
    self.confirmButton.backgroundColor = [UIColor colorWithRed:19/255.0 green:59/255.0 blue:77/255.0 alpha:1.0];
}

- (IBAction)confirmButtonPressed:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"Reload"]) {
            [self.kD downloadSettingsAsChild];
    }
    else {
        self.matchingSetting.confirmedLink = [NSNumber numberWithBool:TRUE];
        KinveyUploader *kU = [[KinveyUploader alloc]init];
        [kU uploadSetting:self.matchingSetting];
        
    }
}




@end
