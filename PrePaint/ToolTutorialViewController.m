//
//  ToolTutorialViewController.m
//  PrePaint
//
//  Created by Jing Tang on 3/29/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "ToolTutorialViewController.h"
#import "PocketSVG.h"


//CONTOUR 页

@interface ToolTutorialViewController (){
    CGRect _initialFrameOfObject;
    UIImageView *_tempImageView;
    BOOL _isXuanPaperOnScreen;
    CAShapeLayer *_firstLayer;
    CAShapeLayer *_secondLayer;
    
    UIImage *_xuan;
    UIImage *_xuanDisabled;
    
    UIImage *_pencil;
    UIImage *_pencilDisabled;
    
    UIImage *_vein;
    UIImage *_veinDisabled;
}
@property (strong, nonatomic)UIImageView *fullPaperImageView;

@end

@implementation ToolTutorialViewController
@synthesize fullPaperImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self isNeedToShowTutorial]) {
        [self.tutorialBgView setHidden:NO];
    }
    else{
        [self.tutorialBgView setHidden:YES];
    }
    [self.titleStyleLabel setText:@"CONTOUR STYLE"];
    [self.titleFlowerLabel setText:@"Lotus"];
    [self resetFlags];
    [self.previousButton setEnabled:NO];
    [self.nextButton setEnabled:NO];
    [self.stepView.layer setCornerRadius:self.stepView.frame.size.height/2.0];
    [self addGestureRecognizersForImageView:self.xuanPaperImageView];
    [self addGestureRecognizersForImageView:self.pencilImageView];
    [self addGestureRecognizersForImageView:self.veinBrushImageView];
    [self setupMaskImages];
    [self enableImageView:self.xuanPaperImageView];
    // Do any additional setup after loading the view from its nib.
}

//LOAD 灰色和正常色的 纸笔图标
-(void)setupMaskImages
{
    UIImage *xuanImage = self.xuanPaperImageView.image;
    UIImage *xuanImage_disabled = [self colorizeImage:xuanImage withColor:kDisabledImageMaskColor];
    
    UIImage *pencilImage = self.pencilImageView.image;
    UIImage *pencilImage_disabled = [self colorizeImage:pencilImage withColor:kDisabledImageMaskColor];
    
    UIImage *veinImage = self.veinBrushImageView.image;
    UIImage *veinImage_disabled = [self colorizeImage:veinImage withColor:kDisabledImageMaskColor];
    
    
    _xuan = xuanImage;
    _xuanDisabled =xuanImage_disabled;
    
    _pencil = pencilImage;
    _pencilDisabled = pencilImage_disabled;
    
    _vein = veinImage;
    _veinDisabled = veinImage_disabled;
}

//根据当前步骤 将传入元素变灰或者变成正常色
-(void)enableImageView:(UIImageView*)imageView
{
    if (imageView == self.xuanPaperImageView) {
        [self.xuanPaperImageView setImage:_xuan];
        [self.pencilImageView setImage:_pencilDisabled];
        [self.veinBrushImageView setImage:_veinDisabled];
    }
    else if (imageView == self.pencilImageView) {
        [self.xuanPaperImageView setImage:_xuanDisabled];
        [self.pencilImageView setImage:_pencil];
        [self.veinBrushImageView setImage:_veinDisabled];
    }
    else if (imageView == self.veinBrushImageView) {
        [self.xuanPaperImageView setImage:_xuanDisabled];
        [self.pencilImageView setImage:_pencilDisabled];
        [self.veinBrushImageView setImage:_vein];
    }
    else{
        [self.xuanPaperImageView setImage:_xuanDisabled];
        [self.pencilImageView setImage:_pencilDisabled];
        [self.veinBrushImageView setImage:_veinDisabled];
    }
}


//第一次的TUTORIAL MODAL， GOT IT按钮按下后调用，作用是移除TUTORIAL图层
-(IBAction)gotitButtonAction:(UIButton*)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(NO) forKey:@"isNeedToShowTutorial"];
    [defaults synchronize];
    [self.tutorialBgView setHidden:YES];
    [self.tutorialBgView removeFromSuperview];
}

