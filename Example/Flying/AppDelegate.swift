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

        // 安装网络环境
//        FlyConfiguration.shared.install(environment: BaseApi())
        
        return true
    }
}

private let kBaseUrlPro = "https://v.api.aa1.cn"

//struct BaseApi: FlyEnvironment {
//
//    var headers: [String : String]? = ["version": "2.4.0"]
//
//    var current: String = kBaseUrlPro
//
//    var baseUrlPro: String = kBaseUrlPro
//
//    var baseUrlPre: String = kBaseUrlPro
//
//    var baseUrlTest: String = kBaseUrlPro
//
//    var testUrlDev: String = kBaseUrlPro
//
//    var plugins: [PluginType] = [FailAlertShow(), FlyLog()]
//}

//class FailAlertShow: PluginType {
//
//    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
//        print("展示失败的弹框")
//
//        if target is MessageAPI {
//            print("收到结果")
//        }
//    }
//}
//
//class FlyLog: PluginType {
//    func willSend(_ request: RequestType, target: TargetType) {
//        print("开始请求")
//    }
//
//    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
//        print("请求结束")
//    }
//}
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
