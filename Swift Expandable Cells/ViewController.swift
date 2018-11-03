//
//  ViewController.swift
//  Swift Expandable Cells
//
//  Created by Roberto Gómez on 23/03/2018.
//  Copyright © 2018 Roberto Gomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: ExpandableTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.setupTableViewWith(items: [Header(), Header(), Header(), Header(),Header(), Header(), Header(), Header()])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

