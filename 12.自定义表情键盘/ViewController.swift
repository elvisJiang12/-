//
//  ViewController.swift
//  12.自定义表情键盘
//
//  Created by Elvis on 2018/2/3.
//  Copyright © 2018年 Elvis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    private lazy var emoticonVc : EmoticonViewController = EmoticonViewController.init { (emoticon) in
        self.textView.insertEmoticon(emoticon)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //让自定义的emoticon控制器中的view, 成为textView的键盘view
        textView.inputView = emoticonVc.view
        
        textView.becomeFirstResponder()
        
    }

    

    //image表情转字符串后,才能发送给服务器
    @IBAction func sendBtnClick() {
        print(textView.getEmoticon())
    }
    
}

