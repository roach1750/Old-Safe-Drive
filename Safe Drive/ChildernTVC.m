//
//  ChildernTVC.m
//  Safe Drive
//
//  Created by Andrew Roach on 4/25/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import "ChildernTVC.h"
#import "KinveyUploader.h"
#import "KinveyDownloader.h"
#import "Settings.h"

@interface ChildernTVC ()

@property (strong,nonatomic) KinveyDownloader *kD;
@property (strong, nonatomic) NSArray *settings;
@end

@implementation ChildernTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.kD = [[KinveyDownloader alloc] init];
    [self.kD downloadSettingsAsParent];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable)
                                                 name:@"SettingsDownloaded"
                                               object:nil];
}




- (IBAction)addChildButtonPressed:(UIBarButtonItem *)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Add Child"
                                          message:@"Please enter your child's email address"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){}];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"Request"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   if (![alertController.textFields.firstObject.text isEqualToString:@""]) {
                                       [self addChildWithEmail:alertController.textFields.firstObject.text];
                                   }
                                   
                               }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 [alertController dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alertController addAction:cancel];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}


-(void)addChildWithEmail:(NSString *)email {
    KinveyUploader *KU = [[KinveyUploader alloc]init];
    [KU uploadDefaultSettingsWithChildEmail:email];
}

#pragma mark - Table view data source


-(void)reloadTable{
    self.settings = self.kD.settings;
    [self.tableView reloadData];
}
- (IBAction)reloadButtonPressed:(UIBarButtonItem *)sender {
        [self.kD downloadSettingsAsParent];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.settings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"child"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"child"];
    }
    
    Settings *setting = [self.settings objectAtIndex:indexPath.row];
    



    
    NSString *imageName = [setting.confirmedLink boolValue] ? @"Green" : @"Red";
    
    cell.detailTextLabel.text = [setting.confirmedLink boolValue] ? @"Confirmed" : @"Unconfirmed";
    
    cell.accessoryView = [self makeDetailButton:imageName];
    
    cell.textLabel.text =  setting.childUserName;
    
    return cell;
    
}

-(UIButton *)makeDetailButton:(NSString *)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 30, 30)];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor clearColor]];
    return  button;
}




@end
