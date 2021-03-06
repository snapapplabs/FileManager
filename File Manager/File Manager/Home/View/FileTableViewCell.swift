//
//  FileTableViewCell.swift
//  File Manager
//
//  Created by Shohan Rahman on 2/4/19.
//  Copyright © 2019 Shohan Rahman. All rights reserved.
//

import UIKit

class FileTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func moreButton(_ sender: Any) {
        if let moreButtonAction = moreButtonAction {
            moreButtonAction()
        }
    }
    
    var moreButtonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(item: FileModel) {
        titleLabel.text = item.fileName
        if item.fileType == FileType.txt {
            iconImageView.image = UIImage(named: "txt-icon")
        } else {
            iconImageView.image = UIImage(named: "folder-icon")
        }
    }
    
}
