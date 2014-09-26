//
//  CalculationRestClient.m
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/24.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import "CalculationRestClient.h"
#import "DispenseCalculation.h"
#import "DispenseCash.h"
#import <UIKit/UIKit.h>

@implementation CalculationRestClient

@synthesize result;

-(id) init {
    self = [super init];
    result = [[DispenseCalculation alloc] init];
    return self;
}

/**
 * Constructs REST call and fire it off asynchronously
 */
-(void) calculate:(DispenseCalculation *)calc completionHandler:(void(^)(id)) completionHandler {
    self.completionHandler = completionHandler;
    NSString *urlStr = @"http://localhost:8080/CoinDispenserWS/dispenser"; //TODO: parameterize
    NSURL *url = [NSURL URLWithString:urlStr];

    NSString *json = [NSString stringWithFormat:@"{\"amountDue\": %.2f, \"noteReceived\":%.0f }", calc.amountDue, calc.noteReceived];
    NSLog(@"JSON: %@", json);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    //Setup the POST request and send
    NSMutableURLRequest *req = [NSMutableURLRequest
                            requestWithURL:url
                            cachePolicy:NSURLRequestReloadIgnoringCacheData
                            timeoutInterval:30.0];
    
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData *requestBodyData = [json dataUsingEncoding:NSUTF8StringEncoding];
    [req setHTTPBody:requestBodyData];
    
    [NSURLConnection connectionWithRequest:req delegate:self];
}

/**
 * XML Parsing. When an element starts we may need to construct stuff
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [self clearContentsOfElement];
    
    if ([elementName isEqualToString:@"dispenseCalculation"]) {
        wipResult = [[DispenseCalculation alloc] init];
    } else if ([elementName isEqualToString:@"cashToDispense"]) {
        wipCash = [[DispenseCash alloc] init];
    }
}

/**
 * XML Parsing. Elements ended. Add the value to the object model
 */

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"dispenseCalculation"]) {
        result = wipResult;
        wipResult = nil;
    } else if([elementName isEqualToString:@"cashToDispense"]) {
        [wipResult.cashToDispense addObject:wipCash];
        wipCash = nil;
    } else if ([elementName isEqualToString:@"amountDue"]) {
        [wipResult setAmountDue:[contentsOfElement doubleValue]];
    } else if ([elementName isEqualToString:@"noteReceived"]) {
        [wipResult setNoteReceived:[contentsOfElement doubleValue]];
    } else if ([elementName isEqualToString:@"denomination"]) {
        [wipCash setDenomination:[contentsOfElement doubleValue]];
    } else if ([elementName isEqualToString:@"quantity"]) {
        [wipCash setQuantity:[contentsOfElement intValue]];
    } else if ([elementName isEqualToString:@"message"]) {
        [wipResult setMessage:contentsOfElement];
    }
    
    [self clearContentsOfElement];
}

@end
