//
//  Message.swift
//  Flying_Example
//
//  Created by 杨雄凯 on 2023/3/30.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Moya

enum MessageAPI {
    case list
    case detail(id: String)
}

extension MessageAPI: TargetType {
    
    var path: String {
        switch self {
        case .list:
            return "/api/yiyan/index.php"
        case .detail(let id):
            return "/api/pyq/index.php?id=\(id)"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Moya.Task {
        return .requestPlain
    }
}
