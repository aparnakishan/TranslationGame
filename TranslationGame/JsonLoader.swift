//
//  JsonLoader.swift
//  TranslationGame
//
//  Created by Aparna Kishan on 15/03/22.
//

import Foundation

protocol FetchTranslationsProtocol {
    func fetchTranslations(from file:String, completionHandler:@escaping ([Translation]?) -> Void)
}

class JsonLoader:FetchTranslationsProtocol {
    func fetchTranslations(from file: String, completionHandler: @escaping ([Translation]?) -> Void) {
        if let url = Bundle.main.url(forResource: file, withExtension: ".json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Translation].self, from: data) 
                completionHandler(jsonData)
            } catch (let error) {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    
}
