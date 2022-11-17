//
//  ViewController.swift
//  Project3
//
//  Created by Lincoln Stewart on 11/2/22.
//

import UIKit
import CoreLocation

class VenuesViewController: UITableViewController {
    
    let reuseIdentifier = "VenueCell"
    var venues: [Venue]? {
        didSet {
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MapViewController {
            destination.passedVenues = venues
            
        }
    }
    
    func setVenues() {
        let store = VenueStore()
        store.fetchVenues { [self]
            (venuesResult) in

            switch venuesResult {
            case let .success(venues):
                self.venues = venues
            case let .failure(error):
                print("Error fetching venues: \(error)")
            }
        }
        
    }
    
    func formatTableView() {
        tableView.overrideUserInterfaceStyle = .dark
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemGreen]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let longTitleLabel = UILabel()
            longTitleLabel.text = "Crypto ATMs"
            longTitleLabel.textColor = UIColor.systemGreen
        longTitleLabel.font = longTitleLabel.font.withSize(25)

            let leftItem = UIBarButtonItem(customView: longTitleLabel)
            self.navigationItem.leftBarButtonItem = leftItem

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatTableView()
        setVenues()
    }
}

extension VenuesViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! VenueCell
        
        let venue = venues?[indexPath.row]
        
        let name = venue?.name ?? ""
        let geo = venue?.geolocation_degrees ?? ""
        let nameSring = "Name: " + name
        let geoString = "Geolocation: " + geo
        
        let latDescrip = venue?.lat.description ?? ""
        let lonDescrip = venue?.lon.description ?? ""
        let latString = "Latitude: " + latDescrip
        let lonString = "Longitude: " + lonDescrip
        
        cell.nameLabel?.text = nameSring
        cell.geoLabel?.text = geoString
        cell.latLabel.text = latString
        cell.lonLabel.text = lonString
        
        return cell
    }
}

