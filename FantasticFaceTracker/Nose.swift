//
//  Nose.swift
//  FantasticFaceTracker
//
//  Created by Mengyuan Tian on 10/10/16.
//  Copyright © 2016 Mengyuan Tian. All rights reserved.
//

import UIKit
import FaceTracker

class Nose: Accessory
{
    
    var nose : [CGPoint] = []
    
    final var noseCornerDistance : CGFloat {
        return sqrt(pow(nose[0].x - nose[6].x, 2) + pow(nose[0].y - nose[6].y, 2))
    }
    
    final var noseCenter : CGPoint {
        return nose[3]
    }
    
    final var noseAngulation : CGFloat {
        return atan2(nose[6].y - nose[0].y, nose[6].x - nose[0].x)
    }
    
    init()
    {
        super.init(imageNamed: "nose")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func injectPoints(points: FacePoints?) {
        super.injectPoints(points)
        self.nose = points?.nose ?? []
    }
    
    override func updatePosition()
    {
        super.updatePosition()
        
        let width = noseCornerDistance * 1.3
        let height = width
        
        self.transform = CGAffineTransformIdentity
        self.frame = CGRect(x: noseCenter.x - width / 2,
                            y: noseCenter.y - height / 1.3,
                            width: width,
                            height: height)
        
        self.transform = CGAffineTransformMakeRotation(noseAngulation)
        
    }
}

