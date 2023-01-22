//
//  ViewController.swift
//  ITFactoryTestTask
//
//  Created by Артем Соколовский on 22.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImagesTableViewCell.self, forCellReuseIdentifier: ImagesTableViewCell.identifier)
        //tableView.separatorColor = self.tableView.backgroundColor
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        viewModel.fetchDataFromFile()
        tableView.separatorColor = self.tableView.backgroundColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
        
    }


}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.dataFromJson.sections.count
    }
    /*
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = viewModel.dataFromJson.sections[section].header
        title.font = .systemFont(ofSize: 20, weight: .bold)
        return title
    }
    */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderLabel.identifier) as? SectionHeaderLabel else { return UIView() }//.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderLabel.identifier) as? SectionHeaderLabel else { return UIView() }
        header.configureHeader(text: viewModel.dataFromJson.sections[section].header)
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImagesTableViewCell.identifier, for: indexPath) as? ImagesTableViewCell else { return UITableViewCell() }
        cell.configureCell(section: viewModel.dataFromJson.sections[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300.0
    }
    
}

