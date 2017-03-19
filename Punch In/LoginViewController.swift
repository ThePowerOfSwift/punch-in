//
//  LoginViewController.swift
//  Punch In
//
//  Created by Kyle Stewart on 1/13/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController {
    
    var backgroundVideoPlayer: AVPlayer!
    var backgroundVideoPlayerLayer = AVPlayerLayer()
    var videoPaused = false
    
    var topLayer: UIView!
    let signUpView = SignUpView()
    let logInView = LogInView()

    var keyboardOpen: Bool = false
    
    var login: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        setBackground()
        
        logInView.drawLogInView(sender: self)
        logInView.delegate = self
        
        signUpView.drawSignUpView(sender: self)
        signUpView.delegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
    
    // Manage Keyboard, let the user exit
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


    func playerItemDidReachEnd(notification: NSNotification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
        backgroundVideoPlayer.play()
        videoPaused = false
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        backgroundVideoPlayer.pause()
        videoPaused = true
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        
        if textField.returnKeyType == UIReturnKeyType.go {
            Network.authToken = "tempValue"
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
    
    func signUpButtonClicked() {
        logInView.animateLogInView(sender: self)
        signUpView.animateSignUpView(sender: self)
        print("Sign Up Button Clicked")
        
    }
    
    func forgotPasswordButtonClicked() {
        
        print("Forgot Password Button Clicked")
        
    }
    
}

extension LoginViewController: SignUpViewDelegate {
    
    func backToLogInButtonClicked() {
        logInView.animateLogInView(sender: self)
        signUpView.animateSignUpView(sender: self)
        print("Back to log in Clicked")
        
    }
    
    func completeSignUpButtonClicked() {
        
        print("Sign Up Button Clicked")
        
    }
    
}

