//
//  KindAlertViewController.swift
//  SwiftTest
//
//  Created by cxq on 16/4/12.
//  Copyright © 2016年 celink. All rights reserved.
//

import UIKit

class KindAlertViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var alertList:UITableView?
    var listSource:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor();

        // Do any additional setup after loading the view.
        //listSource.setArray(["一个按钮","两个按钮","三个按钮","四个按钮","五个按钮"]);
        
        alertList = UITableView(frame: CGRectMake(0, 0, 320, UIScreen.mainScreen().bounds.size.height - 64), style: UITableViewStyle.Plain);
        alertList?.dataSource = self;
        alertList?.delegate = self;
        view.addSubview(alertList!);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("testCell");
        if cell == nil {
            cell = UITableViewCell(style:UITableViewCellStyle.Default,reuseIdentifier:"testCell");
        }
        
        cell?.textLabel?.text = String("\(indexPath.row + 1)" + "个按钮");
        
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        
        let alert = CEAlertView.alertView("提示", message: "是否显示？？？？？？？？是否显示？？？？？？？？是否显示？？？？？？？？是否显示？？？？？？？？");
        for (var index = 0; index <= indexPath.row; index++) {
            alert?.addAlertAction("第" + "\(index)" + "按钮", action:nil);
        }
        alert?.show();
    }
}
