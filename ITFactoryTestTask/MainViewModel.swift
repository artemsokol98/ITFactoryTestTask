//
//  MainViewModel.swift
//  ITFactoryTestTask
//
//  Created by Артем Соколовский on 22.01.2023.
//

import Foundation

protocol MainViewModelProtocol {
    func fetchDataFromFile()
    var dataFromJson: MainModel! { get set }
}

class MainViewModel: MainViewModelProtocol {
    
    var dataFromJson: MainModel!
    /*
    if let path = NSBundle.mainBundle().pathForResource(fileName, ofType:fileType) {
        // use path
    }
        */
    
    func fetchDataFromFile() {
        if let filepath = Bundle.main.path(forResource: "jsonviewer", ofType: "json") {
            do {
                let data = try Data.init(contentsOf: URL(fileURLWithPath: filepath))
                let decodedData = try JSONDecoder().decode(MainModel.self, from: data)
                dataFromJson = decodedData
                print(dataFromJson.sections.count)
//                let contents = try String(contentsOfFile: filepath)
//                print(contents)
            } catch {
                // contents could not be loaded
            }
        } else {
            
        }
    }
    
    
    
        
}
