//
//  WebViewController.swift
//  crawler-webview-ios
//
//  Created by 박정태 on 12/10/23.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var ww: WKWebView!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var testBtn: UIButton!
    
    /** life cycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initWebview()
        loadWebview()
    }
    
    func initWebview() {
        let contentController = WKUserContentController()
        // 브릿지 설정
        contentController.add(self, name:"doneAction")
        

        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        //위 인자사용한 초기화
        ww = WKWebView(frame: CGRect(x: 0, y: 0, width: 300, height: 400) , configuration: config )
        view.addSubview(ww)
    }

    func loadWebview() {
        
        let sURL = "https://www.sagewood.co.kr/yeosu/member/login"
        
        let uURL = URL(string: sURL)
        var request = URLRequest(url: uURL!)
        ww.load(request)
    }
    
    @IBAction func loginClick(_ sender: Any) {
        print("login click")
        let loginEmail = "email" // 로그인 이메일
        let loginPassword = "password" // 로그인 비밀번호
        let script = "document.getElementById('usrId').value='\(loginEmail)'; document.getElementById('usrPwd').value='\(loginPassword)'; fnLoginChk('yeosu') "
        
        ww.evaluateJavaScript("function c() {window.onunload = function () { webkit.messageHandlers.doneAction.postMessage('login success'); }}; c()") { posts, err in
            if let err = err {
                debugPrint("err")
                debugPrint("Error: postPushInfo - \(err)")
            } else {
                debugPrint("none err: event Listener")
                debugPrint("Posts: postPushInfo - \(posts ?? "No Posts")")
            }
        }
        
        print(script)
        ww.evaluateJavaScript(
            script
        ) { posts, err in
            if let err = err {
                debugPrint("err")
                debugPrint("Error: postPushInfo - \(err)")
            } else {
                debugPrint("none err: dom ")
                debugPrint("Posts: postPushInfo - \(posts ?? "No Posts")")
            }
        }
    }
    
    @IBAction func LogoutClick(_ sender: Any) {
        print("logout click")
    }
    @IBAction func testClick(_ sender: Any) {
        print("test click start")

        
        ww.evaluateJavaScript("function c() {webkit.messageHandlers.doneAction.postMessage('mung'); return true;}; c()") { posts, err in
            if let err = err {
                debugPrint("err")
                debugPrint("Error: postPushInfo - \(err)")
            } else {
                debugPrint("none err")
                debugPrint("Posts: postPushInfo - \(posts ?? "No Posts")")
            }
        }
        
        print("test click end")
    }
}

// 자바스크립트에서 호출되면 콜백
extension WebViewController: WKScriptMessageHandler{

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == "doneAction" {
            print("JavaScript 에서 메시지가 왔어요 \(message.body)")
        }
    }
    
}
