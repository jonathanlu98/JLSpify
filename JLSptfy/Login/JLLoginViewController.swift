//
//  JLLoginViewController.swift
//  JLSpfRadioView
//
//  Created by Jonathan Lu on 2020/2/4.
//  Copyright © 2020 Jonathan Lu. All rights reserved.
//

import UIKit


class JLLoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(didTapConnect(_:)), for: .touchUpInside)
        
        if (AppDelegate.sharedInstance.sptSession != nil) {
            loginButton.changStatus(isDisabled: true, disabledColor: #colorLiteral(red: 0.3254599571, green: 0.3255102634, blue: 0.3254440129, alpha: 1), enabledColor: #colorLiteral(red: 0.1137254902, green: 0.8392156863, blue: 0.3764705882, alpha: 1))
            do {
                let session: SPTSession = try NSKeyedUnarchiver.unarchivedObject(ofClass: SPTSession.self, from: AppDelegate.sharedInstance.sptSession! as! Data)!
                AppDelegate.sharedInstance.sessionManager.session = session
                AppDelegate.sharedInstance.sessionManager.renewSession()
            } catch {
                self.presentAlertController(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
            }
        }

    }
    
    
    
    //MARK: Actions
    
    @objc func didTapConnect(_ button: UIButton) {
        button.changStatus(isDisabled: true, disabledColor: #colorLiteral(red: 0.3254599571, green: 0.3255102634, blue: 0.3254440129, alpha: 1), enabledColor: #colorLiteral(red: 0.1137254902, green: 0.8392156863, blue: 0.3764705882, alpha: 1))
        let scope: SPTScope = [ .playlistReadPrivate, .userLibraryRead, .userReadPrivate, .userFollowRead]
        
        if (AppDelegate.sharedInstance.sptSession != nil) {

            do {
                let session: SPTSession = try NSKeyedUnarchiver.unarchivedObject(ofClass: SPTSession.self, from: AppDelegate.sharedInstance.sptSession! as! Data)!
                AppDelegate.sharedInstance.sessionManager.session = session
                AppDelegate.sharedInstance.sessionManager.renewSession()
            } catch {
                self.presentAlertController(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
            }
            
        } else {
            if #available(iOS 11, *) {
                // Use this on iOS 11 and above to take advantage of SFAuthenticationSession
                AppDelegate.sharedInstance.sessionManager.initiateSession(with: scope, options: .default)
            } else {
                // Use this on iOS versions < 11 to use SFSafariViewController
                AppDelegate.sharedInstance.sessionManager.initiateSession(with: scope, options: .default, presenting: self)
            }
        }
        
    }

}