//根据NSUserDefaults 里存取的值 判断是否是首次安装APP
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

//为传入的视图添加拖拽手势识别器（Gesture recognizer）
-(void)addGestureRecognizersForImageView:(UIImageView*)view
{
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureHandler:)];
    [view setUserInteractionEnabled:YES];
    [longGesture setMinimumPressDuration:0.1];
    [longGesture setDelegate:self];
    [view addGestureRecognizer:longGesture];
}

//当用户长按，拖拽， 并且松手时调用。 根据这三种动作的不同 进行不同操作
-(void)longPressGestureHandler:(UILongPressGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            
            _initialFrameOfObject = gesture.view.frame;
            UIImageView *copiedImageView = [[UIImageView alloc] initWithFrame:_initialFrameOfObject];
            [copiedImageView setImage:[(UIImageView*)gesture.view image]];
            [copiedImageView setContentMode:[(UIImageView*)gesture.view contentMode]];
            [gesture.view.superview addSubview:copiedImageView];
            [gesture.view.superview sendSubviewToBack:copiedImageView];
            [self addGestureRecognizersForImageView:copiedImageView];
            _tempImageView = copiedImageView;
            CGRect rectInGlobalView = [self.view convertRect:gesture.view.frame fromView:gesture.view.superview];
            
            [self.view addSubview:gesture.view];
            [gesture.view setFrame:rectInGlobalView];
            [self.view bringSubviewToFront:gesture.view];
            
            [UIView animateWithDuration:0.5 animations:^{
                [gesture.view setAlpha:0.5];
                [gesture.view setCenter:[gesture locationInView:gesture.view.superview]];
                if (gesture.view == self.pencilImageView || gesture.view == self.veinBrushImageView) {
                    gesture.view.transform = CGAffineTransformMakeRotation(-M_PI_4);
                }
            } completion:^(BOOL finished) {
                
            }];
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [gesture.view setCenter:[gesture locationInView:gesture.view.superview]];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
            
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
            else{
                [UIView animateWithDuration:0.5 animations:^{
                    [gesture.view setAlpha:1.0];
                    
                } completion:^(BOOL finished) {
                    [self.previousButton setEnabled:NO];
                    [self.nextButton setEnabled:NO];
                    [self drawVeinBrushPath];
                }];
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

//如果宣纸没有在页面上并且传入的视图是宣纸， 则允许手势识别器识别
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.view == self.xuanPaperImageView) {
        if (_isXuanPaperOnScreen) {
            return NO;
        }
    }
    
    return YES;
}

//利用第三方库PocketSVG将SVG图像转成IOS可用的路径，画出铅笔的图像 并且按照路径控制铅笔本身的动作
-(void)drawPencilPath
{
    CGPathRef myPath = [PocketSVG pathFromSVGFileNamed:@"bigFlower"];
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
    pathAnimation.duration = 10.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];;
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    colorAnimation.duration = 10.0;
    colorAnimation.fromValue = (id)[UIColor clearColor].CGColor;
    colorAnimation.toValue = (id)[UIColor blackColor].CGColor;
    [colorAnimation setFillMode:kCAFillModeBoth];
    
    
    
    CGAffineTransform translation = CGAffineTransformMakeTranslation(265,
                                                                     204);
    CGPathRef movedPath = CGPathCreateCopyByTransformingPath(myShapeLayer.path,
                                                             &translation);
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.path = movedPath;
    anim.calculationMode = kCAAnimationPaced;
    anim.duration = 10.0;
    anim.delegate = self;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    [myShapeLayer addAnimation:pathAnimation forKey:@"strokeAnime"];
    _firstLayer = myShapeLayer;
    [self.pencilImageView.layer addAnimation:anim forKey:@"pencil"];
}

