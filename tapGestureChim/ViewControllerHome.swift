//
//  ViewControllerHome.swift
//  tapGestureChim
//
//  Created by Dr on 1/15/17.
//  Copyright © 2017 datnguyen. All rights reserved.
//

import UIKit

class ViewControllerHome: UIViewController {
    
    @IBOutlet weak var lblHoTen: UITextField!
    
    var hoten:String {
        return lblHoTen.text!.uppercased()
    }
    
    @IBAction func abtnPlay(_ sender: Any) {
        if hoten.characters.count > 0 {
            
            let manhinhchuyen:ViewController = storyboard?.instantiateViewController(withIdentifier: "play") as! ViewController
            manhinhchuyen.hoten = hoten
            show(manhinhchuyen, sender: self)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
