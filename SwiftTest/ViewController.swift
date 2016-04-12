//
//  ViewController.swift
//  SwiftTest
//
//  Created by cxq on 16/4/8.
//  Copyright © 2016年 celink. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var list:UITableView!
    
    var listSource = NSMutableArray();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "列表";
        
        view.backgroundColor = UIColor.whiteColor();
        
        list = UITableView(frame: CGRectMake(0, 0, 320, UIScreen.mainScreen().bounds.size.height - 64), style: UITableViewStyle.Plain);
        list.dataSource = self;
        list.delegate = self;
        self.view.addSubview(list);
        
        listSource.addObjectsFromArray(["CEAlertView","CEActionSheet","CEButton"]);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listSource.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("testCell");
        if cell == nil {
            cell = UITableViewCell(style:UITableViewCellStyle.Default,reuseIdentifier:"testCell");
        }
        
        cell?.textLabel?.text = listSource.objectAtIndex(indexPath.row) as? String;
        
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        
        switch indexPath.row
        {
        case 0:
            print(indexPath.row);
            let c = KindAlertViewController();
            navigationController?.pushViewController(c, animated: true);
        case 1:
            print(indexPath.row);
        default:
            print(indexPath.row);
        }
        
    }
}

