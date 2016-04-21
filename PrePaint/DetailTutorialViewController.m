//
//  ToolTutorialViewController.m
//  PrePaint
//
//  Created by Jing Tang on 3/29/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "DetailTutorialViewController.h"
#import "PocketSVG.h"
#import "FLAnimatedImage.h"

#define animationDuration 5

@interface DetailTutorialViewController (){
    CGRect _initialFrameOfObject;
    UIImageView *_tempImageView;
    BOOL _isXuanPaperOnScreen;
    CAShapeLayer *_firstLayer;
    CAShapeLayer *_secondLayer;
    CALayer *firstColorLayer;
    CALayer *secondColorLayer;
    BOOL _isDragging;
    NSUInteger _currentStep;
    id _draggedItem;
    
    UIImage *_xuan;
    UIImage *_xuanDisabled;
    
    UIImage *_pencil;
    UIImage *_pencilDisabled;
    
    UIImage *_vein;
    UIImage *_veinDisabled;
    
    UIImage *_goat;
    UIImage *_goatDisabled;
    
}
@property (strong, nonatomic)UIImageView *fullPaperImageView;

@end

@implementation DetailTutorialViewController
@synthesize fullPaperImageView;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.titleStyleLabel setText:@"DETAIL STYLE"];
    [self.titleFlowerLabel setText:@"Green Leaf"];
    _currentStep = 0;
    if ([self isNeedToShowTutorial]) {
        [self.tutorialBgView setHidden:NO];
    }
    else{
        [self.tutorialBgView setHidden:YES];
    }
    
    [self resetFlags];
    [self.previousButton setEnabled:NO];
    [self.nextButton setEnabled:NO];
    [self.stepView.layer setCornerRadius:self.stepView.frame.size.height/2.0];
    [self addGestureRecognizersForImageView:self.xuanPaperImageView];
    [self addGestureRecognizersForImageView:self.pencilImageView];
    [self addGestureRecognizersForImageView:self.veinBrushImageView];
    [self addGestureRecognizersForImageView:self.goatBrushImageView];
    [self setupMaskImages];
    [self enableImageView:self.xuanPaperImageView];
    // Do any additional setup after loading the view from its nib.
}



-(IBAction)gotitButtonAction:(UIButton*)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(NO) forKey:@"isNeedToShowTutorial"];
    [defaults synchronize];
    [self.tutorialBgView setHidden:YES];
    [self.tutorialBgView removeFromSuperview];
}

-(BOOL)isNeedToShowTutorial
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *isNeeded =  [defaults objectForKey:@"isNeedToShowTutorial"];
    if (!isNeeded) {
        return YES;
    }
    return [isNeeded boolValue];
}

-(void)resetFlags
{
    _isXuanPaperOnScreen = NO;
}

-(void)addGestureRecognizersForImageView:(UIImageView*)view
{
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureHandler:)];
    [view setUserInteractionEnabled:YES];
    [longGesture setMinimumPressDuration:0.1];
    [longGesture setDelegate:self];
    [view addGestureRecognizer:longGesture];
}

