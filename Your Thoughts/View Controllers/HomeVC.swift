//
//  HomeVC.swift
//  Your Thoughts
//
//  Created by Noah Evans on 09/08/2020.
//

import UIKit

var nameCleared: Bool = false

class HomeVC: UIViewController, UITextFieldDelegate {
    
    let defaults = UserDefaults.standard
    var name: String = ""
    var randomGreet: String = ""

    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    private func loadImage(fileName: String) -> UIImage? {
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image: \(error)")
        }
        return nil
    }
    
    func backgroundBlur() {
        // Define blur
        var blurEffect = UIBlurEffect(style: .light)
        if traitCollection.userInterfaceStyle == .light {
            // Light mode
            blurEffect = UIBlurEffect(style: .systemThinMaterialLight)
        }
        if traitCollection.userInterfaceStyle == .dark {
            // Light mode
            blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        }
        if traitCollection.userInterfaceStyle == .unspecified {
            // Light mode
            blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        }
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        
        // Remove previous blur if any
        self.view.willRemoveSubview(blurVisualEffectView)
        // Add blur
        self.view.insertSubview(blurVisualEffectView, at: 1)
    }
    
 
    func insertAppBackground(fileName: String) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        let image = UIImage(imageLiteralResourceName: fileName)
        backgroundImage.image = image
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func insertCustomBackground() {
        let customBGurl = defaults.object(forKey: "custom-background-url") as! String
        // Load and display BG
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        let image = loadImage(fileName: customBGurl)
        backgroundImage.image = image
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        backgroundBlur()
    }
    
    func insertRandomAppBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        let chosenImageNo = Int.random(in: 1 ... 6)
        let chosenImageNoStr = String(chosenImageNo)
        let backgroundImageID = "bg" + chosenImageNoStr
        let image = UIImage(named: backgroundImageID)
        backgroundImage.image = image
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func insertColourBackground(colour: UIColor) {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        let image = UIImage(color: colour)
        backgroundImage.image = image
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        textField.backgroundColor = colour
        backgroundBlur()
    }
    
    func setBG() {
        // Load in defaults
        let currentBG = defaults.object(forKey: "background") as? Int ?? 0
        
        guard let uploadedBG = defaults.bool(forKey: "uploaded-background") as? Bool else { let uploadedBG = false }
        let colourBG = defaults.object(forKey: "colour-background") as? String
        
        // If the user has a custom background
        if uploadedBG == true {
            insertCustomBackground()
        }
        else {
            // If the user has a colour BG
            if colourBG != "NONE" {
                if colourBG == "green" {
                    // Green
                    insertColourBackground(colour: UIColor.systemGreen)
                }
                if colourBG == "indigo" {
                    // Indigo
                    insertColourBackground(colour: UIColor.systemIndigo)
                }
                if colourBG == "orange" {
                    // Orange
                    insertColourBackground(colour: UIColor.systemOrange)
                }
                if colourBG == "pink" {
                    // Pink
                    insertColourBackground(colour: UIColor.systemPink)
                }
                if colourBG == "purple" {
                    // Purple
                    insertColourBackground(colour: UIColor.systemPurple)
                }
                if colourBG == "red" {
                    // Red
                    insertColourBackground(colour: UIColor.systemRed)
                }
                if colourBG == "teal" {
                    // Teal
                    insertColourBackground(colour: UIColor.systemTeal)
                }
                if colourBG == "yellow" {
                    // Yellow
                    insertColourBackground(colour: UIColor.systemYellow)
                }
                if colourBG == "black" {
                    // Yellow
                    insertColourBackground(colour: UIColor.black)
                }
                if colourBG == "white" {
                    // Yellow
                    insertColourBackground(colour: UIColor.white)
                } else {
                    insertRandomAppBackground()
                }
            }
            if currentBG == 1 {
                // BG is 1
                insertAppBackground(fileName: "bg1")
            }
            else if currentBG == 2 {
                // BG is 2
                insertAppBackground(fileName: "bg2")
            }
            else if currentBG == 3 {
                // BG is 3
                insertAppBackground(fileName: "bg3")
            }
            else if currentBG == 4 {
                // BG is 4
                insertAppBackground(fileName: "bg4")
            }
            else if currentBG == 5 {
                // BG is 5
                insertAppBackground(fileName: "bg5")
            }
            else if currentBG == 6 {
                // BG is 6
                insertAppBackground(fileName: "bg6")
            } else {
                // No background set: likely first launch
                insertRandomAppBackground()
            }
            
        }
    }

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var greetingText: UILabel!
        
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Text field
        self.textField.delegate = self
        
        // Dark \ light
      /*  while true {
            backgroundBlur()
            sleep(5)
        }
        */
        // Get current time
        let hour = Calendar.current.component(.hour, from: Date())
        
        // Define times
        let morningTimes = [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11]
        let afternoonTimes = [12, 13, 14, 15, 16]
        let eveningTimes = [17, 18, 19, 20, 21, 22, 23]
        
        // Set background
        setBG()
        // Get name
        // Check if has been deleted
        if nameCleared == true {
            // Name has recently been cleared
            // No name
            // Define no name greets
            let morningGreets = ["Got much planned for today?", "Doing much today?", "New day, fresh thoughts!", "It's a fresh day, make it your best yet!", "Enjoy your day!", "Have an amazing day!"]
            let afternoonGreets = ["How are you today?", "How's your day?", "Are you doing well?", "Is your day going well?", "How's things?", "Got much planned for later today?"]
            let eveningGreets = ["How was your day?", "Did you do much today?", "Was today good?", "Did you enjoy your day?"]
            // Check time for random greet
            if morningTimes.contains(hour) {
                // Morning
                randomGreet = morningGreets.randomElement()!
                
            }
            if afternoonTimes.contains(hour) {
                // Afternoon
                randomGreet = afternoonGreets.randomElement()!
            }
            if eveningTimes.contains(hour) {
                // Evening
                randomGreet = eveningGreets.randomElement()!
            }
            greetingText.text = randomGreet
            navBar.title = "Hey!"
        }
        else {
            if let name = defaults.string(forKey: "name") {
                let isEmpty = name.isEmpty
                if isEmpty == true {
                    // No name
                    // Define no name greets
                    let morningGreets = ["Got much planned for today?", "Doing much today?", "New day, fresh thoughts!", "It's a fresh day, make it your best yet!", "Enjoy your day!", "Have an amazing day!"]
                    let afternoonGreets = ["How are you today?", "How's your day?", "Are you doing well?", "Is your day going well?", "How's things?", "Got much planned for later today?"]
                    let eveningGreets = ["How was your day?", "Did you do much today?", "Was today good?", "Did you enjoy your day?"]
                    // Check time for random greet
                    if morningTimes.contains(hour) {
                        // Morning
                        randomGreet = morningGreets.randomElement()!
                    }
                    if afternoonTimes.contains(hour) {
                        // Afternoon
                        randomGreet = afternoonGreets.randomElement()!
                    }
                    if eveningTimes.contains(hour) {
                        // Evening
                        randomGreet = eveningGreets.randomElement()!
                    }
                    greetingText.text = randomGreet
                    navBar.title = "Hey!"
                }
                if isEmpty == false {
                    // Name is saved
                    // Define name greets
                    let morningGreets = ["Got much planned for today, \(name)?", "Doing much today?", "New day, fresh thoughts!", "It's a fresh day, make it your best yet!", "Enjoy your day, \(name).", "Have an amazing day, \(name)."]
                    let afternoonGreets = ["How are you today, \(name)?", "How's your day?", "Are you doing well?", "Is your day going well, \(name)?", "How's things?", "Got much planned for later today, \(name)?"]
                    let eveningGreets = ["How was your day, \(name)?", "Did you do much today?", "Was today good, \(name)?", "Did you enjoy your day, \(name)?"]
                    // Check time for random greet
                    if morningTimes.contains(hour) {
                        // Morning
                        randomGreet = morningGreets.randomElement()!
                        navBar.title = "Morning, \(name)!"
                    }
                    if afternoonTimes.contains(hour) {
                        // Afternoon
                        randomGreet = afternoonGreets.randomElement()!
                        navBar.title = "Afternoon, \(name)!"
                    }
                    if eveningTimes.contains(hour) {
                        // Evening
                        randomGreet = eveningGreets.randomElement()!
                        navBar.title = "Evening, \(name)!"
                    }
                    greetingText.text = randomGreet
                    
                }
            }
        }


    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .systemBackground
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let colourBG = defaults.object(forKey: "colour-background") as? String
        if colourBG != "NONE" {
            if colourBG == "green" {
                // Green
                textField.backgroundColor = UIColor.systemGreen
            }
            if colourBG == "indigo" {
                // Indigo
                textField.backgroundColor = UIColor.systemIndigo
            }
            if colourBG == "orange" {
                // Orange
                textField.backgroundColor = UIColor.systemOrange
            }
            if colourBG == "pink" {
                // Pink
                textField.backgroundColor =  UIColor.systemPink
            }
            if colourBG == "purple" {
                // Purple
                textField.backgroundColor = UIColor.systemPurple
            }
            if colourBG == "red" {
                // Red
                textField.backgroundColor = UIColor.systemRed
            }
            if colourBG == "teal" {
                // Teal
                textField.backgroundColor = UIColor.systemTeal
            }
            if colourBG == "yellow" {
                // Yellow
                textField.backgroundColor = UIColor.systemYellow
            }
            if colourBG == "black" {
                // Yellow
                textField.backgroundColor = UIColor.black
            }
            if colourBG == "white" {
                // Yellow
                textField.backgroundColor = UIColor.white
            }
            // No colour set
        } else {
            textField.backgroundColor = UIColor.tertiarySystemGroupedBackground
        }
    }

    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Run when the Done button is tapped on any keybaord in this view
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Define blur
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        
        // Start delete here
        let alertController = UIAlertController(title: "Just to check...", message: "You're about to lose your entry forever.", preferredStyle: .alert)
        
        // Defines the name and type. In this case, its cancel, therefore it will be blue.
        let action2 = UIAlertAction(title: "I'm not done", style: .cancel) { (action:UIAlertAction) in
            blurVisualEffectView.removeFromSuperview()
            // Do nothing.
        }
        
        
        
        // Defines the name and type. In this case, its destructive, therefore it will be red.
        let action1 = UIAlertAction(title: "I'm done", style: .destructive) { (action:UIAlertAction) in
            blurVisualEffectView.removeFromSuperview()
            
            // Calls the text field, then ".text" tells the app that you're talking about the text in the field.
            self.textField.text = ""
            
            // Tells the keybaord to dismiss. If you wanted to bring up the keybaord automatically, you would say "self.yourThoughtsTextField.becomeFirstResponder()"
            self.textField.resignFirstResponder()
            
        }
        
        self.view.addSubview(blurVisualEffectView)
        
        // Adds the specefied actions
        alertController.addAction(action1)
        alertController.addAction(action2)
        // Presents the alert
        self.present(alertController, animated: true, completion: nil)
        // End delete here
        
   
  
        
        // Tells the keybaord to dismiss. If you wanted to bring up the keybaord automatically, you would say "self.yourThoughtsTextField.becomeFirstResponder()"
        self.textField.resignFirstResponder()
        return true
    }


}

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }
}
