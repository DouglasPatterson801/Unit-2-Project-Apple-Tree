//
//  ViewController.swift
//  Unit 2 Project Apple Pie
//
//  Created by Douglas Patterson on 9/21/18.
//  Copyright © 2018 Douglas Patterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["jazz", "music", "salsa", "motorcycle", "pizza", "family", "travel", "apple", "trombone", "banjo", "glasses", "knitting", "love", "wagon", "skate", "guitar", "violin", "cards", "games", "banana", "pasta", "shoes", "table", "chair", "smart", "happy", "sad", "funny", "kitchen"]
   
    
    
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    var currentGame: Game!
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func newRound()  {
        if !listOfWords.isEmpty {
            
            func enabledLetterButtons(_ enable: Bool) {
                for button in letterButtons {
                    button.isEnabled = enable
                }
            }
            
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enabledLetterButtons(true)
            updateUI()
        }
          let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining:
            incorrectMovesAllowed, guessedLetters: [])
        updateUI()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

