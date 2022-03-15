//
//  GameViewModel.swift
//  TranslationGame
//
//  Created by Test Account on 15/03/22.
//

import Foundation
class GameViewModel {
    var translations: [Translation]
    var gameEntries:[GameEntry] = [GameEntry]()
    var currentQuestionIndex:Int = 0
    var currentAnswer:String = ""

    init(translations:[Translation]) {
        self.translations = translations
    }
    
    func moveToNextQuestion() {
        currentQuestionIndex += 1
    }
    func getCurrentTranslation() -> Translation {
        return self.translations[currentQuestionIndex]
    }
    
    func getQuestion() -> String {
        return getCurrentTranslation().text_spa
    }
    func getAnswer() -> String {
        let n = Int.random(in: 0...self.translations.count-1)
        if n % 2 == 0 {
            currentAnswer = getCurrentTranslation().text_eng
        } else {
            currentAnswer =  self.translations[n].text_eng
        }
        return currentAnswer
    }
    func checkAndSave(answer: String?, for input:Bool) -> Bool {
        let currentTranslation = getCurrentTranslation()
        var correctness = false
        
        if let answer = answer {
            if currentTranslation.text_eng == answer && input == true {
                correctness = true
            } else if currentTranslation.text_eng != answer && input == false {
                correctness = true
            }
        }
        let gameEntry = GameEntry(question:currentTranslation.text_spa , answer: currentTranslation.text_eng, didAnswerCorrectly: correctness)
        gameEntries.append(gameEntry)
        return correctness
    }
    
    func getScore() -> (Int,Int) {
        let correctCount = gameEntries.filter{ $0.didAnswerCorrectly }.count
        return ( correctCount, gameEntries.count)
    }
    
}
