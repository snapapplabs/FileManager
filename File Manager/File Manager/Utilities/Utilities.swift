//
//  Utilities.swift
//  File Manager
//
//  Created by Shohan Rahman on 2/5/19.
//  Copyright © 2019 Shohan Rahman. All rights reserved.
//

import UIKit

class Utilities {
    
    func getTextFromAlert(title: String, vc: UIViewController, completion: @escaping (_ text: String?) -> Void) {
        let option = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        option.addTextField(configurationHandler: { (textfield) in
            textfield.placeholder = "Text"
        })
        
        option.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            let textField = option.textFields![0]
            completion(textField.text)
        }))
        
        option.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(option, animated: true, completion: nil)
    }
}


