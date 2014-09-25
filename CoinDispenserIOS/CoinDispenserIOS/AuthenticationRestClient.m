#pragma GCC diagnostic ignored "-Wundeclared-selector"

#import "AuthenticationRestClient.h"

#import "BaseRestClient.h"
#import "LoginResult.h"
#import <UIKit/UIKit.h>

@implementation AuthenticationRestClient

@synthesize result, controller;

-(id) init {
    self = [super init];
    result = [[LoginResult alloc] init];
    return self;
}

-(void) authenticateUser:(id)cntrller userName:(NSString *)uname password:(NSString *)pass {
    self.controller = cntrller;
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/CoinDispenserWS/user/%@/%@", uname, pass];
    NSURL *url = [NSURL URLWithString:urlStr];
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url
                         cachePolicy:NSURLRequestReloadIgnoringCacheData
                                     timeoutInterval:30.0];
    
    [NSURLConnection connectionWithRequest:req delegate:self];
}

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

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [wipData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn {
    [self parseDocument:wipData];
    
    if ([controller respondsToSelector:@selector(updateAuth:)]) {
        [controller performSelector:@selector(updateAuth:) withObject:result];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [self clearContentsOfElement];
    
    if ([elementName isEqualToString:@"loginResult"]) {
        wipResult = [[LoginResult alloc] init];
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"loginResult"]) {
        result = wipResult;
        wipResult = nil;
    } else if ([elementName isEqualToString:@"result"]) {
        [wipResult setResult:_contentsOfElement];
        
    } else if ([elementName isEqualToString:@"success"]) {
        [wipResult setSuccess:_contentsOfElement];
    }
    [self clearContentsOfElement];
}

@end

