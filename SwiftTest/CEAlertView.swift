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
        return 200 - 20;
    }
    
    func maxWidth() ->CGFloat {
        
        if 414 < UIScreen.mainScreen().bounds.width {
            
            return 414 * 0.8 - 20;
        }
        
        return UIScreen.mainScreen().bounds.width * 0.8 - 20;
    }

    class func alertView(title: String,message: String) ->CEAlertView? {
        
        let alert = CEAlertView(frame:CGRectMake(0,0,UIScreen.mainScreen().bounds.width,UIScreen.mainScreen().bounds.height));
        
        alert.title = title;
        alert.message = message;
        
        return alert;
    }
    
    public func addAlertAction(title:String,action:(Void ->Void)?) {
        
        let btn:CEAlertButton = CEAlertButton(type: UIButtonType.System);
        btn.btnAction = action;
        btn.setTitle(title, forState: UIControlState.Normal);
        btn.addTarget(self, action: "press:", forControlEvents: UIControlEvents.TouchUpInside);
        buttons.addObject(btn);
    }
    
    func press(btn:CEAlertButton) {
        
        btn.btnAction?();
        
        self.dismiss();
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
        
        if contentView == nil {
            contentView = UIView();
            contentView?.backgroundColor = UIColor(red:241/255.0,green:241/255.0,blue:241/255.0,alpha:1.0);
            contentView?.clipsToBounds = true;
            contentView?.layer.borderWidth = 1;
            contentView?.layer.borderColor = contentView?.backgroundColor?.CGColor;
            contentView?.layer.cornerRadius = 10;
            contentView?.layer.shadowColor = UIColor.blackColor().CGColor;//UIColor(red:100/255.0,green:100/255.0,blue:100/255.0,alpha:1.0).CGColor;
            contentView?.layer.shadowRadius = 10;
            contentView?.layer.shadowOffset = CGSizeMake(5, 5);
            addSubview(contentView!);
        }
        
        let titleSize = self.textSize(title!, font: UIFont.boldSystemFontOfSize(17));
        let msgSize = self.textSize(message!, font: UIFont.systemFontOfSize(16));
        
        let max_w = titleSize.width > msgSize.width ? titleSize.width + 20 : msgSize.width + 20;
        
        var y:CGFloat = 15;
        
        let lbTile = UILabel(frame: CGRectMake((max_w - titleSize.width)/2,y,titleSize.width,titleSize.height));
        lbTile.text = title;
        lbTile.textAlignment = .Center;
        lbTile.numberOfLines = 0;
        lbTile.font = UIFont.boldSystemFontOfSize(17);
        lbTile.textColor = UIColor.blackColor();
        contentView?.addSubview(lbTile);
        
        y += titleSize.height + 15;
        
        let lbMsg = UILabel(frame: CGRectMake((max_w - msgSize.width)/2,y,msgSize.width,msgSize.height));
        lbMsg.text = message;
        lbMsg.textAlignment = .Center;
        lbMsg.font = UIFont.systemFontOfSize(16);
        lbMsg.numberOfLines = 0;
        lbMsg.textColor = UIColor.blackColor();
        contentView?.addSubview(lbMsg);
        
        if msgSize.height > 0 {
            y += 15 + msgSize.height;
        }
        
        for (var index = 0; index < buttons.count; index++) {
            
            let btn:CEAlertButton = buttons.objectAtIndex(index) as! CEAlertButton;
            contentView?.addSubview(btn);
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = UIColor.blackColor().CGColor;
            btn.backgroundColor = contentView?.backgroundColor;
            
            if (index == buttons.count - 1) {
                
                if (index % 2 == 0) {
                    
                    btn.frame =  CGRectMake(-1, y, max_w + 2, 40 + 1);
                }
                else {
                    btn.frame =  CGRectMake(max_w*0.5 - 1, y, max_w*0.5 + 2, 40 + 1);
                }
                
                y += 40;
            }
            else {
                let h_index = index % 2;
                let x = max_w * 0.5 * CGFloat(h_index);
                
                if h_index == 0 {
                    
                    btn.frame =  CGRectMake(x - 1, y, max_w*0.5 + 1, 40 + 1);
                }
                else {
                    btn.frame =  CGRectMake(x - 1, y, max_w*0.5 + 2, 40 + 1);
                }
                
                if h_index == 1 {
                    y += 40;
                }
            }
        }
        
        contentView?.frame = CGRectMake(0, 0, max_w, y);
        contentView?.center = CGPointMake(frame.width/2, frame.height/2);
        
        self.center = CGPointMake(UIScreen.mainScreen().bounds.width/2, UIScreen.mainScreen().bounds.height/2);
        UIApplication.sharedApplication().keyWindow?.addSubview(self);
        
        let animate = CABasicAnimation(keyPath: "transform.scale");
        animate.fromValue = 0;
        animate.toValue = 1;
        animate.repeatCount = 1;
        animate.duration = 0.3;
        self.layer.addAnimation(animate, forKey: "popStartAnimate");
    }
    
    func dismiss() {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.alpha = 0.0;
            }) { (finished:Bool) -> Void in
                self.removeFromSuperview();
        }
    }
}
