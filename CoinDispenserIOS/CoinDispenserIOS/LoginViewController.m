//
//  ViewController.m
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/23.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import "LoginViewController.h"
#import "AuthenticationRestClient.h"
#import "LoginResult.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
    NSString *uname = self.txtUserName.text;
    NSString *pass = self.txtPassword.text;
    
    if([uname length] == 0 || [pass length] == 0) {
        [self.lblMessage setText:@"User name and password required"];
        return;
    }
    
    AuthenticationRestClient *auth = [[AuthenticationRestClient alloc] init];
    
    //Init the variable to hold the result from the service
    LoginResult *result = [[LoginResult alloc] init];
    
    //When the service returns this block wil handle it using the result variable
    void (^completionHandler)() = ^() {
        NSLog(@"Update auth");
        NSLog(@"%@", result.success);
            
        [self.lblMessage setText:result.result];
            
        if([result.success isEqualToString:@"true"]) {
            [self performSegueWithIdentifier:@"successfulLogin" sender:self];
        }
    };
    
    [auth authenticateUser:uname password:pass completionHandler:completionHandler loginResult:result];
}


@end
