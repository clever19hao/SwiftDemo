//
//  CEAlertView.swift
//  SwiftTest
//
//  Created by cxq on 16/4/8.
//  Copyright © 2016年 celink. All rights reserved.
//

import UIKit

public class CEAlertView: UIView {
    
    var title: String?
    var message: String?
    
    private var buttons:NSMutableArray = NSMutableArray();
    private var contentView:UIView?
    
    func minWidth() ->CGFloat {
        return 200;
    }
    
    func maxWidth() ->CGFloat {
        
        if 414 < UIScreen.mainScreen().bounds.width {
            
            return 414 * 0.8;
        }
        
        return UIScreen.mainScreen().bounds.width * 0.8;
    }

    class func alertView(title: String,message: String) ->CEAlertView? {
        
        let alert = CEAlertView(frame:CGRectMake(0,0,UIScreen.mainScreen().bounds.width,UIScreen.mainScreen().bounds.height));
        
        alert.title = title;
        alert.message = message;
        
        return alert;
    }
    
    public func addAlertAction(title:String,action:()) {
        
        let btn:CEAlertButton = CEAlertButton(type: UIButtonType.System);
        btn.action = action;
        btn.setTitle(title, forState: UIControlState.Normal);
        buttons.addObject(btn);
    }
    
    private func textSize(text:String,font:UIFont) ->CGSize {
        
        let size1 = text.sizeWithAttributes([NSFontAttributeName:font]);
        if size1.width > self.maxWidth() {
            
            let size = text.boundingRectWithSize(CGSizeMake(self.maxWidth(), 10000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil);
            
            return CGSizeMake(size.width, size.height);
        }
        else if size1.width < self.minWidth() {
            
            return CGSizeMake(self.minWidth(), size1.height);
        }
        
        return size1;
    }
    
    public func show() {
        
        let titleSize = self.textSize(title!, font: UIFont.boldSystemFontOfSize(17));
        let msgSize = self.textSize(message!, font: UIFont.systemFontOfSize(16));
    }
}
