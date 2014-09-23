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
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginAction:(id)sender {
    [self.view endEditing:YES];
    
    AuthenticationRestClient *auth = [[AuthenticationRestClient alloc] init];
    
    NSString *uname = self.txtUserName.text;
    NSString *pass = self.txtPassword.text;
    
    [auth authenticateUser:self userName:uname password:pass];
}

- (void) updateAuth:(LoginResult *)res {
    NSLog(@"Update auth");
    NSLog(@"%@", res.success);

    [self.lblMessage setText:res.result];
 }

@end
