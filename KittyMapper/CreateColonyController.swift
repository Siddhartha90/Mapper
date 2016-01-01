//
//  CreateColonyController.swift
//  KittyMapper
//
//  Created by Siddhartha Gupta on 12/30/15.
//
//

import Parse
import UIKit

class CreateColonyController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var colonyNameField: UITextField!
    @IBOutlet var numberOfCatsField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var numericError: UILabel!
    
    @IBAction func done(sender: AnyObject) {
        let colonyName = self.colonyNameField.text
        let numberOfCats = self.numberOfCatsField.text
        let address = self.addressField.text
        
//         Validate input.
        if (Int(numberOfCats!) == nil) {
            // Re-insist error that was previously shown when leaving the text box.
            reshowError()
            return
        }
        
        let testObject = PFObject(className: "Colony")
        testObject["name"] = colonyName
        testObject["NumCats"] = numberOfCats
        testObject["Address"] = address
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if ((error) != nil) {
                print("Somethings wrong with parse db.")
            }
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (colonyNameField.hasText() && numberOfCatsField.hasText() && addressField.hasText()) {
          doneButton.enabled = true
        }
        else {
        doneButton.enabled = false
        }
        
        let numberOfCats = self.numberOfCatsField.text
        if (textField.tag == 1) {
            if (Int(numberOfCats!) == nil) {
                numericError.hidden = false
            }
            else {
                numericError.hidden = true
            }
        }
    }
    
    func reshowError() {
        numericError.hidden = true
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "showNumericError:", userInfo: self, repeats: false)    
    }
    
    func showNumericError(timer: NSTimer) {
        numericError.hidden = false
    }
    
    
//    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
//        return .None
//    }
    
//    func showAlertPopover() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("AlertController") as! AlertController
//        vc.modalPresentationStyle = .Popover
//        vc.preferredContentSize = CGSizeMake(100, 25)
//        
//        if let popoverController = vc.popoverPresentationController {
//            popoverController.delegate = self
//            popoverController.sourceRect = CGRectMake(100, 200, 5, 3)
//            popoverController.sourceView = self.view
//            self.presentViewController(vc, animated: true, completion: nil)
//        
//        
////            let catFieldView = view.viewWithTag(9)
////                        print("printing: ")
////            print(catFieldView?.frame.width)
//            
//        let bottomConstraint = NSLayoutConstraint(item: popoverController, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 5)
//        let leftConstraint = NSLayoutConstraint(item: popoverController, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: 5)
//        self.view.addConstraint(bottomConstraint)
//        self.view.addConstraint(leftConstraint)        
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.enabled = false
        
        colonyNameField.delegate = self
        numberOfCatsField.delegate = self
        addressField.delegate = self
        
        numberOfCatsField.tag = 1
        
        numericError.hidden = true
        numericError.backgroundColor = UIColor.whiteColor()
        numericError.layer.borderWidth = 1.0
        numericError.layer.borderColor = UIColor.blackColor().CGColor
        
    }
    
}
