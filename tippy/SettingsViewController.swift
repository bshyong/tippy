//
//  SettingsViewController.swift
//  tippy
//
//  Created by Benjamin Shyong on 12/17/14.
//  Copyright (c) 2014 Common Sense Labs. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

  @IBOutlet weak var defaultTipSetting: UISegmentedControl!
  @IBOutlet weak var defaultThemeSetting: UISegmentedControl!

  override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    var defaults = NSUserDefaults.standardUserDefaults()
    var defaultTipPercentageIndex = defaults.objectForKey("defaultTipPercentageIndex") as Int?
    var defaultThemeIndex = defaults.objectForKey("defaultThemeIndex") as Int?
    
    defaultTipSetting.selectedSegmentIndex = defaultTipPercentageIndex ?? 0
    defaultThemeSetting.selectedSegmentIndex = defaultThemeIndex ?? 0
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
    
  @IBAction func cancelSettingsPressed(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil);
  }

  // Save the settings and then dismiss current view
  @IBAction func saveSettingsPressed(sender: AnyObject) {
    var defaults = NSUserDefaults.standardUserDefaults()

    var selectedTipPercentageIndex = defaultTipSetting.selectedSegmentIndex ?? 0
    var selectedThemeIndex = defaultThemeSetting.selectedSegmentIndex ?? 0

    defaults.setInteger(selectedTipPercentageIndex, forKey: "defaultTipPercentageIndex")
    defaults.setInteger(selectedThemeIndex, forKey: "defaultThemeIndex")
    defaults.synchronize()
    self.dismissViewControllerAnimated(true, completion: nil);
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
