//
//  Date+Extension.swift
//  SmartOffice
//
//  Created by Duntech on 2018/10/20.
//  Copyright © 2018年 Jack Hu All rights reserved.
//

import Foundation

extension Date {
    
    /// 时间差
    ///
    /// - Parameter fromDate: 起始时间
    /// - Returns: 对象
    public func daltaFrom(_ fromDate: Date) -> DateComponents {
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        return calendar.dateComponents(components, from: fromDate, to: self)
    }
    
    /// 是否是同一年
    ///
    /// - Returns: ture or false
    func isThisYear() -> Bool {
        let calendar = Calendar.current
        let currendarYear = calendar.component(.year, from: Date())
        let selfYear =  calendar.component(.year, from: self)
        return currendarYear == selfYear
    }
    
    public func getComponent (_ component : Calendar.Component) -> Int {
        let calendar = NSCalendar.current
        let componentsValue = calendar.component(component, from: self)
        return componentsValue
    }

    static var milliseconds: TimeInterval {
        get { return Date().timeIntervalSince1970 * 1000 }
    }
    
    static func timeAgoSinceDate(_ date: Date, numericDates: Bool) -> String {
        
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([
            NSCalendar.Unit.minute,
            NSCalendar.Unit.hour,
            NSCalendar.Unit.day,
            NSCalendar.Unit.weekOfYear,
            NSCalendar.Unit.month,
            NSCalendar.Unit.year,
            NSCalendar.Unit.second
            ], from: earliest, to: latest, options: NSCalendar.Options())
        
        if (components.year! >= 2) {
            return "\(String(describing: components.year)) 年前"
        }
        else if (components.year! >= 1){
            if (numericDates){
                return "1 年前"
            }
            else {
                return "去年"
            }
        }
        else if (components.month! >= 2) {
            return "\(String(describing: components.month)) 月前"
        }
        else if (components.month! >= 1){
            if (numericDates){
                return "1 个月前"
            }
            else {
                return "上个月"
            }
        }
        else if (components.weekOfYear! >= 2) {
            return "\(String(describing: components.weekOfYear)) 周前"
        }
        else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 周前"
            }
            else {
                return "上一周"
            }
        }
        else if (components.day! >= 2) {
            return "\(String(describing: components.day)) 天前"
        }
        else if (components.day! >= 1){
            if (numericDates){
                return "1 天前"
            }
            else {
                return "昨天"
            }
        }
        else if (components.hour! >= 2) {
            return "\(String(describing: components.hour)) 小时前"
        }
        else if (components.hour! >= 1){
            return "1 小时前"
        }
        else if (components.minute! >= 2) {
            return "\(String(describing: components.minute)) 分钟前"
        }
        else if (components.minute! >= 1){
            return "1 分钟前"
        }
        else if (components.second! >= 3) {
            return "\(String(describing: components.second)) 秒前"
        }
        else {
            return "刚刚"
        }
    }
    
}

extension Date {
    
    // MARK: Getter
    
    /**
     Date year
     */
    public var year : Int {
        get {
            return getComponent(.year)
        }
    }
    
    /**
     Date month
     */
    public var month : Int {
        get {
            return getComponent(.month)
        }
    }
    
    /**
     Date weekday
     */
    public var weekday : Int {
        get {
            return Calendar.current.component(.weekday, from: self)
        }
    }
    
    public var weekdayStr : String {
        get {
            var calendar = Calendar(identifier: .gregorian)
            let timezone = TimeZone(identifier: "Asia/Shanghai")
            calendar.timeZone = timezone!
            let weekday = calendar.component(.weekday, from: self)
            let weekdayArray = [KLocalString("sunday"),KLocalString("monday"),KLocalString("tuesday"),KLocalString("wednesday"),KLocalString("thursday"),KLocalString("friday"),KLocalString("saturday")]
            return weekdayArray[weekday - 1]
        }
    }
    
    /**
     Date weekMonth
     */
    public var weekMonth : Int {
        get {
            return getComponent(.weekOfMonth)
        }
    }
    
    
    /**
     Date days
     */
    public var days : Int {
        get {
            return getComponent(.day)
        }
    }
    
    /**
     Date hours
     */
    public var hours : Int {
        
        get {
            return getComponent(.hour)
        }
    }
    
    /**
     Date minuts
     */
    public var minutes : Int {
        get {
            return getComponent(.minute)
        }
    }
    
    /**
     Date seconds
     */
    public var seconds : Int {
        get {
            return getComponent(.second)
        }
    }
    
    /** 获取时间字符串 18 Dec 2018 */
    public var dateFormatDDMMMYYYY : String {
        get {
            return self.formatDateStr("dd MMM yyyy")
        }
    }
    
    public var aroundHour : Int {
        get {
            
            let currentDate = self
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH"
            var hourStr = dateFormatter.string(from: currentDate)
            hourStr = String(Int(hourStr)!)
            
            dateFormatter.dateFormat = "mm"
            let miniteStr = dateFormatter.string(from: currentDate)
            
            if Int(miniteStr)! > 45{
                hourStr = String(Int(hourStr)! + 1)
            }
            return Int(hourStr)!
        }
    }
    
    public var aroundMinutes : Int {
        get {
            
            let currentDate = self
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "mm"
            var miniteStr = dateFormatter.string(from: currentDate)
            
            if Int(miniteStr)! < 15 {
                miniteStr = "00"
            }
            else if Int(miniteStr)! > 30 && Int(miniteStr)! < 45 {
                miniteStr = "30"
            }
            else if Int(miniteStr)! > 15 && Int(miniteStr)! < 30 {
                miniteStr = "30"
            }
            else if Int(miniteStr)! > 45 {
                miniteStr = "00"
            }
            return Int(miniteStr)!
        }
    }
    
    public var aroundTime : String {
        get {
            let str = String(format: "%d:%02d", aroundHour, aroundMinutes)
            return str
        }
    }
    
    public var aroundNextHourTime : String {
        get {
            let str = String(format: "%d:%02d", aroundHour + 1, aroundMinutes)
            return str
        }
    }
    
    /** 格式化时间 */
    public func formatDateStr(_ format : String) -> String {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
    
    public func getNextYearDate() -> Double {
        
        let currentYears = Date().formatDateStr("yyyy-MM-dd")
        
        let array = currentYears.components(separatedBy: "-")
        let yearInt = array[0].toInt()
        let nextYears = String(yearInt! + 1) + array[1] + array[2]
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd"
        let last = dfmatter.date(from: nextYears)
        let timeStamp = last?.timeIntervalSince1970
        
        return timeStamp!
    }
    
   public func getNextSevenDaysDate() -> String {
    
        let timeInterval = Date().timeIntervalSince1970 + 7 * 24 * 60 * 60
        let date = Date(timeIntervalSince1970: timeInterval)
    
        return date.formatDateStr("yyyy-MM-dd")
    }
    
}
