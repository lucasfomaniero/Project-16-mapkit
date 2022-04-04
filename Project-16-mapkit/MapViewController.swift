//
//  ViewController.swift
//  Project-16-mapkit
//
//  Created by Lucas Maniero on 27/03/22.
//

import UIKit
import MapKit

let capitals: [Capital] = [
    Capital(title: "MPDFT", coordinate: .init(latitude: -15.787927, longitude: -47.908071),  subtitle: "Local de Trabalho"),
    Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), subtitle: "Home to the 2012 Summer Olympics."),
    Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), subtitle: "Founded over a thousand years ago."),
    Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), subtitle: "Often called the City of Light."),
    Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), subtitle: "Has a whole country inside it."),
    Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), subtitle: "Named after George himself.")
]

class MapViewController: UIViewController {
    let identifier = "Capital"
    var mapTypes: [String: MKMapType] = MKMapType.allCases.toDictionary(with: {$0.formattedName})

    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = .init(image: .init(systemName: "map"), style: .plain, target: self, action: #selector(presentMapTypeAlert))
        mapView.delegate = self
        title = "Capitals"
      
        view.addSubview(mapView)
        mapView.fillSuperView()
        mapView.addAnnotations(capitals)
    }
    
    @objc func presentMapTypeAlert() {
        let alert = UIAlertController(title: "View the map", message: "Choose a map type below", preferredStyle: .actionSheet)
        
        mapTypes.keys.forEach { title in
            let action = UIAlertAction(title: title, style: .default, handler: changeMapType(action:))
            alert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeMapType(action: UIAlertAction) {
        guard let title = action.title,
              let type = mapTypes[title] else {return}
        mapView.mapType = type
    }


}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let text = view.annotation?.title else {return}
        
        let searchViewController = SearchWikipediaViewController()
        searchViewController.stringToSearch = text
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        guard annotation is Capital else { return nil }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

        if annotationView == nil {
            //4
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            
            annotationView?.canShowCallout = true

            // 5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6
            annotationView?.annotation = annotation
        }
        
        annotationView?.pinTintColor = .systemBlue

        return annotationView
    }
}

extension MKMapType: CaseIterable {
    public static var allCases: [MKMapType] {
        [.hybridFlyover, .standard, .satellite, .hybrid, .standard, .satelliteFlyover]
    }
    
    var formattedName: String {
        switch self {
        case .hybrid:           return "Híbrido"
        case .hybridFlyover:    return "3D Híbrido"
        case .standard:         return "Padrão"
        case .satellite:        return "Satélite"
        case .satelliteFlyover: return "3D Satélite"
        default:                return "Outro"
        }
    }
    
}

