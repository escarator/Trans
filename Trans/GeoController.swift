//
//  testView.swift
//  screenTranslation
//
//  Created by えす on 2014/12/16.
//  Copyright (c) 2014年 motoshi. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

// CLLocationManagerDelegateを継承
class GeoController: UIViewController, CLLocationManagerDelegate {
    
    var lm:CLLocationManager
    var longitude: CLLocationDegrees
    var latitude: CLLocationDegrees
    
    // storyboardで関連づけるLabel
    @IBOutlet var latlonLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    // CLLocationManagerDelegateを継承すると、init()が必要になる
    required init(coder aDecoder: NSCoder) {
        lm = CLLocationManager()
        longitude = CLLocationDegrees()
        latitude = CLLocationDegrees()
        super.init(coder: aDecoder)
    }
    
    // ボタンが押された時の処理（storyboardで関連づける）
    @IBAction func btnGetLocation(sender: AnyObject) {
        // get latitude and longitude
        lm.startUpdatingLocation()
    }
    
    // 画面表示後の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lm = CLLocationManager()
        lm.delegate = self
        
        // セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
        
        // まだ認証が得られていない場合は、認証ダイアログを表示
        if status == CLAuthorizationStatus.NotDetermined {
            println("didChangeAuthorizationStatus:\(status)");
            // まだ承認が得られていない場合は、認証ダイアログを表示
            self.lm.requestAlwaysAuthorization()
        }
        
        // 取得精度の設定
        lm.desiredAccuracy = kCLLocationAccuracyBest
        // 取得頻度の設定
        lm.distanceFilter = 100
    }
    
    // 位置情報取得成功時
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
        
        longitude = newLocation.coordinate.longitude
        latitude = newLocation.coordinate.latitude
        self.latlonLabel.text = "\(longitude), \(latitude)"
        
        // get address
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            if error != nil {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
                //stop updating location to save battery life
                self.lm.stopUpdatingLocation()
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    // 位置情報表示
    func displayLocationInfo(placemark: CLPlacemark) {
        var address: String = ""
        address = placemark.locality != nil ? placemark.locality : ""
        address += ","
        address += placemark.postalCode != nil ? placemark.postalCode : ""
        address += ","
        address += placemark.administrativeArea != nil ? placemark.administrativeArea : ""
        address += ","
        address += placemark.country != nil ? placemark.country : ""
        self.addressLabel.text = address
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated) //エフェクト関係のパラメタだと思うが、今回は使用しないので、基底クラスを呼び出して、終わり。
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateオブジェクトの呼び出し。as ◯◯はSwiftのキャスト表現
        appDelegate.ViewLl = self.latlonLabel.text!
        appDelegate.ViewAdd = self.addressLabel.text!// TextFieldの値を取得し、値引き渡し用のプロパティにセット
    }

    
    // 位置情報取得失敗時
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        NSLog("Error while updating location. " + error.localizedDescription)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}