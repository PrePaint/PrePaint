//
//  GetItViewController.m
//  PrePaint
//
//  Created by Jing Tang on 4/22/16.
//  Copyright © 2016 JingTang. All rights reserved.
//

#import "GetItViewController.h"
#import "UIView+Toast.h"

@interface GetItViewController ()
{

}

@property (strong, nonatomic) PPFourTreasuresView *selectedTreasure;

@end

@implementation GetItViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.shareButton.layer setCornerRadius:6.0];
    [self setupStyleViews];
    // Do any additional setup after loading the view from its nib.
}

-(void)setupStyleViews
{
    [self.contourView setButtonType:PPTreasureTypeBrush];
    [self.contourView setResponseDelegate:self];
    
    [self.detailView setButtonType:PPTreasureTypePaper];
    [self.detailView setResponseDelegate:self];
    
    [self.ideaView setButtonType:PPTreasureTypeHolder];
    [self.ideaView setResponseDelegate:self];
    
    [self.combinationView setButtonType:PPTreasureTypeInk];
    [self.combinationView setResponseDelegate:self];
}


-(void)treasureSelected:(PPFourTreasuresView*)treasureView
{
    if (treasureView == self.selectedTreasure) {
        [treasureView.layer setBorderColor:[UIColor clearColor].CGColor];

            self.selectedTreasure = nil;
    }
    else{
        if (self.selectedTreasure == nil) {
            [treasureView.layer setBorderColor:SelectedBlueColor.CGColor];
            [treasureView.layer setBorderWidth:2.0];

            self.selectedTreasure = treasureView;
        }
        else{
            [self.selectedTreasure.layer setBorderColor:[UIColor clearColor].CGColor];

            [treasureView.layer setBorderColor:SelectedBlueColor.CGColor];
            [treasureView.layer setBorderWidth:2.0];

            self.selectedTreasure = treasureView;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)shareAction:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        
        if (self.selectedTreasure == nil) {
            [self.view makeToast:@"Please select a painting style." duration:3.0 position:CSToastPositionCenter];
        }
        
        else{
            NSString *bodyString = @"";
            NSString *vein = @"<div><a href=\"http://www.amazon.com/Leaf-Vein-Fine-Detail-Brush/dp/B013TFTPHQ/ref=sr_1_3?ie=UTF8&qid=1461314374&sr=8-3&keywords=vein+brush\">Vein Brush</a></div>\n";
            NSString *pencil = @"<div><a href=\"http://www.amazon.com/Kuelox-Sketch-Pencil-8B/dp/B0111Q16DG/ref=sr_1_2?ie=UTF8&qid=1461550777&sr=8-2&keywords=sketch+pencil\">Pencil</a></div>\n";
           
            NSString *wolf =@"<div><a href=\"http://www.amazon.com/Chinese-Calligraphy-Writing-Painting-Brush/dp/B016JWFYZI/ref=sr_1_1?ie=UTF8&qid=1461552020&sr=8-1&keywords=wolf+brush+chinese+painting\">Wolf Brush</a></div>\n";
            NSString *goat =@"<div><a href=\"http://www.amazon.com/Chinese-Painting-Soft-Sable-Brush/dp/B006FHLFHY/ref=sr_1_2?ie=UTF8&qid=1461552178&sr=8-2&keywords=goat+brush+chinese+painting\">Goat Brush</a></div>\n";
            
            
            NSString *treatedXuan = @"<div><a href=\"http://www.amazon.com/Practice-Chinese-Calligraphy-Drawing-34x70cm/dp/B00GJDP7IC/ref=sr_1_fkmr1_1?ie=UTF8&qid=1461737086&sr=8-1-fkmr1&keywords=untreated+xuan+paper\">Treated Xuan</a></div>\n";
            
            NSString *untreatedXuan = @"<div><a href=\"http://www.amazon.com/Meiyutang-Calligraphy-Painting-Practice-50sheets/dp/B012J4LVQG/ref=sr_1_fkmr1_3?ie=UTF8&qid=1461737008&sr=8-3-fkmr1&keywords=treated+xuan+paper\">Untreated Xuan</a></div>\n";
            
            NSString *inkStone = @"<div><a href=\"http://www.amazon.com/Chinese-Calligraphy-Drawing-Kanji-12-5CM/dp/B00GJ5QSAQ/ref=sr_1_8?ie=UTF8&qid=1461737195&sr=8-8&keywords=chinese+ink+stone\">Ink Stone</a></div>\n";
            
            NSString *ink = @"<div><a href=\"http://www.amazon.com/Hukaiwen-Ink-Block-Handmade-Calligraphy/dp/B016FJIVHS/ref=sr_1_3?ie=UTF8&qid=1461739230&sr=8-3&keywords=chinese+painting+ink+stick\">Ink Stick</a></div>\n";
            
            NSString *color = @"<div><a href=\"http://www.amazon.com/Colors-Maries-Watercolor-Chinese-Painting/dp/B007SOXBYI/ref=sr_1_1?ie=UTF8&qid=1461739256&sr=8-1&keywords=chinese+painting+color\">Color tubes</a></div>\n";
            
            NSString *inkTube = @"<div><a href=\"http://www.amazon.com/Chinese-Calligraphy-Black-Ink-100G/dp/B0042IRDAQ/ref=sr_1_1?ie=UTF8&qid=1461739387&sr=8-1&keywords=chinese+painting+ink\">Black Ink</a></div>\n";

            UIImage *emailImage;
          
            
            
            NSString *styleString = @"";
            if (self.selectedTreasure == self.contourView) {
                styleString = @"Contour Style";
                bodyString = [NSString stringWithFormat:@"%@ %@ %@ %@", treatedXuan,pencil,vein,inkStone];
                emailImage = [UIImage imageNamed:@"getit_style1"];
            }
            else if (self.selectedTreasure == self.detailView) {
                styleString = @"Detail Style";
                bodyString = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", treatedXuan,vein,goat,inkStone,ink,color];
                emailImage = [UIImage imageNamed:@"getit_style2"];
            }
            else if (self.selectedTreasure == self.ideaView) {
                styleString = @"Idea Style";
                bodyString = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", untreatedXuan,wolf,goat,inkTube,color];
                emailImage = [UIImage imageNamed:@"getit_style3"];
            }
            else{
                styleString = @"Combination Style";
                bodyString = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", untreatedXuan,vein,wolf,goat,inkTube,color];
                emailImage = [UIImage imageNamed:@"getit_style4"];
            }
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[@""]];
        [composeViewController setSubject:@"PrePaint_e_support"];
     
            
        NSMutableString *body = [NSMutableString string];
        [body appendString:@"<div>Hi dear user,</div><br/>\n"];
        [body appendString:@"<div>Here are the style information and tools you will need for the style</div><br/>\n"];
            NSString *imageStr = [self dataStringFromImage:emailImage];
            [body appendString:[NSString stringWithFormat:@"<div class=\"center\"><p><b><img src='data:image/png;base64,%@'></b></p></div>",imageStr]];
        bodyString = [NSString stringWithFormat:@"<div class=\"center\">%@</div><style>.center {margin: auto;width: 418px;text-align:center; }</style><br/><br/><br/>",bodyString];
        [body appendString:bodyString];
        [body appendString:@"<div>Thanks for using PrePaint</div>\n"];
        
        [composeViewController setMessageBody:body isHTML:YES];
        [self presentViewController:composeViewController animated:YES completion:nil];
        }
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{

    switch (result) {
        case MFMailComposeResultSent:
        {
            [self.view makeToast:@"The style you selected has been shared by Email." duration:3.0 position:CSToastPositionCenter];
            [self.selectedTreasure.layer setBorderColor:[UIColor clearColor].CGColor];
            self.selectedTreasure = nil;
        }
            break;
        case MFMailComposeResultSaved:
            [self.view makeToast:@"Email draft has been saved." duration:3.0 position:CSToastPositionCenter];
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this Email.");
            break;
        case MFMailComposeResultFailed:
            [self.view makeToast:@"An error occurred when trying to compose this Email." duration:3.0 position:CSToastPositionCenter];
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)dataStringFromImage:(UIImage *)image
{
    NSData *imgData = UIImageJPEGRepresentation(image, 1);
    return [imgData base64EncodedStringWithOptions:kNilOptions];
}

@end
