//
//  UserDefaultsManager.swift
//  Flying
//
//  Created by 杨雄凯 on 2023/5/21.
//

import Foundation

class UserDefaultsManager {
    
    class func save(environments: [Environment]) {
        let maps = environments.map { ["isInitial": $0.isInitial, "baseURL": $0.baseURL] as [String : Any] }
        UserDefaults.standard.set(maps, forKey: kFlyConfiguration)
        UserDefaults.standard.synchronize()
    }
    
    struct Item: HandyJSON {
        var baseURL: String = ""
        var isInitial: Bool = false
    }
    
    class func fetch() -> [Item] {
        guard let maps = UserDefaults.standard.value(forKey: kFlyConfiguration) as? [[String: Any]],
              let items = [Item].deserialize(from: maps) else { return [] }
        
        return items.compactMap { $0 }
    }
    
    class func resetInitial(_ index: Int) {
        var items = fetch()
        for (sort, _) in items.enumerated() {
            if sort == index {
                items[sort].isInitial = true
            } else {
                items[sort].isInitial = false
            }
        }
        
        let maps = items.toJSON().compactMap { $0 }
        UserDefaults.standard.set(maps, forKey: kFlyConfiguration)
        UserDefaults.standard.synchronize()
    }
}
