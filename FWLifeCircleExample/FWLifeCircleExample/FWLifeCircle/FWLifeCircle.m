//
//  FWLifeCircle.m
//  FWLifeCircleExample
//
//  Created by FireWolf on 2016/7/4.
//
//

#import "FWLifeCircle.h"
@interface FWLifeCircle(){
    int radius;
    int angle;
}

@property(nonatomic)UILabel *timeLabel;

@property(nonatomic,readonly)UIColor *FWLifeArcBackgroundColor;
/*Each state color eg.normal,warrning,dangerous*/
@property (nonatomic)NSArray <UIColor *> *stateColorArray;



@end

@implementation FWLifeCircle

static const float FWLifeCircleFrameSize = 90;
static const float FCLifeCircleLineWidth = 13;
static const float FCLifeCircleMargin    = 7.5;
static inline double radians (double degrees) {return degrees * M_PI/180;}

- (instancetype)initWithMaximumSurviveTime:(NSNumber *)maximumTime
{
    self = [super init];
    if (self) {
        _maximumTime = maximumTime;
        [self initVariable];
        [self initLayout];
    }
    return self;
}
-(void)initVariable{
    _FWLifeArcBackgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];

    radius = FWLifeCircleFrameSize / 2 - FCLifeCircleMargin;
    angle = 360;
    _leftTime = self.maximumTime;
    self.stateColorArray = [self TEST_StateColor];
    self.isCounting = NO;
}
-(void)initLayout{
    self.opaque = NO;
    self.frame = CGRectMake(0, 0, FWLifeCircleFrameSize, FWLifeCircleFrameSize);
    //self.backgroundColor = [UIColor grayColor];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 55, 25)];
    self.timeLabel.text = self.maximumTime.stringValue;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.center = self.center;
    [self addSubview:self.timeLabel];
}

#pragma mark - UIControl Override -
-(void)drawRect:(CGRect)rect{
    [self drawBackgroundArc];
    [self drawLeftTimeArc];
}
-(void)drawBackgroundArc{
    /*Background Arc*/
    CGFloat startAngle     =  radians(-90);
    CGFloat endAngle       =  radians(270);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, radius, startAngle, endAngle, 0);
    [_FWLifeArcBackgroundColor setStroke];
    
    //Define line width and cap
    CGContextSetLineWidth(ctx, FCLifeCircleLineWidth);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    //draw it!
    CGContextDrawPath(ctx, kCGPathStroke);
}
-(void)drawLeftTimeArc{
    double fixAngle = 360 - angle -90;
    CGFloat startAngle  = radians(fixAngle);
    CGFloat endAngle = radians(-90);
    if (fixAngle == -90) {
        endAngle = 270;
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, radius, startAngle, endAngle, 0);
    [[self getCurrentLifeColor:self.leftTime.integerValue] setStroke];
    
    //Define line width and cap
    CGContextSetLineWidth(ctx, FCLifeCircleLineWidth);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    //draw it!
    CGContextDrawPath(ctx, kCGPathStroke);
}

#pragma mark - Public
-(void)setLeftTime:(NSNumber *)leftTime{
    if (![self isInputNumberLegal:leftTime]) {
        return;
    }
    if (self.leftTime != leftTime) {
        
        _leftTime = leftTime;
        self.timeLabel.text = _leftTime.stringValue;
        angle = round(_leftTime.floatValue/_maximumTime.floatValue * 360);
        NSLog(@"change angle:%d",angle);
        [self setNeedsDisplay];
    }
}

-(BOOL)isInputNumberLegal:(NSNumber *)inputNumber{
    if (inputNumber.integerValue < 0 || inputNumber.integerValue > self.maximumTime.integerValue ) {
        return NO;
    }
    return YES;
}
#pragma mark - Helper
-(UIColor *)getCurrentLifeColor:(NSInteger)leftTime{
    NSInteger kMaximumTime = self.maximumTime.integerValue;
    if (self.stateColorArray.count != 0) {
        if (leftTime > kMaximumTime / 2) {
            return self.stateColorArray[0];//normal
        }
        else if (leftTime > kMaximumTime / 4){
            return  self.stateColorArray[1];//warning
        }
        else{
            return  self.stateColorArray[2];//dangerious
        }
    }
    return [UIColor lightGrayColor];
}

#pragma mark - For Test
-(NSArray *)TEST_StateColor{
    UIColor *normalStateColor = [UIColor colorWithRed:0.0 green:196.0/255.0 blue:1.0 alpha:1];
    UIColor *warningStateColor = [UIColor colorWithRed:1.0 green:192.0/255.0 blue:0.0 alpha:1];
    UIColor *dangerousStateColor = [UIColor colorWithRed:1.0 green:25.0/255.0 blue:25.0/255.0 alpha:1];
    return @[normalStateColor,warningStateColor,dangerousStateColor];
}
@end
