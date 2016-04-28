//
//  Settings.m
//  Safe Drive
//
//  Created by Andrew Roach on 4/27/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import "Settings.h"

@implementation Settings


- (NSDictionary *)hostToKinveyPropertyMapping
{
    return  @{ @"objectId" : KCSEntityKeyId, @"childUserName" : @"childUserName", @"bacLimit":@"bacLimit", @"parentUserName" : @"parentUserName", @"confirmedLink" : @"confirmedLink", @"metadata" : KCSEntityKeyMetadata  };
}



@end
