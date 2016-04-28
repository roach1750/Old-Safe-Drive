//
//  KinveyDownloader.m
//  Safe Drive
//
//  Created by Andrew Roach on 4/28/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import "KinveyDownloader.h"
#import "Settings.h"
@implementation KinveyDownloader




-(void)downloadSettings{
    
    KCSCollection* collection = [KCSCollection collectionFromString:@"Settings" ofClass:[Settings class]];
    KCSAppdataStore *store = [KCSAppdataStore storeWithCollection:collection options:nil];
    
    [store queryWithQuery:[[KCSQuery alloc]init] withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
        
        if (errorOrNil == nil && [objectsOrNil count] > 0) {
            self.settings = objectsOrNil;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SettingsDownloaded" object:nil];
        }
        
    } withProgressBlock:^(NSArray *objects, double percentComplete) {
        
    }];
    
    
}




@end
