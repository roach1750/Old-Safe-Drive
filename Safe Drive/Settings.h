//
//  Settings.h
//  Safe Drive
//
//  Created by Andrew Roach on 4/27/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KinveyKit/KinveyKit.h>

@interface Settings : NSObject <KCSPersistable>

@property (nonatomic, retain) NSString *objectId;
@property (nonatomic, retain) NSString *childUserName;
@property (nonatomic, retain) NSString *parentUserName;
@property (nonatomic, retain) NSNumber *bacLimit;
@property (nonatomic, retain) NSNumber *confirmedLink;

@end
