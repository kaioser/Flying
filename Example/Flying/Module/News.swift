//
//  News.swift
//  Flying_Example
//
//  Created by 杨雄凯 on 2023/3/31.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import Flying

enum News {
    case list
    case detail
}

extension News: TargetType {
    
    var path: String {
        ""
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
}

//extension News: TargetInterface {
//    
//    var showFailAlert: Bool {
//        true
//    }
//}
//
//enum TestAPI {
//    case log
//}
//
//extension TestAPI: AllTargetProtocol {
//    
//    var showFailAlert: Bool {
//        false   
//    }
//    
//    var path: String {
//        ""
//    }
//    
//    var method: Moya.Method {
//        .get
//    }
//    
//    var task: Moya.Task {
//        .requestPlain
//    }
//}


