//
//  CoinViewController.h
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/24.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DispenseCalculation;

@interface CoinViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblAmountDue;
@property (nonatomic) double amountDue;
@property (weak, nonatomic) IBOutlet UILabel *lblResults;

- (IBAction) clickRefresh:(id)sender;
- (IBAction) btn100Clicked:(id)sender;
- (IBAction) btn50Clicked:(id)sender;
- (IBAction) btn20Clicked:(id)sender;
- (IBAction) btn10Clicked:(id)sender;
- (void) calculateChange:(double) note;
- (void) displayAmountDue;
@end
