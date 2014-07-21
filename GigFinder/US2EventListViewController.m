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
#import "AsyncImageView.h"
#define ASYNC_IMAGE_TAG 8888
#import "US2EventDetailViewController.h"

@interface US2EventListViewController () <US2EventProxyDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSTimer *aTimer;
    UIActivityIndicatorView *act;
    UILabel *noResultsFound;
}

@property (nonatomic, strong, readwrite) NSMutableArray *artistEventImageArray;
@property (nonatomic, strong, readwrite) NSArray *artists;
@property (nonatomic, strong, readwrite) US2EventProxy *eventProxy;
@property (nonatomic, strong, readwrite) IBOutlet US2EventListView *tableView;

@end

@implementation US2EventListViewController

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"GigFinder";
    
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    /*int height;
    if (IS_IPHONE_5)
    {
        height = 1074;
    }
    else
    {
        height = 374;
    }
    
    [self.eventListView.tableView setFrame:CGRectMake(0, 44, 320, height)];
    [self.eventListView.tableView setNeedsDisplay];
    NSLog(@"Height: %d", height);*/
}

#pragma mark - Event proxy

- (void)eventProxy:(US2EventProxy *)eventProxy retrievedArtists:(NSArray *)artists
{
    NSLog(@"retrievedArtists: %@", artists);
    self.artists = artists;
    
    NSLog(@"isMain :%@", [NSThread isMainThread] ? @"YES" : @"NO");
    
    [act stopAnimating];
    [self.eventListView.tableView reloadData];
    
    //if result array is empty
    if ([artists count] == 0)
    {
        noResultsFound = [[UILabel alloc] init];
        [noResultsFound setFrame:CGRectMake(60, 130, 200, 100)];
        noResultsFound.layer.cornerRadius = 10;
        [noResultsFound setTextAlignment:NSTextAlignmentCenter];
        [noResultsFound setText:@"No results found!"];
        [noResultsFound setTextColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
        [noResultsFound.layer setBackgroundColor:[[UIColor colorWithWhite: 0.0 alpha:0.30] CGColor]];
        [self.view addSubview:noResultsFound];
    }
        
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
    
#define IMAGE_VIEW_TAG 99
    
    NSDictionary *artistInfo = [self.artists objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:@"MyCell"];
    
    if ([self.artists count] > 0)
    {
        if (cell == nil)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:@"MyCell"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        else
        {
            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
            //                            reuseIdentifier:@"MyCell"];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:@"MyCell"];
            
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
            AsyncImageView *asyncImage = [[AsyncImageView alloc] init];
            asyncImage.tag = ASYNC_IMAGE_TAG;
            NSURL *url = [NSURL URLWithString:[artistInfo objectForKey:@"artisEventtImageSmall"]];
            NSLog(@"imageURL: %@", url);
            
            UIImageView *cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            [cellImageView setContentMode:UIViewContentModeScaleAspectFit];
            if (![[artistInfo objectForKey:@"artisEventtImageSmall"] isEqualToString:@""])
            {
                [asyncImage loadImageWithTypeFromURL:url contentMode:UIViewContentModeScaleAspectFit imageNameBG:nil];
                cellImageView.image = asyncImage.image;
                [cell.contentView addSubview:cellImageView];
            }
            else
            {
                cellImageView.image = [UIImage imageNamed:@"noimage.png"];
                [cell.contentView addSubview:cellImageView];
            }
            
            NSDictionary *artistInfo = [self.artists objectAtIndex:indexPath.row];
            
            [cell.contentView addSubview:[self createLabel:25 withWidth:220 withX:108 withY:12 withSize:15.0f withText:[artistInfo objectForKey:@"artistEventLocationName"]]];
            [cell.contentView addSubview:[self createLabel:25 withWidth:220 withX:108 withY:39 withSize:12.0f withText:[NSString stringWithFormat:@"%@", [artistInfo objectForKey:@"artistEventStartDate"]]]];
            [cell.contentView addSubview:[self createLabel:25 withWidth:220 withX:108 withY:53 withSize:11.0f withText:[NSString stringWithFormat:@"Artist name: %@", [artistInfo objectForKey:@"artistName"]]]];
            
            
            //cell.textLabel.text = [artistInfo objectForKey:@"artistEventLocationName"];
            //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [artistInfo objectForKey:@"artistEventStartDate"]];
        }
    }
    
    return cell;
}

- (UILabel *)createLabel:(float)height withWidth:(float) width withX:(float)x withY:(float)y withSize:(float)size withText:(NSString *)labelText
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [label setTextColor:[UIColor blackColor]];
    [label setText:labelText];
    [label setFont:[UIFont fontWithName:@"Helvetica-light" size:size]];
    return label;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *artistInfo = [self.artists objectAtIndex:indexPath.row];
    US2EventDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    
    NSString *startDate = [artistInfo objectForKey:@"artistEventStartDate"];
    NSArray *startDateArray = [startDate componentsSeparatedByString: @" "];
    detail.month = [startDateArray objectAtIndex:2];
    detail.date = [startDateArray objectAtIndex:1];
    detail.eventPlaceName = [artistInfo objectForKey:@"artistEventLocationName"];
    detail.artistName = [artistInfo objectForKey:@"artistName"];
    detail.fullDate = [NSString stringWithFormat:@"%@ %@ %@ %@", [startDateArray objectAtIndex:0], [startDateArray objectAtIndex:1], [startDateArray objectAtIndex:2], [startDateArray objectAtIndex:3]];
    detail.city = [artistInfo objectForKey:@"artistEventCity"];
    detail.country = [artistInfo objectForKey:@"artistEventCountry"];
    detail.eventImageURL = [artistInfo objectForKey:@"artisEventtImageLarge"];
    detail.allArtistDic = self.artists;
    detail.eventURL = [artistInfo objectForKey:@"artistEventURL"];
    detail.latitude = [[artistInfo objectForKey:@"artistVenueLatitude"] doubleValue];
    detail.longitude = [[artistInfo objectForKey:@"artistVenueLongtitude"] doubleValue];
    
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - Table view delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [noResultsFound removeFromSuperview];
    self.eventProxy = [[US2EventProxy alloc] init];
    self.eventProxy.delegate = self;
    NSString *string = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [self.eventProxy retrieveEventsOfArtist:string];
    
    [self.eventListView.tableView reloadData];
    [searchBar resignFirstResponder];
    
    act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // make the area larger
    [act setFrame:CGRectMake(320/2-50, 130, 100, 100)];
    act.layer.cornerRadius = 10;
    // set a background color
    [act.layer setBackgroundColor:[[UIColor colorWithWhite: 0.0 alpha:0.30] CGColor]];
    //CGPoint center = self.view.center;
    //activity.center = center;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, act.frame.size.width, 20)];
    [lable setText:@"Loading..."];
    [lable setFont:[UIFont fontWithName:@"Helvetica-Light" size:12.0f]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    [lable setTextColor:[UIColor whiteColor]];
    [act addSubview:lable];
    
    [self.view addSubview:act];
    [act startAnimating];
}

@end
