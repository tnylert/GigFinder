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
        
        
        cell.textLabel.text = [artistInfo objectForKey:@"artistEventLocationName"];
        //cell.detailTextLabel.text = [item objectForKey:@"secondaryTitleKey"];
        //NSString *path = [[NSBundle mainBundle] pathForResource:[item objectForKey:@"imageKey"] ofType:@"png"];
        //UIImage *theImage = [UIImage imageWithContentsOfFile:path];

        // TODO: (TL) fix this code
    
        
        dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        
        dispatch_async(backgroundQueue, ^{
            NSURL *url = [NSURL URLWithString:[artistInfo objectForKey:@"artisEventtImage"]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *artistImage = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = artistImage;
            });
        });
        
        NSLog(@"LOG: name: %@", self.artists);
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
