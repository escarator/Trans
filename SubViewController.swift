//
//  ViewController.swift
//  Trans
//
//  Created by Shinzato on 2015/01/05.
//  Copyright (c) 2015年 Shinzato. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        label.text =  appDelegate.ViewVal // Labelに値引き渡し用のプロパティから取得して設定する。
    }
    
    @IBOutlet weak var label: UILabel!
    
}

