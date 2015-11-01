//
//  ViewController.swift
//  Calculator
//
//  Created by Taylor Mott on 10/29/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    
    var displayLabel = UILabel()
    
    var isInTheMiddleOfTyping = false
    
    var displayValue: Float {
        get {
            let valueDisplay = displayLabel.text ?? "0"
            return (valueDisplay as NSString).floatValue
            
        } set {
            isInTheMiddleOfTyping = false
            displayLabel.text = "\(newValue)"
            
        }
    }
    
    
    var stack = Stack()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // MARK: LABEL
        displayLabel.text = "0"
        displayLabel.textColor = .whiteColor()
        displayLabel.textAlignment = .Right
        displayLabel.font = UIFont(name: "Arial", size: 100)
        displayLabel.backgroundColor = .blackColor()
        self.view.addSubview(displayLabel)
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var constraint = NSLayoutConstraint(item: displayLabel, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: displayLabel, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: displayLabel, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: displayLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 120)
        displayLabel.addConstraint(constraint)
        
        //MARK: 0 - 9 Button
        
        var numberButtonArray = [UIButton] ()
        
        
        for number in 0...9 {
            let button = UIButton()
            button.setTitle("\(number)", forState: .Normal)
            button.backgroundColor = UIColor.grayColor()
            button.setTitleColor(.blackColor(), forState: .Normal)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.blackColor().CGColor
            
            //Font size
            button.titleLabel?.font = UIFont.systemFontOfSize(25)
            
            
            self.view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            numberButtonArray.append(button)
            button.addTarget(self, action: "appendDigit:", forControlEvents: .TouchUpInside)
            
        }
        
        //MARK: Operation Button
        
        var operationButtonArray = [UIButton] ()
        
        let operationArray = ["/" ,"*", "-", "↵", "+"]
        
        
        for operation in operationArray {
            
            let button = UIButton()
            
            button.setTitle("\(operation)", forState: .Normal)
            button.backgroundColor = UIColor.orangeColor()
            button.setTitleColor(.whiteColor(), forState: .Normal)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.blackColor().CGColor
            
            //Font size
            button.titleLabel?.font = UIFont.systemFontOfSize(25)
            
            self.view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            operationButtonArray.append(button)
            
        }
        
        //MARK: Implement Buttion Action
        operationButtonArray[3].addTarget(self, action: "enter", forControlEvents: .TouchUpInside)
        
        //MARK: Constraint
        
        // Top Row
        
        constraint = NSLayoutConstraint(item: numberButtonArray[7], attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[7], attribute: .Top, relatedBy: .Equal, toItem: displayLabel, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        
        constraint = NSLayoutConstraint(item: numberButtonArray[8], attribute: .Leading, relatedBy: .Equal, toItem: numberButtonArray[7], attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[8], attribute: .Top, relatedBy: .Equal, toItem: displayLabel, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[9], attribute: .Leading, relatedBy: .Equal, toItem: numberButtonArray[8], attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[9], attribute: .Top, relatedBy: .Equal, toItem: displayLabel, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: operationButtonArray[0], attribute: .Leading, relatedBy: .Equal, toItem: numberButtonArray[9], attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: operationButtonArray[0], attribute: .Top, relatedBy: .Equal, toItem: displayLabel, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        // Second Row
        
        constraint = NSLayoutConstraint(item: numberButtonArray[4], attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[4], attribute: .Top, relatedBy: .Equal, toItem: numberButtonArray[7], attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        
        constraint = NSLayoutConstraint(item: numberButtonArray[5], attribute: .Leading, relatedBy: .Equal, toItem: numberButtonArray[4], attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[5], attribute: .Top, relatedBy: .Equal, toItem: numberButtonArray[8], attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[6], attribute: .Leading, relatedBy: .Equal, toItem: numberButtonArray[5], attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[6], attribute: .Top, relatedBy: .Equal, toItem: numberButtonArray[9], attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: operationButtonArray[1], attribute: .Leading, relatedBy: .Equal, toItem: numberButtonArray[6], attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: operationButtonArray[1], attribute: .Top, relatedBy: .Equal, toItem: operationButtonArray[0], attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        // Third Row
        
        constraint = NSLayoutConstraint(item: numberButtonArray[1], attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[1], attribute: .Top, relatedBy: .Equal, toItem: numberButtonArray[4], attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        
        constraint = NSLayoutConstraint(item: numberButtonArray[2], attribute: .Leading, relatedBy: .Equal, toItem: numberButtonArray[1], attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[2], attribute: .Top, relatedBy: .Equal, toItem: numberButtonArray[5], attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[3], attribute: .Leading, relatedBy: .Equal, toItem: numberButtonArray[2], attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[3], attribute: .Top, relatedBy: .Equal, toItem: numberButtonArray[6], attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: operationButtonArray[2], attribute: .Leading, relatedBy: .Equal, toItem: numberButtonArray[3], attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: operationButtonArray[2], attribute: .Top, relatedBy: .Equal, toItem: operationButtonArray[1], attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        // Fourth Row
        
        constraint = NSLayoutConstraint(item: numberButtonArray[0], attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[0], attribute: .Top, relatedBy: .Equal, toItem: numberButtonArray[1], attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[0], attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.5, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: numberButtonArray[0], attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: operationButtonArray[3], attribute: .Leading, relatedBy: .Equal, toItem: numberButtonArray[0], attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: operationButtonArray[3], attribute: .Top, relatedBy: .Equal, toItem: numberButtonArray[2], attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: operationButtonArray[3], attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: operationButtonArray[4], attribute: .Leading, relatedBy: .Equal, toItem: operationButtonArray[3], attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: operationButtonArray[4], attribute: .Top, relatedBy: .Equal, toItem:operationButtonArray[2], attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: operationButtonArray[4], attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(constraint)
        
        //        let newNumberButtonArray = [numberButtonArray, operationButtonArray[3]]
        //        for button in newNumberButtonArray {
        //
        //            constraint = NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: numberButtonArray[7], attribute: .Height, multiplier: 1, constant: 0)
        //            view.addConstraint(constraint)
        //
        //            constraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: 0)
        //           view.addConstraint(constraint)
        //
        //        }
        //        for button in operationButtonArray {
        //
        //            constraint = NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: 100)
        //            button.addConstraint(constraint)
        //
        //            constraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: 100)
        //            button.addConstraint(constraint)
        //        }
        
        let heightArray = [numberButtonArray[0], numberButtonArray[1], numberButtonArray[2], numberButtonArray[3], numberButtonArray[4], numberButtonArray[5], numberButtonArray[6], numberButtonArray[8], numberButtonArray[9], operationButtonArray[0], operationButtonArray[1], operationButtonArray[2], operationButtonArray [3] ,operationButtonArray[4]]
        
        for button in heightArray {
            let heightConstraint = NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: numberButtonArray[7], attribute: .Height, multiplier: 1, constant: 0)
            view.addConstraint(heightConstraint)
        }
        
        let widthArray = [numberButtonArray[7],numberButtonArray[1], numberButtonArray[2], numberButtonArray[3], numberButtonArray[4], numberButtonArray[5], numberButtonArray[6], numberButtonArray[8], numberButtonArray[9], operationButtonArray[0], operationButtonArray[1], operationButtonArray[2], operationButtonArray [3] ,operationButtonArray[4]]
        
        for button in widthArray {
            let widthConstraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.25, constant: 0.0)
            view.addConstraint(widthConstraint)
        }
    }
    
    //MARK: Function
    func appendDigit(button: UIButton) {
        
        
        guard let digit = button.currentTitle else {return}
        
        if isInTheMiddleOfTyping {
            let displayText = displayLabel.text ?? ""
                displayLabel.text = displayText + digit
            
        } else {
            displayLabel.text = digit
            isInTheMiddleOfTyping = true
            
        }
    }
    
    func enter() {
        isInTheMiddleOfTyping = false
        stack.push(displayValue)
        stack.pop()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
