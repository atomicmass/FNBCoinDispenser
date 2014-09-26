//
//  BaseRestClient.h
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/23.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//
//  Provides basic REST functionality. To be extended by actual implementation for specific scenarios
//

#import <Foundation/Foundation.h>

@interface BaseRestClient : NSObject <NSXMLParserDelegate> {
    NSMutableData       *wipData;		// The data being received from the rest service
    NSMutableString		*contentsOfElement;
}

@property (nonatomic) NSObject *result;
@property (nonatomic, strong) void (^completionHandler)();

- (void) parseDocument:(NSData *) data ;
- (void) clearContentsOfElement ;
@end
