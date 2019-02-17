//
//  ViewController.m
//  Stopwatch
//
//  Created by Mike Jarosch on 2/16/19.
//  Copyright © 2019 Mike Jarosch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timerDisplay;
@property (weak, nonatomic) IBOutlet UIButton *startStop;
@property (weak, nonatomic) IBOutlet UIButton *reset;

@end

@implementation ViewController

int _time;
NSTimer *_timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)startStopClicked:(id)sender {
    if (_timer == nil) {
        self.reset.enabled = NO;

        [self.startStop setTitle:@"Stop" forState:UIControlStateNormal];

        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 repeats:YES block:^(NSTimer * _Nonnull timer) {
            _time++;
            [self updateDisplay];
        }];
    } else {
        self.reset.enabled = YES;

        [self.startStop setTitle:@"Start" forState:UIControlStateNormal];

        [_timer invalidate];
        _timer = nil;
    }
}

- (IBAction)resetClicked:(id)sender {
    _time = 0;
    self.reset.enabled = NO;
    [self updateDisplay];
}

- (void)updateDisplay {
    int hundredth = _time % 100;
    int seconds = (_time / 100) % 60;
    int minutes = (_time / 6000) % 60;
    int hours = _time / 360000;
    self.timerDisplay.text = [NSString stringWithFormat: @"%02d:%02d:%02d.%02d", hours, minutes, seconds, hundredth];
}

@end
