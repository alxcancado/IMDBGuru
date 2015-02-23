//
//  ViewController.swift
//  IMDBGuru
//
//  Created by alxcancado on 22/02/15.
//  Copyright (c) 2015 @alxcancado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var titleLabel    : UILabel!
    @IBOutlet var realeaseLabel : UILabel!
    @IBOutlet var ratingLabel   : UILabel!
    @IBOutlet var plotLabel     : UILabel!
    @IBOutlet var posterImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: UIButton){
        
        self.titleLabel.text = "King of Kong"
        self.realeaseLabel.text = "28 Feb 2008"
        self.ratingLabel.text = "PG-13"
        self.plotLabel.text = "Diehard video game fans compete to break World Records on classic arcade games."
        self.posterImageView.image = UIImage(named: "kong-poster.jpeg")
    
    }


}

