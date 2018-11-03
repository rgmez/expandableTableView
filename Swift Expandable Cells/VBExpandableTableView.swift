//
//  VBExpandableTableView.swift
//  Swift Expandable Cells
//
//  Created by Roberto Gómez on 23/03/2018.
//  Copyright © 2018 Roberto Gomez. All rights reserved.
//

import UIKit

final class ExpandableTableView: UITableView {
    
    fileprivate var array: [Any]?
    
    func tableViewInitialSetup() {
        delegate = self
        dataSource = self
        
        registerTableViewCells()
        
        sectionHeaderHeight = UITableViewAutomaticDimension
        estimatedRowHeight = UITableViewAutomaticDimension
        
        alwaysBounceVertical = false
        
        tableFooterView = UIView()
    }
    
    func setupTableViewWith<T: NSObject>(items: [T]) {
        
        array = items
        
        tableViewInitialSetup()
        
        reloadData()
    }
    
    func registerTableViewCells() {
        self.registerNib(VBTeamHeaderTableViewCell.self)
        self.registerNib(VBTeamDetailTableViewCell.self)
    }
    
    // MARK: TableView ReloadData
    
    func reloadDataWith<T: NSObject>(_ items: [T]) {
        
        array = items
        
        reloadData()
    }
}

extension ExpandableTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let items = array else { return 0 }
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let items = array else { return UITableViewCell() }
        
        if items[indexPath.row] is Header {
            let cell = tableView.dequeueCell(VBTeamHeaderTableViewCell.self, for: indexPath)
            return cell
        } else if items[indexPath.row] is Detail {
            let cell = tableView.dequeueCell(VBTeamDetailTableViewCell.self, for: indexPath)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if var array = array {
            let detailIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            
            if let header = array[indexPath.row] as? Header {
                if header.expanded == true {
                    if let detail = array[detailIndexPath.row] as? Detail {
                        self.array = array.filter {
                            if let element = $0 as? Detail {
                                return element != detail
                            }
                            return true
                        }
                        header.expanded = false
                        UIView.animate(withDuration: 0.5, animations: {
                            tableView.beginUpdates()
                            tableView.deleteRows(at: [detailIndexPath], with: .fade)
                            tableView.endUpdates()
                        })
                    }
                } else {
                    array.insert(Detail(), at: detailIndexPath.row)
                    self.array = array
                    header.expanded = true
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        tableView.beginUpdates()
                        tableView.insertRows(at: [detailIndexPath], with: .fade)
                        tableView.endUpdates()
                    })
                    
                    DispatchQueue.main.async {
                        let sectionHeaderRect = self.rectForRow(at: detailIndexPath)
                        
                        if !self.bounds.contains(sectionHeaderRect) {
                            self.scrollRectToVisible(sectionHeaderRect, animated: true)
                        }
                    }
                    
                }
            }
        }
    }
}
