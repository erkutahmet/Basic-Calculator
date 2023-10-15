//
//  ViewController.swift
//  Basic Calculator
//
//  Created by Ahmet Erkut on 15.10.2023.
//

import UIKit

class ViewController: UIViewController {

    private var firstNumber = ""
    private var secondNumber = ""
    private var operation = ""
    private var haveResult = false
    private var resultNumber = ""
    private var numAfterResult = ""
    private var clickedButton = ""

    @IBOutlet weak var divButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var subsButton: UIButton!
    @IBOutlet weak var sumButton: UIButton!

    @IBOutlet private weak var numOnScreen: UILabel!
    @IBOutlet private var calcButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        for button in calcButtons {
            button.layer.cornerRadius = button.frame.size.height / 2
        }
    }
    
    private func errorDivByZero() {
        let alert = UIAlertController(title: "Error", message: "Divide by Zero", preferredStyle: .alert)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    private func doOperation() -> Double {
        switch operation {
            case "+":
                if !haveResult {
                    haveResult = true
                    return (Double(firstNumber) ?? 0) + (Double(secondNumber) ?? 0)
                } else {
                    return (Double(resultNumber) ?? 0) + (Double(numAfterResult) ?? 0)
                }
            case "-":
                if !haveResult {
                    haveResult = true
                    return (Double(firstNumber) ?? 0) - (Double(secondNumber) ?? 0)
                } else {
                    return (Double(resultNumber) ?? 0) - (Double(numAfterResult) ?? 0)
                }
            case "*":
                if !haveResult {
                    haveResult = true
                    return (Double(firstNumber) ?? 1) * (Double(secondNumber) ?? 1)
                } else {
                    return (Double(resultNumber) ?? 1) * (Double(numAfterResult) ?? 1)
                }
            case "/":
                if !haveResult {
                    haveResult = true
                    if Double(secondNumber) == 0 {
                        errorDivByZero()
                    } else {
                        return (Double(firstNumber) ?? 1) / (Double(secondNumber) ?? 1)
                    }
                } else {
                    if Double(numAfterResult) == 0 {
                        errorDivByZero()
                    } else {
                        return (Double(resultNumber) ?? 1) / (Double(numAfterResult) ?? 1)
                    }
                }
            default:
                print("Unavailable operation!")
        }
        return 0
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        defaultButtonColors()
        if operation == "" {
            if numOnScreen.text == "0" && String(sender.tag) != "0" {
                firstNumber = String(sender.tag)
                numOnScreen.text = firstNumber
            } else if numOnScreen.text != "0" {
                firstNumber += String(sender.tag)
                numOnScreen.text = firstNumber
            } else {
                print("Error of typing")
            }
        } else if operation != "" && !haveResult {
            if numOnScreen.text == "0" && String(sender.tag) != "0" {
                secondNumber = String(sender.tag)
                numOnScreen.text = secondNumber
            } else if numOnScreen.text != "0" {
                secondNumber += String(sender.tag)
                numOnScreen.text = secondNumber
            } else {
                print("Error of typing")
            }
        } else if operation != "" && haveResult {
            if numOnScreen.text == "0" && String(sender.tag) != "0" {
                numAfterResult = String(sender.tag)
                numOnScreen.text = numAfterResult
            } else if numOnScreen.text != "0" {
                numAfterResult += String(sender.tag)
                numOnScreen.text = numAfterResult
            } else {
                print("Error of typing")
            }
        }
    }
    
    @IBAction func allClear(_ sender: Any) {
        firstNumber = ""
        secondNumber = ""
        operation = ""
        haveResult = false
        resultNumber = ""
        numAfterResult = ""
        numOnScreen.text = "0"
        defaultButtonColors()
    }
    
    @IBAction func sum(_ sender: Any) {
        operation = "+"
        clickedButton = "+"
        buttonTapped()
    }
    
    @IBAction func subs(_ sender: Any) {
        operation = "-"
        clickedButton = "-"
        buttonTapped()
    }
    
    @IBAction func multiply(_ sender: Any) {
        operation = "*"
        clickedButton = "*"
        buttonTapped()
    }
    
    @IBAction func div(_ sender: Any) {
        operation = "/"
        clickedButton = "/"
        buttonTapped()
    }
    
    private func defaultButtonColors() {
        sumButton.backgroundColor = UIColor.systemOrange
        sumButton.tintColor = UIColor.white
        subsButton.backgroundColor = UIColor.systemOrange
        subsButton.tintColor = UIColor.white
        multiplyButton.backgroundColor = UIColor.systemOrange
        multiplyButton.tintColor = UIColor.white
        divButton.backgroundColor = UIColor.systemOrange
        divButton.tintColor = UIColor.white
    }
    
    private func buttonTapped() {
        switch clickedButton {
            case "+":
                sumButton.backgroundColor = UIColor.white
                sumButton.tintColor = UIColor.systemOrange
                subsButton.backgroundColor = UIColor.systemOrange
                subsButton.tintColor = UIColor.white
                multiplyButton.backgroundColor = UIColor.systemOrange
                multiplyButton.tintColor = UIColor.white
                divButton.backgroundColor = UIColor.systemOrange
                divButton.tintColor = UIColor.white
            case "-":
                subsButton.backgroundColor = UIColor.white
                subsButton.tintColor = UIColor.systemOrange
                sumButton.backgroundColor = UIColor.systemOrange
                sumButton.tintColor = UIColor.white
                multiplyButton.backgroundColor = UIColor.systemOrange
                multiplyButton.tintColor = UIColor.white
                divButton.backgroundColor = UIColor.systemOrange
                divButton.tintColor = UIColor.white
            case "*":
                multiplyButton.backgroundColor = UIColor.white
                multiplyButton.tintColor = UIColor.systemOrange
                sumButton.backgroundColor = UIColor.systemOrange
                sumButton.tintColor = UIColor.white
                subsButton.backgroundColor = UIColor.systemOrange
                subsButton.tintColor = UIColor.white
                divButton.backgroundColor = UIColor.systemOrange
                divButton.tintColor = UIColor.white
            case "/":
                divButton.backgroundColor = UIColor.white
                divButton.tintColor = UIColor.systemOrange
                sumButton.backgroundColor = UIColor.systemOrange
                sumButton.tintColor = UIColor.white
                subsButton.backgroundColor = UIColor.systemOrange
                subsButton.tintColor = UIColor.white
                multiplyButton.backgroundColor = UIColor.systemOrange
                multiplyButton.tintColor = UIColor.white
            default:
                print("Unavaliable Button")
        }
    }
    
    @IBAction func equals(_ sender: Any) {
        defaultButtonColors()
        resultNumber = String(doOperation())
        let numArray = resultNumber.components(separatedBy: ".")
        if numArray[1] == "0" {
            numOnScreen.text = numArray[0]
        } else {
            numOnScreen.text = resultNumber
        }
        numAfterResult = ""
    }
}

