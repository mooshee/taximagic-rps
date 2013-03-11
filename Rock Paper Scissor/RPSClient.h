//
//  RPSClient.h
//  Rock Paper Scissor
//
//  Created by Daniel Hallman on 3/11/13.
//  Copyright (c) 2013 Daniel Hallman. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RPSClientResultsBlock)(NSString *playerThrow, NSString *computerThrow, NSString *result, NSError *error);

@interface RPSClient : NSObject

- (void)playerThrows:(NSString *)playerThrow completionBlock:(RPSClientResultsBlock)completionBlock;

@end
