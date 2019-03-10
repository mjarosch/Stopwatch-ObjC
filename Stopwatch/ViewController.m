//
//  ViewController.m
//  Stopwatch
//
//  Created by Mike Jarosch on 2/16/19.
//  Copyright © 2019 Mike Jarosch. All rights reserved.
//

#import "ViewController.h"
#import "RoundButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timerDisplay;
@property (weak, nonatomic) IBOutlet RoundButton *startButton;
@property (weak, nonatomic) IBOutlet RoundButton *stopButton;
@property (weak, nonatomic) IBOutlet RoundButton *lapButton;
@property (weak, nonatomic) IBOutlet RoundButton *resetButton;
@property (weak, nonatomic) IBOutlet UITableView *laps;


@end

@implementation ViewController

int _time;
NSTimer *_timer;
NSMutableArray *_lapArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _lapArray = [[NSMutableArray alloc] init];

//    [self.startStop setFillColor:[[UIColor alloc] initWithRed:0.0980 green:0.2078 blue:0.1255 alpha:1.0] forState:UIControlStateNormal];
//    [self.startStop setFillColor:[[UIColor alloc] initWithRed:0.0745 green:0.1294 blue:0.0784 alpha:1.0] forState:UIControlStateHighlighted];
}

- (IBAction)startButtonClicked:(id)sender {
    self.resetButton.hidden = YES;
    self.lapButton.hidden = NO;
    self.lapButton.enabled = YES;
    self.startButton.hidden = YES;
    self.stopButton.hidden = NO;

    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 repeats:YES block:^(NSTimer * _Nonnull timer) {
        _time++;
        [self updateDisplay];
    }];
}
- (IBAction)stopButtonClicked:(id)sender {
    self.lapButton.hidden = YES;
    self.resetButton.hidden = NO;
    self.stopButton.hidden = YES;
    self.startButton.hidden = NO;

    [_timer invalidate];
    _timer = nil;
}

- (IBAction)lapButtonClicked:(id)sender {
    [_lapArray addObject:[NSNumber numberWithInt:_time]];
    [self.laps reloadData];
}

- (IBAction)resetButtonClicked:(id)sender {
    self.resetButton.hidden = YES;
    self.lapButton.hidden = NO;
    self.lapButton.enabled = NO;

    _time = 0;

    [_lapArray removeAllObjects];
    [self.laps reloadData];

    [self updateDisplay];
}

- (void)updateDisplay {
    self.timerDisplay.text = [self formatTime:_time];
}

- (NSString*)formatTime:(int)time {
    int hundredth = time % 100;
    int seconds = (time / 100) % 60;
    int minutes = (time / 6000) % 60;
    int hours = time / 360000;
    return [NSString stringWithFormat: @"%02d:%02d:%02d.%02d", hours, minutes, seconds, hundredth];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"Lap %lu", indexPath.row + 1];
    NSNumber *time = _lapArray[indexPath.row];
    cell.detailTextLabel.text = [self formatTime:time.intValue];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _lapArray.count;
}

@end
