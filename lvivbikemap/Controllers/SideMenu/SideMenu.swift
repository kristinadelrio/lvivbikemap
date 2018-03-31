//
//  SideMenuController.swift
//  ForgetMeNot
//
//  Created by Kristina Del Rio Albrechet on 11/6/17.
//  Copyright © 2017 Sergii Tarasov. All rights reserved.
//

import UIKit

let kSideMenuWidth: CGFloat = 270.0
let kContentViewOpacity: CGFloat = 0.1
let kAnimationDuration: Double = 0.4
let kPointOfNoReturnWidth: CGFloat = 50.0
let kOpacityViewBackgroundColor: UIColor = .black

open class SideMenu: UIViewController {
    
    enum SideAction {
        case open
        case close
    }
    
    enum TrackAction {
        case sideMenuTapOpen
        case sideMenuTapClose
        case sideMenuFlickOpen
        case sideMenuFlickClose
    }
    
    struct PanInfo {
        var action: SideAction
        var shouldBounce: Bool
        var velocity: CGFloat
    }
    
    open var opacityView = UIView()
    open var mainContainerView = UIView()
    open var sideContainerView = UIView()
    
    open var mainViewController: UIViewController?
    open var sideViewController: UIViewController?
    
    open var panGesture: UIPanGestureRecognizer?
    open var tapGesture: UITapGestureRecognizer?
    
    // MARK: Lifecycle
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public convenience init(with mainViewController: UIViewController, and sideMenuController: UIViewController) {
        self.init()
        
        self.mainViewController = mainViewController
        sideViewController = sideMenuController
        initViews()
        
    }
    
    fileprivate func initViews() {
        mainContainerView = UIView(frame: view.bounds)
        mainContainerView.backgroundColor = .clear
        mainContainerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.insertSubview(mainContainerView, at: 0)
        
        opacityView = UIView(frame: view.bounds)
        opacityView.backgroundColor = kOpacityViewBackgroundColor
        opacityView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        opacityView.layer.opacity = 0.0
        view.insertSubview(opacityView, at: 1)
        
        var leftFrame: CGRect = view.bounds
        leftFrame.size.width = kSideMenuWidth
        leftFrame.origin.x = leftMinOrigin()
        
        sideContainerView = UIView(frame: leftFrame)
        sideContainerView.backgroundColor = .clear
        sideContainerView.autoresizingMask = .flexibleHeight
        view.insertSubview(sideContainerView, at: 2)
        addGestures()
    }
    
