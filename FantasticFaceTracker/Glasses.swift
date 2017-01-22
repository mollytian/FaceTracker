//
//  Glasses.swift
//  FantasticFaceTracker
//
//  Created by Mengyuan Tian on 10/10/16.
//  Copyright © 2016 Mengyuan Tian. All rights reserved.
//

import UIKit
import FaceTracker

class Glasses: Accessory {
    var leftEye : [CGPoint] = []
    var rightEye : [CGPoint] = []
    
    final var eyesCornerDistance : CGFloat {
        return sqrt(pow(leftEye[0].x - rightEye[5].x, 2) + pow(leftEye[0].y - rightEye[5].y, 2))
    }
    
    final var eyesCenter : CGPoint {
        return CGPoint(x: (leftEye[0].x + rightEye[5].y) / 2,
                       y: (leftEye[0].y + rightEye[5].y) / 2 )
    }
    
    final var eyesAngulation : CGFloat {
        return atan2(rightEye[5].y - leftEye[0].y, rightEye[5].x - leftEye[0].x)
    }
    
    init()
    {
        super.init(imageNamed: "glasses")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func injectPoints(points: FacePoints?) {
        super.injectPoints(points)
        
        self.leftEye = points?.leftEye ?? []
        self.rightEye = points?.rightEye ?? []
    }
    
    override func updatePosition()
    {
        super.updatePosition()
        
        let width = eyesCornerDistance * 1.3
        let height = (imageSize.height / imageSize.width) * width
        
        self.transform = CGAffineTransformIdentity
        self.frame = CGRect(x: eyesCenter.x,
                            y: eyesCenter.y,
                            width: width,
                            height: height)
        
        self.center = eyesCenter
        
        self.transform = CGAffineTransformMakeRotation(eyesAngulation)
    }

}
