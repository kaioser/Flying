//
//  AppDelegate.swift
//  Flying
//
//  Created by yangxiongkai on 03/24/2023.
//  Copyright (c) 2023 yangxiongkai. All rights reserved.
//

import UIKit
import Flying
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // 注册网络环境
        FlyConfiguration.register(environments: [Dev(), Test(), Pro()], plugins: [loadingPlugin, loggerPlugin])
        
        return true
    }
}

fileprivate struct Dev: Environment {
    var baseURL: String = "https://dev.github.com"
    var isInitial: Bool = true
}

fileprivate struct Test: Environment {
    var baseURL: String = "https://test.github.com"
    var isInitial: Bool = false
}

fileprivate struct Pro: Environment {
    var baseURL: String = "https://www.github.com"
    var isInitial: Bool = false
}

let loadingPlugin = NetworkActivityPlugin { change, target in
    print(change)
}

let loggerPlugin = NetworkLoggerPlugin.verbose

//
//class Sign: PluginType {
//
//    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
//
//        let body = request.httpBody
//
//        var signedRequest = request
//
//        if target.method == .get {
//            // ...
//        } else {
//            // 加盐...
//        }
//
//        return signedRequest
//    }
//}
