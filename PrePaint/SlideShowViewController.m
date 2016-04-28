//
//  SlideShowViewController.m
//  PrePaint
//
//  Created by Jing Tang on 4/17/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "SlideShowViewController.h"
#import "BaseViewController.h"




static NSString * const kPageIdentifier = @"Page";

@interface SlideShowViewController ()
{
    BOOL _isAutoScrolling;
}
@end

@implementation SlideShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pagingScrollView = [[GMCPagingScrollView alloc] initWithFrame:self.view.bounds];
    self.pagingScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.pagingScrollView.dataSource = self;
    self.pagingScrollView.delegate = self;
    self.pagingScrollView.infiniteScroll = YES;
    self.pagingScrollView.interpageSpacing = 0;
    [self.view addSubview:self.pagingScrollView];
    [self.view sendSubviewToBack:self.pagingScrollView];
    [self.pagingScrollView registerClass:[UIView class] forReuseIdentifier:kPageIdentifier];
    [self.pagingScrollView reloadData];
    [self.pagingScrollView setCurrentPageIndex:self.selectedTag*3 animated:NO];
    // Do any additional setup after loading the view from its nib.
}

- (NSUInteger)numberOfPagesInPagingScrollView:(GMCPagingScrollView *)pagingScrollView {
    switch (self.currentTreasureType) {
        case PPTreasureTypeBrush:
        {
            return kTotoalPageNumberBrush;
        }
            break;
        case PPTreasureTypePaper:
        {
            return kTotoalPageNumberPaper;
        }
            break;
        case PPTreasureTypeHolder:
        {
            return kTotoalPageNumberInk;
        }
            break;
        case PPTreasureTypeInk:
        {
            return kTotoalPageNumberColor;
        }
            break;
            
        default:
            break;
    }
    
}

- (UIView *)pagingScrollView:(GMCPagingScrollView *)pagingScrollView pageForIndex:(NSUInteger)index {
    UIView *page = [pagingScrollView dequeueReusablePageWithIdentifier:kPageIdentifier];
    if (self.currentTreasureType == PPTreasureTypeBrush) {
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
    }
    else if (self.currentTreasureType == PPTreasureTypePaper) {
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
            default:
                break;
        }
    }
    else if (self.currentTreasureType == PPTreasureTypeHolder) {
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
            default:
                break;
        }
        
    }
    else if (self.currentTreasureType == PPTreasureTypeInk) {
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
            default:
                break;
        }
    }
    else{
        
    }
    return page;
}

-(void)pagingScrollView:(GMCPagingScrollView *)pagingScrollView layoutPageAtIndex:(NSUInteger)index
{
    
}

-(void)pagingScrollViewDidFinishScrolling:(GMCPagingScrollView *)pagingScrollView
{
    [self.pageControl setCurrentPage:pagingScrollView.currentPageIndex%3];
    [(BaseViewController*)self.responseDelegate didScrollToBrush:pagingScrollView.currentPageIndex/3];
}

-(void)pagingScrollView:(GMCPagingScrollView *)pagingScrollView didEndDisplayingPage:(UIView *)page atIndex:(NSUInteger)index
{
    
}

-(void)pagingScrollView:(GMCPagingScrollView *)pagingScrollView didScrollToPageAtIndex:(NSUInteger)index
{
    
}

-(void)selectedBrush:(NSInteger)brushTag
{
    UIView *pageOut = [self.pagingScrollView pageAtIndex:self.pagingScrollView.currentPageIndex];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        [pageOut setAlpha:0.0];
        
    } completion:^(BOOL finished) {
        [self.pagingScrollView setCurrentPageIndex:brushTag*3 animated:NO];
        [self.pageControl setCurrentPage:self.pagingScrollView.currentPageIndex%3];
        UIView *pageIn = [self.pagingScrollView pageAtIndex:self.pagingScrollView.currentPageIndex];
        [pageIn setAlpha:0.0];
        [UIView animateWithDuration:0.5 animations:^{
            [pageIn setAlpha:1.0];
            
        } completion:^(BOOL finished) {
            [pageOut setAlpha:1.0];
        }];
        
    }];
    
    
}

- (IBAction)pageDidSelected:(UIPageControl *)sender {
    
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