-(void)longPressGestureHandler:(UILongPressGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (!_isDragging&&!_draggedItem) {
                BOOL isRightStep = NO;
                if (gesture.view == self.xuanPaperImageView&&_currentStep==0) {
                    isRightStep =YES;
                }
                else if (gesture.view == self.pencilImageView&&_currentStep==1) {
                    isRightStep =YES;
                }
                else if (gesture.view == self.goatBrushImageView&&_currentStep==2) {
                    isRightStep =YES;
                }
                else if (gesture.view == self.veinBrushImageView&&_currentStep==3) {
                    isRightStep =YES;
                }
 
                
                if (isRightStep) {
                    
                
        
            _isDragging = YES;
            _initialFrameOfObject = gesture.view.frame;
            UIImageView *copiedImageView = [[UIImageView alloc] initWithFrame:_initialFrameOfObject];
            [copiedImageView setImage:[(UIImageView*)gesture.view image]];
            [copiedImageView setContentMode:[(UIImageView*)gesture.view contentMode]];
            [gesture.view.superview addSubview:copiedImageView];
            [gesture.view.superview sendSubviewToBack:copiedImageView];
            [self addGestureRecognizersForImageView:copiedImageView];
            _tempImageView = copiedImageView;
            CGRect rectInGlobalView = [self.view convertRect:gesture.view.frame fromView:gesture.view.superview];
            
            //            [gesture.view removeFromSuperview];
            [self.view addSubview:gesture.view];
            [gesture.view setFrame:rectInGlobalView];
            [self.view bringSubviewToFront:gesture.view];
            _draggedItem = gesture.view;
            [UIView animateWithDuration:0.5 animations:^{
                [gesture.view setAlpha:0.5];
                [gesture.view setCenter:[gesture locationInView:self.view]];
                if (gesture.view == self.pencilImageView || gesture.view == self.veinBrushImageView||gesture.view == self.goatBrushImageView) {
                    gesture.view.transform = CGAffineTransformMakeRotation(-M_PI_4);
                }
            } completion:^(BOOL finished) {
               
            }];
                    }
                }
            else{
                _draggedItem = nil;
                _isDragging = NO;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (_isDragging&&_draggedItem == gesture.view) {
                [gesture.view setCenter:[gesture locationInView:gesture.view.superview]];
            }
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (_isDragging&&_draggedItem == gesture.view) {
                if (gesture.view == self.xuanPaperImageView) {
                    
                    [self.xuanPaperImageView setImage:[UIImage imageNamed:@"tool_xuan_fullsize"]];
                    _isXuanPaperOnScreen = YES;
                    [self.previousButton setEnabled:NO];
                    [self.nextButton setEnabled:NO];
                    [UIView animateWithDuration:0.3 animations:^{
                        [gesture.view setAlpha:1.0];
                        
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.5 animations:^{
                            [gesture.view setFrame:CGRectMake(27, CGRectGetMaxY(self.stepBarView.frame)+75, 854, 635)];
                            
                        } completion:^(BOOL finished) {
                            [gesture.view removeGestureRecognizer:[gesture.view.gestureRecognizers firstObject]];
                            [gesture.view setUserInteractionEnabled:NO];
                            self.fullPaperImageView = self.xuanPaperImageView;
                            self.xuanPaperImageView = _tempImageView;
                            _tempImageView = nil;
                            [self.previousButton setEnabled:YES];
                            [self.nextButton setEnabled:YES];
                            [self nextButtonAction:nil];
                            [self enableImageView:self.pencilImageView];
                            _isDragging = NO;
                            _draggedItem = nil;
                            _currentStep = 1;
                        }];
                        
                    }];
                }
                
                else if(gesture.view == self.pencilImageView){
                    
                    
                    [UIView animateWithDuration:0.5 animations:^{
                        [gesture.view setAlpha:1.0];
                        
                    } completion:^(BOOL finished) {
                        [self.previousButton setEnabled:NO];
                        [self.nextButton setEnabled:NO];
                        [self drawPencilPath];
                
                    }];
                }
                else if(gesture.view == self.veinBrushImageView){
                    [UIView animateWithDuration:0.5 animations:^{
                        [gesture.view setAlpha:1.0];
                        
                    } completion:^(BOOL finished) {
                        [self.previousButton setEnabled:NO];
                        [self.nextButton setEnabled:NO];
                        [self drawVeinBrushPath];
                        //                    self.veinBrushImageView = _tempImageView;
                        //                    _tempImageView = nil;
                    }];
                }
                else if(gesture.view == self.goatBrushImageView){
                    [UIView animateWithDuration:0.5 animations:^{
                        [gesture.view setAlpha:1.0];
                        
                    } completion:^(BOOL finished) {
                        [self.previousButton setEnabled:NO];
                        [self.nextButton setEnabled:NO];
                        [self drawGoatBrushPath];
                        [self applyColorAnimation];
                        //                    self.veinBrushImageView = _tempImageView;
                        //                    _tempImageView = nil;
                    }];
                }
            }
            
  
            
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            NSLog(@"cancelled");
        }
            break;
            
        case UIGestureRecognizerStateFailed:
        {
            NSLog(@"failed");
        }
            break;
            
        default:
            break;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.view == self.xuanPaperImageView) {
        if (_isXuanPaperOnScreen) {
            return NO;
        }
    }
    
    return YES;
}

