//
//  Game.swift
//  tictactoetest
//
//  Created by Mathew Soto on 11/19/21.
//

import Foundation
import UIKit

enum CurrentMove: String {
    case X
    case O
}

struct Game {
    //board
    //_ (underscore) means the square is empty
    //- (hyphen) means the square is empty and the game is over
    //otherwise the square might have X or O
    var board = ["_", "_", "_",
                 "_", "_", "_",
                 "_", "_", "_"]
    
    var currentMove = CurrentMove.X
    var previousMove: CurrentMove {
        if currentMove == CurrentMove.X {
            return CurrentMove.O
        } else {
            return CurrentMove.X
        }
    }
    var computerMode = true
    
    mutating func reset() {
        //reset board
        board = ["_", "_", "_",
                "_", "_", "_",
                "_", "_", "_"]
        
        //reset currentMove
        currentMove = CurrentMove.X
    }
    
    //convenience function that displays the board in a 3x3 format
    func displayBoard() {
        for (index, square) in board.enumerated() {
            print(square, terminator: " ")
            if index % 3 == 2 {
                print()
            }
        }
    }
    
    //updates the symbol that will be played next
    mutating func nextTurn() {
        if currentMove == CurrentMove.X {//update the current player's symbol
            currentMove = CurrentMove.O
        } else {
            currentMove = CurrentMove.X
        }
    }
    
    //update the board by playing a move at the index position
    //and setting the state of the board if the game is over
    mutating func updateBoard(at position: Int) {
        board[position] = currentMove.rawValue //update square with the current player's symbol
        if self.someoneHasWon() {//if someone has won, update the board with hyphens in the empty spaces
            for (index, space) in board.enumerated() {
                if space == "_" {
                    board[index] = "-"
                }
            }
        }
    }
    
    //Returns bool indicating if a move was successfully played
    //set the space at position to whatever symbol is the next move
    //we only want this to happen if that position has not been played yet
    mutating func playMove(at position: Int) -> Bool {
        if position >= board.count || position < 0 { //out of bounds, so we don't want to do anything
            return false
        }
        
        if board[position] != "_" {//square is not empty, so we can't play a move
            return false
        }
        
        //the square is empty, so we can play the move
        updateBoard(at: position)
        nextTurn()
        
//        if computerMode {
//            playMoveComputer(previousPosition: position)
//        }
        return true
    }
    
    //if the previous move is in the middle, play a random legal move
    //else, play the square on the opposite side of the board
    mutating func playMoveComputer(previousPosition: Int) {
        //if no legal move, return false
        guard var nextMove = randomLegalMove() else {
            return
        }
        
        //if the previous play was not in the middle,
        //play the move on the opposite side of the board
        //if that's not available, play random move
        let oppositeSpace = oppositeMove(from: previousPosition)
        let middleSquare = 4
        let oppositeSpaceIsEmpty = board[oppositeSpace] == "_"
        
        if previousPosition != middleSquare && oppositeSpaceIsEmpty {
            nextMove = oppositeMove(from: previousPosition)
        }
        
        updateBoard(at: nextMove)
        nextTurn()
        return
    }
    
    func randomLegalMove() -> Int? {
        //get list of legal moves
        var legalMoves: [Int] = []
        for i in 0...8 {
            if board[i] == "_" {
                legalMoves.append(i)
            }
        }
        
        //play random move
        //if no legal moves, return nil
        return legalMoves.randomElement()
    }
    
    func oppositeMove(from previousPosition: Int) -> Int {
        return 8 - previousPosition
    }
    
    func someoneHasWon() -> Bool {
        if board[0] == board[1] && board[1] == board[2] && board[0] != "_" {
            return true
        } else if board[3] == board[4] && board[4] == board[5] && board[3] != "_" {
            return true
        } else if board[6] == board[7] && board[7] == board[8] && board[6] != "_" {
            return true
        } else if board[0] == board[3] && board[3] == board[6] && board[0] != "_" {
            return true
        } else if board[1] == board[4] && board[4] == board[7] && board[1] != "_" {
            return true
        } else if board[2] == board[5] && board[5] == board[8] && board[2] != "_" {
            return true
        } else if board[0] == board[4] && board[4] == board[8] && board[0] != "_" {
            return true
        } else if board[2] == board[4] && board[4] == board[6] && board[2] != "_" {
            return true
        }
        
        return false
    }
    
    func gameIsTied() -> Bool {
        //the condition returns true if there are no empty squares (underscores)
        //and someone hasn't won (you get hyphens after someone wins).
        //this is equivalent to the game being tied
        if board.firstIndex(of: "_") == nil && board.firstIndex(of: "-") == nil {
            return true
        }
        return false
    }
}
