//
//  ViewController.swift
//  Roshambo
//
//  Created by Yahya Emad on 22/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //button outlets
    @IBOutlet var rockButton:UIButton!
    @IBOutlet var paperButton:UIButton!
    @IBOutlet var scissorsButton:UIButton!
    
    let winning = [Options.rock:Options.scissors, Options.paper:Options.rock, Options.scissors:Options.paper]
    var userStatus:String?
    var userOptionTag:Int?
    var enemyOption:Options?
    var userOption:Options?
    
    enum Options:Int{
        case rock = 1,
        paper,
        scissors
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //I am doing this because I found the button with the title button in my test on iphone 7 plus
        rockButton.setTitle("", for: .normal)
        paperButton.setTitle("", for: .normal)
        scissorsButton.setTitle("", for: .normal)
    }
    
    
    func enemyRandomOptionGenerator()->Int{
        return Int.random(in: 1...3)
    }
    
    
    //generic function to be called to set the resultsViewController's image according to the option the user selected and his winning status.
    func setResultViewControllerImage(forStatus status:String, viewController VC:RockViewController, winningImage:UIImage?, losingImage:UIImage?){
        if status.contains("Win"){
            VC.imageDisplayed = winningImage
        }else if status.contains("Lose"){
            VC.imageDisplayed = losingImage
        }else{
            VC.imageDisplayed = UIImage(named: "itsATie")
        }
    }
    
    
    @IBAction func optionSelected(_ sender:UIButton){
        //setting the userOptionTag to the tag of the option he selected.
        userOptionTag = sender.tag
        
        //randomly generating an enemy option and saving the user option
        enemyOption = Options(rawValue: enemyRandomOptionGenerator())
        userOption = Options(rawValue: userOptionTag!)
        
        //checking the user game status whether he is winning, losing or it's a draw.
        if sender.tag == enemyOption?.rawValue{
            userStatus = "It's a draw!"
        }else{
            guard let safeUserOption = userOption else{
                return
            }
            userStatus = enemyOption == winning[safeUserOption,default: .paper] ? "You Win!" : "You Lose!"
        }
        
        //viewing the secondView according to the sender's tag.
        switch sender.tag{
        case 1:
            let controller = storyboard?.instantiateViewController(withIdentifier: "RockViewController") as! RockViewController
            
            
            guard let safeUserStatus = userStatus else{
                return
            }
            controller.gameStatus = "\(userOption!) vs. \(enemyOption!)\n\(safeUserStatus)"
            
            setResultViewControllerImage(forStatus: safeUserStatus, viewController: controller, winningImage: UIImage(named: "RockCrushesScissors"), losingImage: UIImage(named: "PaperCoversRock"))
            
            present(controller, animated: true)
                
        case 2:
            performSegue(withIdentifier: "test", sender: self)
            
        default:
            return
        
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let safeUserOptionUserTag = userOptionTag else{
            print("No tag acquired!")
            return
        }
        guard let safeUserStatus = userStatus else{
            return
        }
        
        if segue.identifier == "test"{
            
            let resultVC = segue.destination as! RockViewController
            resultVC.gameStatus = "\(userOption!) vs. \(enemyOption!)\n\(safeUserStatus)"
            if safeUserOptionUserTag == 2{
                setResultViewControllerImage(forStatus: safeUserStatus, viewController: resultVC, winningImage: UIImage(named: "PaperCoversRock"), losingImage: UIImage(named: "ScissorsCutPaper"))
            }
            else{
                setResultViewControllerImage(forStatus: safeUserStatus, viewController: resultVC, winningImage: UIImage(named: "ScissorsCutPaper"), losingImage: UIImage(named: "RockCrushesScissors"))
            }
        }
        
        //MARK: - Testing knowledge about alert
        else{
            let alert = UIAlertController(title: "Alert Title", message: "Error performing segue as there is no segue with the name \"play\"", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Return", style: .destructive)
            alert.addAction(alertAction)
            
            present(alert, animated: true, completion: nil)
        }
        
    }


}