-(void)drawPencilPath
{
    CGPathRef myPath = [PocketSVG pathFromSVGFileNamed:@"leafPath"];
    // myPath = [self CGPath_NGCreateCopyByScalingPathAroundCentre:myPath scale:0.5];
    CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
    myShapeLayer.path = myPath;
    
    myShapeLayer.strokeColor = [[UIColor darkGrayColor] CGColor];
    myShapeLayer.lineWidth = 1.0;
    myShapeLayer.lineCap = kCALineCapRound;
    myShapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    CGRect rect = self.fullPaperImageView.layer.bounds;
    CGFloat leftRightPadding = 140.0;
    CGFloat topBottomPadding = 70.0;
    rect.origin.x += leftRightPadding;
    rect.origin.y += topBottomPadding;
    rect.size.width = 620;
    rect.size.height = 538-topBottomPadding;
    [myShapeLayer setFrame:rect];
    [self.fullPaperImageView.layer addSublayer:myShapeLayer];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = animationDuration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];;
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    
    
    CGAffineTransform translation = CGAffineTransformMakeTranslation(265,
                                                                     204);
    CGPathRef movedPath = CGPathCreateCopyByTransformingPath(myShapeLayer.path,
                                                             &translation);
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.path = movedPath;
    anim.calculationMode = kCAAnimationPaced;//kCAAnimationPaced;
    //[anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    anim.duration = animationDuration;
    anim.delegate = self;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    [myShapeLayer addAnimation:pathAnimation forKey:@"strokeAnime"];
    _firstLayer = myShapeLayer;
    //  [myShapeLayer addAnimation:colorAnimation forKey:@"colorAnime"];
    [self.pencilImageView.layer addAnimation:anim forKey:@"pencil"];
}


-(void)drawVeinBrushPath
{
    CGPathRef myPath = [PocketSVG pathFromSVGFileNamed:@"leafPath"];
    // myPath = [self CGPath_NGCreateCopyByScalingPathAroundCentre:myPath scale:0.5];
    CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
    myShapeLayer.path = myPath;
    
    myShapeLayer.strokeColor = [[UIColor blackColor] CGColor];
    myShapeLayer.lineWidth = 3.0;
    myShapeLayer.lineCap = kCALineCapRound;
    myShapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    CGRect rect = self.fullPaperImageView.layer.bounds;
    CGFloat leftRightPadding = 140.0;
    CGFloat topBottomPadding = 70.0;
    rect.origin.x += leftRightPadding;
    rect.origin.y += topBottomPadding;
    rect.size.width = 620;
    rect.size.height = 538-topBottomPadding;
    [myShapeLayer setFrame:rect];
    [self.fullPaperImageView.layer addSublayer:myShapeLayer];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = animationDuration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];;
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    
    
    CGAffineTransform translation = CGAffineTransformMakeTranslation(265,
                                                                     204);
    CGPathRef movedPath = CGPathCreateCopyByTransformingPath(myShapeLayer.path,
                                                             &translation);
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.path = movedPath;
    anim.calculationMode = kCAAnimationPaced;//kCAAnimationPaced;
    //[anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    anim.duration = animationDuration;
    anim.delegate = self;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    [myShapeLayer addAnimation:pathAnimation forKey:@"strokeAnime"];
    _secondLayer = myShapeLayer;
    //  [myShapeLayer addAnimation:colorAnimation forKey:@"colorAnime"];
    [self.veinBrushImageView.layer addAnimation:anim forKey:@"vein"];
}


