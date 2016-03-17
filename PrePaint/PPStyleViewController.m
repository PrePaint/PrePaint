//
//  PPStyleViewController.m
//  PrePaint
//
//  Created by Jing Tang on 3/16/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "PPStyleViewController.h"
#import "BaseViewController.h"

#define kNumberOfSlides 4

@interface PPStyleViewController ()

@end

@implementation PPStyleViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTryToolButton];
    [self loadRightPanelViewData];
    [self loadStyles];
    [self putEveryThingOutOfScreen];
}


-(void)putEveryThingOutOfScreen
{
    self.topPanelConstraint.constant = -317;
    self.bottomPanelConstraint.constant = -self.bottomPanel.frame.size.height-22.0;
    self.rightPanelConstraint.constant = -self.rightIntroPanel.frame.size.width;
    [self.view layoutIfNeeded];
}

-(void)animateEveryThingOutOfScreen
{
    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.topPanelConstraint.constant = -317;
        self.bottomPanelConstraint.constant = -self.bottomPanel.frame.size.height-22.0;
        self.rightPanelConstraint.constant = -self.rightIntroPanel.frame.size.width;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}



-(void)animateEveryThingIntoScreen
{
    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.topPanelConstraint.constant = 0;
        self.bottomPanelConstraint.constant = 0;
        self.rightPanelConstraint.constant = 0;
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];

}

-(void)animateRightPanel:(NSInteger)newPanelTag
{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.bottomPanelConstraint.constant = -self.bottomPanel.frame.size.height-22.0;
        self.rightPanelConstraint.constant = -self.rightIntroPanel.frame.size.width;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self loadRightPanelDataBasedOnTag:newPanelTag];
        [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.bottomPanelConstraint.constant = 0;
            self.rightPanelConstraint.constant = 0;
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
        }];

        
    }];
}

-(void)loadRightPanelDataBasedOnTag:(NSInteger)tag
{
    switch (tag) {
        case PPPaintingStyleContour:
        {
            [self.rightPanelView setStyleName:@"CONTOUR STYLE"];
            [self.rightPanelView setStyleIntro:@"Contour style is known as 'White Sketch' in Chinese. Contour is more than merely a linear line drawing. Practicing this style helps build a strong foundation for controlling the brushwork."];
            NSString *p1 = @"Avariety of thick and thin widths within the same line are produced by applying the flexible tip of a fine paintbrush with different pressures.";
            NSString *p2 = @"The focus is on composition, controlling the thickness and thinness of lines, and the graceful application of lines on the paper.";
            [self.rightPanelView setStyleDescriptionArray:[NSMutableArray arrayWithObjects:p1,p2, nil]];
            [self.rightPanelView setNeedsDisplay];
        }
            break;
        case PPPaintingStyleIdea:
        {
            [self.rightPanelView setStyleName:@"DETAIL STYLE"];
            [self.rightPanelView setStyleIntro:@"Contour style is known as 'White Sketch' in Chinese. Contour is more than merely a linear line drawing. Practicing this style helps build a strong foundation for controlling the brushwork."];
            NSString *p1 = @"Avariety of thick and thin widths within the same line are produced by applying the flexible tip of a fine paintbrush with different pressures.";
            NSString *p2 = @"The focus is on composition, controlling the thickness and thinness of lines, and the graceful application of lines on the paper.";
            [self.rightPanelView setStyleDescriptionArray:[NSMutableArray arrayWithObjects:p1,p2, nil]];
            [self.rightPanelView setNeedsDisplay];
        }
        break;
        case PPPaintingStyleCombination:
        {
            [self.rightPanelView setStyleName:@"IDEA STYLE"];
            [self.rightPanelView setStyleIntro:@"Contour style is known as 'White Sketch' in Chinese. Contour is more than merely a linear line drawing. Practicing this style helps build a strong foundation for controlling the brushwork."];
            NSString *p1 = @"Avariety of thick and thin widths within the same line are produced by applying the flexible tip of a fine paintbrush with different pressures.";
            NSString *p2 = @"The focus is on composition, controlling the thickness and thinness of lines, and the graceful application of lines on the paper.";
            [self.rightPanelView setStyleDescriptionArray:[NSMutableArray arrayWithObjects:p1,p2, nil]];
            [self.rightPanelView setNeedsDisplay];
        }
        break;
        case PPPaintingStyleIForgot:
        {
            [self.rightPanelView setStyleName:@"COMBINATION STYLE"];
            [self.rightPanelView setStyleIntro:@"Contour style is known as 'White Sketch' in Chinese. Contour is more than merely a linear line drawing. Practicing this style helps build a strong foundation for controlling the brushwork."];
            NSString *p1 = @"Avariety of thick and thin widths within the same line are produced by applying the flexible tip of a fine paintbrush with different pressures.";
            NSString *p2 = @"The focus is on composition, controlling the thickness and thinness of lines, and the graceful application of lines on the paper.";
            [self.rightPanelView setStyleDescriptionArray:[NSMutableArray arrayWithObjects:p1,p2, nil]];
            [self.rightPanelView setNeedsDisplay];
        }
        break;
            
        default:
            break;
    }
    

}

