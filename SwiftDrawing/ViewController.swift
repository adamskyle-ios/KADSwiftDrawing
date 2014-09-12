//
//  ViewController.swift
//  SwiftDrawing
//
//  Created by Kyle Adams on 09/09/14.
//  Copyright (c) 2014 Kyle Adams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let toolbarHeight: CGFloat = 64.0
    
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var colorButton: UIBarButtonItem!
    @IBOutlet weak var widthButton: UIBarButtonItem!
    @IBOutlet weak var eraseButton: UIBarButtonItem!
    
    //declare SwiftDrawView variable, we promise the compiler it will actually be a SwiftDrawView
    var drawingView: SwiftDrawView!
    let maximumLineWidthValueForSlider: Float = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //instatiate the SwiftDrawView, as promised (;
        let drawViewFrame = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height - toolbarHeight)
        drawingView = SwiftDrawView(frame: drawViewFrame)
        
        //set linewidth value and then the drawingview linewidth
        //if you've changed the maximumLineWidthValueForSlider constant, consider playing around with the setValue() method
        widthSlider.maximumValue = maximumLineWidthValueForSlider
        widthSlider.setValue(maximumLineWidthValueForSlider / 4, animated: true)
        drawingView.lineWidth = CGFloat(widthSlider.value)
        
        //finally, add as subview: enjoy!
        view.addSubview(drawingView)
    }
    
    @IBAction func eraserPressed(sender: AnyObject) {
        drawingView.eraserMode = drawingView.eraserMode ? false : true
        eraseButton.tintColor = drawingView.eraserMode ? UIColor.redColor() : view.tintColor
    }
    
    @IBAction func sliderMoved(sender: UISlider) {
        drawingView.lineWidth = CGFloat(sender.value)
    }
    
    @IBAction func unwindFromColorSelection(segue: UIStoryboardSegue!) {
        var colorSegue: ColorSelectionViewController = segue.sourceViewController as ColorSelectionViewController
            if (colorSegue.selectedColor != nil) {
                drawingView.lineColor = colorSegue.selectedColor
            }
    }
}

