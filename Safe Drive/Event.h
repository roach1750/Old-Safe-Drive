//
//  Event.h
//  Safe Drive
//
//  Created by Andrew Roach on 5/12/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KinveyKit/KinveyKit.h>

@interface Event : NSObject <KCSPersistable>

@property (nonatomic, retain) KCSMetadata* metadata; //Kinvey metadata







@end
