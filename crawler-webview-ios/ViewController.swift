//
//  ViewController.swift
//  crawler-webview-ios
//
//  Created by 박정태 on 12/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func click(_ sender: Any) {
        guard let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebView") as? WebViewController else { return }
                // 화면 전환 애니메이션 설정
                secondViewController.modalTransitionStyle = .coverVertical
                // 전환된 화면이 보여지는 방법 설정 (fullScreen)
                secondViewController.modalPresentationStyle = .fullScreen
                self.present(secondViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello world")
        // Do any additional setup after loading the view.
    }


}

