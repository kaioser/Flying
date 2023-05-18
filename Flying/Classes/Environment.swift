//
//  Environment.swift
//  Flying
//
//  Created by 杨雄凯 on 2023/5/18.
//

import Foundation
import Moya

public protocol Environment {
    
    /// 当前环境
    var current: String { get }
    
    var baseUrlPro: String { get }

    var baseUrlTest: String { get }

    var headers: [String: String]? { get }
    
    var plugins: [PluginType] { get }
}

public extension Environment {
    
    var plugins: [PluginType] { [] }
}
