//
//  US2ArtistDetailViewController.h
//  GigFinder
//
//  Created by Tanya on 7/21/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface US2ArtistDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *artistImageView;
@property (weak, nonatomic) IBOutlet UIWebView *artistContentView;
@property (nonatomic, retain) NSString *artistName;


@end
