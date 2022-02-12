//
//  GameStartViewController.swift
//  tictactoetest
//
//  Created by Mathew Soto on 2/9/22.
//

import UIKit

class GameStartViewController: UIViewController {

    @IBOutlet var passAndPlayButton: UIButton!
    @IBOutlet var computerModeButton: UIButton!
    var computerMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        if sender == passAndPlayButton {
            computerMode = false
        } else {
            computerMode = true
        }
        performSegue(withIdentifier: "showGameScreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TicTacToeViewController
        destinationVC.game.computerMode = self.computerMode
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
