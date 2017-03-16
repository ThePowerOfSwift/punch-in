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
            let addJobView = getAddJobView(to: cell.contentView)
            cell.contentView.addSubview(addJobView)
        } else {
            cell.textLabel?.text = "+ Add Job"
            cell.textLabel?.textColor = .white
        }
        
        return cell
        
    }
    
    func getAddJobView(to contentView: UIView) -> UIView {
        
        let jobInfoView = UIView(frame: CGRect(x: 30, y: 100, width: contentView.frame.width - 60, height: 300))
        
        let nameLabel = UILabel()
        nameLabel.textAlignment = .right
        nameLabel.attributedText = NSAttributedString(string: "JOB NAME", attributes: [NSFontAttributeName: UIFont(name: (Styles.standardFont?.fontName)!, size: 18.0)!, NSForegroundColorAttributeName: Styles.signInPageColorFont])
        nameLabel.frame = CGRect(x: 0, y: 0, width: (jobInfoView.frame.width - 60) / 2, height: 30)
        
        let hourlyRateLabel = UILabel()
        hourlyRateLabel.textAlignment = .right
        hourlyRateLabel.attributedText = NSAttributedString(string: "HOURLY RATE", attributes: [NSFontAttributeName: UIFont(name: (Styles.standardFont?.fontName)!, size: 18.0)!, NSForegroundColorAttributeName: Styles.signInPageColorFont])
        hourlyRateLabel.frame = CGRect(x: 0, y: 80, width: (jobInfoView.frame.width - 60) / 2, height: 30)
        
        // NAME TEXT FIELD
        let jobNameTextField = UITextField()
        jobNameTextField.backgroundColor = UIColor.clear
        jobNameTextField.layer.cornerRadius = 10
        jobNameTextField.layer.borderWidth = 0.5
        jobNameTextField.layer.borderColor = Styles.signInPageColorFont.cgColor
        jobNameTextField.tintColor = Styles.signInPageColorFont
        jobNameTextField.frame = CGRect(x: jobInfoView.frame.width / 2 + 10, y: 0, width: jobInfoView.frame.width / 2 - 10, height: 30)
        jobNameTextField.textColor = Styles.signInPageColorFont
        jobNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        jobNameTextField.autocapitalizationType = UITextAutocapitalizationType.none
        jobNameTextField.delegate = self
        
        // HOURLY RATE TEXT FIELD
        let hourlyRateTextField = UITextField()
        hourlyRateTextField.backgroundColor = UIColor.clear
        hourlyRateTextField.layer.cornerRadius = 10
        hourlyRateTextField.layer.borderWidth = 0.5
        hourlyRateTextField.layer.borderColor = Styles.signInPageColorFont.cgColor
        hourlyRateTextField.tintColor = Styles.signInPageColorFont
        hourlyRateTextField.frame = CGRect(x: jobInfoView.frame.width / 2 + 10, y: 80, width: jobInfoView.frame.width / 2 - 10, height: 30)
        hourlyRateTextField.textColor = Styles.signInPageColorFont
        hourlyRateTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        hourlyRateTextField.keyboardType = .decimalPad
        hourlyRateTextField.delegate = self
        
        jobInfoView.addSubview(nameLabel)
        jobInfoView.addSubview(jobNameTextField)
        jobInfoView.addSubview(hourlyRateLabel)
        jobInfoView.addSubview(hourlyRateTextField)
        
        return jobInfoView
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
        tableView.isUserInteractionEnabled = true
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
            tableView.isUserInteractionEnabled = false
            tableView.beginUpdates()
            tableView.endUpdates()
            setBackToJobsButton()
            animate(openingJob: true)
            tableView.reloadRows(at: [indexPath], with: .fade)
            
        } else {
            
            addJobOpen = true
            tableView.isScrollEnabled = false
            tableView.isUserInteractionEnabled = false
            tableView.beginUpdates()
            tableView.endUpdates()
            setBackToJobsButton()
            animate(openingJob: true)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
}
