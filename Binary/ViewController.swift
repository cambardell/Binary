//
//  ViewController.swift
//  Binary
//
//  Created by Cameron Bardell on 2018-07-09.
//  Copyright © 2018 101. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!

    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var maxSlider: UISlider!
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var maxValueLabel: UILabel!
    var inputArray: Array = [String]()
    var targetInt = 0
    var targetStr = ""
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-8931001791876087/1244299109"
        bannerView.rootViewController = self
        bannerView.delegate = self
        addBannerViewToView(bannerView)
        let request = GADRequest()
        
        bannerView.load(request)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playButton(_ sender: Any) {
        if counter != 0{
            checkValues()
        } else {
            newTarget()
            maxSlider.isHidden = true
            instructionLabel.isHidden = true
            playButton.setTitle("Submit", for: .normal)
            counter = 30
            timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(timerUp), userInfo: nil, repeats: true)
        }
        
   
    }
    
    func newTarget() {
        targetInt = Int(arc4random_uniform(UInt32(maxSlider.value)))
        targetStr = String(targetInt, radix: 2)
        print(targetStr)
        targetLabel.text = String(targetInt)
        inputLabel.text = ""
        inputArray = []
    }
    
    @objc func timerUp() {
        counter -= 1
        timerLabel.text = String(counter)
        if counter == 0 {
            endGame()
        }
    }
    
    func endGame() {
        timer.invalidate()
        playButton.setTitle("Play", for: .normal)
        maxSlider.isHidden = false
        instructionLabel.isHidden = false
    }
    
    @IBAction func oneButton(_ sender: Any) {
        if counter != 0 {
            inputArray.insert("1", at: 0)
            inputLabel.text = inputArray.joined(separator: "")
        }
        
    }
    
    @IBAction func zeroButton(_ sender: Any) {
        if counter != 0 {
            inputArray.insert("0", at: 0)
            inputLabel.text = inputArray.joined(separator: "")
        }
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        if counter != 0 && !inputArray.isEmpty {
            inputArray.removeFirst()
            inputLabel.text = inputArray.joined(separator: "")
        }
        
    }
    
    func checkValues() {
        let inputInt = inputArray.joined(separator: "")
        if inputInt == targetStr {
            newTarget()
            
            counter += 2
        }
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
        maxValueLabel.text = String(Int(maxSlider.value))
    }
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}

