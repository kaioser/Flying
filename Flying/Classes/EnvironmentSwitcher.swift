//
//  Environment+Switch.swift
//  Flying
//
//  Created by 杨雄凯 on 2023/5/18.
//

import UIKit

public class EnvironmentSwitcher {
    
    public class func show() {
                
        let items = UserDefaultsManager.fetch()
        if items.isEmpty {
            debugPrint("本地无存储baseURL，无法弹出alert")
            return
        }
        
        guard let controller = UIViewController.current() else {
            debugPrint("获取当前window的控制器失败，无法弹出alert")
            return
        }
        
        let alert = UIAlertController(title: "切换环境", message: "红色的为当前环境", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))

        for (index, environment) in items.enumerated() {
            let action = UIAlertAction(title: environment.baseURL, style: environment.isInitial ? .destructive : .default) { _ in
                if environment.isInitial { return }
                
                UserDefaultsManager.resetInitial(index)
            }
            alert.addAction(action)
        }
        
        controller.present(alert, animated: true)
    }
}

fileprivate extension UIViewController {
    
    class func current() -> UIViewController? {
        return _window()?.rootViewController
    }
    
    class func _window() -> UIWindow? {
        
        if let window = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive } )
            .map( { $0 as? UIWindowScene } )
            .compactMap( { $0 } )
            .first?.windows
            .filter( { $0.isKeyWindow} ).first {
            
            return window
            
        } else if let window = UIApplication.shared.delegate?.window {
            
            return window
            
        } else {
            return nil
        }
    }
}
