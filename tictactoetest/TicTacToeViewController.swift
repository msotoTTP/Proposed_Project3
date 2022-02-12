//
//  ViewController.swift
//  tictactoetest
//
//  Created by Mathew Soto on 11/19/21.
//

import UIKit

class TicTacToeViewController: UIViewController {
    
    var game = Game()
    @IBOutlet var squares: [UIButton]!
    @IBOutlet var displayLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func squarePressed(_ sender: UIButton) {
        let indexOfPresssedSquare = squares.firstIndex(of: sender)!
        
        //if a move is successfully played, update board
        //and update the display label with who goes next
        if game.playMove(at: indexOfPresssedSquare) {
            updateGameBoard()
            self.displayLabel.text = "\(self.game.currentMove) goes next"
            
            if game.computerMode {
                displayLabel.text = "Thinking..."
                
                //disable all buttons while computer is thinking
                enableAllSquares(enable: false)
                
                //pause for two seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.game.playMoveComputer(previousPosition: indexOfPresssedSquare)
                    //update board
                    self.updateGameBoard()
                    //enable all buttons
                    self.enableAllSquares(enable: true)
                    
                    //update display text if game isn't over
                    if !self.game.someoneHasWon() || !self.game.gameIsTied() {
                        self.displayLabel.text = "\(self.game.currentMove) goes next"
                    }
                }
            }
        }
        //if someone has won, update the display text and enable the restart button so they can play a new game
        if game.someoneHasWon() {
            displayLabel.text = "\(game.previousMove.rawValue) wins!"
            restartButton.isEnabled = true
        }
        //if the game is tied, update the display text and enable the restart button so they can play a new game
        if game.gameIsTied() {
            displayLabel.text = "It's a tie!"
            restartButton.isEnabled = true
        }
    }
    
    func enableAllSquares(enable: Bool) {
        for square in squares {
            square.isEnabled = enable
        }
    }
    
    func updateGameBoard() {
        for (index, squareButton) in squares.enumerated() {
            let squareValue = game.board[index]
            if squareValue != "_" && squareValue != "-" {
                squareButton.setTitle(String(squareValue), for: .normal)
            }
        }
    }
    
    @IBAction func restartGame() {
        //reset label
        displayLabel.text = "X goes next"
        
        //reset square buttons
        for square in squares {
            square.setTitle("", for: .normal)
        }
        
        //reset game
        game.reset()
        
        //disable restart button
        restartButton.isEnabled = false
    }
}

