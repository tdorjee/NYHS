//
//  BoroTableViewCell.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class BoroTableViewCell: UITableViewCell {

//    internal lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.lineBreakMode = .byWordWrapping
//        //label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = UIColor.init(white: 2.0, alpha: 1)
//        label.numberOfLines = 0
//        return label
//    }()
    

    var titleLabel = UILabel()
    var detailLabel = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //detailLabel.font = UIFont.systemFont(ofSize: 16.0)
        
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        
        titleLabel.snp.makeConstraints { (label) in
            label.left.top.equalToSuperview().offset(8)
            label.right.equalToSuperview().inset(80)
            label.centerY.equalToSuperview()
            
        }
        
        detailLabel.snp.makeConstraints { (label) in
            label.leading.equalTo(titleLabel)
            label.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
