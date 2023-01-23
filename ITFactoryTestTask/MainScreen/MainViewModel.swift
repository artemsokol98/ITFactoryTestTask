//
//  MainViewModel.swift
//  ITFactoryTestTask
//
//  Created by Артем Соколовский on 22.01.2023.
//

import Foundation

protocol MainViewModelProtocol {
    func fetchDataFromFile()
    var dataFromJson: JSONModel! { get set }
}

class MainViewModel: MainViewModelProtocol {
    
    var dataFromJson: JSONModel!
  
    func fetchDataFromFile() {
        if let filepath = Bundle.main.path(forResource: "jsonviewer", ofType: "json") {
            do {
                let data = try Data.init(contentsOf: URL(fileURLWithPath: filepath))
                let decodedData = try JSONDecoder().decode(JSONModel.self, from: data)
                dataFromJson = decodedData
            } catch {
                
            }
        } else {
            
        }
    }    
}
