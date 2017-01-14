//
//  ViewController.swift
//  tapGestureChim
//
//  Created by datnguyen on 11/5/16.
//  Copyright © 2016 datnguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var imgChim: UIImageView!
    
    @IBOutlet weak var cuc1: UIView!
    @IBOutlet weak var cuc2: UIView!
    
    
    
    
    var timer:Timer!
    var timerChim:Timer!
    let thoigian:Double = 10
    
    
    
    func tapChim(_ sender: Any) {
        if imgChim.frame.origin.y > imgChim.frame.size.height {
            imgChim.frame.origin.y -= 20
        }
    }
    
    
    
    func manhinhdichuyen(){
        let tranfomr = CATransform3DTranslate(CATransform3DIdentity, 400, 0, 0)
        UIView.animate(withDuration: thoigian, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.imgView.layer.transform = tranfomr
        }, completion: {(true) in
            self.imgView.layer.transform = CATransform3DIdentity
            self.manhinhdichuyen()
        })
    }
    
    func roiChim(){
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            if self.imgChim.frame.origin.y <= self.view.frame.size.height - self.imgChim.frame.size.height{
                self.imgChim.frame.origin.y += 50
            }
        }, completion: { (false) in
            self.roiChim()
        })
        
    }
    
    
    func randomOng() {
        
        /// **Tạo Biến** Gom Code Dễ Sửa
        let khoangcach2cuc:UInt32 = 150
        
        if self.cuc1.frame.origin.x < self.view.frame.size.width - self.cuc1.frame.size.width {
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                self.cuc1.frame.origin.x += 50
                self.cuc2.frame.origin.x += 50
            }, completion: { (true) in
                self.randomOng()
            })
            
            if cuc2.frame.origin.x + imgChim.frame.size.width >= imgChim.frame.origin.x && imgChim.frame.origin.x >= cuc2.frame.origin.x && (imgChim.frame.origin.y + imgChim.frame.size.height <= cuc1.frame.size.height || imgChim.frame.origin.y + imgChim.frame.size.height >= cuc1.frame.size.height + CGFloat(khoangcach2cuc))
                
            {
                imgChim.frame.origin.x = (cuc2.frame.origin.x + imgChim.frame.size.width)

            }
        } else {
            
            /// Vị trí Cuc1,Cuc2 Xuất Hiện
            self.cuc1.frame.origin.x = (-(self.cuc1.frame.size.width))
            self.cuc2.frame.origin.x = (-(self.cuc2.frame.size.width))
            
            /// Random Heigh Cuc1
            let rd1 = arc4random_uniform(400)
            /// Heigh Cuc2 = Heigh View - (Heigh Cuc1(rd1) + khoảng cách 2 Cục)
            let rd2 = UInt32(view.frame.size.height) - (rd1 + khoangcach2cuc)
            
            
            cuc1.frame.size.height = CGFloat(rd1)
            
            cuc2.frame.origin.y = cuc1.frame.size.height + CGFloat(khoangcach2cuc)
            cuc2.frame.size.height = CGFloat(rd2)
            
            /// Gọi Để Func Chạy Lại(Thay Timer)
            self.randomOng()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //timer = Timer.scheduledTimer(timeInterval: thoigian + 0.2, target: self, selector: #selector(ViewController.manhinhdichuyen), userInfo: nil, repeats: true)
        
        manhinhdichuyen()
        roiChim()
        randomOng()
        
        //timerChim = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(ViewController.roiChim), userInfo: nil, repeats: true)
        
        let tapges = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapChim(_:)))
        view.addGestureRecognizer(tapges)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

