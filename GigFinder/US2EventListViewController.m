//
//  US2EventListViewController.m
//  GigFinder
//
//  Created by Tanya on 7/16/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import "US2EventListViewController.h"
#import "US2EventProxy.h"
#import "US2EventListView.h"

@interface US2EventListViewController () <US2EventProxyDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSTimer *aTimer;
}

@property (nonatomic, strong, readwrite) NSArray *artists;
@property (nonatomic, strong, readwrite) US2EventProxy *eventProxy;
@property (nonatomic, strong, readwrite) IBOutlet US2EventListView *tableView;

@end

@implementation US2EventListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"GigFinder";
    
    checkFirstTimer = @"0";
    
}

#pragma mark - Event proxy

- (void)eventProxy:(US2EventProxy *)eventProxy retrievedArtists:(NSArray *)artists
{
    NSLog(@"retrievedArtists: %@", artists);
    self.artists = artists;
    
    NSLog(@"isMain :%@", [NSThread isMainThread] ? @"YES" : @"NO");
    
    [self.eventListView.tableView reloadData];
        
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.artists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"test";
    return cell;*/
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];

    if ([self.artists count] > 0)
    {
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        NSDictionary *artistInfo = [self.artists objectAtIndex:indexPath.row];
        
        
        cell.textLabel.text = [artistInfo objectForKey:@"artistName"];
        //cell.detailTextLabel.text = [item objectForKey:@"secondaryTitleKey"];
        //NSString *path = [[NSBundle mainBundle] pathForResource:[item objectForKey:@"imageKey"] ofType:@"png"];
        //UIImage *theImage = [UIImage imageWithContentsOfFile:path];

        // TODO: (TL) fix this code
        
//        NSURL *url = [NSURL URLWithString:@"http://userserve-ak.last.fm/serve/126/98245551.png"]; //[artistInfo objectForKey:@"artistImage"]];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        UIImage *artistImage = [UIImage imageWithData:data];
//        cell.imageView.image = artistImage;
        
        NSLog(@"LOG: name: %@", self.artists);
        //checkFirstTimer = 1;
    }
    
    
    return cell;
}

#pragma mark - Table view delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.eventProxy = [[US2EventProxy alloc] init];
    self.eventProxy.delegate = self;
    [self.eventProxy retrieveEventsOfArtist:searchBar.text];
}

@end
