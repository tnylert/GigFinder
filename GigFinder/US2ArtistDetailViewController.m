//
//  US2ArtistDetailViewController.m
//  GigFinder
//
//  Created by Tanya on 7/21/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import "US2ArtistDetailViewController.h"
#import "US2ArtistProxy.h"
#import "US2Artist.h"

@interface US2ArtistDetailViewController ()<US2ArtistProxyDelegate>
{
    UIActivityIndicatorView *act;
}


@property (nonatomic, strong, readwrite) US2ArtistProxy *artistProxy;
@property (nonatomic, strong, readwrite) US2Artist *artistObject;


@end

@implementation US2ArtistDetailViewController

@synthesize artistImageView, artistContentView, artistName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.artistProxy = [[US2ArtistProxy alloc] init];
    self.artistProxy.delegate = self;
    self.artistObject = [[US2Artist alloc] init];
    NSLog(@"artistObject - artistname: %@", self.artistObject.artistName);
    [self.artistProxy retrieveArtistInfo:artistName];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)artistProxy:(US2ArtistProxy *)artistProxy retrievedInfo:(NSDictionary *)name
{
    
    [act stopAnimating];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[name objectForKey:@"artistImage"]]];
    artistImageView.image = [UIImage imageWithData:data];
    artistImageView.contentMode = UIViewContentModeScaleAspectFit;
    [artistContentView loadHTMLString:[name objectForKey:@"artistContent"] baseURL:nil];
    
    //[self.view setNeedsDisplay];
}


@end
