//
//  ViewController.swift
//  Flying
//
//  Created by yangxiongkai on 03/24/2023.
//  Copyright (c) 2023 yangxiongkai. All rights reserved.
//

import UIKit
import Flying

class DemoViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        tableView.register(DemoTableViewCell.self, forCellReuseIdentifier: identifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "切换环境", style: .plain, target: self, action: #selector(switchAction))
    }
    
    @objc private func switchAction() {
        EnvironmentSwitcher.show()
    }
    
    private let data: [Section] = [
        Section(name: "Message-API", rows: [Row(title: "消息列表", controller: TempViewController.self),
                                            Row(title: "消息详情", controller: TempViewController.self)]),
        Section(name: "Mall-API", rows: [Row(title: "商品列表", controller: TempViewController.self),
                                         Row(title: "商品详情", controller: TempViewController.self)])
    ]
}

extension DemoViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        data[section].name
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DemoTableViewCell
        
        if #available(iOS 14.0, *) {
            var c = cell.defaultContentConfiguration()
            c.text = data[indexPath.section].rows[indexPath.row].title
            cell.contentConfiguration = c
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = data[indexPath.section].rows[indexPath.row]
        present(row.controller.init(), animated: true)
    }
}

let identifier = "DemoTableViewCellIden"

class DemoTableViewCell: UITableViewCell {}

private struct Row {
    let title: String
    let controller: UIViewController.Type
}

private struct Section {
    let name: String
    var rows: [Row]
}

class TempViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        //        Flying.request(MessageAPI.list)
    }
}
