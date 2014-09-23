//
//  BaseRestClient.h
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/23.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRestClient : NSObject {
    NSMutableString		*_contentsOfElement;
}

- (id) init;
- (void) parseDocument:(NSData *) data ;
- (void) clearContentsOfElement ;
@end
