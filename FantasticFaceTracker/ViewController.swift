//
//  ViewController.swift
//  FantasticFaceTracker
//
//  Created by Mengyuan Tian on 10/9/16.
//  Copyright © 2016 Mengyuan Tian. All rights reserved.
//

import UIKit
import FaceTracker

class ViewController: UIViewController {

    weak var faceTrackerViewController: FaceTrackerViewController?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    var accessories : [Accessory] = [] {
        willSet {
            for accessory in accessories {
                accessory.removeFromSuperview()
            }
        }
        
        didSet {
            for accessory in accessories {
                self.view.addSubview(accessory)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        print( contentView.frame.size)
        
        scrollView.contentSize = contentView.frame.size
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "faceTrackerEmbed") {
            faceTrackerViewController = segue.destinationViewController as? FaceTrackerViewController
            faceTrackerViewController!.delegate = self
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        faceTrackerViewController!.startTracking { () -> Void in
            
        } // completion closure
    }

    @IBAction func addNose(sender: UIButton) {
        for (index, acessory) in accessories.enumerate() {
            if acessory is Nose {
                accessories.removeAtIndex(index)
                return
            }
        }
        accessories.append(Nose())
    }
    
    @IBAction func addGlasses(sender: AnyObject) {
        for (index, acessory) in accessories.enumerate() {
            if acessory is Glasses {
                accessories.removeAtIndex(index)
                return
            }
        }
        accessories.append(Glasses())
    }
    
    @IBAction func addMustache(sender: UIButton) {
        for (index, acessory) in accessories.enumerate() {
            if acessory is Mustache {
                accessories.removeAtIndex(index)
                return
            }
        }
        accessories.append(Mustache())
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    private func updateMinZoomScaleForSize(size: CGSize) {1
        
        scrollView.minimumZoomScale = 1
        
        scrollView.zoomScale = 1
    }
}



extension ViewController : FaceTrackerViewControllerDelegate
{
    func faceTrackerDidUpdate(points: FacePoints?) {
        if let points = points {
            for accessory in accessories {
                accessory.injectPoints(points)
                accessory.updatePosition()
                accessory.hidden = false
            }
            
            return
        }
        
        for accessory in accessories {
            accessory.hidden = true
        }
    }
}


extension ViewController: UIScrollViewDelegate {
//    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
//        return contentView
//    }
}


