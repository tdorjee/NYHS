//
//  ComposeText.swift
//  NYHS
//
//  Created by Thinley Dorjee on 6/20/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
import MessageUI

class ComposeText: NSObject, MFMessageComposeViewControllerDelegate {
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        
        
        messageComposeVC.messageComposeDelegate = self
//        messageComposeVC.recipients = schoolNumber
        messageComposeVC.body =  "I arrieved home safely"
        accessibilityActivate()
        
        return messageComposeVC
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}

