//
//  KinveyDownloader.h
//  Safe Drive
//
//  Created by Andrew Roach on 4/28/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KinveyKit/KinveyKit.h>

@interface KinveyDownloader : NSObject
@property (strong, nonatomic) NSArray *settings;
-(void)downloadSettings;
@end
