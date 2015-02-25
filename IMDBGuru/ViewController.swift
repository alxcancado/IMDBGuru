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

}

