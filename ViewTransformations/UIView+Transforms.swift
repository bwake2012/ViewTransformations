//
//  UIView+Transforms.swift
//  ViewTransformations
//
//  Created by Bob Wakefield on 6/11/17.
//  Copyright © 2017 Bob Wakefield. All rights reserved.
//

import UIKit

extension UIView {
    
    var xscale: CGFloat
    {
        let t = self.transform
        return sqrt(t.a * t.a + t.c * t.c)
    }
    
    var yscale: CGFloat
    {
        let t = self.transform
        return sqrt(t.b * t.b + t.d * t.d)
    }
    
    var rotation: CGFloat
    {
        let t = self.transform
        return CGFloat(atan2f(Float(t.b), Float(t.a)))
    }
    
    var tx: CGFloat
    {
        let t = self.transform
        return t.tx
    }
    
    var ty: CGFloat
    {
        let t = self.transform
        return t.ty
    }
}

extension UIView {
    
    // Coordinate utilities
    func offsetPointToParentCoordinates( aPoint: CGPoint ) -> CGPoint
    {
        return CGPoint( x: aPoint.x + self.center.x, y: aPoint.y + self.center.y )
    }
    
    func pointInViewCenterTerms( aPoint: CGPoint ) -> CGPoint
    {
        return CGPoint( x: aPoint.x - self.center.x, y: aPoint.y - self.center.y )
    }
    
    func pointInTransformedView( aPoint: CGPoint ) -> CGPoint
    {
        let offsetItem = self.pointInViewCenterTerms( aPoint: aPoint )
        let updatedItem = offsetItem.applying( self.transform )
        let finalItem = self.offsetPointToParentCoordinates( aPoint: updatedItem )
        return finalItem
    }
    
    var originalFrame: CGRect
    {
        let currentTransform = self.transform
        self.transform = CGAffineTransform.identity
        let originalFrame = self.frame
        self.transform = currentTransform
        
        return originalFrame
    }
    
    // These four methods return the positions of view elements
    // with respect to the current transform
    
    func transformedTopLeft()  -> CGPoint
    {
        let frame: CGRect = self.originalFrame
        let point = frame.origin
        return self.pointInTransformedView( aPoint: point )
    }
    
    func transformedTopRight() -> CGPoint
    {
        let frame: CGRect = self.originalFrame
        var point = frame.origin
        point.x += frame.size.width
        return self.pointInTransformedView( aPoint: point )
    }
    
    func transformedBottomRight() -> CGPoint
    {
        let frame: CGRect = self.originalFrame
        var point = frame.origin
        point.x += frame.size.width
        point.y += frame.size.height
        return self.pointInTransformedView( aPoint: point )
    }
    
    func transformedBottomLeft() -> CGPoint
    {
        let frame: CGRect = self.originalFrame
        var point = frame.origin
        point.y += frame.size.height
        return self.pointInTransformedView( aPoint: point )
    }
}
