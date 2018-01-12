//
//  CountriesTableViewController.swift
//  eBayCountryApp
//
//  Created by Paul Huynh on 1/10/18.
//  Copyright © 2018 Paul Huynh. All rights reserved.
//

import UIKit

//A struct that is used to store some of the JSON data
//Note: "Codable" means that it can be used to encode and decode JSON data.
//The varible name have to match the JSON key and the type has to match.
struct Countries: Codable{
    let name: String
    let capital: String
    let population: Int
    let latlng: [Double]
    let region: String
}


//Enum for return the result of the web call
enum Result<Value>{
    case success(Value)
    case fail(Error)
}


//This is the controller for the table of countries
class CountriesTableViewController: UITableViewController {
    
    
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
    
    var countriesList = [Countries]()           //Array of countries
    let cellIdentifier = "countriesCell"        //cell indentifier of the countriesTableViewCell
    
    @IBOutlet var CountriesTableView: UITableView!      //The table
    
    //When the view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Countries"         //Nav title
        
        loadTable()                                     //To load the table with data
        tableView.tableFooterView = UIView()            //This is to clear extra rows
    }
    
    
    //The function to load the table with data
    private func loadTable(){
        print("LOADING TABLE")
        //Call the web call function
        getCountries(){ (result) in
            switch result{
            case .success(let countries):                   //if success, reload the table view
                self.countriesList = countries
                print("count222: \(self.countriesList.count)")
                self.CountriesTableView.reloadData()
            case .fail(let error):                          //if fail, fatalerror
                fatalError("error: \(error.localizedDescription)")
                //TODO: Make a popup telling the user what happened
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //number of table section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //number of cell which is equal to thw number of contries in the list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesList.count
    }

    //this function is for populating the cells with info
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CountriesTableViewCell
        //display the country's name
        cell.countryName.text = countriesList[indexPath.row].name

        return cell
    }
    
    
    //This is for when the cell is tapped/selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndexPath = indexPath.row
        print("\(countriesList[selectedIndexPath].name) is being clicked")
        
        //make and prepare the view
        let infoView = InformationViewController()
        infoView.countryName = countriesList[selectedIndexPath].name
        infoView.countryCapital = countriesList[selectedIndexPath].capital
        infoView.countryPopulation = countriesList[selectedIndexPath].population
        infoView.lat = countriesList[selectedIndexPath].latlng[0]
        infoView.long = countriesList[selectedIndexPath].latlng[1]
        
        //display the view that was made, this could have been done in other ways
        self.navigationController?.pushViewController(infoView, animated: true)
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
