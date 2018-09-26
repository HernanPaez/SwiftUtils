//
//  SideMenuContainer.swift
//  A simple side menu controller to avoid including innecesary libraries
//
//  Created by Hernan Paez on 09/04/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import UIKit

fileprivate extension NSLayoutConstraint {
    convenience init(attribute:NSLayoutConstraint.Attribute, ofView l_view:UIView, equalToView r_view:UIView? = nil, withConstant constant:CGFloat) {
        self.init(item: l_view,
                           attribute: attribute,
                           relatedBy: .equal,
                           toItem: r_view,
                           attribute: r_view != nil ? attribute : .notAnAttribute,
                           multiplier: 1,
                           constant: constant)
    }
    
    static func contraintsToMakeEdgesEqualBetween(_ l_view:UIView, _ r_view:UIView) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(attribute: .leading, ofView: l_view, equalToView: r_view, withConstant: 0),
            NSLayoutConstraint(attribute: .trailing, ofView: l_view, equalToView: r_view, withConstant: 0),
            NSLayoutConstraint(attribute: .top, ofView: l_view, equalToView: r_view, withConstant: 0),
            NSLayoutConstraint(attribute: .bottom, ofView: l_view, equalToView: r_view, withConstant: 0)
        ]
    }
    
    static func constraints(withProperties properties:[NSLayoutConstraint.Attribute], forView l_view:UIView, andView r_view:UIView?, withConstant constant:CGFloat = 0) -> [NSLayoutConstraint] {
        
        return properties.map({ (attribute) -> NSLayoutConstraint in
            return NSLayoutConstraint(attribute: attribute,
                                      ofView: l_view,
                                      equalToView: r_view,
                                      withConstant: constant)
        })
        
    }
}

extension UIViewController {
    var sideMenu:SideMenuContainer? {
        //Search for side menu recursively
        if let parent = self.parent {
            if let sideMenu = parent as? SideMenuContainer {
                return sideMenu
            }
            else {
                return parent.sideMenu
            }
        }
        return nil
    }
}

@IBDesignable class SideMenuContainer: UIViewController {
    //MARK: - Properties
    //MARK: Public
    @IBInspectable var leftControllerWidth:CGFloat = 280
    @IBInspectable var animationDuration:Double = 0.5
    
    //MARK: Private
    fileprivate var _leftController:UIViewController?
    fileprivate var _centerController:UIViewController?
    
    fileprivate var _leftControllerLeadingConstraint:NSLayoutConstraint? {
        return self.view.constraints.filter({ $0.firstAttribute == .leading && ($0.firstItem as? UIView) == _leftContainerView }).first
    }
    
    fileprivate lazy var _leftContainerView:UIView = {
        let container = UIView()
        container.isHidden = true
        
        self.view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints(NSLayoutConstraint.constraints(withProperties: [.leading, .top, .bottom],
                                                                forView: container,
                                                                andView: view))
        
        container.addConstraint(NSLayoutConstraint(attribute: .width,
                                                    ofView: container,
                                                    withConstant: leftControllerWidth))
        
        return container
    }()
    
    fileprivate lazy var _centerContainer:UIView = {
        let container = UIView()
        container.isHidden = false
        container.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(container)
        
        view.addConstraints(NSLayoutConstraint.contraintsToMakeEdgesEqualBetween(view, container))
        
        return container
    }()
    
    //MARK: - UIViewController Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let shadowPath = UIBezierPath(rect: _leftContainerView.bounds)
        _leftContainerView.layer.masksToBounds = false
        _leftContainerView.layer.shadowColor = UIColor.black.cgColor
        _leftContainerView.layer.shadowOffset = CGSize(width: 20, height: 0)
        _leftContainerView.layer.shadowOpacity = 0.2
        _leftContainerView.layer.shadowRadius = 20
        _leftContainerView.layer.shadowPath = shadowPath.cgPath
    }
    
    //MARK: - Set Logic
    
    func set(leftController:UIViewController) {
        self._leftController?.view.removeFromSuperview()
        self._leftController?.removeFromParent()
        
        self._leftController = leftController
        self.addChild(leftController)
        
        let childView:UIView = leftController.view
        childView.translatesAutoresizingMaskIntoConstraints = false
        self._leftContainerView.addSubview(childView)
        
        _leftContainerView.addConstraints(NSLayoutConstraint.contraintsToMakeEdgesEqualBetween(childView, _leftContainerView))
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func set(centerController:UIViewController) {
        self._centerController?.view.removeFromSuperview()
        self._centerController?.removeFromParent()
        
        self._centerController = centerController
        self.addChild(centerController)
        
        let childView:UIView = centerController.view
        childView.translatesAutoresizingMaskIntoConstraints = false
        self._centerContainer.addSubview(childView)
        
        _centerContainer.addConstraints(NSLayoutConstraint.contraintsToMakeEdgesEqualBetween(childView, _centerContainer))
        
        self.view.setNeedsLayout()
        
        //Force layout update. It does some weird animation while setting the centerController and animating left controller close at the same time
        self.view.layoutIfNeeded()
    }

    
    //MARK: - Show/Hide Logic
    
    func showLeftController(animated:Bool = true) {
        _centerContainer.isUserInteractionEnabled = false
        _leftContainerView.superview?.bringSubviewToFront(_leftContainerView)
        _leftContainerView.isHidden = false
        
        if let constraint = _leftControllerLeadingConstraint {
            constraint.constant = -_leftContainerView.frame.width
            self.view.layoutIfNeeded()
            
            constraint.constant = 0
            UIView.animate(withDuration: animated ? animationDuration : 0) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func hideLeftController(animated:Bool = true) {
        
        if let constraint = _leftControllerLeadingConstraint {
            constraint.constant = -_leftContainerView.frame.width
            UIView.animate(withDuration: animated ? animationDuration : 0, animations: { [unowned self] in
                self.view.layoutIfNeeded()
            }) {[unowned self] (finished) in
                self._leftContainerView.isHidden = true
                self._centerContainer.isUserInteractionEnabled = true
            }
        }
    }
    
    //MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard _leftContainerView.isHidden == false else { return }
        for touch in touches {
            let location = touch.location(in: _leftContainerView)
            if _leftContainerView.bounds.contains(location) == false {
                self.hideLeftController()
                return
            }
        }
    }

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
