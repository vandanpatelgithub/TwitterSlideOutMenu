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
        setupMenuController()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }

    let menuVC = MenuViewController()

    fileprivate let menuWidth: CGFloat = 300.0

    @objc func handleOpen() {
        performAnimations(transform: CGAffineTransform(translationX: menuWidth, y: 0))
    }

    @objc func handleHide() {
        performAnimations(transform: .identity)
    }

    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed {
            let translation = gesture.translation(in: view)
            var x = translation.x
            x = min(menuWidth, x)
            x = max(0, x)
            let transform = CGAffineTransform(translationX: x, y: 0)
            menuVC.view.transform = transform
            navigationController?.view.transform = transform
        } else if gesture.state == .ended {
            handleOpen()
        }
    }

    fileprivate func performAnimations(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut, animations: {
                        self.menuVC.view.transform = transform
                        self.navigationController?.view.transform = transform
        })
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

    fileprivate func setupMenuController() {
        menuVC.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuVC.view)
        addChild(menuVC)
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

