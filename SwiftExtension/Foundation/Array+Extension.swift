//
//  Array+Extension.swift
//  SmartBookingIOS
//
//  Created by dun on 2019/2/25.
//  Copyright © 2019 Duntech. All rights reserved.
//

import Foundation

extension Array {
    
    /// 数组内中文按拼音字母排序
    ///
    /// - Parameter ascending: 是否升序（默认升序）
    func sortedByPinyin(ascending: Bool = true) -> Array<String>? {
        
        if self is Array<String> {
            return (self as! Array<String>).sorted { (value1, value2) -> Bool in
                let pinyin1 = value1.transformToPinyin()
                let pinyin2 = value2.transformToPinyin()
                return pinyin1.compare(pinyin2) == (ascending ? .orderedAscending : .orderedDescending)
            }
        }
        return nil
    }
}

extension Array where Element : Equatable {
    
    public mutating func removeAll(_ item: Element) -> [Element] {
        removeAll(where: { $0 == item })
        return self
    }
    
    
}
