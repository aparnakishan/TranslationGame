//
//  TranslationsViewModel.swift
//  TranslationGame
//
//  Created by Aparna Kishan on 15/03/22.
//

import Foundation

class TranslationsViewModel {
    var translations:[Translation]?
        
    func getTenRandomTranslationForGame() -> [Translation]? {
        if let data = self.translations {
            let shuffled = data.shuffled()
            var gameTranslations:[Translation] = [Translation]()
            gameTranslations.append(contentsOf: shuffled[0...9])
            return gameTranslations
        }
        return nil
    }
}