-(void)loadStyles
{
    self.stylesArray = [NSMutableArray arrayWithObjects:@"style_slice1",@"style_slice2",@"style_slice3",@"style_slice4", nil];
    
    CGFloat baseX = 0.0;
    CGFloat width = self.view.bounds.size.width/kNumberOfSlides;
    CGFloat height = self.styleScrollView.bounds.size.height;
    
    for (NSString *styleData in self.stylesArray) {
        CGRect currentFrame = CGRectMake(baseX, 0, width, height);
        UIButton *styleImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [styleImageButton setFrame:currentFrame];
        [styleImageButton setImage:[UIImage imageNamed:styleData] forState:UIControlStateNormal];
        [styleImageButton setTag:[self.stylesArray indexOfObject:styleData]];
        [styleImageButton addTarget:self action:@selector(styleTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.styleScrollView addSubview:styleImageButton];
        baseX+=width;

        
//        CGRect currentFrame = CGRectMake(baseX, 0, width, height);
//        UIImageView *styleImageView = [[UIImageView alloc] initWithFrame:currentFrame];
//        [styleImageView setImage:[UIImage imageNamed:styleData]];
//        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(styleTapped:)];
//        [tapGesture setDelegate:self];
//        [styleImageView addGestureRecognizer:tapGesture];
//        [styleImageView setTag:[self.stylesArray indexOfObject:styleData]];
//        [self.styleScrollView addSubview:styleImageView];
//        baseX+=width;
    }
    
    CGFloat contentsize = baseX ;
    [self.styleScrollView setContentSize:CGSizeMake(contentsize, self.styleScrollView.bounds.size.height)];
    
    
    
    
}



-(void)styleTapped:(UIButton*)button
{
    NSInteger tag = button.tag;
    NSLog(@"%ld",(long)tag);
    [button setSelected:!button.isSelected];
    [self animateRightPanel:tag];
}

-(void)loadRightPanelViewData
{
    [self.rightPanelView setStyleName:@"CONTOUR STYLE"];
    [self.rightPanelView setStyleIntro:@"Contour style is known as 'White Sketch' in Chinese. Contour is more than merely a linear line drawing. Practicing this style helps build a strong foundation for controlling the brushwork."];
    NSString *p1 = @"Avariety of thick and thin widths within the same line are produced by applying the flexible tip of a fine paintbrush with different pressures.";
    NSString *p2 = @"The focus is on composition, controlling the thickness and thinness of lines, and the graceful application of lines on the paper.";
    [self.rightPanelView setStyleDescriptionArray:[NSMutableArray arrayWithObjects:p1,p2, nil]];
    [self.rightPanelView setNeedsDisplay];
    [self.rightIntroPanel setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0  blue:255.0/255.0  alpha:0.7]];
    [self.rightPanelView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0  blue:255.0/255.0  alpha:0.7]];
//    [self.rightIntroPanel setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
}

-(void)setupTryToolButton
{
    [self.tryToolButtons setAlpha:1.0];
    [self.tryToolButtons.layer setBorderColor:SelectedBlueColor.CGColor];
    [self.tryToolButtons.layer setBorderWidth:1.5];
    [self.tryToolButtons.layer setCornerRadius:self.tryToolButtons.frame.size.height/2.0];
}

- (IBAction)tryToolButtonAction:(UIButton *)sender {
//    [(BaseViewController*)self.parentViewController removeStyleVCAndloadFourTreasureVC];
}

-(void)didReceiveMemoryWarning
{

}

-(void)dealloc
{

}
@end
