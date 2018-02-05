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
            //4.1根据图片的路径创建"属性字符串"
            let attachment = EmoticonAttachment()
            attachment.image = UIImage.init(contentsOfFile: emoticon.pngPath!)
            attachment.chs = emoticon.chs
            //设置图片的尺寸
            let font = textView.font!
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            
            let attriImageString = NSAttributedString.init(attachment: attachment)
            
            //4.2创建可变的属性字符串
            let attriMString = NSMutableAttributedString(attributedString: textView.attributedText)
            
            //4.3将图片属性字符串, 替换到可变属性字符串的光标所在位置
            let range = textView.selectedRange
            attriMString.replaceCharacters(in: range, with: attriImageString)
            
            //显示至textView
            textView.attributedText = attriMString
            
            //!!重置textView文字font
            textView.font = font
            //!!光标位置调整
            textView.selectedRange = NSRange.init(location: range.location + 1, length: 0)
            
            return
        }
        
    }

    //image表情转字符串后,才能发送给服务器
    @IBAction func sendBtnClick() {
        //1.获取textView的属性字符串
        let mAttriString = NSMutableAttributedString.init(attributedString: textView.attributedText)
        
        //2.遍历属性字符串
        let range = NSRange(location: 0, length: mAttriString.length)
        mAttriString.enumerateAttributes(in: range, options: []) { (dict, range, _) in
//            print(dict)
//            print(range)
            if let attachment = dict[NSAttributedStringKey(rawValue: "NSAttachment")] as? EmoticonAttachment {
                mAttriString.replaceCharacters(in: range, with: attachment.chs!)
            }
        }
        
        //3.获取字符串
        print(mAttriString.string)
    }
    
}

