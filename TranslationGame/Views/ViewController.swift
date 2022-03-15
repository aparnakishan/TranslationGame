//
//  ViewController.swift
//  TranslationGame
//
//  Created by Aparna Kishan on 15/03/22.
//

import UIKit

class ViewController: UIViewController {
    var jsonLoader:JsonLoader = JsonLoader()
    var translations:[Translation] = [Translation]()
    var viewModel:TranslationsViewModel = TranslationsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        // Do any additional setup after loading the view.
    }

    func getData() {
        let jsonFileName = StringConstants.jsonFileName
        self.jsonLoader.fetchTranslations(from: jsonFileName) { result in
            if let translationsArray = result {
                self.viewModel.translations = translationsArray
            } else {
                let alert = UIAlertController(title:StringConstants.ErrorTitle, message: StringConstants.loadJsonError, preferredStyle: UIAlertController.Style.alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameViewController = segue.destination as? GameViewController {
            if let data = self.viewModel.getTenRandomTranslationForGame() {
                gameViewController.viewModel = GameViewModel(translations: data)
            }
            gameViewController.modalPresentationStyle = .fullScreen
        }
    }
}

