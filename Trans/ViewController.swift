//
//  ViewController.swift
//  Trans
//
//  Created by Shinzato on 2015/01/05.
//  Copyright (c) 2015年 Shinzato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var toptext: UITextField!
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated) //エフェクト関係のパラメタだと思うが、今回は使用しないので、基底クラスを呼び出して、終わり。
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateオブジェクトの呼び出し。as ◯◯はSwiftのキャスト表現
        appDelegate.ViewVal = toptext.text // TextFieldの値を取得し、値引き渡し用のプロパティにセット
    }

    @IBOutlet weak var ido: UILabel!
    
    @IBOutlet weak var keido: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        ido.text =  appDelegate.ViewLl // Labelに値引き渡し用のプロパティから取得して設定する。
        keido.text =  appDelegate.ViewAdd // Labelに値引き渡し用のプロパティから取得して設定する。
    }
    

}

