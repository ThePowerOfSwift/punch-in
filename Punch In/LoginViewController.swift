//
//  LoginViewController.swift
//  Punch In
//
//  Created by Kyle Stewart on 1/13/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var backgroundVideoPlayer: AVPlayer!
    var backgroundVideoPlayerLayer = AVPlayerLayer()
    
    var topLayer: UIView!
    let logInView = LogInView()

    var keyboardOpen: Bool = false
    
    var login: Bool = true
    var handle: FIRAuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        setBackground()
        
        logInView.drawLogInView(sender: self)
        logInView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        backgroundVideoPlayer.play()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        FIRAuth.auth()?.removeStateDidChangeListener(handle!)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        backgroundVideoPlayer.pause()
    }
    
    func setBackground() {
        
        backgroundVideoPlayer = AVPlayer(url: Styles.loginBackgroundVideoURL!)
        backgroundVideoPlayerLayer = AVPlayerLayer(player: backgroundVideoPlayer)
        backgroundVideoPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        backgroundVideoPlayer.volume = 0
        backgroundVideoPlayer.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        
        backgroundVideoPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = UIColor.clear
        view.layer.insertSublayer(backgroundVideoPlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: backgroundVideoPlayer.currentItem)
        
        topLayer = UIView(frame: CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height))
        
        topLayer.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.addSubview(topLayer)
        
    }
    
    func animate() {

        if !keyboardOpen {
            logInView.animateForKeyboard(sender: self)
        }

    }


    func playerItemDidReachEnd(notification: NSNotification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        if textField.returnKeyType == UIReturnKeyType.go {
            NetworkConstants.authToken = "tempValue"
            RootNavigationController.shared.presentHome(animated: true)
        }
        
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        animate()
        keyboardOpen = true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        keyboardOpen = false   // Will only animate is keyboardOpen is false. Set to false, then animate.
        animate()
    }
    
}

extension LoginViewController: LogInViewDelegate {
    
    func loginWithFacebook() {
        print("Login With Facebook")
    }
    
    func loginWithGoogle() {
        print("Login With Google")
    }
    
    func loginWithEmail(for email: String, with password: String) {
        print("Login with Email")
    }
    
    func signupWithFacebook() {
        print("Sign up with Facebook")
    }
    
    func signupWithGoogle() {
        print("Sign up with Google")
    }
    
    func signupWithEmail(for email: String, with password: String) {
        print("Create User Request")
        print("Email: " + email)
        print("Password: " + password)
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let user = user {
                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
                
                user.getTokenWithCompletion({ (token, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    print("USER SUCCESSFULLY CREATED")
                    print("USER ID: " + uid)
                    print("EMAIL: " + email!)
                    print("PHOTO URL: " + String(describing: photoURL))
                    print("TOKEN: " + token!)
                    
                })
            }
            
        })
        
    }

    }

    func forgotPasswordButtonClicked() {
        print("Forgot Password Button Clicked")
    }
    
}

//extension LoginViewController: SignUpViewDelegate {
//    
//    func backToLogInButtonClicked() {
//        //logInView.animateLogInView(sender: self)
//        signUpView.animateSignUpView(sender: self)
//        print("Back to log in Clicked")
//        
//    }
//    
//    func completeSignUpButtonClicked(for email: String, with password: String) {
//        
//
//}

