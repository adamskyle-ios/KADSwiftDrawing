//
//  ColorSelectionViewController.swift
//  SwiftDrawing
//
//  Created by Kyle Adams on 12/09/14.
//  Copyright (c) 2014 Kyle Adams. All rights reserved.
//

import UIKit

class ColorSelectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let colorArray = [UIColor.blackColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.orangeColor(), UIColor.purpleColor()]
    var selectedColor: UIColor!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var colorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        return colorArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "Color Cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        
        // Configure the cell
        
        switch indexPath.row {
        case 0:
            cell.backgroundColor = colorArray[0]
        case 1:
            cell.backgroundColor = colorArray[1]
        case 2:
            cell.backgroundColor = colorArray[2]
        case 3:
            cell.backgroundColor = colorArray[3]
        case 4:
            cell.backgroundColor = colorArray[4]
        default:
            cell.backgroundColor = colorArray[0]
        }
        
        cell.layer.cornerRadius = cell.bounds.width / 2
        cell.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            colorLabel.textColor = colorArray[0]
            selectedColor = colorArray[0]
        case 1:
            colorLabel.textColor = colorArray[1]
            selectedColor = colorArray[1]
        case 2:
            colorLabel.textColor = colorArray[2]
            selectedColor = colorArray[2]
        case 3:
            colorLabel.textColor = colorArray[3]
            selectedColor = colorArray[3]
        case 4:
            colorLabel.textColor = colorArray[4]
            selectedColor = colorArray[4]
        default:
            colorLabel.textColor = colorArray[0]
            selectedColor = colorArray[0]
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
