//
//  ISLoadingView.swift
//
//  Created by Hernan Paez on 23/11/15.
//  Copyright © 2015 Infinixsoft. All rights reserved.
//

import UIKit
import ObjectiveC

extension UIView {
    private struct AssociatedKeys {
        static var LoadingView = "__is_ak_LoadingView"
    }
    
    var loadingView:ISLoadingView! {
        get {
            if let loadingView = objc_getAssociatedObject(self, &AssociatedKeys.LoadingView) as? ISLoadingView {
                return loadingView
            }
            else {
                let loadingView = ISLoadingView(frame: self.frame, insets: UIEdgeInsets.zero)
                addSubview(loadingView)
                loadingView.contentInset = UIEdgeInsets.zero
                loadingView.isHidden = true
                
                self.loadingView = loadingView
                
                return loadingView
            }
            
        }
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.LoadingView, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

class ISLoadingView : UIView {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    var errorContainer:UIView?
    var errorMessageLabel:UILabel?
    var errorButtonAction:(()->())?
    var errorButton:ISBorderedButton?
    
    var errorMessageFont = UIFont.appFontWithSize(size: 20)
    var errorButtonFont = UIFont.appFontLightWithSize(size: 18)
    
    var errorMessageColor = UIColor.lightGray
    var errorButtonColor = UIColor.lightGray
    
    private var topConstraint:NSLayoutConstraint?
    private var trailingConstraint:NSLayoutConstraint?
    private var leadingConstraint:NSLayoutConstraint?
    private var bottomConstraint:NSLayoutConstraint?
    
    var contentInset = UIEdgeInsets.zero {
        didSet {
            self.translatesAutoresizingMaskIntoConstraints = false
            
            if let superview = superview {
                
                //Set or update constraints
                
                let topConstraint = self.topConstraint ?? NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: contentInset.top)
                let trailingConstraint = self.trailingConstraint ?? NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailing, multiplier: 1, constant: -contentInset.left)
                let leadingConstraint = self.leadingConstraint ?? NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1, constant: contentInset.right)
                let bottomConstraint = self.bottomConstraint ?? NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: -contentInset.bottom)
                
                topConstraint.constant = contentInset.top
                trailingConstraint.constant = -contentInset.left
                leadingConstraint.constant = contentInset.right
                bottomConstraint.constant = -contentInset.bottom
                
                if self.topConstraint == nil && self.leadingConstraint == nil && self.trailingConstraint == nil && self.bottomConstraint == nil {
                    
                    self.topConstraint = topConstraint
                    self.bottomConstraint = bottomConstraint
                    self.leadingConstraint = leadingConstraint
                    self.trailingConstraint = trailingConstraint
                    
                    superview.addConstraints([topConstraint, trailingConstraint, leadingConstraint, bottomConstraint])
                }
                
                superview.setNeedsLayout()
            }
            
        }
    }
    
    required init(frame: CGRect, insets:UIEdgeInsets) {
        super.init(frame: frame)
        
        //Create Activity Indicator
        
        backgroundColor = UIColor.clear
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.white
        addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        //Set activity indicator constraints
        let centerX = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraints([centerX, centerY])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
  @objc func buttonAction() {
        errorButtonAction?()
    }
    
    func setErrorMessage(text:String? = nil, retryButtonTitle:String? = nil, action:((Void) -> Void)? = nil) {
        //Remove the existing error container if needed
        isHidden = false
        if let errorContainer = errorContainer {
            errorContainer.removeFromSuperview()
        }
        
        let errorMessageContainer = UIView()
        errorMessageContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //If there id text, we need to create a label to show it
        if let text = text {
            errorMessageLabel = UILabel(frame: CGRect.zero)
            errorMessageLabel?.translatesAutoresizingMaskIntoConstraints = false
            errorMessageLabel?.textAlignment = .center
            errorMessageLabel?.numberOfLines = 0
            errorMessageLabel?.text = text
            
            errorMessageLabel?.font = errorMessageFont
            errorMessageLabel?.textColor = errorMessageColor
            
            errorMessageContainer.addSubview(errorMessageLabel!)
        }
        
        //If we set a button, we need to create it and set the button action
        if let retryButtonTitle = retryButtonTitle {
            errorButton = ISBorderedButton(type: .custom)
            errorButton?.borderWidth = 0.5
            errorButton?.borderColor = errorButtonColor
            errorButton?.setTitleColor(errorButtonColor, for: .normal)
            errorButton?.translatesAutoresizingMaskIntoConstraints = false
            errorButton?.addTarget(self, action: #selector(ISLoadingView.buttonAction), for: .touchUpInside)
            
            errorButton?.setTitle(retryButtonTitle, for: .normal)
            errorButton?.titleLabel?.font = errorButtonFont
            errorMessageContainer.addSubview(errorButton!)
        }
        
        errorButtonAction = action
        
        addSubview(errorMessageContainer)
        
        //Add constraints
        
        let errorMessageContainerCenterY = NSLayoutConstraint(item: errorMessageContainer, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let errorMessageContainerCenterX = NSLayoutConstraint(item: errorMessageContainer, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)

        let errorMessageContainerWidth = NSLayoutConstraint(item: errorMessageContainer, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        self.addConstraints([errorMessageContainerCenterY, errorMessageContainerCenterX, errorMessageContainerWidth])
        
        if let errorMessageLabel = errorMessageLabel, let errorButton = errorButton {
            let labelTopConstraint = NSLayoutConstraint(item: errorMessageLabel, attribute: .top, relatedBy: .equal, toItem: errorMessageContainer, attribute: .top, multiplier: 1, constant: 0)
            let labelTrailingConstraint = NSLayoutConstraint(item: errorMessageLabel, attribute: .trailing, relatedBy: .equal, toItem: errorMessageContainer, attribute: .trailing, multiplier: 1, constant: 0)
            let labelLeadingConstraint = NSLayoutConstraint(item: errorMessageLabel, attribute: .leading, relatedBy: .equal, toItem: errorMessageContainer, attribute: .leading, multiplier: 1, constant: 0)
            
            let buttonTopConstraint = NSLayoutConstraint(item: errorButton, attribute: .top, relatedBy: .equal, toItem: errorMessageLabel, attribute: .bottom, multiplier: 1, constant: 20)
            let buttonTrailingConstraint = NSLayoutConstraint(item: errorButton, attribute: .trailing, relatedBy: .equal, toItem: errorMessageContainer, attribute: .trailing, multiplier: 1, constant: -30)
            let buttonLeadingConstraint = NSLayoutConstraint(item: errorButton, attribute: .leading, relatedBy: .equal, toItem: errorMessageContainer, attribute: .leading, multiplier: 1, constant: 30)
            let buttonBottomConstraint = NSLayoutConstraint(item: errorButton, attribute: .bottom, relatedBy: .equal, toItem: errorMessageContainer, attribute: .bottom, multiplier: 1, constant: 0)
            let buttonHeightConstraint = NSLayoutConstraint(item: errorButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
            errorButton.cornerRadius = buttonHeightConstraint.constant / 2

            errorMessageContainer.addConstraints([labelTopConstraint, labelTrailingConstraint, labelLeadingConstraint, buttonTopConstraint, buttonTrailingConstraint, buttonLeadingConstraint, buttonBottomConstraint])
            errorButton.addConstraints([buttonHeightConstraint])
        }
        else if let errorMessageLabel = errorMessageLabel{
            let labelTopConstraint = NSLayoutConstraint(item: errorMessageLabel, attribute: .top, relatedBy: .equal, toItem: errorMessageContainer, attribute: .top, multiplier: 1, constant: 0)
            let labelTrailingConstraint = NSLayoutConstraint(item: errorMessageLabel, attribute: .trailing, relatedBy: .equal, toItem: errorMessageContainer, attribute: .trailing, multiplier: 1, constant: 0)
            let labelLeadingConstraint = NSLayoutConstraint(item: errorMessageLabel, attribute: .leading, relatedBy: .equal, toItem: errorMessageContainer, attribute: .leading, multiplier: 1, constant: 0)
            let labelBottomConstraint = NSLayoutConstraint(item: errorMessageLabel, attribute: .bottom, relatedBy: .equal, toItem: errorMessageContainer, attribute: .bottom, multiplier: 1, constant: 0)
            
            errorMessageContainer.addConstraints([labelTopConstraint, labelTrailingConstraint, labelLeadingConstraint, labelBottomConstraint])
        }
        else if let errorButton = errorButton {
            let buttonTopConstraint = NSLayoutConstraint(item: errorButton, attribute: .top, relatedBy: .equal, toItem: errorMessageContainer, attribute: .bottom, multiplier: 1, constant: 20)
            let buttonTrailingConstraint = NSLayoutConstraint(item: errorButton, attribute: .trailing, relatedBy: .equal, toItem: errorMessageContainer, attribute: .trailing, multiplier: 1, constant: 30)
            let buttonLeadingConstraint = NSLayoutConstraint(item: errorButton, attribute: .leading, relatedBy: .equal, toItem: errorMessageContainer, attribute: .leading, multiplier: 1, constant: 30)
            let buttonBottomConstraint = NSLayoutConstraint(item: errorButton, attribute: .bottom, relatedBy: .equal, toItem: errorMessageContainer, attribute: .bottom, multiplier: 1, constant: 0)
            
            let buttonHeightConstraint = NSLayoutConstraint(item: errorButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
            errorButton.cornerRadius = buttonHeightConstraint.constant / 2
            
            errorMessageContainer.addConstraints([buttonTopConstraint, buttonTrailingConstraint, buttonLeadingConstraint, buttonBottomConstraint])
            errorButton.addConstraints([buttonHeightConstraint])
        }
        
        errorContainer = errorMessageContainer
        self.setNeedsLayout()
    }
    
    func startAnimating() {
        isHidden = false
        errorContainer?.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func stopAnimating(error:String? = nil, retryButtonTitle:String? = nil, action:((Void) -> Void)? = nil) {
        activityIndicator.stopAnimating()
        
        if error == nil && retryButtonTitle == nil && action == nil {
            isHidden = true
        }
        else {
            self.setErrorMessage(text: error, retryButtonTitle: retryButtonTitle, action: action)
        }
    }
}