    fileprivate func addGestures() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture?.delegate = self
        view.addGestureRecognizer(panGesture!)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSideMenu))
        tapGesture?.delegate = self
        view.addGestureRecognizer(tapGesture!)
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        sideContainerView.isHidden = true
        coordinator.animate(alongsideTransition: nil, completion: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.closeSideMenuNonAnimation()
            self.sideContainerView.isHidden = false
        })
    }
    
    open override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if isSideMenuOpen() {
            closeSideMenu(with: 0.0)
        }
        
        mainViewController?.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setUpViewController(mainContainerView, targetViewController: mainViewController)
        setUpViewController(sideContainerView, targetViewController: sideViewController)
    }
    
    // MARK: Open/Close sideMenu
    
    open func openSideMenu() {
    
        sideViewController?.beginAppearanceTransition(!isSideMenuOpen(), animated: true)
        setWindowLevel(UIWindowLevelStatusBar)
        openSideMenu(with: 0.0)
    }
    
    open func closeSideMenu() {
        sideViewController?.beginAppearanceTransition(!isSideMenuOpen(), animated: true)
        setWindowLevel(UIWindowLevelNormal)
        closeSideMenu(with: 0.0)
    }
    
    fileprivate func setWindowLevel(_ level: UIWindowLevel) {
        DispatchQueue.main.async(execute: {
            if let window = UIApplication.shared.keyWindow {
                window.windowLevel = level
            }
        })
    }

    @objc open func toggleSideMenu() {
        if isSideMenuOpen() {
            closeSideMenu()
            setWindowLevel(UIWindowLevelNormal)
        } else {
            openSideMenu()
        }
    }
    
    open func isSideMenuOpen() -> Bool {
        return sideViewController != nil && sideContainerView.frame.origin.x == 0.0
    }
    
    open func closeSideMenuNonAnimation() {
        setWindowLevel(UIWindowLevelNormal)
        sideContainerView.frame.origin.x = leftMinOrigin()
        opacityView.layer.opacity = 0.0
        removeShadow(sideContainerView)
        isUserInteractionEnabled(true)
    }
    
    open func openSideMenu(with velocity: CGFloat) {
        let finalXOrigin: CGFloat = 0.0
        var frame = sideContainerView.frame
        frame.origin.x = finalXOrigin
    
        addShadowToView(sideContainerView)
        
        let duration = getDuration(with: velocity, finalXOrigin: finalXOrigin)
        UIView.animate(withDuration: duration, delay: 0.0, options: [], animations: { [weak self] ()->() in
            self?.sideContainerView.frame = frame
            self?.opacityView.layer.opacity = Float(kContentViewOpacity)
            
        }) { [weak self] (Bool)->() in
            self?.isUserInteractionEnabled(false)
            self?.sideViewController?.endAppearanceTransition()
        }
    }
    
    open func closeSideMenu(with velocity: CGFloat) {
        let finalXOrigin: CGFloat = leftMinOrigin()
        var frame: CGRect = sideContainerView.frame
        frame.origin.x = finalXOrigin
        
        let duration = getDuration(with: velocity, finalXOrigin: finalXOrigin)
        UIView.animate(withDuration: duration, animations: { [weak self]() -> Void in
            self?.sideContainerView.frame = frame
            self?.opacityView.layer.opacity = 0.0
            
        }) { [unowned self] (finish) -> Void in
            self.removeShadow(self.sideContainerView)
            self.isUserInteractionEnabled(true)
            self.sideViewController?.endAppearanceTransition()
        }
    }
    
    fileprivate func getDuration(with velocity: CGFloat, finalXOrigin: CGFloat) -> TimeInterval {
        var duration = kAnimationDuration
        if velocity != 0.0 {
            duration = Double(fabs(sideContainerView.frame.origin.x - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        return duration
    }
    
    fileprivate func leftMinOrigin() -> CGFloat {
        return  -kSideMenuWidth
    }
    
    // MARK: View configuration
    
    fileprivate func getOpenedLeftRatio() -> CGFloat {
        let width: CGFloat = sideContainerView.frame.size.width
        let currentPosition: CGFloat = sideContainerView.frame.origin.x - leftMinOrigin()
        return currentPosition / width
    }
    
    fileprivate func applyLeftOpacity() {
        let openedLeftRatio: CGFloat = getOpenedLeftRatio()
        let opacity: CGFloat = kContentViewOpacity * openedLeftRatio
        opacityView.layer.opacity = Float(opacity)
    }
    
    fileprivate func addShadowToView(_ targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = false
        targetContainerView.layer.shadowPath = UIBezierPath(rect: targetContainerView.bounds).cgPath
    }
    
    fileprivate func removeShadow(_ targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = true
        mainContainerView.layer.opacity = 1.0
    }
    
    fileprivate func isUserInteractionEnabled(_ state: Bool) {
        mainContainerView.isUserInteractionEnabled = state
    }
    
    // MARK: ViewControllers
    
    open func changeMainViewController(_ mainViewController: UIViewController,  close: Bool) {
        if (mainViewController != self.mainViewController) {
            removeViewController(self.mainViewController)
            self.mainViewController = mainViewController
            setUpViewController(mainContainerView, targetViewController: mainViewController)
        }
        
        if close {
            closeSideMenu()
        }
    }
    
    fileprivate func setUpViewController(_ targetView: UIView, targetViewController: UIViewController?) {
        if let viewController = targetViewController {
            viewController.view.frame = targetView.bounds
            
            if (!childViewControllers.contains(viewController)) {
                addChildViewController(viewController)
                targetView.addSubview(viewController.view)
                viewController.didMove(toParentViewController: self)
            }
        }
    }
    
    fileprivate func removeViewController(_ viewController: UIViewController?) {
        viewController?.view.layer.removeAllAnimations()
        viewController?.willMove(toParentViewController: nil)
        viewController?.view.removeFromSuperview()
        viewController?.removeFromParentViewController()
    }
}

// MARK: Gesture handling

extension SideMenu: UIGestureRecognizerDelegate {
    
    struct PanState {
        static var frameAtStartOfPan: CGRect = CGRect.zero
        static var startPointOfPan: CGPoint = CGPoint.zero
        static var wasOpenAtStartOfPan: Bool = false
        static var wasHiddenAtStartOfPan: Bool = false
        static var lastState: UIGestureRecognizerState = .ended
    }
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let point: CGPoint = touch.location(in: view)
        
        if gestureRecognizer == panGesture {
            return true
        } else {
            return isSideMenuOpen() && !isPointContainedWithinLeftRect(point)
        }
    }
    
    fileprivate func isPointContainedWithinLeftRect(_ point: CGPoint) -> Bool {
        return sideContainerView.frame.contains(point)
    }
    
    @objc func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .began:
            PanState.frameAtStartOfPan = sideContainerView.frame
            PanState.startPointOfPan = panGesture.location(in: view)
            PanState.wasOpenAtStartOfPan = isSideMenuOpen()
            PanState.wasHiddenAtStartOfPan = !isSideMenuOpen()
            
            sideViewController?.beginAppearanceTransition(PanState.wasHiddenAtStartOfPan, animated: true)
            addShadowToView(sideContainerView)
            setWindowLevel(UIWindowLevelStatusBar)
            
        case .changed:
            let translation: CGPoint = panGesture.translation(in: panGesture.view!)
            sideContainerView.frame = applySideMenuTranslation(translation, toFrame: PanState.frameAtStartOfPan)
            applyLeftOpacity()
            
        case .ended, .cancelled:
            if PanState.lastState != .changed {
                setWindowLevel(UIWindowLevelNormal)
                return
            }
            
            let velocity:CGPoint = panGesture.velocity(in: panGesture.view)
            let panInfo: PanInfo = panResultInfoForVelocity(velocity)
            
            if panInfo.action == .open {
                if !PanState.wasHiddenAtStartOfPan {
                    sideViewController?.beginAppearanceTransition(true, animated: true)
                }
                openSideMenu(with: panInfo.velocity)
                
            } else {
                if PanState.wasHiddenAtStartOfPan {
                    sideViewController?.beginAppearanceTransition(false, animated: true)
                }
                closeSideMenu(with: panInfo.velocity)
                setWindowLevel(UIWindowLevelNormal)
            }
        default:
            break
        }
        
        PanState.lastState = panGesture.state
    }
    
    fileprivate func panResultInfoForVelocity(_ velocity: CGPoint) -> PanInfo {
        let thresholdVelocity: CGFloat = 1000.0
        let pointOfNoReturn: CGFloat = CGFloat(floor(leftMinOrigin())) + kPointOfNoReturnWidth
        let leftOrigin: CGFloat = sideContainerView.frame.origin.x
        
        var panInfo: PanInfo = PanInfo(action: .close, shouldBounce: false, velocity: 0.0)
        
        panInfo.action = leftOrigin <= pointOfNoReturn ? .close : .open
        
        if velocity.x >= thresholdVelocity {
            panInfo.action = .open
            panInfo.velocity = velocity.x
            
        } else if velocity.x <= (-1.0 * thresholdVelocity) {
            panInfo.action = .close
            panInfo.velocity = velocity.x
        }
        
        return panInfo
    }
    
    fileprivate func applySideMenuTranslation(_ translation: CGPoint, toFrame:CGRect) -> CGRect {
        var newOrigin: CGFloat = toFrame.origin.x
        newOrigin += translation.x
        
        let minOrigin: CGFloat = leftMinOrigin()
        let maxOrigin: CGFloat = 0.0
        var newFrame: CGRect = toFrame
        
        if newOrigin < minOrigin {
            newOrigin = minOrigin
        } else if newOrigin > maxOrigin {
            newOrigin = maxOrigin
        }
        
        newFrame.origin.x = newOrigin
        return newFrame
    }
}
