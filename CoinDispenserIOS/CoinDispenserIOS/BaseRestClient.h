//
//  BaseRestClient.h
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/23.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LoginResult;

@interface BaseRestClient : NSObject <NSXMLParserDelegate> {
    NSMutableData       *wipData;		// The data being received from the rest service
    NSMutableString		*contentsOfElement;
}

@property (nonatomic) id result;
@property (nonatomic, strong) void (^completionHandler)(LoginResult *);

- (id) init;
- (void) parseDocument:(NSData *) data ;
- (void) clearContentsOfElement ;
@end
