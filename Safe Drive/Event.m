//
//  Event.m
//  Safe Drive
//
//  Created by Andrew Roach on 5/12/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import "Event.h"

@implementation Event

- (NSDictionary *)hostToKinveyPropertyMapping
{
    return  @{ @"objectId" : KCSEntityKeyId, @"metadata" : KCSEntityKeyMetadata  };
}


@end
