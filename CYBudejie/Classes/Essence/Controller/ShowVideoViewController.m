//
//  ShowVideoViewController.m
//  CYBudejie
//
//  Created by Cyrill on 2017/3/10.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "ShowVideoViewController.h"
#import "Topic.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ShowVideoViewController ()

@property (nonatomic, strong) MPMoviePlayerController *movie;

@end

@implementation ShowVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.movie play];
    
    [self addNotifi];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.movie stop];
    self.movie = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNotifi {
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.movie];
        [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.movie];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.movie];
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
- (void)mediaPlayerPlaybackStateChange:(NSNotification *)notification {
    switch (self.movie.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%zd",self.movie.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
- (void)mediaPlayerPlaybackFinished:(NSNotification *)notification {
    NSLog(@"播放完成.%zd",self.movie.playbackState);
}

- (void)movieFinishedCallback:(NSNotification *)notify {
    MPMoviePlayerController *theMovie = [notify object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
- (NSURL *)getVideoUrl {
    return [NSURL URLWithString:self.topic.videouri];
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
- (NSURL *)getNetworkUrl {
    return [NSURL URLWithString:self.topic.videouri];
}


- (MPMoviePlayerController *)movie
{
    if (!_movie) {
        NSURL *url = [self getNetworkUrl];
        _movie = [[MPMoviePlayerController alloc] initWithContentURL:url];
        
        _movie.view.frame = CGRectMake(0, 64, kScreenW, kScreenH - 64);
        [self.view addSubview:_movie.view];
    }
    return _movie;
}

@end
