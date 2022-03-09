//
//  String+Extension.swift
//  List Post
//
//  Created by Jan Sebastian on 07/03/22.
//

import Foundation

extension String {
    
    func addAPIRoute(path route: Route) -> String {
        return self + route.rawValue
    }
    
    func addAPIRoute(id num: Int) -> String {
        return self + "/\(num)"
    }
    
}
