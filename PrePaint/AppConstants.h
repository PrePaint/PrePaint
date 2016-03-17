//
//  AppConstants.h
//  PrePaint
//
//  Created by Xi Zhang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#ifndef AppConstants_h
#define AppConstants_h


#endif /* AppConstants_h */

/* ----------------------- color -------------------*/
#define SelectedBlueColor [UIColor colorWithRed:111.0/255.0 green:189.0/255.0 blue:177.0/255.0 alpha:1.0]
#define UnSelectedGreyColor [UIColor colorWithRed:110.0/255.0 green:113.0/255.0 blue:122.0/255.0 alpha:1.0]

/* ----------------------- font -------------------*/
#define KHelveticaNeueRegular @"HelveticaNeue"
#define KHelveticaNeueUltralight @"HelveticaNeue-UltraLight"
#define KHelveticaNeueThin @"HelveticaNeue-Thin"
#define KHelveticaNeueLight @"HelveticaNeue-Light"
#define kHelveticaNeueBold @"HelveticaNeue-Bold"
#define kHelveticaNeueItalics @"HelveticaNeue-LightItalic"
#define kHelveticaNeueMediumItalics @"HelveticaNeue-MediumItalic"
#define kHelveticaNeueBoldItalics @"HelveticaNeue-BoldItalic"


/* ----------------------- type -------------------*/

typedef enum {
    PPNavationOptionTypeTools,
    PPNavationOptionTypeNeeded,
    PPNavationOptionTypeGetIt,
    PPNavationOptionTypeWishList
}
PPNavationOptionType;

typedef enum {
    PPTreasureTypeBrush,
    PPTreasureTypePaper,
    PPTreasureTypeHolder,
    PPTreasureTypeInk
}
PPTreasureType;

typedef enum {
    PPPaintingStyleContour = 0,
    PPPaintingStyleIdea = 1,
    PPPaintingStyleCombination = 2,
    PPPaintingStyleIForgot = 3
    
} PPPaintingStyle;
