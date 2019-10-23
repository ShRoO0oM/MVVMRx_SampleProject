//
//  MessageView.swift
//  MVVMRx
//
//  Created by Mohammad Zakizadeh on 7/27/18.
//  Copyright © 2018 Storm. All rights reserved.
//

import UIKit


public enum Theme {
    case success
    case warning
    case error
}

class MessageView: UIView {
    
    static var sharedInstance = MessageView()
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet var containerView: UIView!
    
    var parentView: UIView!
    
    private var maskingView : UIView!

    var hideTimer : Timer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        Bundle.main.loadNibNamed("MessageView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    func showOnView(message:String,theme:Theme){
        parentView = UIApplication.shared.keyWindow
        parentView.addSubview(self)
        addMaskView()
        messageLabel.text = message
        applyTheme(theme: theme)
        self.frame.size = CGSize(width: parentView.frame.width, height: 100)
        self.frame = CGRect(x: parentView.frame.minX, y: parentView.frame.minY - self.frame.height , width: self.frame.width, height: self.frame.height)
        parentView.bringSubviewToFront(self)
        UIView.animate(withDuration: 0.2) {
            self.frame = CGRect(x: self.parentView.frame.minX, y: self.parentView.frame.minY, width: self.frame.width, height: self.frame.height)
        }
        makeDim()
        hideTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(hideView), userInfo: nil, repeats: false)
    }
    private func applyTheme(theme:Theme) {
        var backgroundColor : UIColor
        switch theme {
        case .error:
            backgroundColor = UIColor(red: 249.0/255.0, green: 66.0/255.0, blue: 47.0/255.0, alpha: 1.0)
        case .success:
            backgroundColor = UIColor(red: 97.0/255.0, green: 161.0/255.0, blue: 23.0/255.0, alpha: 1.0)
        case .warning:
            backgroundColor = UIColor(red: 238.0/255.0, green: 189.0/255.0, blue: 34.0/255.0, alpha: 1.0)
        }
        self.backgroundColor = backgroundColor
    }
    func addMaskView() {
        maskingView = UIView(frame: parentView.bounds)
        parentView.addSubview(maskingView)
        maskingView.backgroundColor = .clear
        maskingView.addTapGestureRecognizer(action: { [weak self] in
            guard let `self` = self else {return}
            self.hideView()
        })
        parentView.addSubview(maskingView)
        maskingView.fillToSuperView()
    }
    func makeDim(){
        self.maskingView.backgroundColor = UIColor.clear
        UIView.animate(withDuration: 0.2, animations: {
            self.maskingView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        })
    }
    @objc func hideView(){
        hideTimer.invalidate()
        UIView.animate(withDuration: 0.2, animations: {
            self.maskingView.backgroundColor = .clear
            self.frame.origin.y -= 100
        }) { (_) in
            self.maskingView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
}
