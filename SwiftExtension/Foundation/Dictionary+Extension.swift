//
//  Dictionary+Extension.swift
//  SmartBookingIOS
//
//  Created by dun on 2019/1/18.
//  Copyright © 2019 Duntech. All rights reserved.
//

import Foundation

extension Dictionary {
    
    
    public var jsonString: String{
        
        if (!JSONSerialization.isValidJSONObject(self)) {
            DLog("无法解析出JSONString")
            return ""
        }
        let data : Data = try! JSONSerialization.data(withJSONObject: self, options: [])
        let JSONString = String(data: data, encoding: String.Encoding.utf8)
        return JSONString!
    }
    
    /// 获取字典中的字符串value
    func stringValue(key: Key, defaultValue: String = "") -> String {
        
        let value = self[key]
        switch value {
        case let string as String:
            return string.count > 0 ? string : defaultValue
        case let number as NSNumber:
            return number.stringValue
        default:
            return defaultValue
        }
    }

    /// 获取字典中的整形value
    func intValue(key: Key, defaultValue: Int = 0) -> Int {
        
        let value = self[key]
        switch value {
        case let value as Int:
            return value
        case let value as String:
            return atol(value)
        case let value as NSNumber:
            return value.intValue
        default:
            return defaultValue
        }
    }
    
    /// 获取字典中的单精度浮点型value
    func floatValue(key: Key, defaultVale: Float = 0.0) -> Float {
        let value = self[key]
        switch value {
        case let value as Float:
            return value
        case let value as NSNumber:
            return value.floatValue
        default:
            return defaultVale
        }
    }
    
    /// 获取字典中的双精度浮点型value
    func doubleValue(key: Key, defaultVale: Double = 0.0) -> Double {
        let value = self[key]
        switch value {
        case let value as Double:
            return value
        case let value as String:
            return atof(value)
        case let value as NSNumber:
            return value.doubleValue
        default:
            return defaultVale
        }
    }
    
    /// 获取字典中的bool型value
    func boolValue(key: Key, defaultValue: Bool = false) -> Bool {
        let value = self[key]
        switch value {
        case let value as Bool:
            return value
        case let value as NSNumber:
            return value.boolValue
        default:
            return defaultValue
        }
    }
}
