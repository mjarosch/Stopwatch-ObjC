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
int _lastLapTime;
NSTimer *_timer;
NSMutableArray *_lapArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _lapArray = [[NSMutableArray alloc] init];
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
    [_lapArray addObject:[NSNumber numberWithInt:_time - _lastLapTime]];
    _lastLapTime = _time;
    [self.laps reloadData];
}

- (IBAction)resetButtonClicked:(id)sender {
    self.resetButton.hidden = YES;
    self.lapButton.hidden = NO;
    self.lapButton.enabled = NO;

    _time = 0;
    _lastLapTime = 0;

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
    if (hours > 0) {
        return [NSString stringWithFormat: @"%02d:%02d:%02d.%02d", hours, minutes, seconds, hundredth];
    } else {
        return [NSString stringWithFormat: @"%02d:%02d.%02d", minutes, seconds, hundredth];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSUInteger count = _lapArray.count;

    cell.textLabel.text = [NSString stringWithFormat:@"Lap %lu", count - indexPath.row];
    NSNumber *time = _lapArray[count - indexPath.row - 1];
    cell.detailTextLabel.text = [self formatTime:time.intValue];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _lapArray.count;
}

@end
