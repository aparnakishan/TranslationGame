//
//  GameViewController.swift
//  TranslationGame
//
//  Created by Test Account on 15/03/22.
//

import UIKit

class GameViewController: UIViewController {
    var viewModel:GameViewModel?
    @IBOutlet var questionLabel:UILabel!
    var answerLabel = UILabel()
    var didAnswerQuestion:Bool = false
    @IBOutlet weak var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        answerLabel.frame = CGRect.init(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width * 0.75, height: 30)
        answerLabel.backgroundColor = UIColor.red     //give color to the view
        answerLabel.center = self.view.center
        answerLabel.numberOfLines = 0 //If you want to display only 2 lines replace 0(Zero) with 2.
        answerLabel.lineBreakMode = .byWordWrapping //Word Wrap
        answerLabel.textAlignment = .center
        self.view.addSubview(answerLabel)
        questionLabel.text = self.viewModel?.getQuestion()
        answerLabel.text = self.viewModel?.getAnswer()
        moveIt(answerLabel, 5)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.answerLabel.removeFromSuperview()
    }
    
    @IBAction func incorrectButtontapped(_ sender: Any) {
        self.answerLabel.layer.removeAllAnimations()
        validateAndSaveAnswer(with: false)
    }
    
    @IBAction func correctButtonTapped(_ sender: Any) {
        self.answerLabel.layer.removeAllAnimations()
        validateAndSaveAnswer(with: true)
    }

    func validateAndSaveAnswer(with selectedOption:Bool) {
        self.didAnswerQuestion = true
        if let isCorrect = viewModel?.checkAndSave(answer: viewModel!.currentAnswer, for: selectedOption) {
            if isCorrect {
                showAlert(with: "Yay!! You got it right.")
            } else {
                showAlert(with: "Uh oh.. You got it wrong!")
            }
        }
    }
    
    func saveMissedQuestion() {
        _ = viewModel?.checkAndSave(answer: nil, for: false)
        showAlert(with: "Uh oh.. You missed it!")
    }
    
    func showAlert(with title: String) {
        let alert = UIAlertController(title: "Result", message: title, preferredStyle: UIAlertController.Style.alert)
        let next = UIAlertAction(title: "Next", style: .default, handler: { action in
            self.goToNextQuestion()
            self.updateUI()
        })
        alert.addAction(next)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func moveIt(_ ansView: UIView,_ speed:CGFloat) {
        let speeds = speed
        let viewSpeed = speeds / view.frame.size.height
        let averageSpeed = (view.frame.size.height - view.frame.origin.y) * viewSpeed

        UIView.animate(withDuration: TimeInterval(averageSpeed), delay: 0.0, options: .curveLinear, animations: {
            ansView.frame.origin.y = self.view.frame.size.height
        }, completion: { (_) in
            ansView.frame.origin.y = -ansView.frame.size.height
            if (!self.didAnswerQuestion) {
                self.saveMissedQuestion()
            }
        })
    }
    
    func goToNextQuestion() {
        self.didAnswerQuestion = false
        self.viewModel?.moveToNextQuestion()
    }
    
    func updateUI() {
            self.questionLabel.text = self.viewModel?.getQuestion()
            self.answerLabel.text = self.viewModel?.getAnswer()
            if let score = self.viewModel?.getScore().0, let total = self.viewModel?.getScore().1 {
                self.scoreLabel.text = String("\(score)/\(total)")
            }
        self.moveIt(answerLabel, 5)
    }

}