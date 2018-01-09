//
//  BoroTableViewCell.swift
//  NYHS
//
//  Created by Thinley Dorjee on 5/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class BoroTableViewCell: UITableViewCell {
    
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
        
        detailLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        addview()
        constraintConfig()
        
    }
    
    @objc func addview() {
        self.addSubview(labelContainer)
        labelContainer.addSubview(titleLabel)
        labelContainer.addSubview(detailLabel)
    }
    
    @objc func constraintConfig(){
        labelContainer.snp.makeConstraints { (container) in
            container.left.top.equalToSuperview().offset(8)
            container.bottom.equalToSuperview().inset(8)
            container.right.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { (label) in
            label.left.top.equalToSuperview()
            label.right.equalToSuperview()
            
        }
        
        detailLabel.snp.makeConstraints { (label) in
            label.leading.equalTo(titleLabel)
            label.right.equalToSuperview()
            label.centerY.equalToSuperview().inset(15)
        }
    }

    
    internal lazy var labelContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    internal lazy var titleLabel:  UILabel = {
        let label = UILabel()
        return label
    }()
    internal lazy var detailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
