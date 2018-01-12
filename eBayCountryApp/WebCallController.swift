//
//  WebCallController.swift
//  eBayCountryApp
//
//  Created by Paul Huynh on 1/12/18.
//  Copyright © 2018 Paul Huynh. All rights reserved.
//

import Foundation


//This is the web call controller, where all web call would be made
//TODO: Get Flag images. Store in cache?
class WebCallController {
    //Web call function to get the information about the countries
    func getCountries(completion: ((Result<[Countries]>)-> Void)?){
        
        //The URL of the API call
        let url = URL(string:"https://restcountries-v1.p.mashape.com/all")
        
        //The request
        var request = URLRequest(url: url!)
        print(request)
        
        //declaring the http method
        request.httpMethod = "GET"
        
        //Setting the headers
        request.setValue("1IosQYQKu0mshuIZjcqiIXbiLGJSp1dBB9Yjsnfd2aISWLA7Yk", forHTTPHeaderField:"X-Mashape-Key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        //Making the API call, receiving the Data and/or error message
        let task = session.dataTask(with: request){ (responseData, response, responseError) in
            
            //Calling the main thread
            DispatchQueue.main.async {
                
                //if there's an error, return a fail
                guard responseError == nil else{
                    completion?(.fail(responseError!))
                    return
                }
                
                //Making sure that there is JSON data, else return a fail
                guard let jsonData = responseData else{
                    let error = NSError(domain: "", code:0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.fail(error))
                    return
                }
                
                //The decoder
                let decoder = JSONDecoder()
                
                do{
                    print("In the DO")
                    //Decode the JSON
                    let countries = try decoder.decode([Countries].self, from: jsonData)
                    /*let c = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                     print(c)*/
                    print(countries[0])
                    completion?(.success(countries))    //return a fail
                } catch{
                    completion?(.fail(error))           //if it is not decodable, return a fail
                }
            }
        }
        task.resume()
    }
    
    func getPic(countryCode: String){
        let url = "http://geonames.org/flags/l/" + countryCode.lowercased() + ".gif"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let dlPic = session.dataTask(with: url){ (responseData, response, responseError) in
            
        }
        
        
    }
}
