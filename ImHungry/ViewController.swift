//
//  ViewController.swift
//  ImHungry
//
//  Created by ShaoTianchi on 14-7-5.
//  Copyright (c) 2014年 rainbow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isFirstResponder = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController.setNavigationBarHidden(true,animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.isFirstResponder = true
        self.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.resignFirstResponder()
        self.isFirstResponder = false
        super.viewWillDisappear(animated)
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true;
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent!){
        if motion == .MotionShake && self.isFirstResponder {
            self.performSegueWithIdentifier("Main2Map",sender: self);
        }
    }

}

