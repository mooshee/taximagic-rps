//
//  DetailViewController.h
//  Rock Paper Scissor
//
//  Created by Daniel Hallman on 3/11/13.
//  Copyright (c) 2013 Daniel Hallman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Game;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Game *game;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *youThrowLabel;
@property (weak, nonatomic) IBOutlet UILabel *computerThrowLabel;

@end
