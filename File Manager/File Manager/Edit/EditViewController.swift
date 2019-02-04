//
//  EditViewController.swift
//  File Manager
//
//  Created by Shohan Rahman on 2/5/19.
//  Copyright © 2019 Shohan Rahman. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBAction func saveButton(_ sender: Any) {
        self.delegate?.saveTextData(fileName: fileName, textData: textView.text)
        self.navigationController?.popViewController(animated: true)
    }
    
    var delegate: SaveDelegate?
    var text = ""
    var fileName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = text
    }

}
