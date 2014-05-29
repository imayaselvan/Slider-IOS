//
//  ViewController.m
//  Distance
//
//  Created by Administrator on 27/05/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "ViewController.h"
#import "DistanceEditorView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:248/255.0 alpha:1.0];
    
    DistanceEditorView *distanceEditorView = [[DistanceEditorView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 60)];
    [self.view addSubview:distanceEditorView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
