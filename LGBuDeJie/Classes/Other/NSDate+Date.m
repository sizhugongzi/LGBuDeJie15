//
//  NSDate+Date.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "NSDate+Date.h"

@implementation NSDate (Date)

- (BOOL)isThisYear
{
    //获取年份 日历对象（获取日历组建）
    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //获取调用者日期年份
    NSDateComponents *createCmp = [calendar components:NSCalendarUnitYear fromDate:self];
    //拿着发帖的时间与当前时间对比
    //获取当前时间
    NSDate *curDate = [NSDate date];
    
    //获取当前日期的年份
    NSDateComponents *curCmp = [calendar components:NSCalendarUnitYear fromDate:curDate];
    
    return createCmp.year == curCmp.year;
}

- (BOOL)isThisToday
{
    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar isDateInToday:self];
}

- (BOOL)isThisYesterday
{
    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar isDateInYesterday:self];
}

- (NSDateComponents *)datalWithNow
{
    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:self toDate:[NSDate date] options:NSCalendarWrapComponents];
}

@end
