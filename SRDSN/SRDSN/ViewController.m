//
//  ViewController.m
//  SRDSN
//
//  Created by Jennie Shapira on 2/27/14.
//  Copyright (c) 2014 Jennie Shapira. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myWebView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)switchPressed:(id)sender {
    UISwitch *theSwitch = (UISwitch *) sender;
    
    if (theSwitch.isOn){
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.2/$1"];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [myWebView loadRequest:req];
    }
    else {
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.2/$2"];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [myWebView loadRequest:req];
    }
}

@end

//KALMAN FILTER
