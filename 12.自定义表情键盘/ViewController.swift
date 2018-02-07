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
    
    private lazy var emoticonVc : EmoticonViewController = EmoticonViewController.init {[weak self] (emoticon) in
        self?.textView.insertEmoticon(emoticon)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //让自定义的emoticon控制器中的view, 成为textView的键盘view
        textView.inputView = emoticonVc.view
        
        textView.becomeFirstResponder()
        
        let statusText = "@xixihaha: #出行生活#【打工小伙背猫骑摩托车返乡：女朋友怕冻，猫不怕冻[喵喵]】2月6日，广西的一位陈先生骑摩托车从广东返乡。他说这是第3年骑摩托回家。女友嫌冷坐大巴回去[哈哈]，而他专门给猫买了背包，带着爱猫上路。陈先生说，骑摩托回家更自由[好喜欢]。#我的春运# 你今年什么时候回家，坐什么交通工具？...全文： http://m.weibo.cn/1644088831/4204917016887278"
        
        textView.attributedText = MatchEmoticon.shareInstance.matchAttrString(text: statusText, font: textView.font!)
        
    }

    

    //image表情转字符串后,才能发送给服务器
    @IBAction func sendBtnClick() {
        print(textView.getEmoticon())
    }
    
}

