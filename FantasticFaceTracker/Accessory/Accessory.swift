//
//  Accessory.swift
//  FantasticFaceTracker
//
//  Created by Mengyuan Tian on 10/10/16.
//  Copyright © 2016 Mengyuan Tian. All rights reserved.
//

import UIKit
import FaceTracker

class Accessory: UIImageView, AccessoryProtocol {
    
    var imageSize : CGSize
    {
        guard let _ = self.image else {
            return CGSize(width: 0, height: 0)
        }
        
        return CGSize(width: self.image!.size.width, height: self.image!.size.height)
    }
    
    init(imageNamed:String) {
        super.init(image: UIImage(named: imageNamed))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func injectPoints(points: FacePoints?) {}
    
    func updatePosition() {}

}


protocol AccessoryProtocol
{
    func injectPoints(points:FacePoints?)
    func updatePosition()
}