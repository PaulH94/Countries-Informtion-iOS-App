//
//  InformationViewController.swift
//  eBayCountryApp
//
//  Created by Paul Huynh on 1/10/18.
//  Copyright © 2018 Paul Huynh. All rights reserved.
//

import UIKit
import MapKit

class InformationViewController: UIViewController {

    var countryName: String = "Temp"
    var countryCapital: String = ""
    var populationn: Int = 0
    var lat: Double = 0.0
    var long: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavBar()
        
        view.addSubview(cNameLabel)
        cNameLabel.center = view.center
        // Do any additional setup after loading view.
    }
    
    private func setUpNavBar(){
        self.navigationItem.title = "Country Information"
        self.navigationItem.leftBarButtonItem?.title = "Back"
        
        view.addSubview(cNameLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var cNameLabel:UILabel! = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        label.text = countryName
        return label
    }()

    lazy var mapView:MKMapView! = {
        let map = MKMapView()
        map.mapType = MKMapType.standard
        map.isZoomEnabled = false
        map.isScrollEnabled = false
        
        let countryLocation = CLLocation(latitude: lat, longitude: long)
        
        
        
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
