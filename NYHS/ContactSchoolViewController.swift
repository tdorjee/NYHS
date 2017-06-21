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

    let messageComposer = ComposeText()
    
    var schoolNumber: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        viewHierarchy()
        constrainConfiguration()
    
    }
    
    // MARK: - Actions
    
    func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func callThisNum(){
        if (messageComposer.canSendText()){
//            messageComposer.MFMessageComposeViewController.recipients = schoolNumber
            let messageComposerVC = messageComposer.configuredMessageComposeViewController()
            present(messageComposerVC, animated: true, completion: nil)
        }else{
            print("Plz run it in device")
        }
    }


    func viewHierarchy(){
        
        view.addSubview(backgroundImage)
        view.addSubview(closeButton)
        
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
        
        closeButton.snp.makeConstraints { (button) in
            button.top.equalToSuperview().offset(40)
            button.left.equalToSuperview().offset(20)
            button.height.width.equalTo(40)
        }
        
        backgroundImage.snp.makeConstraints { (label) in
            label.top.equalToSuperview().offset(100)
            label.centerX.equalToSuperview()
            label.height.equalTo(180)
            label.width.equalTo(180)
        }
        
        
        callButton.snp.makeConstraints { (button) in
            button.bottom.equalTo(lineSeparatorTwo.snp.top)
            button.height.equalToSuperview().multipliedBy(0.10)
            button.left.equalToSuperview()
            button.width.equalTo(self.view.frame.width)
        }
        
        lineSeparatorTwo.snp.makeConstraints { (line) in
            line.bottom.equalTo(emailButton.snp.top)
            line.height.equalTo(0.5)
            line.left.equalTo(callButton.snp.left)
        }
        
        emailButton.snp.makeConstraints { (button) in
            button.bottom.equalTo(lineSeparatorThree.snp.top)
            button.height.equalToSuperview().multipliedBy(0.10)
            button.left.equalTo(callButton.snp.left)
            button.width.equalTo(callButton.snp.width)
        }
        
        lineSeparatorThree.snp.makeConstraints { (line) in
            line.bottom.equalTo(favoriteButton.snp.top)
            line.height.equalTo(0.5)
            line.left.equalTo(callButton.snp.left)
        }
        
        favoriteButton.snp.makeConstraints { (button) in
            button.bottom.equalTo(lineSeparatorFour.snp.top)
            button.height.equalToSuperview().multipliedBy(0.10)
            button.left.equalTo(callButton.snp.left)
            button.width.equalTo(callButton.snp.width)
        }
        
        lineSeparatorFour.snp.makeConstraints { (line) in
            line.bottom.equalTo(moreButton.snp.top)
            line.height.equalTo(0.5)
            line.left.equalTo(callButton.snp.left)
        }
        
        moreButton.snp.makeConstraints { (button) in
            button.bottom.equalToSuperview()
            button.height.equalToSuperview().multipliedBy(0.10)
            button.left.equalTo(callButton.snp.left)
            button.width.equalTo(callButton.snp.width)
        }
        
        
        
    }
    
    // MARK: - Outlets
    
    internal lazy var backgroundImage: UIImageView = {
        let  image = UIImageView()
        image.image = #imageLiteral(resourceName: "contactPage")
        image.layer.cornerRadius = 10
        image.backgroundColor = .red
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    internal lazy var closeButton: UIButton = {
        let  button = UIButton()
//        button.backgroundColor = .red
        button.isUserInteractionEnabled = true
        button.backgroundColor = UIColor(white: 0.7, alpha: 0.5)
        button.layer.cornerRadius = 20
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
        button.addTarget(self, action: #selector(callThisNum), for: .touchUpInside)
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
