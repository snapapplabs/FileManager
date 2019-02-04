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
        reloadTableView()
    }
    
    @IBAction func createFileAction(_ sender: Any) {
        debugPrint(viewModel.createNextTextFile(fileName: "test", fileData: "Write First file."))
        reloadTableView()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let tableviewCellIdentifier = "FileTableViewCell"
    fileprivate let viewModel = HomeViewModel()
    fileprivate var fileList = [FileModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "File Manager"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: tableviewCellIdentifier, bundle: nil), forCellReuseIdentifier: tableviewCellIdentifier)
        tableView.tableFooterView = UIView()
        
        reloadTableView()
    }
    
    func reloadTableView() {
        fileList = viewModel.getFileList()
        tableView.reloadData()
    }
}

// MARK:- Tableview Datasource and delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableviewCellIdentifier, for: indexPath) as! FileTableViewCell
        cell.setup(item: fileList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if fileList[indexPath.row].fileType == FileType.txt {
            debugPrint(viewModel.getTextFileData(fileName: fileList[indexPath.row].fileName))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
