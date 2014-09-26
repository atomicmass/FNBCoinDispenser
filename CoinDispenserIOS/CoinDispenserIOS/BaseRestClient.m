//
//  BaseRestClient.m
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/23.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#pragma GCC diagnostic ignored "-Wundeclared-selector"

#import "BaseRestClient.h"
#import <UIKit/UIKit.h>

@implementation BaseRestClient

@synthesize result, completionHandler;

- (id) init {
    self = [super init];
    return self;
}

- (void) clearContentsOfElement {
    contentsOfElement = [[NSMutableString alloc] init];
}

/**
 * Start parsing the XML documnent using the parser in the child classes
 */
- (void) parseDocument:(NSData *) data {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    
    [parser parse];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [contentsOfElement appendString:string];
}

- (NSString *)trim:(NSString *)inStr {
    return [inStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [wipData appendData:data];
}

/**
 * All the data has loaded. Parse it.
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)conn {
    [self parseDocument:wipData];
    
    completionHandler(result);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/**
 * This just indicates that we are getting a response. Does not handle the response itself.
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        int status = (int)httpResponse.statusCode;
        
        if (!((status >= 200) && (status < 300))) {
            NSLog(@"Connection failed with status %d", status);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        } else {
            wipData = [[NSMutableData alloc] initWithCapacity:1024];
        }
    }
}


@end
