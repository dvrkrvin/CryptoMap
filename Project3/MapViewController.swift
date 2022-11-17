//
//  MapViewController.swift
//  Project3
//
//  Created by Lincoln Stewart on 11/14/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let mapView : MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        return map
    }()
    
    var cllArray : [CLLocation] = []
    var passedVenues : [Venue]?
    var passedVenueIndex : Int?
    
    func setMapContstraints() {
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }
    
    @objc func parseCoordinates() {

        guard let receivedVenues = passedVenues else {
            print("Received null venues on mapVC")
            return
        }
        
        for venue in receivedVenues {
            let location = CLLocation(
                latitude: venue.lat,
                longitude: venue.lon
            )
            cllArray.append(location)
        }
    }
    
    func addPins() {
        if cllArray.count != 0 {
            for (index, _) in cllArray.enumerated() {
                let pin = MKPointAnnotation()
                pin.title = passedVenues![index].name
                pin.coordinate = CLLocationCoordinate2D(
                    latitude: cllArray[index].coordinate.latitude,
                    longitude: cllArray[index].coordinate.longitude
                )
                mapView.addAnnotation(pin)
            }
        }
    }
    
    override func viewDidLoad() {
        setMapContstraints()
        parseCoordinates()
        addPins()
    }
}

