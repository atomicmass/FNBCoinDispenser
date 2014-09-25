//
//  ViewController.m
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/23.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import "ViewController.h"
#import "AuthenticationRestClient.h"
#import "LoginResult.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize userName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set up deleaget to hide kyboard when the user taps out
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.txtUserName resignFirstResponder];
    [self.txtPassword resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 * Kick off the REST service to authenticate the user (async)
 */
- (IBAction)btnLoginAction:(id)sender {
    [self.view endEditing:YES];
    
    AuthenticationRestClient *auth = [[AuthenticationRestClient alloc] init];
    
    NSString *uname = self.txtUserName.text;
    NSString *pass = self.txtPassword.text;
    
    [auth authenticateUser:self userName:uname password:pass];
}

/**
 * Gets called once the REST service returns
 */
- (void) updateAuth:(LoginResult *)res {
    NSLog(@"Update auth");
    NSLog(@"%@", res.success);

    [self.lblMessage setText:res.result];
    
    if([res.success isEqualToString:@"true"]) {
        [self performSegueWithIdentifier:@"successfulLogin" sender:self];
    }
 }

@end
