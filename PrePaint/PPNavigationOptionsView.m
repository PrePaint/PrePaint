//
//  PPNavigationOptionsView.m
//  PrePaint
//
//  Created by Jing Tang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "PPNavigationOptionsView.h"
#import "BaseViewController.h"

@implementation PPNavigationOptionsView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // Drawing code
    CGFloat imageWidth = 24.0;
    CGFloat imageHeight = 24.0;
    UIImage *buttonImage;
    NSString *numberStr = @"";
    NSString *buttonTitle = @"";
    CGRect imageRect = CGRectMake(CGRectGetMidX(rect)-imageWidth/2.0, CGRectGetMidY(rect)-imageHeight/2.0, imageWidth, imageHeight);
    imageRect.origin.y -= 5.0;
    UIColor *fontColor;
    
    switch (self.buttonType) {
        case PPNavationOptionTypeTools:
        {
            if (self.isSelected) {
                buttonImage = [UIImage imageNamed:@"navi_heart_selected"];
            }
            else{
                buttonImage = [UIImage imageNamed:@"navi_heart_unselected"];
            }
            
//            numberStr = @"2.";
            buttonTitle = @"EXAMPLE";
           
        }
            break;
        case PPNavationOptionTypeNeeded:
        {
     
            
            if (self.isSelected) {
                buttonImage = [UIImage imageNamed:@"navi_brush_selected"];
            }
            else{
                buttonImage = [UIImage imageNamed:@"navi_brush_unselected"];
            }
            
//            numberStr = @"1.";
            buttonTitle = @"LEARN TOOLS";
        }
            break;
        case PPNavationOptionTypeGetIt:
        {
            if (self.isSelected) {
                buttonImage = [UIImage imageNamed:@"navi_navigation_selected"];
            }
            else{
                buttonImage = [UIImage imageNamed:@"navi_navigation_unselected"];
            }
            
//            numberStr = @"3.";
            buttonTitle = @"GET TOOLS";
        }
            break;
        case PPNavationOptionTypeWishList:
        {
            if (self.isSelected) {
                buttonImage = [UIImage imageNamed:@"navi_wishlist_selected"];
            }
            else{
                buttonImage = [UIImage imageNamed:@"navi_wishlist_unselected"];
            }
            
           // numberStr = @"1.";
            buttonTitle = @" WISH LIST";
        }
            break;
            
        default:
        {
            if (self.isSelected) {
                buttonImage = [UIImage imageNamed:@"navi_brush_selected"];
            }
            else{
                buttonImage = [UIImage imageNamed:@"navi_brush_unselected"];
            }
            
//            numberStr = @"1.";
            buttonTitle = @"LEARN TOOLS";
        }
            break;
    }
    
    if (self.isSelected) {
        fontColor = [UIColor blackColor];
    }
    else{
        fontColor = UnSelectedGreyColor;
    }
    
    [buttonImage drawInRect:imageRect];
    
    UIFont *numberFont = [UIFont fontWithName:kHelveticaNeueBold size:18.0];
    UIFont *titleFont = [UIFont fontWithName:KHelveticaNeueLight size:12.0];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    NSDictionary *numberAttr = @{NSParagraphStyleAttributeName:style,
                           NSFontAttributeName:numberFont,
                           NSForegroundColorAttributeName:fontColor
                           };
    NSDictionary *titleAttr = @{NSParagraphStyleAttributeName:style,
                           NSFontAttributeName:titleFont,
                           NSForegroundColorAttributeName:fontColor
                           };
    
    if (self.buttonType != PPNavationOptionTypeWishList) {
        
        NSMutableAttributedString *buttonAttrStr = [[NSMutableAttributedString alloc] initWithString:numberStr attributes:numberAttr];
        
        NSMutableAttributedString *indicationAttrStr = [[NSMutableAttributedString alloc] initWithString:buttonTitle attributes:titleAttr];
        
        [buttonAttrStr appendAttributedString:indicationAttrStr];
        
        CGRect titleRect = [buttonAttrStr boundingRectWithSize:CGSizeMake(120.0, 100.0) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        
        titleRect.origin.x = CGRectGetMidX(rect)-titleRect.size.width/2.0;
        titleRect.origin.y = CGRectGetMidY(rect)+15.0;
        
        [buttonAttrStr drawInRect:titleRect];
    }
    else{
        NSDictionary *titleAttr = @{NSParagraphStyleAttributeName:style,
                                    NSFontAttributeName:titleFont,
                                    NSForegroundColorAttributeName:fontColor
                                    };
        CGRect titleRect = [buttonTitle boundingRectWithSize:CGSizeMake(120, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:titleAttr context:nil];
        titleRect.origin.x = CGRectGetMidX(rect)-titleRect.size.width/2.0;
        titleRect.origin.y = CGRectGetMidY(rect)+16.0;
        [buttonTitle drawInRect:titleRect withAttributes:titleAttr];
    }
}

-(void)setIsSelected:(BOOL)isSelected
{
    if (self.buttonType != PPNavationOptionTypeWishList) {
        if (isSelected) {
            [self setBackgroundColor:[UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0]];
        }
        else{
            [self setBackgroundColor:[UIColor whiteColor]];
        }
    }
    else{
        [self setBackgroundColor:[UIColor blackColor]];
    }
    _isSelected = isSelected;
    [self setNeedsDisplay];

}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.responseDelegate respondsToSelector:@selector(optionSelected:)]) {
        [self.responseDelegate performSelector:@selector(optionSelected:) withObject:self];
    }
}


@end
