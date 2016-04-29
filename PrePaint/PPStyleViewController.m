//
//  PPStyleViewController.m
//  PrePaint
//
//  Created by Jing Tang on 3/16/16.
//  Copyright © 2016 JingTang. All rights reserved.
//
//STEP 2 STYLE页

#import "PPStyleViewController.h"
#import "BaseViewController.h"

#define kNumberOfSlides 4

@interface PPStyleViewController ()
@property (assign,nonatomic)NSInteger selectedTag;
@end

@implementation PPStyleViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *barImage = [[UIImage imageNamed:@"style_bottom_bg"] stretchableImageWithLeftCapWidth:724.0 topCapHeight:0];
    [self.bottomBGImageView setImage:barImage];
    UIImage *buttonImage = [UIImage imageNamed:@"try_tool_1"];
    [self.tryToolButtons setImage:buttonImage forState:UIControlStateNormal];
    [self loadRightPanelViewData];
    [self loadStyles];
    [self putEveryThingOutOfScreen];
}

-(void)selectFirstButton
{
    UIButton *firstButton = [self.styleButtonArray firstObject];
    [firstButton setSelected:YES];
}

-(void)selectSecondButton
{
    UIButton *secondButton = [self.styleButtonArray objectAtIndex:1];
    [secondButton setSelected:YES];
}

-(void)selectThirdButton
{
    UIButton *thirdButton = [self.styleButtonArray lastObject];
    [thirdButton setSelected:YES];
}



//初始状态将上、下、右的PANEL放到视图外
-(void)putEveryThingOutOfScreen
{
    self.topPanelConstraint.constant = -317;
    self.bottomPanelConstraint.constant = -self.bottomPanel.frame.size.height-22.0;
    self.rightPanelConstraint.constant = -self.rightIntroPanel.frame.size.width;
    [self.view layoutIfNeeded];
}

//将上、下、右的PANEL添加移动到视图外的动画
-(void)animateEveryThingOutOfScreen
{
    [UIView animateWithDuration:1.0 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.topPanelConstraint.constant = -317;
        self.bottomPanelConstraint.constant = -self.bottomPanel.frame.size.height;
        self.rightPanelConstraint.constant = -self.rightIntroPanel.frame.size.width;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}


//将上、下、右的PANEL添加移动到视图内的动画
-(void)animateEveryThingIntoScreen
{
    self.topPanelConstraint.constant = 0;
    self.bottomPanelConstraint.constant = 0;
    self.rightPanelConstraint.constant = 0;
    [UIView animateWithDuration:0.75 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

//移动并且转换右边PANEL的内容， 当用户选择不同STYLE后调用
-(void)animateRightPanel:(NSInteger)newPanelTag
{
    
    UIImage *bottomImage;
    UIImage *buttonImage;
    
    switch (newPanelTag) {
        case 0:
        {
            bottomImage = [UIImage imageNamed:@"style_bottom_bg"];
            buttonImage = [UIImage imageNamed:@"try_tool_1"];
        }
            break;
        case 1:
        {
            bottomImage = [UIImage imageNamed:@"style_bottom_bg_detail"];
            buttonImage = [UIImage imageNamed:@"try_tool_2"];
        }
            break;
        case 2:
        {
            bottomImage = [UIImage imageNamed:@"style_bottom_bg_idea"];
            buttonImage = [UIImage imageNamed:@"try_tool_3"];
        }
            break;
        case 3:
        {
            bottomImage = [UIImage imageNamed:@"style_bottom_bg_combination"];
            buttonImage = [UIImage imageNamed:@"try_tool_4"];
        }
            break;
            
        default:
        {
            bottomImage = [UIImage imageNamed:@"style_bottom_bg"];
            buttonImage = [UIImage imageNamed:@"try_tool_1"];
            
        }
            break;
    }
    
    
    
    [UIView animateWithDuration:0.75 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.bottomPanelConstraint.constant = -self.bottomPanel.frame.size.height;
        self.rightPanelConstraint.constant = -self.rightIntroPanel.frame.size.width;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self loadRightPanelDataBasedOnTag:newPanelTag];
        [self.tryToolButtons setImage:buttonImage forState:UIControlStateNormal];
        [self.bottomBGImageView setImage:bottomImage];
        [UIView animateWithDuration:0.75 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.bottomPanelConstraint.constant = 0;
            self.rightPanelConstraint.constant = 0;
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
        }];
        
        
    }];
}

//按用户选择的STYLE不同， 读取里面文字内容
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
            [self.rightPanelView setStyleIntro:@"Detail style is known as “Meticulous style”. because of the laborious drawing and thin washes requried to create the rich hues and intense colors. The process is time-cosuming and requires a lot of patience."];
            NSString *p1 = @"Layers of color washed are added to a Contour style painting to build up the colors of the finished art work.";
            NSString *p2 = @" This slow building of colors enhances the transparency of light in the subject and builds up the radiance of the colors.";
            
            
            [self.rightPanelView setStyleDescriptionArray:[NSMutableArray arrayWithObjects:p1,p2, nil]];
            [self.rightPanelView setNeedsDisplay];
        }
            break;
        case PPPaintingStyleCombination:
        {
            [self.rightPanelView setStyleName:@"IDEA STYLE"];
            [self.rightPanelView setStyleIntro:@"In the Song Dyansty, many artists explored new ways to refine their art.Mo-Ku, is an expansion of Contour style, in which brushwork is manipulated to denote surfaces instead of contours of the subject."];
            NSString *p1 = @"Artists don't sketch on the paper before starting to paint. Instead, brushwork is applied directly onto the paper, composition is adjusted during the painting process.";
            NSString *p2 = @"the style focuses on impressionistic approach, so anatomic accuracy may sometimes be compromised.";
            [self.rightPanelView setStyleDescriptionArray:[NSMutableArray arrayWithObjects:p1,p2, nil]];
            [self.rightPanelView setNeedsDisplay];
        }
            break;
        case PPPaintingStyleIForgot:
        {
            [self.rightPanelView setStyleName:@"COMBINATION STYLE"];
            [self.rightPanelView setStyleIntro:@"Often called “Half-Detail-Half-Spontaneous,” the Combination style incorporates the refined structure of a Detail style painting with the spirit of the Idea Paingting. "];
            NSString *p1 = @"Combines spirited brushwork with subject prescision and accuracy";
            NSString *p2 = @"Usually created without a sketch and the composition is sdjusted as the paintings proceed.";
            NSString *p3 =@"Attention is paid to the accurate rendering of the subject’s anatomy, color, value, and the light source.";
            [self.rightPanelView setStyleDescriptionArray:[NSMutableArray arrayWithObjects:p1,p2,p3, nil]];
            [self.rightPanelView setNeedsDisplay];
        }
            break;
            
        default:
            break;
    }
    
    
}

