//
//  TestViewController.m
//  Safe Drive
//
//  Created by Andrew Roach on 4/28/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import "TestViewController.h"
#import "BACtrack.h"

@interface TestViewController () <BacTrackAPIDelegate>
@property (strong, nonatomic) BacTrackAPI *mbacTrack;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@end

@implementation TestViewController

- (void)viewDidLoad {
    self.mbacTrack = [[BacTrackAPI alloc] initWithDelegate:self AndAPIKey:@"0a32f2ab7bf144e4905e723347989b"];
    [super viewDidLoad];
}

-(void)BacTrackAPIKeyDeclined:(NSString *)errorMessage	{
    NSLog(@"API KEY Doesn't work: %@",errorMessage);
}

- (IBAction)connectButtonPressed:(UIButton *)sender {
    [self.mbacTrack connectToNearestBreathalyzer];
}

-(void)BacTrackConnected{
    NSLog(@"connected");
}
@end
