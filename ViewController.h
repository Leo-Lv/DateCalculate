//
//  ViewController.h
//  DateCalculation
//
//  Created by lvdejain on 2018/6/15.
//  Copyright © 2018年 lvdejain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/**
 *  得到这个周的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfThisWeek;
/**
 *  得到上周的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfLastWeek;
/**
 *  得到这个月的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfThisMonth;
/**
 *  得到今年的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfThisYear;
/**
 *  得到上个月的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfLastMonth;
/**
 *  得到季度的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfThisQuarter;
/**
 *  得到上季度的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfLastQuarter;

@end

