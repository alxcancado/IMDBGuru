//
//  ViewController.swift
//  IMDBGuru
//
//  Created by alxcancado on 22/02/15.
//  Copyright (c) 2015 @alxcancado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, IMDBAPIControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet var titleLabel    : UILabel!
    @IBOutlet var realeaseLabel : UILabel!
    @IBOutlet var ratingLabel   : UILabel!
    @IBOutlet var plotLabel     : UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var imdbSearchBar : UISearchBar!
    
    lazy var apiController : IMDBAPIController = IMDBAPIController(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apiController.delegate = self
        
        let tapGesture  = UITapGestureRecognizer(target: self, action: "userTappedInView:")
        self.view.addGestureRecognizer(tapGesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didFinishIMDBSearch(result: Dictionary<String, String>) {
        self.titleLabel.text = result["Title"]
        self.realeaseLabel.text = result["Released"]
        self.ratingLabel.text = result["Rated"]
        self.plotLabel.text = result["Plot"]
        
        if let foundPosterURL = result["Poster"]? {
            
            self.formatImageFromPath(foundPosterURL)
            
        }
        
        
    }
    
    func formatImageFromPath(path : String) {
        
        var posterURL = NSURL(string: path)
        
        if let foundPosterImage = posterURL? {
            
            var posterImageData                 = NSData(contentsOfURL: foundPosterImage)
            self.posterImageView.clipsToBounds  = true
            self.posterImageView.image          = UIImage(data: posterImageData!)
            
            self.blurBackgroundUsingImage(self.posterImageView.image!)
        }
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
        
        self.apiController.searchIMDB(searchBar.text)
        searchBar.resignFirstResponder()
        searchBar.text = ""
        
    }
    
    
    func userTappedInView(recognizer : UITapGestureRecognizer) {
        
        //println("tapped!")
        self.imdbSearchBar.resignFirstResponder()
        
    }
    
    func blurBackgroundUsingImage(image : UIImage) {
        
        var frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        
        var imageView = UIImageView(frame : frame)
        imageView.image = image
        imageView.contentMode = .ScaleAspectFill
        
        var blurEffect = UIBlurEffect(style: .Light)
        var blurEffectView = UIVisualEffectView(effect : blurEffect)
        blurEffectView.frame = frame
        
        var transparentWhiteView        = UIView(frame: frame)
        transparentWhiteView.backgroundColor = UIColor(white: 1.0, alpha: 0.30)
        
        var viewsArray = [imageView, blurEffectView, transparentWhiteView]
        
        for index in 0..<viewsArray.count {
            
            if let oldView = self.view.viewWithTag(index + 1) {
                
                var oldView = self.view.viewWithTag(index + 1)
                oldView?.removeFromSuperview()
            }
            
            var viewToInsert = viewsArray[index]
            self.view.insertSubview(viewToInsert, atIndex: index + 1)
            viewToInsert.tag = index + 1
        }
    }

}

