//
//  File.swift
//  SwiftDrawing
//
//  Created by Kyle Adams on 09/09/14.
//  Copyright (c) 2014 Kyle Adams. All rights reserved.
//

import UIKit

class SwiftDrawView: UIView {
    private var firstTimeCache = true
    private var path = UIBezierPath()
    private var cache = UIImage()
    
    private var pts = [CGPointZero, CGPointZero, CGPointZero, CGPointZero]
    private var ctr: Int!
    
    var lineWidth: CGFloat = 1.0
    var lineColor = UIColor.blackColor()
    var eraserMode = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = UIColor.whiteColor()
        opaque = false
    }
    
    override func drawRect(rect: CGRect) {
        backgroundColor = nil
        opaque = false
        cache.drawInRect(rect)
        path.lineWidth = lineWidth
        path.lineCapStyle = kCGLineCapRound
        if eraserMode {
            UIColor.whiteColor().setStroke()
            path.strokeWithBlendMode(kCGBlendModeClear, alpha: 1.0)
        } else {
            lineColor.setStroke()
            path.stroke()
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        ctr = 0
        var touch = touches.anyObject() as UITouch
        pts[0] = touch.locationInView(self)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        var p = touch.locationInView(self)
        ctr = ctr + 1
        pts[ctr] = p
        if  (ctr == 3) {
            pts[2] = CGPointMake((pts[1].x + pts[3].x)/2.0, (pts[1].y + pts[3].y)/2.0);
            path.moveToPoint(pts[0])
            path.addQuadCurveToPoint(pts[2], controlPoint: pts[1])
            setNeedsDisplay()
            pts[0] = pts[2]
            pts[1] = pts[3]
            ctr = 1
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if (ctr == 0)
        {
            //path.addArcWithCenter(pts[0], radius: 1, startAngle: 0, endAngle: CGFloat(M_PI) * 2, clockwise: true)
            var magicNumber = lineWidth / 6
            path = UIBezierPath(roundedRect: CGRectMake(pts[0].x, pts[0].y, magicNumber, magicNumber), cornerRadius: magicNumber / 2)
        }
        else if (ctr == 1)
        {
            path.moveToPoint(pts[0])
            path.addLineToPoint(pts[1])
        }
        else if (ctr == 2)
        {
            path.moveToPoint(pts[0])
            path.addQuadCurveToPoint(pts[2], controlPoint: pts[1])
        }
        if !eraserMode {
            drawBitmap()
        } else {
            eraseBitmap()
        }
        setNeedsDisplay()
        path.removeAllPoints()
        ctr = 0;
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        touchesEnded(touches, withEvent: event)
    }
    
    func drawBitmap() {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        
        lineColor.setStroke()
        path.lineWidth = lineWidth
        path.lineCapStyle = kCGLineCapRound
        if (firstTimeCache) {
            var rectPath = UIBezierPath(rect: bounds)
            UIColor.whiteColor().setFill()
            rectPath.fill()
            firstTimeCache = false
        }
        
        cache.drawAtPoint(CGPointZero)
        path.stroke()
        
        cache = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func eraseBitmap() {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        cache.drawAtPoint(CGPointZero)
        path.strokeWithBlendMode(kCGBlendModeClear, alpha: 1.0)
        cache = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
