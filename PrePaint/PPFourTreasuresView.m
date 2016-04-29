//
//  PPFourTreasuresView.m
//  PrePaint
//
//  Created by Jing Tang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

//自制的文房四宝图标

#import "PPFourTreasuresView.h"
#import "FourTreasuresViewController.h"

@implementation PPFourTreasuresView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

-(void)setIsSelected:(BOOL)isSelected
{
    if (isSelected) {
        [self setBackgroundColor:SelectedBlueColor];
    }
    else{
        [self setBackgroundColor:[UIColor clearColor]];
    }
    _isSelected = isSelected;
    
}

//TOUCH后调用的方法， 让responseDelegate 也就是文房四宝页CONTROLLER的treasureSelected方法被调用，详见FourTreasuresViewController.m里的treasureSelected方法， GET IT页也用到本方法
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.responseDelegate respondsToSelector:@selector(treasureSelected:)]) {
        [self.responseDelegate performSelector:@selector(treasureSelected:) withObject:self];
    }
}
@end
