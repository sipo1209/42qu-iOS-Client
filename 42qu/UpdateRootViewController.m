//
//  UpdateRootViewController.m
//  42qu
//
//  Created by Alex Rezit on 12-5-22.
//  Copyright (c) 2012年 Seymour Dev. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "API.h"
#import "AccountControl.h"

#import "UpdateRootViewController.h"
//#import "PublishViewController.h"
#import "UpdateCell.h"

@interface UpdateRootViewController ()

@end

@implementation UpdateRootViewController

@synthesize updateList = _updateList;

#pragma mark - Actions

- (void)publish
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"oglFlip";
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
//    PublishViewController *publishViewController = [[[PublishViewController alloc] init] autorelease];
    
//    [self.navigationController pushViewController:publishViewController animated:NO]; 
}

- (void)loadData
{
    
}

- (void)refreshData
{
    SnsClient *snsClient = [API newConnection];
    @try {
        TaskFilter *taskFilter = [[[TaskFilter alloc] init] autorelease];
        taskFilter.state = TaskStatus_Open;
        taskFilter.sort = TaskSort_ByTime;
        taskFilter.city_id = 0;
        taskFilter.tag_id = 0;
        NSArray *newData = [snsClient task_list:[AccountControl shared].accessToken :TaskListType_All :taskFilter :0 :0];
        [_updateList removeAllObjects];
        [_updateList addObjectsFromArray:newData];
        [self.tableView reloadData];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
    [API closeConnection:snsClient];
}

#pragma mark - Life cycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"Update", nil);
    }
    return self;
}

- (void)dealloc
{
    [_updateList release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure nav bar items
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Filter", nil) style:UIBarButtonItemStylePlain target:self action:nil] autorelease];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(publish)] autorelease];
    
    self.updateList = [[[NSMutableArray alloc] init] autorelease];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _updateList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UpdateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
