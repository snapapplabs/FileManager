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
    
    func getFileList() -> [String] {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: path)
        let filePath = url.path
        let fileManager = FileManager.default
        do {
            try fileManager.contentsOfDirectory(atPath: filePath)
        } catch {
            
        }
        return []
    }
    
}
