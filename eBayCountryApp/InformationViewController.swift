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

    //There will be information that are passed in that will overwrite all of this temp data
    var countryName: String = "Temp"
    var countryCapital: String = "Cap"
    var countryNativeName: String = "Native"
    var countrySubregion: String = "Sub"
    var countryPopulation: Int = 0
    var lat: Double = 0.0
    var long: Double = 0.0
    var countryArea: Double = 0.0
    var countrySpan: Double = 0.0
    var countryFlag: UIImage = #imageLiteral(resourceName: "whiteFlag")         //to use when getting a flag
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavBar()
        
        //Add all the views to the main view
        view.addSubview(nameLabel)
        //view.addSubview(flagImage)
        view.addSubview(nativeNameLabel)
        view.addSubview(capitalLabel)
        view.addSubview(populationLabel)
        view.addSubview(subregionLabel)
        view.addSubview(mapView);
        setUpLayout()       //set up the views
        
        // Do any additional setup after loading view.
    }
    
    
    //function for setting up the auto layout
    func setUpLayout(){
        
        //Each label will have similar constraints
        //translatesAutoresizingMaskIntoConstraints is so that we can autosize with constraints and not frames
        //topAnchor is where the top of the view is restricted to, usually it is connected to the view above it's bottom anchor
        //CenterXAnchor is used to make sure everything is lined up together
        //highanchor is to make sure we're in control of how tall the view is, this could be either a constant or a ratio comparison
        //WidthAnchor is the same as highanchor but with the width instead
        //No need for a bottom/left/right anchor here, since I have a top,hight, and width anchor
        //A view will usually only need four anchors beside the translatesAutoresizingMaskIntoConstraints.
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        /*
        flagImage.translatesAutoresizingMaskIntoConstraints = false
        flagImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        flagImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        flagImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.20).isActive = true
        flagImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        */
        
        nativeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        nativeNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nativeNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
        
        subregionLabel.translatesAutoresizingMaskIntoConstraints = false
        subregionLabel.topAnchor.constraint(equalTo: populationLabel.bottomAnchor).isActive = true
        subregionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subregionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        subregionLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: subregionLabel.bottomAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50).isActive = true
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
        label.textAlignment = NSTextAlignment.center    //Center text
        label.adjustsFontSizeToFitWidth = true          //Adjust font size if need to
        return label
    }()
    
    //Native name label, the string class will handle ani unicode
    lazy var nativeNameLabel:UILabel! = {
        let label = UILabel()
        label.text = "Native Name: \(countryNativeName)"
        label.textAlignment = NSTextAlignment.center    //Center
        label.adjustsFontSizeToFitWidth = true          //Adjust
        return label
        
    }()
    
    
    //capital label
    lazy var capitalLabel:UILabel = {
        let label = UILabel()
        label.text = "Capital: \(countryCapital)"
        label.textAlignment = NSTextAlignment.center    //Center
        label.adjustsFontSizeToFitWidth = true          //Adjust
        return label
        
    }()
    
    
    //Set up the population label
    lazy var populationLabel: UILabel = {
        let label = UILabel()
        label.text = "Population: \(String(countryPopulation))"
        label.textAlignment = NSTextAlignment.center    //center
        label.adjustsFontSizeToFitWidth = true          //adjust
        return label
    }()
    
    //Set up the subregion label
    //Subregion is enough, region is a tad too much
    lazy var subregionLabel: UILabel = {
        let label = UILabel()
        label.text = "Subregion: \(countrySubregion)"
        label.textAlignment = NSTextAlignment.center    //center
        label.adjustsFontSizeToFitWidth = true          //adjust
        return label
    }()
    
    /*
    lazy var flagImage: UIImageView = {
        return UIImageView(image: countryFlag)
    }()*/

    //The map View
    lazy var mapView:MKMapView = {
        let map = MKMapView()
        //map setting
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true            //renabled soom and scroll
        map.isScrollEnabled = true
        map.showsCompass = false
        map.showsScale = false
        
        //Set the location and region
        let countryLocation = CLLocationCoordinate2DMake(lat, long)
        
        //TODO: Use area or something to change the span depending on country
        //SUCCESS-ish, by using the square root of the area, I was able to get an approx width and hight
        //for the span. Had to multiple it by 1000 to convert km to meters. Added ten thousand for some space.
        //Better for square-ish countries
        //var countrySpan = countryArea.squareRoot()
        //countrySpan = (countrySpan * 1000) + 10000
        let countryRegion = MKCoordinateRegionMakeWithDistance(countryLocation, countrySpan, countrySpan)
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
