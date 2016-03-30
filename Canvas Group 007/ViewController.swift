//
//  ViewController.swift
//  Canvas Group 007
//
//  Created by Nguyen T Do on 3/30/16.
//  Copyright © 2016 Nguyen Do. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var newlyCreatedFace: UIImageView!
    
    @IBAction func onTrayPanGesture(sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)
        let point = sender.locationInView(trayView)
        let translation = sender.translationInView(trayView)
        let velocity = sender.velocityInView(trayView)
        
        if sender.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = trayView.center
            print("Gesture began at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)

            print("Gesture changed at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: [], animations: { () -> Void in
                if velocity.y > 0 {
                    self.trayView.center = self.trayCenterWhenOpen
                } else {
                    self.trayView.center = self.trayCenterWhenClosed
                }
                
                }, completion: { (Bool) -> Void in
                    print("it works")
            })
        }
        
    }
    
    @IBAction func onTapGesture(sender: UITapGestureRecognizer) {

        if self.trayView.center == self.trayCenterWhenOpen {
            self.trayView.center = self.trayCenterWhenClosed
        } else {
            self.trayView.center = self.trayCenterWhenOpen
        }
    }
    
    @IBAction func onCreatNewFacesPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(sender.view)
        let imageView = sender.view as! UIImageView
        if sender.state == UIGestureRecognizerState.Began {

            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            print(trayView.frame.origin.y)
            print(newlyCreatedFace.center)
            newlyCreatedFace.userInteractionEnabled = true
            
            

        } else if sender.state == UIGestureRecognizerState.Changed {
            
            newlyCreatedFace.center = CGPoint(x: imageView.center.x + trayView.frame.origin.x + translation.x, y: imageView.center.y + translation.y + trayView.frame.origin.y)
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onNewlyCreatedFacePan:")
            
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
        }
    }
    
    func onNewlyCreatedFacePan(sender: UIPanGestureRecognizer) {
        print("Hello")
        var point = sender.locationInView(sender.view)
        var velocity = sender.velocityInView(sender.view)
        var translation = sender.translationInView(sender.view)
        var imageOriginalCenter: CGPoint!
        if sender.state == UIGestureRecognizerState.Began {

            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            newlyCreatedFace.center = CGPoint(x: (sender.view?.center.x)! + translation.x, y: (sender.view?.center.y)! + translation.y)
            print("Gesture changed at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayCenterWhenClosed = trayView.center
        trayCenterWhenOpen = CGPoint(x: trayView.center.x, y:trayView.center.y + 172)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

