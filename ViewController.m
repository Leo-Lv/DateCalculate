//
//  ViewController.m
//  DateCalculation
//
//  Created by lvdejain on 2018/6/15.
//  Copyright © 2018年 lvdejain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


+(NSArray *)getFirstAndLastDayOfThisWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger weekday = [dateComponents weekday];   //第几天(从sunday开始)
    NSInteger firstDiff,lastDiff;
    if (weekday == 1) {
        firstDiff = -6;
        lastDiff = 0;
    }else {
        firstDiff =  - weekday + 2;
        lastDiff = 8 - weekday;
    }
    NSInteger day = [dateComponents day];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [firstComponents setDay:day+firstDiff];
    NSDate *firstDay = [calendar dateFromComponents:firstComponents];
    NSDateComponents *lastComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [lastComponents setDay:day+lastDiff];
    NSDate *lastDay = [calendar dateFromComponents:lastComponents];
    return [NSArray arrayWithObjects:firstDay,lastDay, nil];
}
+(NSArray *)getFirstAndLastDayOfLastWeek {
    //    NSString *dateStr = @"2018-01-05 09:09:09";
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSDate *nowDate = [formatter dateFromString:dateStr];
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];
    NSDateComponents *comp = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:nowDate];
    //获取今天是周几
    NSInteger weekDay = [comp weekday];
    //获取某天是几号
    NSInteger day = [comp day];
    //获取某天是几月
    //    NSInteger month = [comp month];
    //计算当前日期和上周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = -13;
        lastDiff = 0;
    } else {
        firstDiff = [calendar firstWeekday] - weekDay +1-7;
        lastDiff = firstDiff + 6;
    }
    //在当前日期基础上加上时间差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    
    return [NSArray arrayWithObjects:firstDayOfWeek,lastDayOfWeek, nil];
}

+(NSArray *)getFirstAndLastDayOfThisMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:[NSDate date]];
    NSDateComponents *lastDateComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:firstDay];
    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+dayNumberOfMonth-1];
    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
    return [NSArray arrayWithObjects:firstDay,lastDay, nil];
}

