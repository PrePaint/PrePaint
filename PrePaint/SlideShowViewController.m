//
//  SlideShowViewController.m
//  PrePaint
//
//  Created by Xi Zhang on 4/17/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "SlideShowViewController.h"
#import "BaseViewController.h"

static NSString * const kPageIdentifier = @"Page";

@interface SlideShowViewController ()

@end

@implementation SlideShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pagingScrollView = [[GMCPagingScrollView alloc] initWithFrame:self.view.bounds];
    self.pagingScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.pagingScrollView.dataSource = self;
    self.pagingScrollView.infiniteScroll = YES;
    self.pagingScrollView.interpageSpacing = 0;
     [self.view addSubview:self.pagingScrollView];
    [self.view sendSubviewToBack:self.pagingScrollView];
    [self.pagingScrollView registerClass:[UIView class] forReuseIdentifier:kPageIdentifier];
    
    [self.pagingScrollView reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (NSUInteger)numberOfPagesInPagingScrollView:(GMCPagingScrollView *)pagingScrollView {
    return 15;
}

- (UIView *)pagingScrollView:(GMCPagingScrollView *)pagingScrollView pageForIndex:(NSUInteger)index {
    UIView *page = [pagingScrollView dequeueReusablePageWithIdentifier:kPageIdentifier];
    
    switch (index) {
        case 0:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"goat_page_1"]];
        }
            break;
        case 1:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"goat_page_2"]];
        }
            break;
        case 2:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"goat_page_3"]];
        }
            break;
            
        case 3:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"vein_page_1"]];
        }
            break;
        case 4:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"vein_page_2"]];
        }
            break;
        case 5:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"vein_page_3"]];
        }
            break;
            
        case 6:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"wolf_page_1"]];
        }
            break;
        case 7:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"wolf_page_2"]];
        }
            break;
        case 8:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"wolf_page_3"]];
        }
            break;
            
        case 9:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"combination_page_1"]];
        }
            break;
        case 10:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"combination_page_2"]];
        }
            break;
        case 11:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"combination_page_3"]];
        }
            break;
        case 12:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"landscape_page_1"]];
        }
            break;
        case 13:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"landscape_page_2"]];
        }
            break;
        case 14:
        {
            UIImageView *imageView =[[UIImageView alloc] initWithFrame:page.bounds];
            [page addSubview:imageView];
            [imageView setImage:[UIImage imageNamed:@"landscape_page_3"]];
        }
            break;
    }
    
    return page;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)leftButtonAction:(id)sender {
}

- (IBAction)rightButtonAction:(id)sender {
}

- (IBAction)cancelButtonAction:(id)sender {
    
    [(BaseViewController*)self.responseDelegate closeSlideView];
}
@end
