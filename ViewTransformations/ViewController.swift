//
//  ViewController.swift
//  ViewTransformations
//
//  Created by Bob Wakefield on 6/11/17.
//  Copyright © 2017 Bob Wakefield. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var transformedView: UIView!
    
    @IBOutlet weak var scaleHorizontal: UISlider!
    @IBOutlet weak var scaleVertical: UISlider!
    @IBOutlet weak var scaleBoth: UISlider!
    @IBOutlet weak var rotation: UISlider!
    @IBOutlet weak var translateX: UISlider!
    @IBOutlet weak var translateY: UISlider!
    @IBOutlet weak var translateBoth: UISlider!

    @IBAction func didScaleHorizontal(_ sender: UISlider) {

        scaleHorizontalValue.text = String( sender.value )
        
        translate()
    }

    @IBAction func didScaleVertical(_ sender: UISlider) {
        
        scaleVerticalValue.text = String( sender.value )
        
        translate()
    }
    
    @IBAction func didScaleBoth(_ sender: UISlider) {
        
        scaleHorizontal.value = sender.value
        scaleVertical.value = sender.value

        scaleHorizontalValue.text = String( sender.value )
        scaleVerticalValue.text = String( sender.value )
        
        translate()
    }
    
    @IBAction func didRotate(_ sender: UISlider) {
        
        rotationValue.text = String( sender.value )
        
        translate()
    }
    
    @IBAction func didTranslateX(_ sender: UISlider) {
        
        translateXValue.text = String( sender.value )
        
        translate()
    }
    
    @IBAction func didTranslateY(_ sender: UISlider) {
        
        translateYValue.text = String( sender.value )
        
        translate()
    }
    
    @IBAction func didTranslateBoth(_ sender: UISlider) {
        
        translateX.value = sender.value
        translateY.value = sender.value

        translateXValue.text = String( sender.value )
        translateYValue.text = String( sender.value )
        
        translate()
    }
    
    @IBOutlet weak var scaleHorizontalValue: UILabel!
    @IBOutlet weak var scaleVerticalValue: UILabel!

    @IBOutlet weak var rotationValue: UILabel!

    @IBOutlet weak var translateXValue: UILabel!
    @IBOutlet weak var translateYValue: UILabel!
    
    func makeTransform( xScale: CGFloat, yScale: CGFloat, theta: CGFloat, tx: CGFloat, ty: CGFloat ) -> CGAffineTransform
    {
        var transform = CGAffineTransform.identity;
        
        transform.a = xScale * cos(theta);
        transform.b = yScale * sin(theta);
        transform.c = xScale * -sin(theta);
        transform.d = yScale * cos(theta);
        transform.tx = tx;
        transform.ty = ty;
        
        return transform;
    }

    func translate() {
        
        let scaleX = 1.0 + CGFloat( self.scaleHorizontal.value )
        let scaleY = 1.0 + CGFloat( self.scaleVertical.value )
        
        let theta = CGFloat( self.rotation.value )
        
        let translateX = CGFloat( self.translateX.value )
        let translateY = CGFloat( self.translateY.value )
        
        let transform = makeTransform( xScale: scaleX, yScale: scaleY, theta: theta, tx: translateX, ty: translateY )
        
        transformedView.transform = transform
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        transformedView.translatesAutoresizingMaskIntoConstraints = false
        
        scaleHorizontal.value = 0
        scaleVertical.value = 0
        scaleBoth.value = 0
        rotation.value = 0
        translateX.value = 0
        translateY.value = 0
        translateBoth.value = 0
        
        scaleHorizontalValue.text = String( Int64( transformedView.xscale ) )
        scaleVerticalValue.text = String( Int64( transformedView.yscale ) )
        
        rotationValue.text = String( Int64( transformedView.rotation ) )
        
        translateXValue.text = String( Int64( transformedView.tx ) )
        translateYValue.text = String( Int64( transformedView.ty ) )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        translateX.minimumValue = -Float( self.displayView.bounds.width / 2 )
        translateX.maximumValue = Float( self.displayView.bounds.width / 2 )
        
        translateY.minimumValue = -Float( self.displayView.bounds.height / 2 )
        translateY.maximumValue = Float( self.displayView.bounds.height / 2 )
    }
}

