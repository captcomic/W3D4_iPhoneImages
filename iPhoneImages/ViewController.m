//
//  ViewController.m
//  iPhoneImages
//
//  Created by Fariha on 6/21/18.
//  Copyright © 2018 Bootcamp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;
@property NSMutableArray<NSURL*> *iphoneImageURLs;
@property int currentIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray<NSString*> *iphoneImageURLStrings = @[@"http://imgur.com/bktnImE.png", @"http://imgur.com/zdwdenZ.png", @"http://imgur.com/CoQ8aNl.png", @"http://imgur.com/2vQtZBb.png", @"http://imgur.com/y9MIaCS.png"];
    
    self.iphoneImageURLs = [[NSMutableArray alloc] init];
    
    for (NSString* URLString in iphoneImageURLStrings) {
        
        [self.iphoneImageURLs addObject:[NSURL URLWithString:URLString]];
    }
    //NSLog(@"%@", self.iphoneImageURLs);
    
    self.currentIndex = 0;
    
    [self downloadImage];

}


- (void)downloadImage {
    
    NSURL *url = self.iphoneImageURLs[self.currentIndex];
    //NSURL *url = [NSURL URLWithString:@"http://i.imgur.com/bktnImE.png"]; // 1
    //NSLog(@"%@", url);

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.iPhoneImageView.image = image; // 4
        }];
        
    }]; // 4
    
    [downloadTask resume]; // 5
}


- (IBAction)randomIndex:(UIButton *)sender {
    
    int randomIndex;
    
    do {
        randomIndex = arc4random_uniform((uint32_t)self.iphoneImageURLs.count);
        //NSLog(@"random index: %d, current index: %d", randomIndex, self.currentIndex);
    } while (randomIndex == self.currentIndex);
    
    self.currentIndex = randomIndex;
    //NSLog(@"random index: %d, current index: %d", randomIndex, self.currentIndex);

    [self downloadImage];
}

@end
