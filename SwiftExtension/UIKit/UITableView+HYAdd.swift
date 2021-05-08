//
//  UITableView+HYAdd.swift
//  SmartBooking
//
//  Created by 胡勇 on 2018/11/25.
//  Copyright © 2018 Jack Hu. All rights reserved.
//

import UIKit

extension UITableView {
    
   
    func registerClassOf<T: UITableViewCell>(_: T.Type){
        
        register(T.self, forCellReuseIdentifier: T.hy_reuseIdentifier)
    }
    
    func registerHeaderFooterClassOf<T: UITableViewHeaderFooterView>(_: T.Type){
        
        register(T.self, forHeaderFooterViewReuseIdentifier: T.hy_reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.hy_reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.hy_reuseIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>() -> T {
        
        guard let view = dequeueReusableHeaderFooterView(withIdentifier:T.hy_reuseIdentifier) as? T else {
            fatalError("Could not dequeue HeaderFooter with identifier: \(T.hy_reuseIdentifier)")
        }
        
        return view
    }
    
}
