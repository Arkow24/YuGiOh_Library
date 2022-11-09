
//  StartViewController.swift
//  YuGiOh_Library
//
//  Created by Arkow on 26/10/2022.
//

import Foundation
import UIKit
import AlamofireImage
import Combine


final class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    let viewModel: MainViewModelType
    var cancellables = [AnyCancellable]()
    private lazy var dataSource = makeDataSource()
    
    var contenView: MainView {
        return view as! MainView
    }
    
    //MARK: - Initialization
    
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = MainView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.contenView.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputs.fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupView()
        setupBindings()
        applySnapshot()
    }

    //MARK: - Setup
    
    func setupView() {
        title = "YGO Library"
        contenView.tableView.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.identifier)
        contenView.tableView.delegate = self
        contenView.nameTextField.delegate = self
    }
    
    func setupBindings() {
        
        let action = UIAction { _ in
            self.applySnapshot()
        }
        contenView.allCardsButton.addAction(action, for: .touchUpInside)
        
        viewModel.outputs.reloadTableView
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.contenView.tableView.reloadData()
                self?.applySnapshot()
            }
            .store(in: &cancellables)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selected = SelectedCardViewController()
        selected.selectedCard = viewModel.outputs.cards[indexPath.row]
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
            viewModel.inputs.fetchTargerData(for: textField.text ?? "")
            applySnapshot()
        }
        return true
    }
}

extension MainViewController {

    func makeDataSource() -> UITableViewDiffableDataSource<Section, Card> {
        
        let dataSource = UITableViewDiffableDataSource<Section,Card>( tableView: contenView.tableView,
                cellProvider: { (tableView, indexPath, card) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.identifier,
                                                     for: indexPath) as? MainViewCell

            cell?.cardNameLabel.text = card.name
            cell?.imageCard.af.setImage(withURL: card.cardImages[0].imageURLSmall)
            return cell
        })
        return dataSource
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Card>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.viewModel.outputs.cards, toSection: .main)
        dataSource.apply(snapshot)
    }
}

extension MainViewController {
    enum Section: CaseIterable {
        case main
    }
}
