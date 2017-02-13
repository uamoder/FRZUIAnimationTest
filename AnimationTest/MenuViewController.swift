//
//  MenuViewController.swift
//  AnimationTest
//
//  Created by Alex Neminsky on 12.02.17.
//  Copyright © 2017 SkaKot. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - Constants
    
    //True if UIAutomatic test, false if UIView base animation
    let isUIDynamicTest = false
    
    // MARK: - Outlets
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var headerMask: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var shareView: UIView!
    
    // MARK: - Variables
    //handle moving
    var startPositionMainView : CGPoint?
    var xDelta: CGFloat?
    var yDelta: CGFloat?
    
    //UIDynamicAnimator test
    var animator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!
    var snapBehavior: UISnapBehavior!

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maskView.addBlur(type: .light)
        headerMask.addBlur(type: .light)
        //popupView.isHidden = false
        popupView.addBlur(type: .light)
        userView.addBlur(type: .light)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimations()
        dinamicAnimator()
    }
    
    // MARK: - Methods
    @IBAction func handleRecognizer(_ sender: UIPanGestureRecognizer) {
        print(sender)
        
        let locationInParent = sender.location(in: view)
        let location = sender.location(in: mainView)
        
        if isUIDynamicTest == true {
            //UIDynamicTest
            switch sender.state {
            case .began:
                startPositionMainView = mainView.center
                animator.removeAllBehaviors()
                let offset = UIOffsetMake(location.x - mainView.bounds.height/2, location.y - mainView.bounds.width/2)
                attachmentBehavior = UIAttachmentBehavior(item: mainView, offsetFromCenter: offset, attachedToAnchor: sender.location(in: view))
                attachmentBehavior.frequency = 0
                animator.addBehavior(attachmentBehavior)
                
            case .changed:
                attachmentBehavior.anchorPoint = locationInParent
                
            case .ended:
                animator.removeBehavior(attachmentBehavior)
                snapBehavior = UISnapBehavior(item: mainView, snapTo: view.center)
                snapBehavior.damping = 0
                
                animator.addBehavior(snapBehavior)
            default:
                print(mainView.center)
            }
        } else {
            //base animation
            
            switch sender.state {
            case .began:
                startPositionMainView = mainView.center
                let location = sender.location(in: mainView)
                //до центра - поправка
                xDelta = location.x - mainView.bounds.width / 2
                yDelta = location.y - mainView.bounds.height / 2
            
            case .changed:
                
                mainView.center = CGPoint(x: locationInParent.x - xDelta!, y: locationInParent.y - yDelta!)
                
            
            case .ended:
                UIView.animate(withDuration: 0.2, animations: {
                    self.mainView.center = self.startPositionMainView!
                    }, completion: { (isCompleted) in
                        self.startPositionMainView = nil
                })
                        
            default:
                print(mainView.center)
                }
            
        }

        
    }
    
    
    // MARK: - 
    
    func startAnimations() {
        
        let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let translate = CGAffineTransform(translationX: 0, y: -300)
        
        mainView.transform = scale.concatenating(translate)
        
        UIView.animate(withDuration: 2, animations: {
            let scale = CGAffineTransform(scaleX: 1, y: 1)
            let translate = CGAffineTransform(translationX: 0, y: 0)
            
            self.mainView.transform = scale.concatenating(translate)
        })
    }
    
    func dinamicAnimator() {
        
        animator = UIDynamicAnimator(referenceView: view)
        
    }



}
