//
//  ViewController.swift
//  tippy
//
//  Created by Benjamin Shyong on 12/13/14.
//  Copyright (c) 2014 Common Sense Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tipLabel: UILabel!
  @IBOutlet weak var billField: UITextField!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var tipControl: UISegmentedControl!
  @IBOutlet weak var billFieldDescription: UILabel!
  @IBOutlet weak var tipFieldDescription: UILabel!
  @IBOutlet weak var totalFieldDescription: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveInputState", name: "applicationWillExitNotification", object: nil)
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    var defaults = NSUserDefaults.standardUserDefaults()
    var defaultTipPercentageIndex = defaults.objectForKey("defaultTipPercentageIndex") as Int?

    if (defaultTipPercentageIndex != nil){
      tipControl.selectedSegmentIndex = defaultTipPercentageIndex!
    }
    
    var defaultThemeIndex = defaults.objectForKey("defaultThemeIndex") as Int?
    if (defaultThemeIndex == 1){
      self.view.backgroundColor = UIColor.blackColor()
      tipLabel.textColor = UIColor.whiteColor()
      totalLabel.textColor = UIColor.whiteColor()
      billFieldDescription.textColor = UIColor.whiteColor()
      tipFieldDescription.textColor = UIColor.whiteColor()
      totalFieldDescription.textColor = UIColor.whiteColor()
      tipControl.tintColor = UIColor.whiteColor()
    } else {
      self.view.backgroundColor = UIColor.whiteColor()
      tipLabel.textColor = UIColor.blackColor()
      totalLabel.textColor = UIColor.blackColor()
      billFieldDescription.textColor = UIColor.blackColor()
      tipFieldDescription.textColor = UIColor.blackColor()
      totalFieldDescription.textColor = UIColor.blackColor()
      tipControl.tintColor = UIColor.blackColor()
    }

    var lastSavedDate = defaults.objectForKey("lastSaved") as NSDate?
    
    if (lastSavedDate != nil){
      var timeSinceLastSaved = NSDate().timeIntervalSinceDate(lastSavedDate!)
      if (timeSinceLastSaved < 600){
        billField.text = defaults.objectForKey("lastBillAmount") as String?
      }
    }
  }
  
  func saveInputState(){
    var defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(NSDate(), forKey: "lastSaved")
    defaults.setObject(billField.text, forKey: "lastBillAmount")
    defaults.synchronize()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onEditingChanged(sender: AnyObject) {
    var selectedTipPercentage = Constants.TipPercentages[tipControl.selectedSegmentIndex]
    
    var billAmount = billField.text._bridgeToObjectiveC().doubleValue
    var tip = billAmount * selectedTipPercentage
    var total = billAmount + tip

    tipLabel.text = String(format: "$%.2f", tip)
    totalLabel.text = String(format: "$%.2f", total)
  }

  @IBAction func onTap(sender: AnyObject) {
    view.endEditing(true)
  }
}

