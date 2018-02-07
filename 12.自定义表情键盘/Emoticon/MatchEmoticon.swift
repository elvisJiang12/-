//
//  MatchEmoticon.swift
//  12.自定义表情键盘
//
//  Created by Elvis on 2018/2/8.
//  Copyright © 2018年 Elvis. All rights reserved.
//

import UIKit

class MatchEmoticon: NSObject {
    
    //MARK:- 懒加载的属性
    private lazy var manager : EmoticonManager = EmoticonManager()
    
    func matchAttrString(text : String, font : UIFont) -> NSAttributedString? {
        //1.创建匹配规则, e.g. [哈哈]
        let pattern = "\\[.*?\\]"
        
        //2.创建正则表达式对象
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        
        //3.开始匹配
        let results = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
        
        //4.获取匹配的结果
        let attrMutableString = NSMutableAttributedString(string: text)
        
        //遍历匹配结果, 进行替换
        for result in results.reversed() {
            let chs = (text as NSString).substring(with: result.range)
            
            //4.1根据chs获取表情图片的路径
            guard let pngPath = findPngPath(chs) else {
                print("未找到\(chs)对应的表情图片")
                return nil
            }
            //4.2创建属性字符串
            let attachment = NSTextAttachment()
            attachment.image = UIImage(contentsOfFile: pngPath)
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let attrImageString = NSAttributedString(attachment: attachment)
            //4.3将属性字符串替换到来源的文字位置
            attrMutableString.replaceCharacters(in: result.range, with: attrImageString)
        }
        
        return attrMutableString
    }
    
    private func findPngPath(_ chs : String) -> String? {
        for package in manager.packages {
            for emoticon in package.emoticon {
                if emoticon.chs == chs {
                    return emoticon.pngPath
                }
            }
        }
        
        return nil
    }

}
