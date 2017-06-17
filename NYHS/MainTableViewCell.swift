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
        self.addSubview(cellLabel)
        
        //self.addSubview(blackView)
    }
    
    func configureConstraints(){
        
        cellImage.snp.makeConstraints { (view) in
            view.bottom.top.leading.trailing.equalToSuperview()
        }
        
        cellLabel.snp.makeConstraints { (label) in
            label.center.equalToSuperview()
            label.top.equalToSuperview().offset(80.0)
            label.bottom.equalToSuperview().inset(80.0)
            label.width.equalToSuperview().multipliedBy(0.60)
        }
        
//        blackView.snp.makeConstraints { (view) in
//            view.bottom.leading.trailing.equalToSuperview()
//        }
    }
    
    // Outlets
    
    lazy var cellLabel: UILabel = {
        let label: UILabel = UILabel ()
        label.textAlignment = .center
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 3
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    lazy var blackView: UIView  = {
        let view : UIView = UIView()
        view.backgroundColor = .black
        view.alpha = 0.25
        return view
    }()
    
    lazy var cellImage: UIImageView  = {
        let image : UIImageView = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()

}