-(void)drawGoatBrushPath
{
    CGPathRef myPath = [PocketSVG pathFromSVGFileNamed:@"pathGuide"];
    // myPath = [self CGPath_NGCreateCopyByScalingPathAroundCentre:myPath scale:0.5];
    CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
    myShapeLayer.path = myPath;
    
    myShapeLayer.strokeColor = [[UIColor clearColor] CGColor];
    myShapeLayer.lineWidth = 2.0;
    myShapeLayer.lineCap = kCALineCapRound;
    myShapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    CGRect rect = self.fullPaperImageView.layer.bounds;
    CGFloat leftRightPadding = 344.0;
    CGFloat topBottomPadding = 192.0;
    rect.origin.x += leftRightPadding;
    rect.origin.y += topBottomPadding;
    rect.size.width = 214;
    rect.size.height = 266;

    
    CGAffineTransform translation = CGAffineTransformMakeTranslation(265,
                                                                     204);
    CGPathRef movedPath = CGPathCreateCopyByTransformingPath(myPath,
                                                             &translation);
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.path = movedPath;
    anim.calculationMode = kCAAnimationPaced;//kCAAnimationPaced;
    //[anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    anim.duration = animationDuration;
    anim.delegate = self;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.repeatCount = 2;

    //  [myShapeLayer addAnimation:colorAnimation forKey:@"colorAnime"];
    [self.goatBrushImageView.layer addAnimation:anim forKey:@"goat"];
}

-(void)applyColorAnimation
{
    CGRect rect = self.fullPaperImageView.layer.bounds;
    CGFloat leftRightPadding = 344.0;
    CGFloat topBottomPadding = 192.0;
    rect.origin.x += leftRightPadding;
    rect.origin.y += topBottomPadding;
    rect.size.width = 214;
    rect.size.height = 266;
    CALayer *colorLayer = [CALayer layer];
    [colorLayer setFrame:rect];
    UIImage *colorImage = [UIImage imageNamed:@"leaf_color1"];
    [colorLayer setContents:(id)colorImage.CGImage];
    [self.fullPaperImageView.layer addSublayer:colorLayer];
    [colorLayer setOpacity:0.0];
    firstColorLayer = colorLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = animationDuration;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:1.0f];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    animation.additive = NO;
    animation.delegate = self;
    [colorLayer addAnimation:animation forKey:@"opacityIN"];
    
    
    
}






-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if (flag) {
        
        if (anim == [[self.pencilImageView layer] animationForKey:@"pencil"]) {
            [self.pencilImageView removeFromSuperview];
            self.pencilImageView = _tempImageView;
            _tempImageView = nil;
            [self nextButtonAction:nil];
            _isDragging = NO;
            _draggedItem = nil;
            _currentStep = 2;
            [self enableImageView:_goatBrushImageView];
        }
        else if (anim == [[self.veinBrushImageView layer] animationForKey:@"vein"]) {
            [self.veinBrushImageView removeFromSuperview];
            self.veinBrushImageView = _tempImageView;
            _tempImageView = nil;
            [self nextButtonAction:nil];
            _isDragging = NO;
            _draggedItem = nil;
            _currentStep = 4;
            [self enableImageView:nil];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Tutorial Completed!"
                                                                           message:@"Awesome, you have finished this tutorial, would you like to go back?"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Go Back" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [self backButtonAction:nil];
                                                                  }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     
                                                                 }];
            
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if (anim == [[self.goatBrushImageView layer] animationForKey:@"goat"]) {
            [self.goatBrushImageView removeFromSuperview];
            self.goatBrushImageView = _tempImageView;
            _tempImageView = nil;
            [self nextButtonAction:nil];
            _isDragging = NO;
            _draggedItem = nil;
            _currentStep = 3;
            [self enableImageView:self.veinBrushImageView];
        }
        else if (anim == [firstColorLayer animationForKey:@"opacityIN"]){
            CGRect rect = self.fullPaperImageView.layer.bounds;
            CGFloat leftRightPadding = 344.0;
            CGFloat topBottomPadding = 192.0;
            rect.origin.x += leftRightPadding;
            rect.origin.y += topBottomPadding;
            rect.size.width = 214;
            rect.size.height = 266;

            CALayer *colorLayerDeep = [CALayer layer];
            [colorLayerDeep setFrame:rect];
            UIImage *colorImage = [UIImage imageNamed:@"leaf_color2"];
            [colorLayerDeep setContents:(id)colorImage.CGImage];
            [self.fullPaperImageView.layer addSublayer:colorLayerDeep];
            secondColorLayer = colorLayerDeep;
            [colorLayerDeep setOpacity:0.0];
            
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            animation.duration = animationDuration;
            animation.fromValue = [NSNumber numberWithFloat:0.0f];
            animation.toValue = [NSNumber numberWithFloat:1.0f];
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeBoth;
            animation.additive = NO;
            animation.delegate = self;
            
            [colorLayerDeep addAnimation:animation forKey:@"opacityIN2"];
        }
        else if (anim == [firstColorLayer animationForKey:@"opacityIN2"]){

            _isDragging = NO;
        }
        [self.previousButton setEnabled:YES];
        [self.nextButton setEnabled:YES];
    }
}

