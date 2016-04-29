//
//  AppConstants.h
//  PrePaint
//
//  Created by Jing Tang on 3/7/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

//APP所用到的所有常量

#ifndef AppConstants_h
#define AppConstants_h


#endif /* AppConstants_h */

/* ----------------------- color -------------------*/
#define SelectedBlueColor [UIColor colorWithRed:111.0/255.0 green:189.0/255.0 blue:177.0/255.0 alpha:1.0]
#define UnSelectedGreyColor [UIColor colorWithRed:110.0/255.0 green:113.0/255.0 blue:122.0/255.0 alpha:1.0]
#define kDisabledImageMaskColor [[UIColor blackColor] colorWithAlphaComponent:0.6]

/* ----------------------- font -------------------*/
#define KHelveticaNeueRegular @"HelveticaNeue"
#define KHelveticaNeueUltralight @"HelveticaNeue-UltraLight"
#define KHelveticaNeueThin @"HelveticaNeue-Thin"
#define KHelveticaNeueLight @"HelveticaNeue-Light"
#define kHelveticaNeueBold @"HelveticaNeue-Bold"
#define kHelveticaNeueItalics @"HelveticaNeue-LightItalic"
#define kHelveticaNeueMediumItalics @"HelveticaNeue-MediumItalic"
#define kHelveticaNeueBoldItalics @"HelveticaNeue-BoldItalic"

#define kAvenirHeavy @"Avenir-Heavy"
#define kAvenirLight @"Avenir-Light"
#define kAvenirMedium @"Avenir-Medium"
#define kAvenirBlack @"Avenir-Black"
#define kAvenirRoman @"Avenir-Roman"


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


//text
static NSString *kTTStep1Text = @"Place treated xuan paper on the table";
static NSString *kTTStep2Text = @"Drag the pencil to the treated xuan paper";
static NSString *kTTStep3Text = @"Drag the vein brush to the treated xuan paper";

static NSString *kDTStep1Text = @"Place treated xuan paper on the table";
static NSString *kDTStep2Text = @"Drag the pencil to the treated xuan paper";
static NSString *kDTStep3Text = @"Drag the goat brush to the treated xuan paper";
static NSString *kDTStep4Text = @"Drag the vein brush to the treated xuan paper";


static NSString *kITStep1Text = @"Place untreated xuan paper on the table";
static NSString *kITStep2Text = @"Drag the goat brush to the untreated xuan paper";
static NSString *kITStep3Text = @"Drag the vein brush to the untreated xuan paper";
static NSString *kITStep4Text = @"Drag the wolf brush to the untreated xuan paper";

static NSString *kCTStep1Text = @"Place untreated xuan paper on the table";
static NSString *kCTStep2Text = @"Drag the pencil to the untreated xuan paper";
static NSString *kCTStep3Text = @"Drag the goat brush to the untreated xuan paper";
static NSString *kCTStep4Text = @"Drag the vein brush to the untreated xuan paper";
static NSString *kCTStep5Text = @"Drag the wolf brush to the untreated xuan paper";

//------------------------- size -------------------------//
#define kSlideShowViewHeight 624.0

//-------------------------- macro values -----------------//
#define kTotoalPageNumberBrush 15
#define kTotoalPageNumberPaper 6
#define kTotoalPageNumberInk 9
#define kTotoalPageNumberColor 6





