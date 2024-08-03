//
//  LocationMapViewController.swift
//  newSearchJoselyn
//
//  Created by Joselyn Cordero on 03/08/24.
//

import Foundation
import UIKit
import MapKit

class LocationMapViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var mapa: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        mapa.delegate = self
        let initialLocation = CLLocationCoordinate2D(latitude: -54.810, longitude: -68.315)
            let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 50000, longitudinalMeters: 50000)
            mapa.setRegion(region, animated: true)
        let airports = AirportDataManager.shared.airports
        print("Airports: \(airports)")
        addMarkers(for: airports)
    }
    
    func addMarkers(for airports: [Airport]) {
        mapa.removeAnnotations(mapa.annotations)
            for airport in airports {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude)
                annotation.title = airport.name
                annotation.subtitle = "IATA: \(airport.iataCode ?? "N/A"), ICAO: \(airport.icaoCode)"
                mapa.addAnnotation(annotation)
            }
        }
    
}

extension LocationMapViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch(item.tag){
        case 0:
            let listMaps = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListAirportViewController") as! ListAirportViewController
            present(listMaps, animated: false)
        case 1:
            let locationMaps = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationMapViewController") as! LocationMapViewController
            present(locationMaps, animated: false)
        default:
            break
        }
    }
}

extension LocationMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "marker"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}

