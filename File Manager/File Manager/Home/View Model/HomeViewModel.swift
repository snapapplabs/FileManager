//
//  HomeViewModel.swift
//  File Manager
//
//  Created by Shohan Rahman on 2/4/19.
//  Copyright © 2019 Shohan Rahman. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModel {
    
    fileprivate let pathUrl = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
    
    // MARK:- Get File and Directory List
    
    func getFileList() -> [FileModel] {
        
        var fileModelList = [FileModel]()
        
        let filePath = pathUrl.path
        let fileManager = FileManager.default
        do {
            let fileList = try fileManager.contentsOfDirectory(atPath: filePath)
            for file in fileList {
                var model = FileModel()
                model.fileName = file
                if file.contains(".txt") {
                    model.fileType = FileType.txt
                } else {
                    model.fileType = FileType.directory
                }
                fileModelList.append(model)
            }
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
        
        return fileModelList
    }
    
    // MARK:- Create new Directory
    
    func createDirectory(directoryName: String) -> Bool {
        let logsPath = pathUrl.appendingPathComponent(directoryName)
        do {
            try FileManager.default.createDirectory(atPath: logsPath.path, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
            return false
        }
    }
    
}
