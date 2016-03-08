//
//  ViewController.swift
//  FacialRecognition
//
//  Created by Melinda Po and Deepa Krishnan on 2015/11/20.
//  Copyright (c) 2015 Melinda Po and Deepa Krishnan. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    
    
    @IBOutlet var imageView : UIImageView!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ciImage  = CIImage(CGImage:imageView.image!.CGImage!)
        let ciDetector = CIDetector(ofType:CIDetectorTypeFace
            ,context:nil
            ,options:[
                CIDetectorAccuracy:CIDetectorAccuracyHigh,
                CIDetectorSmile:false
            ]
        )
        let features = ciDetector.featuresInImage(ciImage) as! [CIFaceFeature]
        
    
//        public class CIRectangleFeature : CIFeature {
//
//            public var bounds: CGRect { get }
//            public var topLeft: CGPoint { get }
//            public var topRight: CGPoint { get }
//            public var bottomLeft: CGPoint { get }
//            public var bottomRight: CGPoint { get }
//        }
        
        UIGraphicsBeginImageContext(imageView.image!.size)
        imageView.image!.drawInRect(CGRectMake(0,0,imageView.image!.size.width,imageView.image!.size.height))
        
        for feature in features{
            
            //context
            let drawCtxt = UIGraphicsGetCurrentContext()
            
            //face
            let faceRect = (feature).bounds
            CGContextSetStrokeColorWithColor(drawCtxt, UIColor.clearColor().CGColor)
            CGContextStrokeRect(drawCtxt,faceRect)
            
            //mouth
            if((feature.hasMouthPosition)){
                let mouthRectY = imageView.image!.size.height - feature.mouthPosition.y
                let mouthRect  = CGRectMake(feature.mouthPosition.x - 5,mouthRectY - 5,10,10)
                CGContextSetStrokeColorWithColor(drawCtxt,UIColor.clearColor().CGColor)
                CGContextStrokeRect(drawCtxt,mouthRect)
            }

            //IMAGE OVER MOUTH
            let mustacheImg      = UIImage(named:"mustache_100.png")
            let mouthRectY = imageView.image!.size.height - feature.mouthPosition.y
            let mustacheWidth  = faceRect.size.width * 3/5
            let mustacheHeight = mustacheWidth * 0.3
            let mustacheRect  = CGRectMake(feature.mouthPosition.x - mustacheWidth/2,mouthRectY - mustacheHeight/2,mustacheWidth,mustacheHeight)
            CGContextDrawImage(drawCtxt,mustacheRect,mustacheImg!.CGImage)
//            
//            //IMAGE OVER EYES
//            let higeImg = UIImage(named:"glasses.png")
//            let eyeRect = imageView.image!.size.height - feature.rightEyePosition.y
//            let higeWidth  = faceRect.size.width * 0.8
//            print("Eye Image Width \(higeWidth)")
//            let higeHeight = higeWidth * 0.3
//            print("Eye Image Height \(higeHeight)")
//            let higeRect  = CGRectMake(feature.mouthPosition.x - higeWidth/2,eyeRect - higeHeight/2,higeWidth,higeHeight)
//            CGContextDrawImage(drawCtxt,higeRect,higeImg!.CGImage)
//
//            //IMAGE OVER EYES
//            let higeImg = UIImage(named:"hat.png")
//            let eyeRect = imageView.image!.size.height - feature.rightEyePosition.y
//            let higeWidth  = faceRect.size.width
//            print("Eye Image Width \(higeWidth)")
//            let higeHeight = higeWidth * 0.2
//            print("Eye Image Height \(higeHeight)")
//            let higeRect  = CGRectMake(feature.mouthPosition.x - higeWidth/2,eyeRect - higeHeight/2,higeWidth,higeHeight)
//            CGContextDrawImage(drawCtxt,higeRect,higeImg!.CGImage)

//            //leftEye
//            if((feature.hasLeftEyePosition)){
//                let leftEyeRectY = imageView.image!.size.height - feature.leftEyePosition.y
//                let leftEyeRect  = CGRectMake(feature.leftEyePosition.x - 5,leftEyeRectY - 5,10,10)
//                CGContextSetStrokeColorWithColor(drawCtxt, UIColor.blueColor().CGColor)
//                CGContextStrokeRect(drawCtxt,leftEyeRect)
//            }

//            //rightEye
//            if((feature.hasRightEyePosition)){
//                let rightEyeRectY = imageView.image!.size.height - feature.rightEyePosition.y
//                let rightEyeRect  = CGRectMake(feature.rightEyePosition.x - 5,rightEyeRectY - 5,10,10)
//                CGContextSetStrokeColorWithColor(drawCtxt, UIColor.blueColor().CGColor)
//                CGContextStrokeRect(drawCtxt,rightEyeRect)
//            }
            
        }
        
        
        /**Make sure the image is drawn onto the picture**/
        
        let drawImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        imageView.image = drawImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

