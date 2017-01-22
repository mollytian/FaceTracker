//
//  Mustache.swift
//  FantasticFaceTracker
//
//  Created by Mengyuan Tian on 10/16/16.
//  Copyright © 2016 Mengyuan Tian. All rights reserved.
//

import UIKit
import FaceTracker

class Mustache: Accessory {
    var nose : [CGPoint] = []
    var outerMouth: [CGPoint] = []
    
    final var mustacheCornerDistance : CGFloat {
//        print("6 - \(outerMouth[6]) ")
//        print("7 - \(outerMouth[7]) ")
//        print("8 - \(outerMouth[8]) ")
        return sqrt(pow(outerMouth[0].x - outerMouth[6].x, 2) + pow(outerMouth[0].y - outerMouth[6].y, 2))
    }
    
    final var mustacheCenter : CGPoint {
        return CGPoint(x: nose[3].x, y:  (outerMouth[3].y + nose[3].y) / 2)
    }
    
    final var mustacheAngulation : CGFloat {
        // same as nose
        return atan2(nose[6].y - nose[0].y, nose[6].x - nose[0].x)
    }
    
    init()
    {
        super.init(imageNamed: "mustache")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func injectPoints(points: FacePoints?) {
        super.injectPoints(points)
        self.nose = points?.nose ?? []
        self.outerMouth = points?.outerMouth ?? []
    }
    
    override func updatePosition()
    {
        super.updatePosition()
        
        let width = mustacheCornerDistance * 1.3
        let height = (imageSize.height / imageSize.width) * width
        
        self.transform = CGAffineTransformIdentity
        self.frame = CGRect(x: mustacheCenter.x - width / 2,
                            y: mustacheCenter.y - height / 1.3,
                            width: width,
                            height: height)

        self.transform = CGAffineTransformMakeRotation(mustacheAngulation)
        
    }
 
}