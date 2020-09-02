//
//  ViewController.m
//  BigIgvBrowser
//
//  Created by DahaoJiang on 2020/9/2.
//  Copyright © 2020 DahaoJiang. All rights reserved.
//

#import "ViewController.h"
#import "DlBigImageView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DlBigImageView *bigIgv = [[DlBigImageView alloc] initWithFrame:self.view.bounds];
    bigIgv.imageName = @"BigPicture";
    bigIgv.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:bigIgv];
    
}


@end
