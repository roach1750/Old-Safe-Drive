//
//  ChildernTVC.m
//  Safe Drive
//
//  Created by Andrew Roach on 4/25/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import "ChildernTVC.h"

@interface ChildernTVC ()

@end

@implementation ChildernTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)addChildButtonPressed:(UIBarButtonItem *)sender {
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"child"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"child"];
    }
    
    cell.textLabel.text =  @"child1";

    
    return cell;
    
}


@end
