//
//  ViewController.swift
//  File Manager
//
//  Created by Shohan Rahman on 2/4/19.
//  Copyright © 2019 Shohan Rahman. All rights reserved.
//

import UIKit

protocol SaveDelegate {
    func saveTextData(fileName: String, textData: String)
}

class ViewController: UIViewController {

    @IBAction func createDirectoryAction(_ sender: Any) {
        Utilities().getTextFromAlert(title: "Directory Name",vc: self) { (text) in
            print(self.viewModel.createDirectory(directoryName: text ?? ""))
            self.reloadTableView()
        }
    }
    
    @IBAction func createFileAction(_ sender: Any) {
        Utilities().getTextFromAlert(title: "File Name", vc: self) { (text) in
            let fileName = text ?? ""
            Utilities().getTextFromAlert(title: "File Data", vc: self) { (data) in
                let textData = data ?? ""
                debugPrint(self.viewModel.createNextTextFile(fileName: "\(fileName).txt", fileData: textData))
                self.reloadTableView()
            }
        }
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
        cell.moreButtonAction = {
            let optionMenu = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)
            
            let copyAction = UIAlertAction(title: "Copy", style: .default, handler: {
                [weak self] _  in
                
            })
            
            let moveAction = UIAlertAction(title: "Move", style: .default, handler: {
                [weak self] _  in
                
            })
            
            let renameAction = UIAlertAction(title: "Rename", style: .default, handler: { _  in
                let oldName = self.fileList[indexPath.row].fileName
                Utilities().getTextFromAlert(title: "New Name", vc: self) { (text) in
                    if self.fileList[indexPath.row].fileType == FileType.txt {
                        let newName = text ?? ""
                        debugPrint(self.viewModel.renameFile(oldfileName: oldName, newFileName: "\(newName).txt"))
                    } else {
                        debugPrint(self.viewModel.renameFile(oldfileName: oldName, newFileName: text ?? ""))
                    }
                    self.reloadTableView()
                }
            })
            
            let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: {  [weak self] _  in
                debugPrint(self?.viewModel.removeFile(fileName: self?.fileList[indexPath.row].fileName ?? "") ?? false)
                self?.reloadTableView()
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            if self.fileList[indexPath.row].fileType == FileType.txt {
                optionMenu.addAction(copyAction)
                optionMenu.addAction(moveAction)
            }
            optionMenu.addAction(renameAction)
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            
            self.present(optionMenu, animated: true, completion: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if fileList[indexPath.row].fileType == FileType.txt {
            debugPrint(viewModel.getTextFileData(fileName: fileList[indexPath.row].fileName))
            let vc = EditViewController()
            vc.delegate = self
            vc.text = viewModel.getTextFileData(fileName: fileList[indexPath.row].fileName)
            vc.fileName = fileList[indexPath.row].fileName
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ViewController: SaveDelegate {
    func saveTextData(fileName: String, textData: String) {
        debugPrint(self.viewModel.createNextTextFile(fileName: fileName, fileData: textData))
        self.reloadTableView()
    }
}
