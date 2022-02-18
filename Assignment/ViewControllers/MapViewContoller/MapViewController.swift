//
//  MapViewController.swift
//  Assignment
//
//  Created by ToanHT on 18/02/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    
    //MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Properties
    private var city: CityModel
    
    init(city: CityModel) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetchMKPoint()
    }
    
    private func fetchMKPoint() {
        let annotations = MKPointAnnotation()
        annotations.title = city.name
        annotations.coordinate = CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon)
        mapView.addAnnotation(annotations)
    }
    
}
