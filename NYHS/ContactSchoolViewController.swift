//
//  ContactSchoolViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/20/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class ContactSchoolViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        viewHierarchy()
        constrainConfiguration()
    
    }
    
    func dismissView(){
        print("View dismissing")
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewHierarchy(){
        
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(closeButton)
        
        //view.addSubview(lineSeparatorOne)
        view.addSubview(callButton)
            view.addSubview(lineSeparatorTwo)
        view.addSubview(emailButton)
            view.addSubview(lineSeparatorThree)
        view.addSubview(favoriteButton)
        view.addSubview(lineSeparatorFour)
        view.addSubview(moreButton)
     
    }
    
    func constrainConfiguration(){
        
        self.edgesForExtendedLayout = []
        
        backgroundImage.snp.makeConstraints { (label) in
            label.height.equalToSuperview().multipliedBy(0.50)
            label.width.equalTo(self.view.frame.width)
            label.left.top.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { (button) in
            button.left.equalToSuperview().offset(12)
            button.top.equalToSuperview().offset(50)
            button.height.width.equalTo(50)
        }
        
        callButton.snp.makeConstraints { (button) in
            button.top.equalTo(backgroundImage.snp.bottom)
            button.left.equalTo(backgroundImage.snp.left)
            button.height.equalToSuperview().multipliedBy(0.10)
            button.width.equalTo(backgroundImage.snp.width)
        }
        
        lineSeparatorTwo.snp.makeConstraints { (line) in
            line.top.equalTo(callButton.snp.bottom)
            line.height.equalTo(0.5)
            line.left.equalTo(backgroundImage.snp.left)
        }
        
        emailButton.snp.makeConstraints { (button) in
            button.top.equalTo(lineSeparatorTwo.snp.bottom)
            button.left.equalTo(backgroundImage.snp.left)
            button.height.equalToSuperview().multipliedBy(0.10)
            button.width.equalTo(backgroundImage.snp.width)
        }
        
        lineSeparatorThree.snp.makeConstraints { (line) in
            line.top.equalTo(emailButton.snp.bottom)
            line.height.equalTo(0.5)
            line.left.equalTo(backgroundImage.snp.left)
        }
        
        favoriteButton.snp.makeConstraints { (button) in
            button.top.equalTo(lineSeparatorThree.snp.bottom)
            button.left.equalTo(backgroundImage.snp.left)
            button.height.equalToSuperview().multipliedBy(0.10)
            button.width.equalTo(backgroundImage.snp.width)
        }
        
        lineSeparatorFour.snp.makeConstraints { (line) in
            line.top.equalTo(favoriteButton.snp.bottom)
            line.height.equalTo(0.5)
            line.left.equalTo(backgroundImage.snp.left)
        }
        
        moreButton.snp.makeConstraints { (button) in
            button.top.equalTo(lineSeparatorFour.snp.bottom)
            button.left.equalTo(backgroundImage.snp.left)
            button.height.equalToSuperview().multipliedBy(0.10)
            button.width.equalTo(backgroundImage.snp.width)
        }
        
        
        
    }
    
    // MARK: - Outlets
    
    internal lazy var backgroundImage: UIImageView = {
        let  image = UIImageView()
        image.image = #imageLiteral(resourceName: "contactPage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    internal lazy var closeButton: UIButton = {
        let  button = UIButton()
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        return button
    }()
    
    
    internal lazy var lineSeparatorOne: UIView = {
        let line = UIView()
        line.backgroundColor = ColorScheme.lineSeparatorColor
        return line
    }()
    
    internal lazy var callButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorScheme.navColor
        button.setTitle("Call", for: .normal)
        //button.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
        return button
    }()
    
    
    internal lazy var lineSeparatorTwo: UIView = {
        let line = UIView()
        line.backgroundColor = ColorScheme.lineSeparatorColor
        return line
    }()
    
    internal lazy var emailButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorScheme.navColor
        button.setTitle("Email", for: .normal)
        //button.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
        return button
    }()
    
    internal lazy var lineSeparatorThree: UIView = {
        let line = UIView()
        line.backgroundColor = ColorScheme.lineSeparatorColor
        return line
    }()
    
    internal lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorScheme.navColor
        button.setTitle("Add to favorite", for: .normal)
        //button.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
        return button
    }()
    
    internal lazy var lineSeparatorFour: UIView = {
        let line = UIView()
        line.backgroundColor = ColorScheme.lineSeparatorColor
        return line
    }()
    
    internal lazy var moreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorScheme.navColor
        button.setTitle("More", for: .normal)
        //button.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
        return button
    }()
    


}
