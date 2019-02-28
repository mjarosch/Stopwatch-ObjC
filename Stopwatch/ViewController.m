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
@property (weak, nonatomic) IBOutlet UIButton *lapReset;
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
}

- (IBAction)startStopClicked:(id)sender {
    if (_timer == nil) {
        self.lapReset.enabled = YES;
        [self.lapReset setTitle:@"Lap" forState:UIControlStateNormal];

        [self.startStop setTitle:@"Stop" forState:UIControlStateNormal];

        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 repeats:YES block:^(NSTimer * _Nonnull timer) {
            _time++;
            [self updateDisplay];
        }];
    } else {
        self.lapReset.enabled = YES;
        [self.lapReset setTitle:@"Reset" forState:UIControlStateNormal];

        [self.startStop setTitle:@"Start" forState:UIControlStateNormal];

        [_timer invalidate];
        _timer = nil;
    }
}

- (IBAction)lapResetClicked:(id)sender {
    if (_timer == nil) {
        _time = 0;

        self.lapReset.enabled = NO;
        [self.lapReset setTitle:@"Lap" forState:UIControlStateNormal];

        [_lapArray removeAllObjects];
        [self.laps reloadData];

        [self updateDisplay];
    } else {
        [_lapArray addObject:[NSNumber numberWithInt:_time]];
        [self.laps reloadData];
    }
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
