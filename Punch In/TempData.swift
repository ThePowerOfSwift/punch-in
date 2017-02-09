//
//  TempData.swift
//  Punch In
//
//  Created by Kyle Stewart on 2/1/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import Foundation

func getTempJobData() -> [JobData] {
    
    var data = [JobData]()
    
    let temp = JobData(title: "Izeni", timeWorked: 34)
    let temp1 = JobData(title: "Nanny", timeWorked: 5)
    let temp2 = JobData(title: "Mowing Lawns", timeWorked: 10)
    
    data.append(temp)
    data.append(temp1)
    data.append(temp2)
    
    return data
    
}
