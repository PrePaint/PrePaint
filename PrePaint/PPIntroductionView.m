//
//  PPIntroductionView.m
//  PrePaint
//
//  Created by Jing Tang on 3/16/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "PPIntroductionView.h"

@implementation PPIntroductionView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //setup
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIFont *titleFont = [UIFont fontWithName:kAvenirRoman size:20.0];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentLeft];
    NSDictionary *attr = @{NSParagraphStyleAttributeName:style,
                           NSFontAttributeName:titleFont
                           };
    
    CGFloat horizontalPadding = 35.0;
    
    
    //draw style title
    CGRect titleRect = [self.styleName boundingRectWithSize:CGSizeMake(rect.size.width-horizontalPadding*2.0, 45.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    titleRect.origin.x = horizontalPadding;
    titleRect.origin.y = 20.0;
    
    [self.styleName drawInRect:titleRect withAttributes:attr];
    
    CGContextMoveToPoint(ctx, horizontalPadding, CGRectGetMaxY(titleRect)+10.0);
    CGContextAddLineToPoint(ctx, rect.size.width, CGRectGetMaxY(titleRect)+10.0);
    CGContextSetStrokeColorWithColor(ctx, UnSelectedGreyColor.CGColor);
    CGContextStrokePath(ctx);
    
    UIFont *introFont = [UIFont fontWithName:kAvenirLight size:14.0];
    
    attr = @{NSParagraphStyleAttributeName:style,
             NSFontAttributeName:introFont
             };
    
    CGRect introRect = [self.styleIntro boundingRectWithSize:CGSizeMake(rect.size.width-horizontalPadding*2.0, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    
    introRect.origin.x = horizontalPadding;
    introRect.origin.y = CGRectGetMaxY(titleRect)+10.0+15.0;
    
    [self.styleIntro drawInRect:introRect withAttributes:attr];
    
    CGFloat baseY = CGRectGetMaxY(introRect)+18.0;
    
    UIFont *descriptionFont = [UIFont fontWithName:kAvenirMedium size:13.0];
    
    attr = @{NSParagraphStyleAttributeName:style,
             NSFontAttributeName:descriptionFont
             };
    
    for (NSString *detailIntro in self.styleDescriptionArray) {
        CGRect dotRect = CGRectMake(horizontalPadding, baseY, 10.0, 10.0);
        CGContextSetFillColorWithColor(ctx, SelectedBlueColor.CGColor);
        CGContextFillEllipseInRect(ctx, dotRect);
        
        CGRect currentRect = [detailIntro boundingRectWithSize:CGSizeMake(rect.size.width-horizontalPadding*2.0-dotRect.size.width-10.0, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
        currentRect.origin.x = CGRectGetMaxX(dotRect)+10.0;
        currentRect.origin.y = dotRect.origin.y-3.0;
        [detailIntro drawInRect:currentRect withAttributes:attr];
        baseY += currentRect.size.height+15.0;
        
    }
}


@end
