//
//  ViewController.swift
//  TwitterSlideOutMenu
//
//  Created by Patel, Vandan (ETW - FLEX) on 9/29/18.
//  Copyright © 2018 Patel, Vandan (ETW - FLEX). All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .red
        setupNavigationItems()
    }

    @objc func handleOpen() {
        let vc = MenuViewController()
        vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: view.frame.height)

        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(vc.view)
    }

    @objc func handleHide() {
        print("Hiding Menu ...")
    }


    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem    = UIBarButtonItem(title: "Open",
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(handleOpen))
        navigationItem.rightBarButtonItem   = UIBarButtonItem(title: "Hide",
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(handleHide))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellID")
        cell.textLabel?.text = "Row: \(indexPath.row)"
        return cell
    }
}

