//
//  ViewController.swift
//  tictactoe
//
//  Created by Chuma Nnaji on 12/21/14.
//  Copyright (c) 2014 Chuma Nnaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var winner = 0
    var goNumber = 1

    // 0 = empty, 1 = cross, 2 = nought
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    let winningCombinations = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], // horizontals
        [0, 3, 6], [1, 4, 7], [2, 5, 8], // verticals
        [0, 4, 8], [2, 4, 6]             // diagonals
    ]

    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var playAgain: UIButton!

    @IBAction func playAgainPressed(sender: AnyObject) {
        winner = 0
        goNumber = 1
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]

        label.alpha = 0
        playAgain.alpha = 0

        for tag in 0..<9 {
            var button: UIButton = view.viewWithTag(tag) as UIButton
            button.setImage(nil, forState: .Normal)
        }
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        var image: UIImage
        if gameState[sender.tag] == 0 && winner == 0 {
            if goNumber++ % 2 == 0 {
                image = UIImage(named: "cross.png")!
                gameState[sender.tag] = 1
            } else {
                image = UIImage(named: "nought.png")!
                gameState[sender.tag] = 2
            }

            sender.setImage(image, forState: .Normal)
        }

        for combination in winningCombinations {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                winner = gameState[combination[0]]
            }
        }

        if winner != 0 {
            if winner == 1 {
                label.text = "Crosses has won!"
            } else {
                label.text = "Noughts has won!"
            }
            UIView.animateWithDuration(0.40, animations: {
                self.label.alpha = 1
                self.playAgain.alpha = 1
            })
        } else if gameState.filter({ $0 == 0 }).count == 0 {
            label.text = "It's a draw!"
            UIView.animateWithDuration(0.40, animations: {
                self.label.alpha = 1
                self.playAgain.alpha = 1
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        label.alpha = 0
        playAgain.alpha = 0
    }
}

