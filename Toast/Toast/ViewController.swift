//
//  ViewController.swift
//  Toast
//
//  Created by J_Min on 2022/10/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tf: UITextField!
    
    var toastView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func toast(_ sender: UIButton) {
        guard let text = tf.text,
              !text.isEmpty else {
            return
        }
        
        view.toast(message: text, bottomPosition: 300, showDuration: 0.5, duration: 2)
    }
    
    @IBAction func showToast(_ sender: UIButton) {
        guard let text = tf.text,
              !text.isEmpty else {
            return
        }
        
        toastView = view.toast(message: text, bottomPosition: 300, showDuration: 0.5, autoHide: false)
    }
    
    @IBAction func hideToast(_ sender: UIButton) {
        guard let toast = toastView else {
            return
        }
        
        view.hideToast(view: toast, hideDuration: 0.5)
        toastView = nil
    }

}

