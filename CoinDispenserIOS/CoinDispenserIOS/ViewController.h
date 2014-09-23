//
//  ViewController.h
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/23.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginResult;

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (copy, nonatomic) NSString *userName;
- (IBAction)btnLoginAction:(id)sender;
- (void) updateAuth:(LoginResult *)data;

@end

