//
//  JobsTableViewController.swift
//  Punch In
//
//  Created by Kyle Stewart on 1/31/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import UIKit

class JobsViewController: UIViewController, UITextFieldDelegate {
    
    var data = [JobData] ()
    
    var openJobIndexPath: IndexPath?
    var backToJobsButton = UIButton()
    var addJobOpen: Bool = false
    var tableViewFrame: CGRect = CGRect()
    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var upChevronImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = getTempJobData()
        
        tableViewFrame = tableView.frame
        upChevronImage.image = chevron.up
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        
    }
    
    func getJobCellData(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> JobsTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID.job, for: indexPath) as! JobsTableViewCell
        
        cell.jobNameLabel.text = data[indexPath.row].title
        cell.hoursWorkedLabel.text = "\(data[indexPath.row].timeWorked)"
        
        if indexPath.row % 2 != 0 {
            cell.backgroundColor = .secondaryColor
            cell.barGraphView.backgroundColor = .secondaryColor
        } else {
            cell.backgroundColor = .thirdColor
            cell.barGraphView.backgroundColor = .thirdColor
        }
        
        if indexPath == openJobIndexPath {
            cell.extend()
        } else {
            cell.collapse()
        }
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = .mainColor
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    func getAddJobCellData(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> AddJobTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID.addJob, for: indexPath) as! AddJobTableViewCell
        
        cell.backgroundColor = .mainColor
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = .thirdColor
        cell.selectedBackgroundView = bgColorView
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        if addJobOpen {
            let addJobView = getAddJobView(to: cell.contentView, for: self)
            cell.contentView.addSubview(addJobView)
        } else {
            cell.textLabel?.text = "+ Add Job"
            cell.textLabel?.textColor = .white
        }
        
        return cell
        
    }
    
    func animate(openingJob: Bool) {
        
        UIView.animate(withDuration: 0.3) {
            if openingJob {
                self.backToJobsButton.alpha = 1.0
                self.segControl.alpha = 0.0
                self.upChevronImage.alpha = 1.0
                
            } else {
                self.backToJobsButton.alpha = 0.0
                self.upChevronImage.alpha = 0.0
                self.segControl.alpha = 1.0
            }
        }
    }
    
    func setBackToJobsButton() {
        
        backToJobsButton.frame = topBarView.frame
        backToJobsButton.addTarget(self, action: #selector(backToJobsButtonPressed), for: .touchUpInside)
        topBarView.addSubview(backToJobsButton)
        
    }
    
    func backToJobsButtonPressed() {
        
        if openJobIndexPath != nil {
        let indexPath = openJobIndexPath!
        openJobIndexPath = nil
        tableView.reloadRows(at: [indexPath], with: .fade)
        } else if addJobOpen {
        addJobOpen = false
        let test = IndexPath(row: 0, section: 1)
        tableView.reloadRows(at: [test], with: .fade)
        }
        
        tableView.isScrollEnabled = true
        tableView.allowsSelection = true
        tableView.beginUpdates()
        tableView.endUpdates()
        animate(openingJob: false)

    }
    
}

// MARK: ALL THE TABLE VIEW FUNCTIONS

extension JobsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {  return 2   }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = 0
        
        if indexPath.section == 0 {
            
            if openJobIndexPath == nil && !addJobOpen{
                
                height = Constants.height.jobCell
                
            } else {
                
                if indexPath == openJobIndexPath {
                    height = view.frame.height - topBarView.frame.height
                    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        switch indexPath.section {
        case 0:
            cell = getJobCellData(tableView, cellForRowAt: indexPath)
        case 1:
            cell = getAddJobCellData(tableView, cellForRowAt: indexPath)
            
        default:
            break
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            openJobIndexPath = indexPath
            tableView.isScrollEnabled = false
            tableView.allowsSelection = false
            tableView.beginUpdates()
            tableView.endUpdates()
            setBackToJobsButton()
            animate(openingJob: true)
            tableView.reloadRows(at: [indexPath], with: .fade)
            
        } else {
            
            addJobOpen = true
            tableView.isScrollEnabled = false
            tableView.beginUpdates()
            tableView.endUpdates()
            tableView.allowsSelection = false
            setBackToJobsButton()
            animate(openingJob: true)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
}
