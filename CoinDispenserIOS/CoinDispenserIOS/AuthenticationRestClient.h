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
    LoginResult			*wipResult;
}

-(void) authenticateUser:(NSString *)uname password:(NSString *)pass completionHandler:(void(^)(LoginResult *)) completionHandler;

@end
