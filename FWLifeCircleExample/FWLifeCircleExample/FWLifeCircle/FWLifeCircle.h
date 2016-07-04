//
//  FWLifeCircle.h
//  FWLifeCircleExample
//
//  Created by FireWolf on 2016/7/4.
//
//

#import <UIKit/UIKit.h>

@interface FWLifeCircle : UIControl


@property(nonatomic)UIImageView *profileView;

@property (nonatomic,readonly) NSNumber *maximumTime;
@property (nonatomic) NSNumber *leftTime;
@property (assign,nonatomic) BOOL isCounting;



- (instancetype)initWithMaximumSurviveTime:(NSNumber *)maximumTime;


@end
