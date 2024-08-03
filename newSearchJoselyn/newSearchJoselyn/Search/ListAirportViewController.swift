//
//  listAirportViewController.swift
//  newSearchJoselyn
//
//  Created by Joselyn Cordero on 02/08/24.
//

import Foundation
import UIKit


class ListAirportViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tabBar.delegate = self
    }
    
}

extension ListAirportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AirportDataManager.shared.airports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellViewController") as! CellViewController
        let airport = AirportDataManager.shared.airports[indexPath.row]
        cell.configure(with: airport)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80.0 // O el tamaño que desees
        }

}

extension ListAirportViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch(item.tag){
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let resultVC = storyboard.instantiateViewController(withIdentifier: "ListAirportViewController") as! ListAirportViewController
            present(resultVC, animated: true)
            
        case 1:
            let storyboards = UIStoryboard(name: "Main", bundle: nil)
            let resultVCs = storyboards.instantiateViewController(withIdentifier: "LocationMapViewController") as! LocationMapViewController
            present(resultVCs, animated: true)
        
        default:
            break
        }
    }
}