+(NSArray *)getFirstAndLastDayOfThisYear
{
    //通过2月天数的改变，来确定全年天数
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"yyyy"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    dateStr = [dateStr stringByAppendingString:@"-02-14"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *aDayOfFebruary = [formatter dateFromString:dateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitYear startDate:&firstDay interval:nil forDate:[NSDate date]];
    NSDateComponents *lastDateComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay fromDate:firstDay];
    NSUInteger dayNumberOfFebruary = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:aDayOfFebruary].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+337+dayNumberOfFebruary-1];
    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
    
    return [NSArray arrayWithObjects:firstDay,lastDay, nil];
}
+(NSArray *)getFirstAndLastDayOfLastMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];
    //当前时间
    NSDate *dateNow = [NSDate date];
    //转换当前时间的格式为 XXXX-XX-XX
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:dateNow];
    //获取 年月日
    NSInteger year = [[dateStr substringToIndex:4] integerValue];
    NSInteger month = [[dateStr substringWithRange:NSMakeRange(5, 2)] integerValue];
    //    NSInteger day = [[dateStr substringFromIndex:8] integerValue];
    //构造当月的1号时间
    NSDateComponents *firstDayCurrentMonth = [[NSDateComponents alloc] init];
    [firstDayCurrentMonth setYear:year];
    [firstDayCurrentMonth setMonth:month];
    [firstDayCurrentMonth setDay:1];
    //当月1号
    NSDate *firstDayOfCurrentMonth = [calendar dateFromComponents:firstDayCurrentMonth];
    //构造上月1号时间
    month --;
    //获取上月月份
    if (month == 0) {
        month = 12;
        year--;
    }
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:1];
    //上月1号时间
    NSDate *firstDayOfLastMonth = [calendar dateFromComponents:dateComponents];
    //上个月的最后一天的最后一秒
    NSDate *lastDayOfLastlMonth = [firstDayOfCurrentMonth dateByAddingTimeInterval:-1];
    return [NSArray arrayWithObjects:firstDayOfLastMonth,lastDayOfLastlMonth, nil];
}
+(NSArray *)getFirstAndLastDayOfThisQuarter {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];
    //当前时间
    NSDate *dateNow = [NSDate date];
    //转换当前时间的格式为 XXXX-XX-XX
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:dateNow];
    //获取 年月日
    NSInteger year = [[dateStr substringToIndex:4] integerValue];
    NSInteger month = [[dateStr substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSDate *firstDayOfQuarter = [[NSDate alloc] init];
    NSDate *lastDayOfQuarter = [[NSDate alloc] init];
    if (month >= 0 && month <= 3) {//第一季度
        NSDateComponents *firstDay = [[NSDateComponents alloc] init];
        [firstDay setYear:year];
        [firstDay setMonth:1];
        [firstDay setDay:1];
        firstDayOfQuarter = [calendar dateFromComponents:firstDay];
        
        NSDateComponents *lastDay = [[NSDateComponents alloc] init];
        [lastDay setYear:year];
        [lastDay setMonth:3];
        [lastDay setDay:31];
        lastDayOfQuarter = [calendar dateFromComponents:lastDay];
    } else if (month > 3 && month <= 6) {//第二季度
        NSDateComponents *firstDay = [[NSDateComponents alloc] init];
        [firstDay setYear:year];
        [firstDay setMonth:4];
        [firstDay setDay:1];
        firstDayOfQuarter = [calendar dateFromComponents:firstDay];
        
        NSDateComponents *lastDay = [[NSDateComponents alloc] init];
        [lastDay setYear:year];
        [lastDay setMonth:6];
        [lastDay setDay:30];
        lastDayOfQuarter = [calendar dateFromComponents:lastDay];
    } else if (month > 6 && month <= 9) {//第三季度
        NSDateComponents *firstDay = [[NSDateComponents alloc] init];
        [firstDay setYear:year];
        [firstDay setMonth:7];
        [firstDay setDay:1];
        firstDayOfQuarter = [calendar dateFromComponents:firstDay];
        
        NSDateComponents *lastDay = [[NSDateComponents alloc] init];
        [lastDay setYear:year];
        [lastDay setMonth:9];
        [lastDay setDay:30];
        lastDayOfQuarter = [calendar dateFromComponents:lastDay];
    } else {//第四季度
        NSDateComponents *firstDay = [[NSDateComponents alloc] init];
        [firstDay setYear:year];
        [firstDay setMonth:10];
        [firstDay setDay:1];
        firstDayOfQuarter = [calendar dateFromComponents:firstDay];
        
        NSDateComponents *lastDay = [[NSDateComponents alloc] init];
        [lastDay setYear:year];
        [lastDay setMonth:12];
        [lastDay setDay:31];
        lastDayOfQuarter = [calendar dateFromComponents:lastDay];
    }
    return [NSArray arrayWithObjects:firstDayOfQuarter,lastDayOfQuarter,nil];
}
+(NSArray *)getFirstAndLastDayOfLastQuarter {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];
    //当前时间
    NSDate *dateNow = [NSDate date];
    //转换当前时间的格式为 XXXX-XX-XX
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:dateNow];
    //获取 年月日
    NSInteger year = [[dateStr substringToIndex:4] integerValue];
    NSInteger month = [[dateStr substringWithRange:NSMakeRange(5, 2)] integerValue];
    NSDate *firstDayOfQuarter = [[NSDate alloc] init];
    NSDate *lastDayOfQuarter = [[NSDate alloc] init];
    if (month >= 0 && month <= 3) {//第一季度的上一季度为去年的最后一季度
        NSDateComponents *firstDay = [[NSDateComponents alloc] init];
        [firstDay setYear:year-1];
        [firstDay setMonth:10];
        [firstDay setDay:1];
        firstDayOfQuarter = [calendar dateFromComponents:firstDay];
        
        NSDateComponents *lastDay = [[NSDateComponents alloc] init];
        [lastDay setYear:year-1];
        [lastDay setMonth:12];
        [lastDay setDay:31];
        lastDayOfQuarter = [calendar dateFromComponents:lastDay];
    } else if (month > 3 && month <= 6) {//第二季度的上一季度为第一季度
        NSDateComponents *firstDay = [[NSDateComponents alloc] init];
        [firstDay setYear:year];
        [firstDay setMonth:1];
        [firstDay setDay:1];
        firstDayOfQuarter = [calendar dateFromComponents:firstDay];
        
        NSDateComponents *lastDay = [[NSDateComponents alloc] init];
        [lastDay setYear:year];
        [lastDay setMonth:3];
        [lastDay setDay:31];
        lastDayOfQuarter = [calendar dateFromComponents:lastDay];
    } else if (month > 6 && month <= 9) {//第三季度的上一季度为第二季度
        NSDateComponents *firstDay = [[NSDateComponents alloc] init];
        [firstDay setYear:year];
        [firstDay setMonth:4];
        [firstDay setDay:1];
        firstDayOfQuarter = [calendar dateFromComponents:firstDay];
        
        NSDateComponents *lastDay = [[NSDateComponents alloc] init];
        [lastDay setYear:year];
        [lastDay setMonth:6];
        [lastDay setDay:30];
        lastDayOfQuarter = [calendar dateFromComponents:lastDay];
    } else {//第四季度的上一季度为第三季度
        NSDateComponents *firstDay = [[NSDateComponents alloc] init];
        [firstDay setYear:year];
        [firstDay setMonth:7];
        [firstDay setDay:1];
        firstDayOfQuarter = [calendar dateFromComponents:firstDay];
        
        NSDateComponents *lastDay = [[NSDateComponents alloc] init];
        [lastDay setYear:year];
        [lastDay setMonth:9];
        [lastDay setDay:30];
        lastDayOfQuarter = [calendar dateFromComponents:lastDay];
    }
    return [NSArray arrayWithObjects:firstDayOfQuarter,lastDayOfQuarter,nil];
}

@end
