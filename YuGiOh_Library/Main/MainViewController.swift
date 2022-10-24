//
//  ViewController.swift
//  YuGiOh_Library
//
//  Created by Arkow on 20/10/2022.
//

import UIKit
import AlamofireImage

final class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    var contenView: MainView {
        return view as! MainView
    }
    
    var eachCardLocal: [Card] = []
    var localCard: Card?
  
    //MARK: - Lifecycle
    
    override func loadView() {
        view = MainView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupView()
   
        ApiClient.shared.getCards { eachCardLocal in
            self.eachCardLocal = eachCardLocal
            DispatchQueue.main.async {
                self.contenView.tableView.reloadData()
            }
        }
    }

    //MARK: - Setup
    
    func setupView() {
        title = "Main Screen"
        contenView.tableView.dataSource = self
       contenView.tableView.delegate = self
        contenView.tableView.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.identifier)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.eachCardLocal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.identifier, for: indexPath) as? MainViewCell else {return UITableViewCell()}
        
        let item = self.eachCardLocal[indexPath.row]
        
        cell.cardNameLabel.text = item.name
        cell.imageCard.af.setImage(withURL: item.cardImages[0].imageURLSmall )
        
        return cell
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        self.localCard = self.eachCardLocal[indexPath.row]

        let selected = SelectedCardViewController()
        selected.selectedCard = self.localCard
        self.navigationController?.pushViewController(selected, animated: true)
    }
}

