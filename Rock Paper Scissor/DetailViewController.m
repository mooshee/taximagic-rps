//
//  DetailViewController.m
//  Rock Paper Scissor
//
//  Created by Daniel Hallman on 3/11/13.
//  Copyright (c) 2013 Daniel Hallman. All rights reserved.
//

#import "DetailViewController.h"
#import "Game.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setGame:(Game *)game {
    if (_game != game) {
        _game = game;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.game) {
        self.youThrowLabel.text = self.game.youThrow;
        self.computerThrowLabel.text = self.game.computerThrow;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterMediumStyle;
        self.timestampLabel.text = [dateFormatter stringFromDate:self.game.timeStamp];
        
        NSRange range = [self.game.resultText rangeOfString:@"!"];
        if (range.location != NSNotFound) {
            self.resultLabel.text = [self.game.resultText substringToIndex:range.location+1];
        } else {
            self.resultLabel.text = self.game.resultText;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Results", @"Results");
    }
    return self;
}
							
@end
