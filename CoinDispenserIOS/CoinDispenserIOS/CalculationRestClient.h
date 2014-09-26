//
//  CalculationRestClient.h
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/24.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRestClient.h"
@class DispenseCalculation;
@class DispenseCash;

@interface CalculationRestClient : BaseRestClient {
    DispenseCalculation			*wipResult;		// the work in progress result
    DispenseCash                *wipCash;
}

-(void) calculate:(DispenseCalculation *)calc completionHandler:(void(^)(id)) completionHandler;

@end
