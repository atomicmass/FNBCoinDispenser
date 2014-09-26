//
//  CoinViewController.m
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/24.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import "CoinViewController.h"
#import "DispenseCalculation.h"
#import "CalculationRestClient.h"
#import "DispenseCash.h"

@interface CoinViewController ()

@end

@implementation CoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayAmountDue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)clickRefresh:(id)sender {
    [self displayAmountDue];
}

- (IBAction)btn100Clicked:(id)sender {
    [self calculateChange:100];
}

- (IBAction)btn50Clicked:(id)sender {
    [self calculateChange:50];
}

- (IBAction)btn20Clicked:(id)sender {
    [self calculateChange:20];
}

- (IBAction)btn10Clicked:(id)sender {
    [self calculateChange:10];
}

/**
 * Generate a new due amount and setup the page
 */
-(void) displayAmountDue {
    //random an amount due, up to 100.00 but only in increments of 5c
    self.amountDue = (arc4random_uniform(2000) * 5) / 100.00;
    [self.lblAmountDue setText:[NSString stringWithFormat:@"R %.2f", self.amountDue]];
    [self.lblResults setText:@""];
    
    //Make the label "pop".
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    self.lblAmountDue.transform = CGAffineTransformMakeScale(2,2);
    [UIView setAnimationRepeatCount:1];
    self.lblAmountDue.transform = CGAffineTransformMakeScale(1,1);
    [UIView commitAnimations];
}

/**
 * Kick off the REST call to calculate the chnage
 */
-(void) calculateChange:(double) note {
    CalculationRestClient *rest = [[CalculationRestClient alloc] init];
    
    DispenseCalculation *calc = [[DispenseCalculation alloc] init];
    calc.amountDue = self.amountDue;
    calc.noteReceived = note;
    
    //When the service returns this block wil be calle to handle the return which will be in the calc variable
    void (^completionHandler)() = ^() {
        NSMutableString *results = [[NSMutableString alloc] init];
        for (DispenseCash *c in calc.cashToDispense) {
            if (c.denomination >= 1) {
                [results appendFormat:@"%d x R %.0f\n", c.quantity, c.denomination];
            } else {
                [results appendFormat:@"%d x %.0fc\n", c.quantity, c.denomination * 100];
            }
        }
        
        //If there is a message then something went wrong - make red
        [self.lblResults setTextColor:[UIColor blackColor]];
        if ([calc.message length] > 0) {
            [self.lblResults setTextColor:[UIColor redColor]];
            [results appendFormat:@"%@\n", calc.message];
        }
        
        [results appendFormat:@"\nTotal: R%.2f", calc.noteReceived - calc.amountDue];
        
        [self.lblResults setText:results];
    };
    
    [rest calculate:calc completionHandler:completionHandler];
}
@end