-(void)viewDidLayoutSubviews
{
    //    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    //    NSLog(@"sdf");
}


-(CGPathRef)CGPath_NGCreateCopyByScalingPathAroundCentre:(CGPathRef)path scale:(float) scale
{
    CGRect bounding = CGPathGetPathBoundingBox(path);
    CGPoint pathCenterPoint = CGPointMake(CGRectGetMidX(bounding), CGRectGetMidY(bounding));
    
    CGAffineTransform translateAndScale = CGAffineTransformTranslate( CGAffineTransformMakeScale(scale, scale), - pathCenterPoint.x, -pathCenterPoint.y) ;
    CGAffineTransform translateBack = CGAffineTransformMakeTranslation(pathCenterPoint.x, pathCenterPoint.y);
    
    CGPathRef centeredAndScaled = CGPathCreateCopyByTransformingPath(path, &translateAndScale);
    CGPathRef translatedPathRef = CGPathCreateCopyByTransformingPath(centeredAndScaled, &translateBack);
    
    CGPathRelease(centeredAndScaled);
    
    return translatedPathRef;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)dealloc
{
    
}

- (IBAction)backButtonAction:(id)sender {
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                    completion:nil];
}

-(void)changeStepText
{
    
}

- (IBAction)previousButtonAction:(id)sender {
    NSInteger step = [self.stepNumberLabel.text integerValue];
    if (step == 1) {
        _isXuanPaperOnScreen = NO;
        [self.fullPaperImageView removeFromSuperview];
        [self.hintLabel setText:kDTStep1Text];
        
    }
    else if (step == 2) {
        [_firstLayer removeFromSuperlayer];
        [self.hintLabel setText:kDTStep2Text];
    }
    else if (step == 3){
        [_secondLayer removeFromSuperlayer];
        [self.hintLabel setText:kDTStep3Text];
    }
    else if (step == 4){
        [_secondLayer removeFromSuperlayer];
        [self.hintLabel setText:kDTStep3Text];
    }
    if (step > 1) {
        [self.stepNumberLabel setText:[NSString stringWithFormat:@"%ld",step-1]];
    }
    
}

