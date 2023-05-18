//
//  FlyConfiguration.swift
//  Flying
//
//  Created by 杨雄凯 on 2023/3/30.
//

import Foundation
import Moya

public class NetworkConfiguration {
    
    public static let shared = NetworkConfiguration()
    
    private init() {}

    private var environment: Environment?
    
    var baseUrlPro: String {
        return environment?.baseUrlPro ?? ""
    }
    
    var baseUrlTest: String {
        return environment?.baseUrlTest ?? ""
    }
    
    var current: String {
        return environment?.current ?? ""
    }
    
    var headers: [String: String]? {
        return environment?.headers
    }

    var plugins: [PluginType] {
        return environment?.plugins ?? []
    }
    
    public func install(environment: Environment) {
        self.environment = environment
    }
}

public extension TargetType {

    var baseURL: URL {
        return URL(string: NetworkConfiguration.shared.current)!
    }
    
    var headers: [String : String]? {
        return NetworkConfiguration.shared.headers
    }
    
    var method: Moya.Method { .post }
}
