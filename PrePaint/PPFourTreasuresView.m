//
//  PPFourTreasuresView.m
//  PrePaint
//
//  Created by Xi Zhang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "PPFourTreasuresView.h"

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


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.responseDelegate respondsToSelector:@selector(treasureSelected:)]) {
        [self.responseDelegate performSelector:@selector(treasureSelected:) withObject:self];
    }
}
@end