//将4个STYLE读取到上面的PANEL
-(void)loadStyles
{
    self.stylesArray = [NSMutableArray arrayWithObjects:@"style_slice1",@"style_slice2",@"style_slice3",@"style_slice4", nil];
    self.styleButtonArray = [NSMutableArray array];
    CGFloat baseX = 0.0;
    CGFloat width = (self.view.bounds.size.width)/kNumberOfSlides;
    CGFloat height = self.styleScrollView.bounds.size.height;
    
    for (NSString *styleData in self.stylesArray) {
        NSString *styleDataSelected = [NSString stringWithFormat:@"%@_selected",styleData];
        
        CGRect currentFrame = CGRectMake(baseX, 0, width, height);
        UIView *holderView = [[UIView alloc] initWithFrame:currentFrame];
        UIButton *styleImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [styleImageButton setFrame:holderView.bounds];
        [styleImageButton setImage:[UIImage imageNamed:styleData] forState:UIControlStateNormal];
        [styleImageButton setImage:[UIImage imageNamed:styleDataSelected] forState:UIControlStateSelected];
        [styleImageButton setTag:[self.stylesArray indexOfObject:styleData]];
        [styleImageButton addTarget:self action:@selector(styleTapped:) forControlEvents:UIControlEventTouchUpInside];
        [styleImageButton setSelected:NO];
        
        [self.styleButtonArray addObject:styleImageButton];
        [self.styleScrollView addSubview:holderView];
        
        [holderView addSubview:styleImageButton];
        [self.styleScrollView sendSubviewToBack:holderView];
        
        
        
        baseX+=width;
    }
    
    CGFloat contentsize = baseX ;
    [self.styleScrollView setContentSize:CGSizeMake(contentsize, self.styleScrollView.bounds.size.height)];
    
    
    
    
}


//当用户选去STYLE后调用
-(void)styleTapped:(UIButton*)button
{
    
    if (!button.isSelected) {
        NSInteger tag = button.tag;
        self.selectedTag = tag;
        
        [self animateRightPanel:tag];
        for (UIButton *styleButton in self.styleButtonArray) {
            if (styleButton != button) {
                [styleButton setSelected:NO];
            }
            else{
                [styleButton setSelected:YES];
                NSString *bgFileName = [NSString stringWithFormat:@"style_bg%d",tag+1];
                
                UIImage * toImage = [UIImage imageNamed:bgFileName];
                [UIView transitionWithView:self.bgImageView
                                  duration:1.5
                                   options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationCurveEaseInOut
                                animations:^{
                                    self.bgImageView.image = toImage;
                                } completion:nil];
            }
        }
    }
    
}

//初始状态 默认读取CONTOUR STYLE的数据
-(void)loadRightPanelViewData
{
    [self.rightPanelView setStyleName:@"CONTOUR STYLE"];
    [self.rightPanelView setStyleIntro:@"Contour style is known as 'White Sketch' in Chinese. Contour is more than merely a linear line drawing. Practicing this style helps build a strong foundation for controlling the brushwork."];
    NSString *p1 = @"Avariety of thick and thin widths within the same line are produced by applying the flexible tip of a fine paintbrush with different pressures.";
    NSString *p2 = @"The focus is on composition, controlling the thickness and thinness of lines, and the graceful application of lines on the paper.";
    [self.rightPanelView setStyleDescriptionArray:[NSMutableArray arrayWithObjects:p1,p2, nil]];
    [self.rightPanelView setNeedsDisplay];
    [self.rightIntroPanel setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0  blue:255.0/255.0  alpha:1.0]];
    [self.rightPanelView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0  blue:255.0/255.0  alpha:1.0]];
    [self setupRightPanelShadow];
}

//为右PANEL的左边添加阴影效果
-(void)setupRightPanelShadow
{
    [self.rightPanelView.layer setShadowColor:[UIColor blackColor].CGColor];
    CGRect shadowRect = self.rightPanelView.bounds;
    shadowRect.size.width = 1.0;
    self.rightPanelView.layer.shadowPath = [UIBezierPath bezierPathWithRect:shadowRect].CGPath;
    [self.rightPanelView.layer setShadowOpacity:1.0];
}

//TRY TOOL按钮按下后调用
- (IBAction)tryToolButtonAction:(UIButton *)sender {
    
    [(BaseViewController*)self.parentViewController flipToToolTutorialPage:self.selectedTag];
}

-(void)didReceiveMemoryWarning
{
    
}

-(void)dealloc
{
    
}
@end
