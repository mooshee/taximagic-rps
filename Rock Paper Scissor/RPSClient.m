//
//  RPSClient.m
//  Rock Paper Scissor
//
//  Created by Daniel Hallman on 3/11/13.
//  Copyright (c) 2013 Daniel Hallman. All rights reserved.
//

#import "RPSClient.h"

NSString * const kRPSBaseURL = @"http://roshambo.herokuapp.com/";

@interface RPSClient() <NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, copy) RPSClientResultsBlock completionBlock;
@end

@implementation RPSClient

- (void)playerThrows:(NSString *)playerThrow completionBlock:(RPSClientResultsBlock)completionBlock
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@throws/%@", kRPSBaseURL, playerThrow]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"text/plain" forHTTPHeaderField:@"Accept"];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    _responseData = [NSMutableData data];
    _completionBlock = [completionBlock copy];
    [connection start];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_completionBlock) {
        _completionBlock(nil, nil, nil, error);
    }
}

NSString * const kRPSComputerPrefix = @"Computer:";
NSString * const kRPSPlayerPrefix = @"Player:";
NSString * const kRPSResultPrefix = @"You";

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *string = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    NSString *playerThrow, *computerThrow, *result;
    
    if (string) {
        NSArray *lines = [string componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        for (NSString *line in lines) {
            if ([line hasPrefix:kRPSPlayerPrefix]) {
                playerThrow = [[line substringFromIndex:kRPSPlayerPrefix.length] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            }
            else if ([line hasPrefix:kRPSComputerPrefix]) {
                computerThrow = [[line substringFromIndex:kRPSComputerPrefix.length] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            }
            else if ([line hasPrefix:kRPSResultPrefix]) {
                result = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            }
        }
    }
    if (_completionBlock) {
        if (playerThrow && computerThrow && result) {
            _completionBlock(playerThrow, computerThrow, result, nil);
        } else {
            _completionBlock(nil, nil, nil, [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:1 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Invalid Response", NSLocalizedDescriptionKey ,nil]]);
        }
    }
}

@end