- (IBAction)nextButtonAction:(id)sender {
    NSInteger step = [self.stepNumberLabel.text integerValue];
    if (step == 1) {
        if (self.fullPaperImageView) {
            [self.view addSubview:self.fullPaperImageView];
            [self.fullPaperImageView setFrame:CGRectMake(27, CGRectGetMaxY(self.stepBarView.frame)+75, 854, 635)];
        }
        [self.hintLabel setText:kDTStep2Text];
    }
    else if (step == 2) {
        if (_firstLayer) {
            [self.fullPaperImageView.layer addSublayer:_firstLayer];
        }
        [self.hintLabel setText:kDTStep3Text];
    }
    else if (step == 3){
        if (_secondLayer) {
            [self.fullPaperImageView.layer addSublayer:_secondLayer];
        }
        
    }
    else if (step == 4){
//        if (_secondLayer) {
//            [self.fullPaperImageView.layer addSublayer:_secondLayer];
//        }
        
    }
    if (step <4) {
        [self.stepNumberLabel setText:[NSString stringWithFormat:@"%ld",step+1]];
    }
}
-(void)setupMaskImages
{
    UIImage *xuanImage = self.xuanPaperImageView.image;
    UIImage *xuanImage_disabled = [self colorizeImage:xuanImage withColor:kDisabledImageMaskColor];
    
    UIImage *pencilImage = self.pencilImageView.image;
    UIImage *pencilImage_disabled = [self colorizeImage:pencilImage withColor:kDisabledImageMaskColor];
    
    UIImage *veinImage = self.veinBrushImageView.image;
    UIImage *veinImage_disabled = [self colorizeImage:veinImage withColor:kDisabledImageMaskColor];
    
    UIImage *goatImage = self.goatBrushImageView.image;
    UIImage *goatImage_disabled = [self colorizeImage:goatImage withColor:kDisabledImageMaskColor];
    

    
    _xuan = xuanImage;
    _xuanDisabled =xuanImage_disabled;
    
    _pencil = pencilImage;
    _pencilDisabled = pencilImage_disabled;
    
    _vein = veinImage;
    _veinDisabled = veinImage_disabled;
    
    _goat = goatImage;
    _goatDisabled = goatImage_disabled;
    
 
}

-(void)enableImageView:(UIImageView*)imageView
{
    if (imageView == self.xuanPaperImageView) {
        [self.xuanPaperImageView setImage:_xuan];
        [self.pencilImageView setImage:_pencilDisabled];
        [self.veinBrushImageView setImage:_veinDisabled];
        [self.goatBrushImageView setImage:_goatDisabled];

        
    }
    else if (imageView == self.pencilImageView) {
        [self.xuanPaperImageView setImage:_xuanDisabled];
        [self.pencilImageView setImage:_pencil];
        [self.veinBrushImageView setImage:_veinDisabled];
        [self.goatBrushImageView setImage:_goatDisabled];
 
    }
    else if (imageView == self.veinBrushImageView) {
        [self.xuanPaperImageView setImage:_xuanDisabled];
        [self.pencilImageView setImage:_pencilDisabled];
        [self.veinBrushImageView setImage:_vein];
        [self.goatBrushImageView setImage:_goatDisabled];
      
    }
    else if (imageView == self.goatBrushImageView) {
        [self.xuanPaperImageView setImage:_xuanDisabled];
        [self.pencilImageView setImage:_pencilDisabled];
        [self.veinBrushImageView setImage:_veinDisabled];
        [self.goatBrushImageView setImage:_goat];
      
    }

    else{
        [self.xuanPaperImageView setImage:_xuanDisabled];
        [self.pencilImageView setImage:_pencilDisabled];
        [self.veinBrushImageView setImage:_veinDisabled];
        [self.goatBrushImageView setImage:_goatDisabled];
     
    }
}

-(void)enableAllImage
{
    [self.xuanPaperImageView setImage:_xuan];
    [self.pencilImageView setImage:_pencil];
    [self.veinBrushImageView setImage:_vein];
    [self.goatBrushImageView setImage:_goat];
 
    
    _isXuanPaperOnScreen = NO;
    [self.fullPaperImageView removeFromSuperview];
    [_firstLayer removeFromSuperlayer];
    [_secondLayer removeFromSuperlayer];

    _currentStep = 0;
    [self.hintLabel setText:kCTStep1Text];
}



- (UIImage *)colorizeImage:(UIImage *)image withColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
    CGContextRef c = UIGraphicsGetCurrentContext();
    [image drawInRect:rect];
    CGContextSetFillColorWithColor(c, [color CGColor]);
    CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
    CGContextFillRect(c, rect);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

@end
