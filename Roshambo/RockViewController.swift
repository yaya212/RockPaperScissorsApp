//
//  RockViewController.swift
//  Roshambo
//
//  Created by Yahya Emad on 22/04/2022.
//

import UIKit

class RockViewController: UIViewController {

    var imageDisplayed:UIImage?
    var gameStatus:String?
    
    @IBOutlet var rockImage:UIImageView!
    @IBOutlet var gameStatusLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if imageDisplayed != nil{
            rockImage.image = imageDisplayed
        }
        if gameStatus != nil{
            gameStatusLabel.text = gameStatus
        }
    }
    
    @IBAction func playAgain(){
        self.dismiss(animated: true, completion: nil)
    }

}
