//
//  ContactSchoolViewController.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/20/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import MessageUI

class ContactSchoolViewController: UIViewController {

    
    var schoolFromdetailSchool: School?
 
    
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
    
    let messageComposer = MFMessageComposeViewController()
    let mailComposer = MFMailComposeViewController()
    
    
    func smsSchool(){
        if MFMessageComposeViewController.canSendText(){
            messageComposer.messageComposeDelegate = self as? MFMessageComposeViewControllerDelegate
            if let schoolWebSite = schoolFromdetailSchool?.website {
                messageComposer.body = "Check this school out: \(schoolWebSite))"
            }
            present(messageComposer, animated: true, completion: nil)
        }
    }
    
    func callSchool(){
        guard let number = URL(string: "telprompt://" + (schoolFromdetailSchool?.phone_number)!) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    func emailSchool() {
        if MFMailComposeViewController.canSendMail(){
            self.mailComposer.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            mailComposer.setToRecipients([(schoolFromdetailSchool?.school_email)!])
            present(mailComposer, animated: true, completion: nil)
        }
    }
    
    func addToFavourite(){
        
        // Jason's strategy
        
        //        if var dict = UserDefaults.standard.dictionary(forKey: "favoriteSchools") {
        //            dict[detailSchool.name] = detailSchool.name
        //            UserDefaults.standard.set(dict, forKey: "favoriteSchools")
        //        }else {
        //            let dict = [detailSchool.name : detailSchool.name]
        //            UserDefaults.standard.set(dict, forKey: "favoriteSchools")
        //        }
        
        let favSchool = UserDefaults.standard.object(forKey: "school")
        var favSchoolAdd: [School]
        
        if let tempSchool = favSchool as? [School] {
            
            favSchoolAdd = tempSchool
            favSchoolAdd.append((schoolFromdetailSchool)!)
            
        }else {
            favSchoolAdd = [(schoolFromdetailSchool)!]
        }
        UserDefaults.standard.set(favSchoolAdd, forKey: "school")
        
        let alert = UIAlertController(title: "Saved", message: "School added to Favorite list", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


    func viewHierarchy(){
        
        view.addSubview(backgroundImage)
        view.addSubview(closeButton)
        
        //view.addSubview(lineSeparatorOne)
        view.addSubview(smsButton)
            view.addSubview(lineSeparatorTwo)
        view.addSubview(emailButton)
            view.addSubview(lineSeparatorThree)
        view.addSubview(favoriteButton)
        view.addSubview(lineSeparatorFour)
        view.addSubview(callButton)
     
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
        
        smsButton.snp.makeConstraints { (button) in
            button.bottom.equalTo(lineSeparatorTwo.snp.top)
            button.height.equalToSuperview().multipliedBy(0.10)
            button.left.equalToSuperview()
            button.width.equalTo(self.view.frame.width)
        }
        
        lineSeparatorTwo.snp.makeConstraints { (line) in
            line.bottom.equalTo(emailButton.snp.top)
            line.height.equalTo(0.5)
            line.left.equalTo(smsButton.snp.left)
        }
        
        emailButton.snp.makeConstraints { (button) in
            button.bottom.equalTo(lineSeparatorThree.snp.top)
            button.height.equalToSuperview().multipliedBy(0.10)
            button.left.equalTo(smsButton.snp.left)
            button.width.equalTo(smsButton.snp.width)
        }
        
        lineSeparatorThree.snp.makeConstraints { (line) in
            line.bottom.equalTo(favoriteButton.snp.top)
            line.height.equalTo(0.5)
            line.left.equalTo(smsButton.snp.left)
        }
        
        favoriteButton.snp.makeConstraints { (button) in
            button.bottom.equalTo(lineSeparatorFour.snp.top)
            button.height.equalToSuperview().multipliedBy(0.10)
            button.left.equalTo(smsButton.snp.left)
            button.width.equalTo(smsButton.snp.width)
        }
        
        lineSeparatorFour.snp.makeConstraints { (line) in
            line.bottom.equalTo(callButton.snp.top)
            line.height.equalTo(0.5)
            line.left.equalTo(smsButton.snp.left)
        }
        
        callButton.snp.makeConstraints { (button) in
            button.bottom.equalToSuperview()
            button.height.equalToSuperview().multipliedBy(0.10)
            button.left.equalTo(smsButton.snp.left)
            button.width.equalTo(smsButton.snp.width)
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
    
    internal lazy var smsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorScheme.navColor
        button.setTitle("SMS", for: .normal)
        button.addTarget(self, action: #selector(smsSchool), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(emailSchool), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
        return button
    }()
    
    internal lazy var lineSeparatorFour: UIView = {
        let line = UIView()
        line.backgroundColor = ColorScheme.lineSeparatorColor
        return line
    }()
    
    internal lazy var callButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorScheme.navColor
        button.setTitle("Call", for: .normal)
        button.addTarget(self, action: #selector(callSchool), for: .touchUpInside)
        return button
    }()
}

extension ContactSchoolViewController: MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch (result){
        case .cancelled:
            print("Mail cancelled")
            break
        case .saved:
            print("Mail saved")
            break
        case .sent:
            print("Mail sent")
            break
        case .failed:
            print("Mail sent failure: \(String(describing: error?.localizedDescription))")
        }
        // Close the Mail Interface
        controller.dismiss(animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
