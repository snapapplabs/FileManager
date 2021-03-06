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
    
    func getFileList(subPath: String) -> [FileModel] {
        
        var fileModelList = [FileModel]()
        
        let filePath = pathUrl.path + subPath
        
        debugPrint(filePath)
        
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
    
    func createDirectory(subPath: String, directoryName: String) -> Bool {
        let logsPath = pathUrl.appendingPathComponent(subPath + "/" + directoryName)
        do {
            try FileManager.default.createDirectory(atPath: logsPath.path, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
            return false
        }
    }
    
    // MARK:- Create new Text File
    
    func createNextTextFile(fileName: String, fileData: String) -> Bool {
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = directory.appendingPathComponent(fileName)
            do {
                try fileData.write(to: fileURL, atomically: false, encoding: .utf8)
                return true
            } catch {
                debugPrint("write failed.")
            }
        }
        
        return false
    }
    
    // Mark:- Read text File Data
    
    func getTextFileData(subPath: String, fileName: String) -> String {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(subPath + "/" + fileName)
            do{
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                return text
            }catch{
                print("cant read...")
            }
        }
        return ""
    }
    
    // Mark:- Delete Directory / File
    
    func removeFile(subPath: String, fileName: String) -> Bool {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let removeFile = dir.appendingPathComponent(subPath + "/" + fileName)
            let fileManager = FileManager.default
            do{
                try fileManager.removeItem(at: removeFile)
                return true
            }catch{
                print("cant remove file...")
            }
        }
        return false
    }
    
    // Mark:- Rename Directory / File
    
    func renameFile(oldfileName: String, newFileName: String) -> Bool {
        do {
            let originPath = pathUrl.appendingPathComponent(oldfileName)
            let destinationPath = pathUrl.appendingPathComponent(newFileName)
            try FileManager.default.moveItem(at: originPath, to: destinationPath)
            return true
        } catch {
            print(error)
        }
        return false
    }
    
    //Mark:- Copy File to Folder
    
    func copyFile(oldPth: String, newPath: String) -> Bool {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let originalFile = dir.appendingPathComponent(oldPth)
            let copyFile = dir.appendingPathComponent(newPath)
            
            let fileManager = FileManager.default
            do {
                try fileManager.copyItem(at: originalFile, to: copyFile)
                return true
            } catch {
                print("can't copy")
            }
        }
        
        return false
    }
    
    //Mark:- move File to folder
    
    func moveFile(oldPth: String, newPath: String) -> Bool {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let oldPath = dir.appendingPathComponent(oldPth)
            let newPath = dir.appendingPathComponent(newPath)
            let fileManager = FileManager.default
            do{
                try fileManager.moveItem(at: oldPath, to: newPath)
                return true
            }catch{
                print("cant move the file...")
            }
        }
        return false
    }
    
}
