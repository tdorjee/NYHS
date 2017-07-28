//
//  MainTableViewCell.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewHierarchy()
        configureConstraints()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func viewHierarchy(){
        self.addSubview(cellImage)
    
        self.addSubview(blackView)
        blackView.addSubview(cellLabel)
        blackView.addSubview(schoolNumberLabel)
    }
    
    func configureConstraints(){
        
        cellImage.snp.makeConstraints { (view) in
            view.top.leading.equalToSuperview().offset(5)
            view.bottom.trailing.equalToSuperview().inset(5)
        }
        
        blackView.snp.makeConstraints { (view) in
            view.bottom.trailing.equalToSuperview()
            view.leading.equalToSuperview().offset(20)
            view.height.equalTo(50)
        }
        
        cellLabel.snp.makeConstraints { (label) in
            label.left.equalToSuperview().offset(8)
            label.centerY.equalToSuperview()

        }
        
        schoolNumberLabel.snp.makeConstraints { (label) in
            label.centerY.equalToSuperview()
            label.right.equalToSuperview().inset(8)
        }
        
    }
    
    // Outlets
    lazy var cellImage: UIImageView  = {
        let image : UIImageView = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    lazy var blackView: UIView  = {
        let view : UIView = UIView()
        view.backgroundColor = .black
        view.alpha = 0.50
        return view
    }()
    
    lazy var cellLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var schoolNumberLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    

}
