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
    
    override func viewWillAppear(_ animated: Bool) {
        self.contenView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiReload()
        setupView()
        setupBindings()
    }

    //MARK: - Setup
    
    func setupView() {
        title = "YGO Library"
        contenView.nameTextField.delegate = self
        contenView.tableView.dataSource = self
       contenView.tableView.delegate = self
        contenView.tableView.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.identifier)
    }
    
    func setupBindings() {
        //mozna uzyc combine
        let action = UIAction { _ in
            self.apiReload()
        }
        contenView.allCardsButton.addAction(action, for: .touchUpInside)
    }
    
    func apiReload() {
        ApiClient.shared.allData { eachCardLocal in
            self.eachCardLocal = eachCardLocal
            DispatchQueue.main.async {
                self.contenView.tableView.reloadData()
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.eachCardLocal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.identifier, for: indexPath) as? MainViewCell else {return UITableViewCell()}
        //jak pobiore dane moge wyslac combine o reload
        
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

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contenView.nameTextField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField.text!.count > 3 {
            fetchCard(for: textField.text ?? "" )
            self.contenView.tableView.reloadData()
        } else {
            apiReload()
        }
        return true
    }
    
    
    // od view modelu
    
    func fetchCard(for query: String) {
        var tab: [Card] = []
        for cards in eachCardLocal {
            if cards.name.contains("\(query)") {
                tab.append(cards)
            }
        }
        self.eachCardLocal = tab
    }
    
}


// diffable datasources table view  / collection view
// 

