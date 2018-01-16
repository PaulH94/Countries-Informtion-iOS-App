//
//  CountriesTableViewController.swift
//  eBayCountryApp
//
//  Created by Paul Huynh on 1/10/18.
//  Copyright © 2018 Paul Huynh. All rights reserved.
//
//Tried to stick to MVC, but there is some bleed over

import UIKit

/*
//A struct that is used to store some of the JSON data
//Note: "Codable" means that it can be used to encode and decode JSON data.
//The varible name have to match the JSON key and the type has to match.
//A number of more data could have been recorded, but for this exercise I am going to only get what I
//need and data that I think are more important to "people" who would use the app
struct Country: Codable{
    let name: String
    let capital: String
    let population: Int
    let latlng: [Double]
    let nativeName: String      //String class takes care of unicode
    let subregion: String
    let area: Double?           //Potentially used for map span
    let alpha2Code: String      //Potentially used for flags
}
*/

//Enum for return the result of the web call
//either return a success and the data or a fail and the error message
enum Result<Value>{
    case success(Value)
    case fail(Error)
}


//This is the controller for the table of countries
class CountriesTableViewController: UITableViewController {
    
    var countriesList: [Country]! = []          //Array of countries
    let cellIdentifier = "countriesCell"        //cell indentifier of the countriesTableViewCell
    
    @IBOutlet var CountriesTableView: UITableView!      //The table
    
    //When the view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Countries"         //Nav title
        
        //self.CountriesTableView.backgroundView = UILabel()
        //TODO: Add some sort of loading message
        
        loadTable()                                     //To load the table with data
        tableView.tableFooterView = UIView()            //This is to clear extra rows
    }
    
    
    //The function to load the table with data
    private func loadTable(){
        print("LOADING TABLE")
        let webCall = WebCallController()
        
        //Call the web call function
        webCall.getCountries(){ (result) in
            switch result{
            case .success(let countries):                   //if success, reload the table view
                self.countriesList = countries
                DispatchQueue.main.async{
                    self.CountriesTableView.reloadData()
                }
            case .fail(let error):                          //if fail, fatalerror
                //fatalError("error: \(error.localizedDescription)")
                //TODO - DONE: Make a popup telling the user what happened 
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default))
                self.present(alert,animated: true)
                fatalError("error: \(error.localizedDescription)")
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
        infoView.countryNativeName = countriesList[selectedIndexPath].nativeName
        infoView.countryCapital = countriesList[selectedIndexPath].capital
        infoView.countryPopulation = countriesList[selectedIndexPath].population
        infoView.countrySubregion = countriesList[selectedIndexPath].subregion
        infoView.lat = countriesList[selectedIndexPath].latlng[0]
        infoView.long = countriesList[selectedIndexPath].latlng[1]
        
        if let area = countriesList[selectedIndexPath].area{
            infoView.countryArea = area
        }else{
            infoView.countryArea = 0
        }
        
        //let web = WebCallController()
        //infoView.countryFlag = web.getPic(countryCode: countriesList[selectedIndexPath].alpha2Code)
        
        //display the view that was made, this could have been done in other ways
        self.navigationController?.pushViewController(infoView, animated: true)
    }
    
    //READ: This could have been also done with a segue, but this was is much easier and quicker

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
