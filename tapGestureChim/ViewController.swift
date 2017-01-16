//
//  ViewController.swift
//  tapGestureChim
//
//  Created by datnguyen on 11/5/16.
//  Copyright © 2016 datnguyen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var imgChim: UIImageView!
    
    @IBOutlet weak var cuc1: UIView!
    @IBOutlet weak var cuc2: UIView!
    
    @IBOutlet weak var lblTen: UILabel!
    @IBOutlet weak var lblDiem: UILabel!
    @IBOutlet weak var lblTapTap: UILabel!
    @IBOutlet weak var lbldiemcaonhat: UILabel!
    
    var diem:Int = 0
    
    var timer:Timer!
    var timerChim:Timer!
    let thoigian:Double = 8
    var dequy:Bool = true
    var chimx:CGFloat!
    var chimy:CGFloat!
    
    var hoten:String!
    
    var player:AVAudioPlayer = AVAudioPlayer()
    
    
    
    
    func tapChim(_ sender: Any) {
        if dequy == true {
            if imgChim.frame.origin.y > imgChim.frame.size.height {
                imgChim.frame.origin.y -= 30
                imgChim.frame.origin.x -= 5
            }
        } else {
            dequy = true
            if diem > dcn {
                userDF.set(diem, forKey: "1")
                
            }
            
            lblTapTap.isHidden = true
            ViTriChim()
            manhinhdichuyen()
            randomOng()
            roiChim()
            diem = 0
            lblDiem.text = String(diem)
        }
    }
    func nhapnhay() {
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveLinear, animations: {
            self.lblTapTap.backgroundColor = #colorLiteral(red: 1, green: 0.1677291691, blue: 0, alpha: 1)
        }, completion: { (true) in
            UIView.animate(withDuration: 1, delay: 0.1, options: .curveLinear, animations: {
                self.lblTapTap.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            }, completion: { (true) in
                self.nhapnhay()
            })
        })
        
        
    }
    
    func ViTriChim() {
        imgChim.frame.origin.x = view.frame.size.width/2 - imgChim.frame.size.width/2 // tạo lại chim
        imgChim.frame.origin.y = view.frame.size.height/2 - imgChim.frame.size.height/2 // tạo lại chim
        
        chimx = view.frame.size.width/2 - imgChim.frame.size.width/2 // lấy vị trí chim
        chimy = view.frame.size.height/2 - imgChim.frame.size.height/2 // lấy vị trí chim
        
        
    }
    
    func manhinhdichuyen(){
        let tranfomr = CATransform3DTranslate(CATransform3DIdentity, 400, 0, 0)
        UIView.animate(withDuration: thoigian, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.imgView.layer.transform = tranfomr
        }, completion: {(true) in
            self.imgView.layer.transform = CATransform3DIdentity
            if self.dequy == true {
                self.manhinhdichuyen()
            }
        })
    }
    
    func roiChim(){
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            if self.imgChim.frame.origin.y <= self.view.frame.size.height - self.imgChim.frame.size.height{
                self.imgChim.frame.origin.y += 4
                self.chimy = self.imgChim.frame.origin.y
                
            }
        }, completion: { (true) in
            if self.dequy == true {
                self.roiChim()
            }  else {
                self.lblTapTap.isHidden = false
                self.nhapnhay()
            }
        })
        
    }
    
    /// **Tạo Biến** Gom Code Dễ Sửa
    let khoangcach2cuc:UInt32 = 150
    
    func randomOng() {
        
        
        
        /// Random Heigh Cuc1
        let rd1 = arc4random_uniform(400) + 50
        /// Heigh Cuc2 = Heigh View - (Heigh Cuc1(rd1) + khoảng cách 2 Cục)
        let rd2 = UInt32(view.frame.size.height) - (rd1 + khoangcach2cuc)
        
        if self.cuc1.frame.origin.x < self.view.frame.size.width - self.cuc1.frame.size.width {
            
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.cuc1.frame.origin.x += 5
                self.cuc2.frame.origin.x += 5
                
            }, completion: { (true) in
                if self.dequy == true {
                    self.randomOng()
                }
            })
            
            
            
            if cuc2.frame.origin.x + imgChim.frame.size.width >= imgChim.frame.origin.x && imgChim.frame.origin.x >= cuc2.frame.origin.x && (imgChim.frame.origin.y + imgChim.frame.size.height <= cuc1.frame.size.height || imgChim.frame.origin.y + imgChim.frame.size.height >= cuc1.frame.size.height + CGFloat(khoangcach2cuc))
            {
                imgChim.frame.origin.x = (cuc2.frame.origin.x + imgChim.frame.size.width)
                chimx = (cuc2.frame.origin.x + imgChim.frame.size.width)
                
                if imgChim.frame.origin.x >= view.frame.size.width {
                    lblDiem.text = "Bạn Đã Thua!! Điểm bạn là \(diem)"
                    
                    dequy = false
                    
                    
                }
                
                
            }
            
        } else {
            
            /// Vị trí Cuc1,Cuc2 Xuất Hiện
            self.cuc1.frame.origin.x = (-(self.cuc1.frame.size.width))
            self.cuc2.frame.origin.x = (-(self.cuc2.frame.size.width))
            
            
            
            cuc1.frame.size.height = CGFloat(rd1)
            cuc2.frame.origin.y = cuc1.frame.size.height + CGFloat(khoangcach2cuc)
            cuc2.frame.size.height = CGFloat(rd2)
            
            diem += 1
            print("diem pass cuc:\(diem)")
            lblDiem.text = String(diem)
            
            /// Gọi Để Func Chạy Lại(Thay Timer)
            self.randomOng()
        }
    }
    
    func diemCaoNhat() {
        if userDF.object(forKey: "1") == nil {
            lbldiemcaonhat.text = "Chưa có điểm cao nhất!"
        } else {
            dcn = userDF.object(forKey: "1") as! Int
            lbldiemcaonhat.text = "Điểm cao nhất của \(hoten!) Là:\(String(dcn))"
        }
    }
    
    var dcn:Int = 0
    let userDF:UserDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path:String = Bundle.main.path(forResource: "trovedi", ofType: "mp3")!
        let url:URL = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
            //player.stop()
            //player.pause()
            player.volume = 0.5
            /// Thời Gian hiện tại đang phát
            //player.currentTime.isNormal = true
            /// Thời Gian Toàn Bộ bài nhạc
            //player.duration.isNormal = true
        } catch { }
        
        lblTen.text = hoten
        lblDiem.text = String(diem)
        
        diemCaoNhat()
        
        //timer = Timer.scheduledTimer(timeInterval: thoigian + 0.2, target: self, selector: #selector(ViewController.manhinhdichuyen), userInfo: nil, repeats: true)
        
        self.lblTapTap.text = "TAP TAP"
        self.lblTapTap.isHidden = true
        
        
        
        manhinhdichuyen()
        roiChim()
        randomOng()
        
        
        //timerChim = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(ViewController.roiChim), userInfo: nil, repeats: true)
        
        let tapges = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapChim(_:)))
        view.addGestureRecognizer(tapges)
        
        ViTriChim()
        
        cuc1.frame = CGRect(x: -(cuc1.frame.size.width), y: 0 , width: 50, height: 200)
        
        cuc2.frame = CGRect(x: -(cuc2.frame.size.width), y: cuc1.frame.size.height + CGFloat(khoangcach2cuc), width: 50, height: view.frame.size.height - (cuc1.frame.size.height + CGFloat(khoangcach2cuc)))
        
        
        
        imgChim.frame = CGRect(x: chimx, y: chimy, width: 50, height: 50)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

