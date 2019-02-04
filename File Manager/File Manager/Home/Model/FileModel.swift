//
//  FileModel.swift
//  File Manager
//
//  Created by Shohan Rahman on 2/5/19.
//  Copyright © 2019 Shohan Rahman. All rights reserved.
//

import Foundation

struct FileModel {
    var fileName = ""
    var fileType = FileType.none
    
    init() {
        
    }
}

enum FileType: String {
    case directory = "directory"
    case txt = "txt"
    case none = "none"
}
