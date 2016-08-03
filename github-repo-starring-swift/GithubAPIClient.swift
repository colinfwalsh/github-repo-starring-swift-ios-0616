//
//  GithubAPIClient.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
    
    class func unstarRepository(fullName: String, completion:() -> ()) {
        let url = NSURL(string: "\(githubStarred)/\(fullName)")
        
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        
        let request = NSMutableURLRequest(URL: unwrappedURL)
        request.HTTPMethod = "DELETE"
        request.addValue("token \(gitToken)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            guard let responseValue = response as? NSHTTPURLResponse else {
                assertionFailure("Error!")
                return}
            
            if responseValue.statusCode == 204 {
                completion()
            }
            else if responseValue.statusCode == 404 {
                completion()
            }
                
            else {
                print("other status code")}
        })
        task.resume()}
    
    class func starRepository(fullName: String, completion:() -> ()) {
        let url = NSURL(string: "\(githubStarred)/\(fullName)")
        
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        
        let request = NSMutableURLRequest(URL: unwrappedURL)
        request.HTTPMethod = "PUT"
        request.addValue("token \(gitToken)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            guard let responseValue = response as? NSHTTPURLResponse else {
                assertionFailure("Error!")
                return}
            
            if responseValue.statusCode == 204 {
                completion()
            }
            else if responseValue.statusCode == 404 {
                completion()
            }
                
            else {
                print("other status code")}
        })
        task.resume()}

    
    class func checkIfRepositoryIsStarred(fullName: String, completion: (Bool) -> ()) {
        
        let url = NSURL(string: "\(githubStarred)/\(fullName)")
        
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        
        let request = NSMutableURLRequest(URL: unwrappedURL)
        request.HTTPMethod = "GET"
        request.addValue("token \(gitToken)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            guard let responseValue = response as? NSHTTPURLResponse else {
                assertionFailure("Error!")
                return}
            
            if responseValue.statusCode == 204 {
                completion(true)
            }
            else if responseValue.statusCode == 404 {
                completion(false)
            }
                
            else {
                print("other status code")}
            
        })
        task.resume()
    }
    
    class func getRepositoriesWithCompletion(completion: (NSArray) -> ()) {
        let urlString = "\(githubAPIURL)/repositories?client_id=\(githubClientID)&client_secret=\(githubClientSecret)"
        let url = NSURL(string: urlString)
        
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseArray = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSArray {
                if let responseArray = responseArray {
                    completion(responseArray)
                }
            }
        }
        task.resume()
    }
}

