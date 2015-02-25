//
//  ViewController.swift
//  IMDBGuru
//
//  Created by alxcancado on 22/02/15.
//  Copyright (c) 2015 @alxcancado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, IMDBAPIControllerDelegate {
    
    @IBOutlet var titleLabel    : UILabel!
    @IBOutlet var realeaseLabel : UILabel!
    @IBOutlet var ratingLabel   : UILabel!
    @IBOutlet var plotLabel     : UILabel!
    @IBOutlet var posterImageView: UIImageView!
    
    lazy var apiController : IMDBAPIController = IMDBAPIController(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apiController.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: UIButton){
        
       
    }
    
    func didFinishIMDBSearch(result: Dictionary<String, String>) {
        self.titleLabel.text = result["Title"]
        self.realeaseLabel.text = result["Released"]
        self.ratingLabel.text = result["Rated"]
        self.plotLabel.text = result["Plot"]
//        self.posterImageView.image = UIImage(named: "kong-poster.jpeg")
    }
    

}

