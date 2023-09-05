//
//  ViewController.swift
//  Flying
//
//  Created by yangxiongkai on 03/24/2023.
//  Copyright (c) 2023 yangxiongkai. All rights reserved.
//

import UIKit
import Flying
import Moya
import HandyJSON

class DemoViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        tableView.register(DemoTableViewCell.self, forCellReuseIdentifier: identifier)
        
        // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "切换环境", style: .plain, target: self, action: #selector(switchAction))
    }
    
    //    @objc private func switchAction() {
    //        EnvironmentSwitcher.show()
    //    }
    
    private let data: [UserAPI] = UserAPI.allCases
}

extension DemoViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DemoTableViewCell
        
        if #available(iOS 14.0, *) {
            var c = cell.defaultContentConfiguration()
            let api = data[indexPath.row]
            c.text = api.path
            c.secondaryText = api.method.rawValue
            cell.contentConfiguration = c
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let api = data[indexPath.row]
        Flying.request(api) { response in
            
            var jsonString = ""
            do {
                jsonString = try response.mapString()
            } catch {
                self.showAlert(title: "请求成功，解码失败", message: error.localizedDescription)
            }
            
            self.showAlert(title: "请求成功，解码成功", message: jsonString)
            
        } failure: { error in
            self.showAlert(title: "请求失败", message: error.localizedDescription)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}

let identifier = "DemoTableViewCellIden"

class DemoTableViewCell: UITableViewCell {}

enum UserAPI: CaseIterable {
    case createUser
    case userProfile
    case allUser
}

extension UserAPI: TargetType {
    
    var path: String {
        switch self {
        case .createUser:
            return "/users"
        case .userProfile:
            return "/user/info"
        case .allUser:
            return "/users/all"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createUser:
            return .post
        case .userProfile:
            return .get
        case .allUser:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .createUser:
            return .requestPlain
        case .userProfile:
            return .requestPlain
        case .allUser:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
