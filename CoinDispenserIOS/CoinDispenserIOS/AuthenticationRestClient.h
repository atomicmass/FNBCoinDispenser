//
//  AuthenticationRestClient.h
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/23.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRestClient.h"
@class LoginResult;

@interface AuthenticationRestClient : BaseRestClient {
    NSMutableData		*wipData;
    LoginResult			*wipResult;
}


@property (nonatomic) LoginResult *result;
@property (nonatomic) id controller;

-(void) authenticateUser:(id)controller userName:(NSString *)uname password:(NSString *)pass;

@end
