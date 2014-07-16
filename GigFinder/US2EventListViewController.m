//
//  US2EventListViewController.m
//  GigFinder
//
//  Created by Tanya on 7/16/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import "US2EventListViewController.h"
#import "US2EventProxy.h"

@interface US2EventListViewController () <US2EventProxyDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong, readwrite) US2EventProxy *eventProxy;
@end

@implementation US2EventListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.eventProxy = [[US2EventProxy alloc] init];
    self.eventProxy.delegate = self;
    [self.eventProxy retrieveAllArtists];
}

#pragma mark - Event proxy

- (void)eventProxy:(US2EventProxy *)eventProxy retrievedArtists:(NSArray *)artists
{
    NSLog(@"retrievedArtists: %@", artists);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"test";
    return cell;
}

#pragma mark - Table view delegate

@end
