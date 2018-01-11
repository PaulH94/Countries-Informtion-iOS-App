//
//  CountriesTableViewController.swift
//  eBayCountryApp
//
//  Created by Paul Huynh on 1/10/18.
//  Copyright © 2018 Paul Huynh. All rights reserved.
//

import UIKit

struct Countries: Codable{
    let name: String
    let capital: String
    let population: Int
    let latlng: [Double]
}

enum Result<Value>{
    case success(Value)
    case fail(Error)
}

class CountriesTableViewController: UITableViewController {
    
    func getCountries(completion: ((Result<[Countries]>)-> Void)?){
        /*var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "restcountries-vl.p.mashape.com"
        urlComponents.path = "/all"
        
        guard let url = urlComponents.url else {
            fatalError("URL is broken")
        }*/
        
        let url = URL(string:"https://restcountries-v1.p.mashape.com/all")
        
        print(url!)
        var request = URLRequest(url: url!)
        print(request)
        request.httpMethod = "GET"
        request.setValue("1IosQYQKu0mshuIZjcqiIXbiLGJSp1dBB9Yjsnfd2aISWLA7Yk", forHTTPHeaderField:"X-Mashape-Key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request){ (responseData, response, responseError) in
            //print(response)
            DispatchQueue.main.async {
                guard responseError == nil else{
                    completion?(.fail(responseError!))
                    return
                }
                
                guard let jsonData = responseData else{
                    let error = NSError(domain: "", code:0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    completion?(.fail(error))
                    return
                }
                
                print("Got to here #1")
                let decoder = JSONDecoder()
                
                do{
                    print("In the DO")
                    //print(jsonData)
                    let countries = try decoder.decode([Countries].self, from: jsonData)
                    //let countries = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    print(countries[0])
                    completion?(.success(countries))
                } catch{
                    completion?(.fail(error))
                }
            }
            
        }
        
        task.resume()
        
        
    }
    
    var coty = [Countries]()
    let cellIdentifier = "countriesCell"
    
    @IBOutlet var CountriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Countries"
        
        print("LOADING TABLE")
        getCountries(){ (result) in
            switch result{
            case .success(let countries):
                self.coty = countries
                print("count222: \(self.coty.count)")
                self.CountriesTableView.reloadData()
            case .fail(let error):
                fatalError("error: \(error.localizedDescription)")
            }
            
        }
        print("count: \(coty.count)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coty.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CountriesTableViewCell
        // Configure the cell...
        cell.countryName.text = coty[indexPath.row].name

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
