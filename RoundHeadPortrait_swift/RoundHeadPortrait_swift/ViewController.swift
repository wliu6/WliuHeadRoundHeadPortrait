//
//  ViewController.swift
//  RoundHeadPortrait_swift
//
//  Created by 66 on 15/8/17.
//  Copyright (c) 2015年 w66. All rights reserved.
//

import UIKit
class ViewController: UIViewController,WliuHeadPortraitViewDelegate {
    @IBOutlet var headIcon5: WliuHeadPortraitImageView!
    @IBOutlet var headIcon6: WliuHeadPortraitImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var headIcon : WliuHeadPortraitImageView = WliuHeadPortraitImageView(frame: CGRect(x: 100, y:100, width: 100, height: 360))
        headIcon.image = UIImage(named: "C2E2ECFA02295635822CC3BE760DBE7B.png")
        headIcon.borderWidth = 3
        headIcon.borderColor = UIColor.blackColor()
        headIcon.maskBGColor = UIColor.whiteColor()
        headIcon.maskAlpha = 0.6
        headIcon.highlightMaskViewBGColor = UIColor.whiteColor()
        headIcon.highlightMaskViewAlpha = 0.6
        headIcon.highlightBorderColor = UIColor.cyanColor()
        headIcon.highlightBorderWidth = 6
        headIcon.delegate = self
        self.view.addSubview(headIcon)
//
        var headIcon1 : WliuHeadPortraitImageView = WliuHeadPortraitImageView(frame: CGRect(x: 100, y:300, width: 100, height: 200), boardWidth: 3, boardColor: UIColor.blueColor())
        headIcon1.cornerRadius = 12
        headIcon1.image = UIImage(named: "C2E2ECFA02295635822CC3BE760DBE7B.png")
        headIcon1.maskBGColor = UIColor.whiteColor()
        headIcon1.maskAlpha = 0.6
        headIcon1.highlightMaskViewBGColor = UIColor.blackColor()
        headIcon1.highlightMaskViewAlpha = 0.6
        headIcon1.highlightBorderColor = UIColor.orangeColor()
        headIcon1.highlightBorderWidth = 6
//        headIcon1.wwwwww = 666666
//        println(headIcon1.wwwwww)
        headIcon1.delegate = self
        self.view.addSubview(headIcon1)
        
        var headIcon2 : WliuHeadPortraitImageView = WliuHeadPortraitImageView(image: UIImage(named: "C2E2ECFA02295635822CC3BE760DBE7B.png"))
        headIcon2.frame = CGRect(x: 200, y:150, width: 100, height: 200)
        headIcon2.maskBGColor = UIColor.whiteColor()
        headIcon2.maskAlpha = 0.6
        headIcon2.highlightMaskViewBGColor = UIColor.blackColor()
        headIcon2.highlightMaskViewAlpha = 0.6
        headIcon2.highlightBorderColor = UIColor.purpleColor()
        headIcon2.highlightBorderWidth = 6
        headIcon2.delegate = self
        self.view.addSubview(headIcon2)
        
        headIcon5.delegate = self
        headIcon6.delegate = self
    }
    
    func isClicked() {
        println("666666")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

