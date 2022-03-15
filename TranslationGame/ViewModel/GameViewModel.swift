//
//  GameViewModel.swift
//  TranslationGame
//
//  Created by Test Account on 15/03/22.
//

import Foundation
enum InputType{
    case correct
    case incorrect
    case missed
}

enum QuestionStatus {
    case moveToNext
    case endGame
}

enum AnswerStatus: CustomStringConvertible  {
    case right
    case wrong
    case missed
    
    var description : String {
        switch self {
        case .right: return "Yay!! You got it right"
        case .wrong: return "Un oh.. You got it wrong"
        case .missed: return "ohh.. You missed it"
        }
    }
}
class GameViewModel {
    var translations: [Translation]
    var gameEntries:[GameEntry] = [GameEntry]()
    var currentQuestionIndex:Int = 0
    var currentAnswer:String = ""

    init(translations:[Translation]) {
        self.translations = translations
    }
    
    func canMoveToNextQuestion() -> QuestionStatus {
        if currentQuestionIndex == translations.count - 1 {
            return .endGame
        }
        return .moveToNext
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
    func checkAndSave(answer: String?, for input:InputType) -> AnswerStatus {
        let currentTranslation = getCurrentTranslation()
        var correctness:AnswerStatus = .missed
        
        if let answer = answer {
            correctness = .wrong
            if currentTranslation.text_eng == answer && input == .correct {
                correctness = .right
            } else if currentTranslation.text_eng != answer && input == .incorrect {
                correctness = .right
            }
        }
        let gameEntry = GameEntry(question:currentTranslation.text_spa , answer: currentTranslation.text_eng, answerType:correctness)
        gameEntries.append(gameEntry)
        return correctness
    }
    
    func getScore() -> (Int,Int) {
        let correctCount = gameEntries.filter{ $0.answerType == .right }.count
        return ( correctCount, gameEntries.count)
    }
    
    func getGameResult() -> String {
        let score =  self.getScore()
        return "You answered \(score.0) correctly out of \(score.1) questions"
    }
    
}
