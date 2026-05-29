#import <Foundation/Foundation.h>

@interface Counter : NSObject {
@protected
    int value;
}
- (void)increment;
- (void)decrement;
- (void)reset;
- (int)getValue;
- (void)printInfo;
@end

@implementation Counter
- (instancetype)init {
    self = [super init];
    if (self) {
        value = 0;
    }
    return self;
}
- (void)increment { value++; }
- (void)decrement { value--; }
- (void)reset { value = 0; }
- (int)getValue { return value; }
- (void)printInfo {
    NSLog(@"Counter value = %d", value);
}
@end

@interface BoundedCounter : Counter {
    int maxValue;
}
- (instancetype)initWithMaxValue:(int)max;
@end

@implementation BoundedCounter
- (instancetype)initWithMaxValue:(int)max {
    self = [super init];
    if (self) {
        maxValue = max;
    }
    return self;
}
- (void)increment {
    if (value < maxValue) {
        value++;
    }
}
- (void)printInfo {
    NSLog(@"BoundedCounter value = %d, max = %d", value, maxValue);
}
@end

@interface StepCounter : Counter {
    int step;
}
- (instancetype)initWithStep:(int)newStep;
@end

@implementation StepCounter
- (instancetype)initWithStep:(int)newStep {
    self = [super init];
    if (self) {
        step = newStep;
    }
    return self;
}
- (void)increment { value += step; }
- (void)decrement { value -= step; }
- (void)printInfo {
    NSLog(@"StepCounter value = %d, step = %d", value, step);
}
@end

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        Counter *normal = [[Counter alloc] init];
        BoundedCounter *bounded = [[BoundedCounter alloc] initWithMaxValue:2];
        StepCounter *stepped = [[StepCounter alloc] initWithStep:3];

        [normal increment];
        [bounded increment];
        [bounded increment];
        [bounded increment];
        [stepped increment];
        [stepped decrement];

        NSArray<Counter *> *counters = @[
            [[Counter alloc] init],
            [[BoundedCounter alloc] initWithMaxValue:1],
            [[StepCounter alloc] initWithStep:5]
        ];

        for (Counter *counter in counters) {
            [counter increment];
            [counter printInfo]; // Message dispatch uses the actual object class.
        }
    }
    return 0;
}
