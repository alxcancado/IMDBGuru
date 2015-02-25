//
//  IMDBAPIController.swift
//  IMDBGuru
//
//  Created by alxcancado on 25/02/15.
//  Copyright (c) 2015 @alxcancado. All rights reserved.
//

import UIKit

protocol IMDBAPIControllerDelegate {
    
    func didFinishIMDBSearch(result: Dictionary<String, String>)
    
}

class IMDBAPIController {
    
    var delegate : IMDBAPIControllerDelegate?
    
    init(delegate: IMDBAPIControllerDelegate?) {
        
        self.delegate = delegate
        
    }
    
    func searchIMDB(forContent: String){
        
        var spacelessString = forContent.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        //        println(spacelessString)
        
        if let foundString = spacelessString {
            
            var urlPath = NSURL(string: "http://www.omdbapi.com/?t=\(foundString)&tomatoes=true")
            
            var session = NSURLSession.sharedSession()
            
            var task = session.dataTaskWithURL(urlPath!){
                
                data, response, error -> Void in
                
                if (error != nil) {
                    
                    println(error.localizedDescription)
                }
                
                var jsonError : NSError?
                
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as Dictionary<String, String>
                
                if ((jsonError?) != nil){
                    
                    println(jsonError!.localizedDescription)
                }
                
                if let apiDelegate = self.delegate? {
                    
                    dispatch_async(dispatch_get_main_queue()){
                        
                        apiDelegate.didFinishIMDBSearch(jsonResult)
                        
                    }
                    
                }
                
                
            }
            
            task.resume()
        }
    }
   
}
