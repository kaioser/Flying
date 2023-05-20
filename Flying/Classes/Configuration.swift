//
//  FlyConfiguration.swift
//  Flying
//
//  Created by 杨雄凯 on 2023/3/30.
//

import Foundation
import Moya

let kFlyConfiguration = "FlyConfiguration"

public class FlyConfiguration {
    
    static var plugins: [PluginType] = []
    
    public static func register(environments: [Environment], plugins: [PluginType]) {
        
        UserDefaultsManager.save(environments: environments)
        self.plugins = plugins
    }
    
    static var current: String? = UserDefaultsManager.fetch().filter { $0.isInitial }.first?.baseURL
}

public protocol Environment {
    var baseURL: String { get }
    var isInitial: Bool { get }
}

public extension TargetType {
    
    var baseURL: URL {
        if let urlString = FlyConfiguration.current {
            return URL(string: urlString)!
        }
        return URL(string: "https://github.com")!
    }
}
