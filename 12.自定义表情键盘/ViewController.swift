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
        self.insertEmoticonIntoTextView(emoticon : emoticon)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //让自定义的emoticon控制器中的view, 成为textView的键盘view
        textView.inputView = emoticonVc.view
        
        textView.becomeFirstResponder()
        
        
//        let manager = EmoticonManager()
//        for package in manager.packages {
//            for emoticon in package.emoticon {
//                print(emoticon)
//            }
//        }
    }

    //把表情插入textView的光标所在处
    private func insertEmoticonIntoTextView(emoticon : Emoticon) {
        //1.空白表情
        if emoticon.isEmptyEmoticon {
            return
        }
        
        //2.删除按钮
        if emoticon.isRemoveEmoticon {
            //删除光标位置的前一个字符
            textView.deleteBackward()
            return
        }
        
        //3.emoji表情
        if emoticon.emojiCode != nil {
            //3.1获取光标所在的位置:UITextRange
            let textRange = textView.selectedTextRange!
            //3.2替换emoji表情
            textView.replace(textRange, withText: emoticon.emojiCode!)
            
            return
        }
        
        //4.image表情
        if emoticon.pngPath != nil {
            
            
            return
        }
        
    }


}

