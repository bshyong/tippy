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
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onEditingChanged(sender: AnyObject) {
    var tipPercentages = [0.18, 0.2, 0.22]
    var selectedTipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
    
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

