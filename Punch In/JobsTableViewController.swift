//
//  JobsTableViewController.swift
//  Punch In
//
//  Created by Kyle Stewart on 1/31/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import UIKit

class JobsTableViewController: PITableViewController {

    var data = [JobData] ()
    
    var openJobIndex: Int?
    
    var addJobOpen: Bool = false
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        data = getTempJobData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {  return 2   }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rows = 0
        
        switch section {
        case 0:
            rows = data.count
        case 1:
            rows = 1
        default:
            break
        }
    
        return rows
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = 0
        
        if indexPath.section == 0 {
        
            if openJobIndex == nil && !addJobOpen{
                
                height = Constants.height.jobCell
                
            } else {
                
                if indexPath.row == openJobIndex {
                    height = view.frame.height
                } else {
                    height = 0
                }
                
            }
            
        } else {
            
            if addJobOpen {
                height = self.view.frame.height
            } else {
                height = Constants.height.addJobCell
            }
            
        }
        
        return height

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        switch indexPath.section {
        case 0:
            cell = getJobCellData(tableView, cellForRowAt: indexPath)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID.addJob, for: indexPath) as! AddJobTableViewCell
            cell.backgroundColor = .mainColor
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = .thirdColor
            cell.selectedBackgroundView = bgColorView
        default:
            break
        }
        
        return cell
        
    }
    
    func getJobCellData(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> JobsTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID.job, for: indexPath) as! JobsTableViewCell
        
        cell.jobNameLabel.text = data[indexPath.row].title
        cell.hoursWorkedLabel.text = "\(data[indexPath.row].timeWorked)"
        
        if indexPath.row % 2 != 0 {
            print(indexPath.row)
            cell.backgroundColor = .secondaryColor
        } else {
            cell.backgroundColor = .thirdColor
        }
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = .mainColor
        cell.selectedBackgroundView = bgColorView
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            if openJobIndex == nil {
                openJobIndex = indexPath.row
                tableView.isScrollEnabled = false
                tableView.beginUpdates()
                tableView.endUpdates()
            } else {
                openJobIndex = nil
                tableView.isScrollEnabled = true
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        
        } else {
            
            if addJobOpen {
                addJobOpen = false
                tableView.isScrollEnabled = true
                tableView.beginUpdates()
                tableView.endUpdates()
            } else {
                addJobOpen = true
                tableView.isScrollEnabled = false
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            
        }
    }
    
}
