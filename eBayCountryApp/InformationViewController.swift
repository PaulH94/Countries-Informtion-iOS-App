//
//  InformationViewController.swift
//  eBayCountryApp
//
//  Created by Paul Huynh on 1/10/18.
//  Copyright © 2018 Paul Huynh. All rights reserved.
//

import UIKit
import MapKit


//This is UIViewController for the information/detail screen
//The challenege here was to make the view with code instead of storyboard
class InformationViewController: UIViewController {

    var countryName: String = "Temp"
    var countryCapital: String = ""
    var countryNativeName: String = "Native"
    var countryPopulation: Int = 0
    var lat: Double = 0.0
    var long: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavBar()
        
        //Add all the views to the main view
        view.addSubview(nameLabel)
        view.addSubview(nativeNameLabel)
        view.addSubview(capitalLabel)
        view.addSubview(populationLabel)
        view.addSubview(mapView);
        setUpLayout()       //set up the views
        
        // Do any additional setup after loading view.
    }
    
    
    //function for setting up the auto layout
    func setUpLayout(){

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        nativeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        nativeNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nativeNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //nativeNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nativeNameLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        nativeNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.topAnchor.constraint(equalTo: nativeNameLabel.bottomAnchor).isActive = true
        capitalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        capitalLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        capitalLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        populationLabel.translatesAutoresizingMaskIntoConstraints = false
        populationLabel.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor).isActive = true
        populationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        populationLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        populationLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: populationLabel.bottomAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
    
    //set up the nav bar
    private func setUpNavBar(){
        self.navigationItem.title = "Country Information"
        self.navigationItem.leftBarButtonItem?.title = "Back"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This is where I set up the labels for the view, by using lazy they will not be initialized until called upon.
    
    //The name label
    lazy var nameLabel:UILabel! = {
        let label = UILabel()
        label.text = countryName
        label.font = label.font.withSize(35)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var nativeNameLabel:UILabel! = {
        let label = UILabel()
        label.text = "Native Name: \(countryNativeName)"
        label.textAlignment = NSTextAlignment.center
        return label
        
    }()
    
    
    //capital label
    lazy var capitalLabel:UILabel! = {
        let label = UILabel()
        label.text = "Capital: \(countryCapital)"
        label.textAlignment = NSTextAlignment.center
        return label
        
    }()
    
    
    //Set up the population label
    lazy var populationLabel: UILabel! = {
        let label = UILabel()
        label.text = "Population: \(String(countryPopulation))"
        label.textAlignment = NSTextAlignment.center
        return label
    }()

    //The map View
    lazy var mapView:MKMapView! = {
        let map = MKMapView()
        //map setting
        map.mapType = MKMapType.standard
        map.isZoomEnabled = false
        map.isScrollEnabled = false
        map.showsCompass = false
        map.showsScale = false
        
        //Set the location and region
        let countryLocation = CLLocationCoordinate2DMake(lat, long)
        
        //TODO: Use area or something to change the span depending on country
        let countryRegion = MKCoordinateRegionMakeWithDistance(countryLocation, 1000000, 1000000)
        map.setRegion(countryRegion, animated: true)        //Set the region
        
        return map
    }()
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
