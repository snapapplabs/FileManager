//
//  ViewController.swift
//  File Manager
//
//  Created by Shohan Rahman on 2/4/19.
//  Copyright © 2019 Shohan Rahman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func createDirectoryAction(_ sender: Any) {
        print(viewModel.createDirectory(directoryName: "Shohan"))
    }
    
    @IBAction func createFileAction(_ sender: Any) {
        print(viewModel.getFileList())
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let tableviewCellIdentifier = "FileTableViewCell"
    fileprivate let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "File Manager"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: tableviewCellIdentifier, bundle: nil), forCellReuseIdentifier: tableviewCellIdentifier)
        tableView.tableFooterView = UIView()
        
        print(viewModel.getFileList())
    }
}

// MARK:- Tableview Datasource and delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableviewCellIdentifier, for: indexPath) as! FileTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Position ===> \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
