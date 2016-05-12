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
@property (strong, nonatomic) BacTrackAPI *mBacTrack;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIView *viewForTesting;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *connectToCarButton;

@property (strong, nonatomic) CAShapeLayer *circleAnimationLayer;

@end


@implementation TestViewController

- (void)viewDidLoad {
    self.mBacTrack = [[BacTrackAPI alloc] initWithDelegate:self AndAPIKey:@"0a32f2ab7bf144e4905e723347989b"];
    
    [self.connectButton setHidden:FALSE];
    [self.viewForTesting setHidden:TRUE];
    [self.countdownLabel setHidden:TRUE];
    [self.startButton setHidden:TRUE];
    [self.statusLabel setHidden:TRUE];
    
    [super viewDidLoad];
}

-(void)BacTrackAPIKeyDeclined:(NSString *)errorMessage	{
    NSLog(@"API KEY Doesn't work: %@",errorMessage);
}

- (IBAction)connectButtonPressed:(UIButton *)sender {
    [self.mBacTrack connectToNearestBreathalyzer];
}

-(void)BacTrackConnected{
    [self.startButton setHidden:FALSE];
    [self.view bringSubviewToFront:self.startButton];
    [self.connectButton setHidden:TRUE];
}

- (IBAction)startButtonPressed:(UIButton *)sender {
    [self.startButton setHidden:TRUE];
    [self.statusLabel setText:@"Warming Up"];
    [self.statusLabel setHidden:FALSE];
    [self.viewForTesting setHidden:FALSE];
    firstTimeOnCountdown = TRUE;
    [self.mBacTrack startCountdown];
    
}







bool firstTimeOnCountdown;

-(void)BacTrackCountdown:(NSNumber *)number executionFailure:(BOOL)failure
{
    if (failure)
    {
        [self BacTrackError:nil];
        return;
    }
    else{
        NSLog(@"Status: %@",number);
        [self.countdownLabel setText:[NSString stringWithFormat:@"%@",number]];
        if (firstTimeOnCountdown == TRUE) {
            [self.viewForTesting setHidden:FALSE];
            [self.countdownLabel setHidden:FALSE];
            [self drawCircleWithDuration:[number doubleValue] andColor:[UIColor redColor]];
            firstTimeOnCountdown = FALSE;
        }
    }
}


bool firstTimeBlowing;

- (void)BacTrackStart
{
    firstTimeBlowing = TRUE;
    NSLog(@"start blowing");
    [self.circleAnimationLayer removeFromSuperlayer];
    [self.circleAnimationLayer removeAllAnimations];
    [self.statusLabel setText:@"Blow!"];
    [self.countdownLabel setText:@""];
    [self.countdownLabel setHighlighted:TRUE];

}

- (void)BacTrackBlow
{
    if (firstTimeBlowing == TRUE) {
        [self drawCircleWithDuration:5.0 andColor:[UIColor greenColor]];
        firstTimeBlowing = FALSE;
    }
}

- (void)BacTrackAnalyzing
{
    [self.circleAnimationLayer removeFromSuperlayer];
    [self.circleAnimationLayer removeAllAnimations];
    [self.statusLabel setText:@"Analyzing..."];
    [self.viewForTesting setHidden:TRUE];

}


-(void)BacTrackResults:(CGFloat)bac
{
    [self.circleAnimationLayer removeFromSuperlayer];
    [self.circleAnimationLayer removeAllAnimations];
    [self.viewForTesting setHidden:TRUE];
    [self.statusLabel setText:[NSString stringWithFormat:@"Your BAC: %f",bac]];
    if (bac == 0.0) {
        [self addStartCarButton];
    }
}


-(void)addStartCarButton {
    [self.connectToCarButton setHidden:FALSE];
}

- (IBAction)connectToCarButtonPressed:(UIButton *)sender {
    
}





-(void)drawCircleWithDuration:(double)duration andColor:(UIColor *)color{
    // Set up the shape of the circle
    [self.circleAnimationLayer removeFromSuperlayer];
    
    CGRect testingFrame = self.viewForTesting.frame;
    
    int radius = testingFrame.size.width * 0.4;
    NSLog(@"%d",radius);

    self.circleAnimationLayer = [CAShapeLayer layer];
    // Make a circular shape
    self.circleAnimationLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape in self.view
    self.circleAnimationLayer.position = CGPointMake(CGRectGetMidX(testingFrame)-radius,
                                  CGRectGetMidY(testingFrame)-radius);
    
    // Configure the apperence of the circle
    self.circleAnimationLayer.fillColor = [UIColor clearColor].CGColor;
    self.circleAnimationLayer.strokeColor = color.CGColor;
    self.circleAnimationLayer.lineWidth = 15;
    
    // Add to parent layer
    [self.view.layer addSublayer:self.circleAnimationLayer];
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    drawAnimation.duration            = duration; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation to the circle
    [self.circleAnimationLayer addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
}


#pragma mark - Error Handeling
-(void)BacTrackError:(NSError*)error
{
    if(error)
    {
        NSLog(@"CHECKCHECK %@", error.description);
        NSString* errorDescription = [error localizedDescription];
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorDescription preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [self dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}





@end