//利用第三方库PocketSVG将SVG图像转成IOS可用的路径，画出VEIN的图像 并且按照路径控制VEIN笔本身的动作
-(void)drawVeinBrushPath
{
    CGPathRef myPath = [PocketSVG pathFromSVGFileNamed:@"bigFlower"];
    CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
    myShapeLayer.path = myPath;
    
    myShapeLayer.strokeColor = [[UIColor blackColor] CGColor];
    myShapeLayer.lineWidth = 5.0;
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
    pathAnimation.duration = 15.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];;
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    colorAnimation.duration = 15.0;
    colorAnimation.fromValue = (id)[UIColor clearColor].CGColor;
    colorAnimation.toValue = (id)[UIColor blackColor].CGColor;
    [colorAnimation setFillMode:kCAFillModeBoth];
    
    
    
    CGAffineTransform translation = CGAffineTransformMakeTranslation(265,
                                                                     204);
    CGPathRef movedPath = CGPathCreateCopyByTransformingPath(myShapeLayer.path,
                                                             &translation);
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.path = movedPath;
    anim.calculationMode = kCAAnimationPaced;
    anim.duration = 15.0;
    anim.delegate = self;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    [myShapeLayer addAnimation:pathAnimation forKey:@"strokeAnime"];
    _secondLayer = myShapeLayer;
    [self.veinBrushImageView.layer addAnimation:anim forKey:@"vein"];
}



//当画图动画结束时调用， 作用是清理画图后的一些数值，改变（增加）STEP的步数， 如果是最后一步则跳出ALERT。
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if (flag) {
        
        if (anim == [[self.pencilImageView layer] animationForKey:@"pencil"]) {
            [self.pencilImageView removeFromSuperview];
            self.pencilImageView = _tempImageView;
            _tempImageView = nil;
            [self nextButtonAction:nil];
            [self enableImageView:self.veinBrushImageView];
        }
        else if (anim == [[self.veinBrushImageView layer] animationForKey:@"vein"]) {
            [self.veinBrushImageView removeFromSuperview];
            self.veinBrushImageView = _tempImageView;
            _tempImageView = nil;
            [self nextButtonAction:nil];
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
        [self.previousButton setEnabled:YES];
        [self.nextButton setEnabled:YES];
    }
}

//拉伸路径图（由SVG转化后的）
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

//电池那行TOP BAR的STYLE
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//隐藏电池那个BAR
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

//当用户点清除画布后调用
- (IBAction)previousButtonAction:(id)sender {
    [self clearCanvas];
}

//清除画布上所有原素， 将所有值重设回默认
-(void)clearCanvas
{
    _tempImageView = nil;
    _isXuanPaperOnScreen = NO;
    [_firstLayer removeFromSuperlayer];
    [_secondLayer removeFromSuperlayer];
    _firstLayer = nil;
    _secondLayer = nil;
    [self.fullPaperImageView removeFromSuperview];
    self.fullPaperImageView = nil;
    [self.hintLabel setText:kTTStep1Text];
    [self.stepNumberLabel setText:[NSString stringWithFormat:@"%d",1]];
    [self enableImageView:self.xuanPaperImageView];
    [self.previousButton setEnabled:NO];
}

//改变STEP LABEL的步数，按步骤让其它笔变灰
- (IBAction)nextButtonAction:(id)sender {
    
    NSInteger step = [self.stepNumberLabel.text integerValue];
    if (step == 1) {
        if (self.fullPaperImageView) {
            [self.view addSubview:self.fullPaperImageView];
            [self.fullPaperImageView setFrame:CGRectMake(27, CGRectGetMaxY(self.stepBarView.frame)+75, 854, 635)];
            [self enableImageView:self.pencilImageView];
        }
        
        [self.hintLabel setText:kTTStep2Text];
    }
    else if (step == 2) {
        if (_firstLayer) {
            [self enableImageView:self.veinBrushImageView];
            [self.fullPaperImageView.layer addSublayer:_firstLayer];
        }
        [self.hintLabel setText:kTTStep3Text];
    }
    else if (step == 3){
        if (_secondLayer) {
            [self.fullPaperImageView.layer addSublayer:_secondLayer];
            [self enableImageView:nil];
        }
        
    }
    if (step <3) {
        [self.stepNumberLabel setText:[NSString stringWithFormat:@"%d",step+1]];
    }
}

//将传入的图像变成灰色
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
