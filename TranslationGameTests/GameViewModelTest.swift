//
//  GameViewModelTest.swift
//  TranslationGameTests
//
//  Created by Test Account on 15/03/22.
//

import XCTest
@testable import TranslationGame

class GameViewModelTest: XCTestCase {
    var viewModel:GameViewModel?

    override func setUpWithError() throws {
        let translation1 = Translation(text_eng: "group", text_spa: "grupo")
        let translation2 = Translation(text_eng: "holidays", text_spa: "vacaciones")
        let translation3 = Translation(text_eng: "class", text_spa: "curso")
        let translation4 = Translation(text_eng: "bell", text_spa: "timbre")


        viewModel = GameViewModel(translations: [translation1,translation2,translation3,translation4])
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
        

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanMoveToNextQuestionforThirdQuestion() throws {
        self.viewModel?.currentQuestionIndex = 2
        XCTAssertEqual(self.viewModel?.canMoveToNextQuestion(), .moveToNext)
    }
    func testCanMoveToNextQuestionforFifthQuestion() throws {
        self.viewModel?.currentQuestionIndex = 3
        XCTAssertEqual(self.viewModel?.canMoveToNextQuestion(), .endGame)
    }
    
    func testMoveToNextQuestion() throws {
        self.viewModel?.currentQuestionIndex = 2
        self.viewModel?.moveToNextQuestion()
        XCTAssertEqual(self.viewModel?.getCurrentTranslation().text_spa, "timbre")
    }
    
    func testgetCurrentTrnaslation() throws {
        self.viewModel?.currentQuestionIndex = 2
        XCTAssertEqual(self.viewModel?.getCurrentTranslation().text_spa, "curso")
    }
    
    func testGetQuestion() throws {
        self.viewModel?.currentQuestionIndex = 0
        XCTAssertEqual(self.viewModel?.getQuestion(), "grupo")
    }
    
    func testCheckAndSaveWrongAnswer() throws {
        self.viewModel?.currentQuestionIndex = 2
        XCTAssertEqual(self.viewModel?.checkAndSave(answer: "calendar", for: .correct),.wrong)
        XCTAssertEqual(self.viewModel?.gameEntries.count,1)
    }
    
    func testCheckAndSaveCorrectAnswer() throws {
        self.viewModel?.currentQuestionIndex = 2
        XCTAssertEqual(self.viewModel?.checkAndSave(answer: "class", for: .correct),.right)
        XCTAssertEqual(self.viewModel?.gameEntries.count,1)
    }

    func testGetScore() throws {
        self.viewModel?.currentQuestionIndex = 2
        XCTAssertEqual(self.viewModel?.checkAndSave(answer: "class", for: .correct),.right)
        XCTAssertEqual(self.viewModel?.getScore().0,1)
    }
}
