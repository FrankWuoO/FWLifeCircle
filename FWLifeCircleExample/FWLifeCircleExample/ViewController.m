//
//  ViewController.m
//  FWLifeCircleExample
//
//  Created by FireWolf on 2016/7/4.
//
//

#import "ViewController.h"
#import "FWLifeCircle.h"

@interface ViewController ()
{
    FWLifeCircle *lifeCircle1;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    lifeCircle1 = [[FWLifeCircle alloc]initWithMaximumSurviveTime:@120];
    lifeCircle1.frame = CGRectMake(100, 120, lifeCircle1.frame.size.width, lifeCircle1.frame.size.height);
    [self.view addSubview:lifeCircle1];
    
    UIButton *increaseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    increaseButton.frame = CGRectMake(50, 200, 40, 40);
    increaseButton.tag = 1;
    increaseButton.titleLabel.font = [UIFont boldSystemFontOfSize:30.0f];
    [increaseButton setTitle:@"+" forState:UIControlStateNormal];
    [increaseButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:increaseButton];
    
    
    UIButton *decreaseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    decreaseButton.frame = CGRectMake(220, 200, 40, 40);
    decreaseButton.tag = -1;
    decreaseButton.titleLabel.font = [UIFont boldSystemFontOfSize:30.0f];
    [decreaseButton setTitle:@"-" forState:UIControlStateNormal];
    [decreaseButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:decreaseButton];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonClick:(UIButton *)clickedButton{
    
    if (clickedButton.tag == 1) {
        [lifeCircle1 setLeftTime:@(lifeCircle1.leftTime.intValue+1)];
    }
    else{
        [lifeCircle1 setLeftTime:@(lifeCircle1.leftTime.intValue-1)];
    }
}

@end
