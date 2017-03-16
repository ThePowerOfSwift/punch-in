//
//  BarGraphView.swift
//  Punch In
//
//  Created by Kyle Stewart on 2/22/17.
//  Copyright © 2017 Kyle Stewart. All rights reserved.
//

import UIKit

class BarGraphView: UIView {
    
    let days = ["S","M","T","W","T","F","S"]
    
    let data = [0.0, 5.4, 5.5, 7.8, 9.0, 8.0, 0.0]
    
    var margin: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        
        for view in subviews {
            view.removeFromSuperview()
        }
        
        addSubview(dayOfWeekView())
        addSubview(graph())
        
    }
    
    func getChartRatio() -> Double {
        
        var ratio: Double = 0.0
        
        var highestValue = 0.0
        for time in data {
            if time > highestValue {
                highestValue = time
            }
        }
        
        ratio = Double(frame.height - 70) / highestValue
        
        return ratio
        
    }

    func dayOfWeekView() -> UIView {
        
        let dayOfWeekView = UIView(
            frame: CGRect(
                x: 0,
                y: frame.height - 20,
                width: frame.width,
                height: 20
            )
        )
        
        margin = ((dayOfWeekView.frame.width / CGFloat(days.count)) - CGFloat(20)) / 2
        
        var x: CGFloat = 0
        for day in days {
            x = x + margin
            
            let weekLabel = UILabel(
                frame: CGRect(
                    x: x,
                    y: 0,
                    width: 20,
                    height: 20
                )
            )
            weekLabel.textAlignment = .center
            weekLabel.text = day
            weekLabel.font = Styles.standardFont

            x = x + 20 + margin
            dayOfWeekView.addSubview(weekLabel)
        }
        return dayOfWeekView
    }
    
    func graph() -> UIView {
        
        let graphView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: frame.width,
                height: frame.height - 30
            )
        )
        var x: CGFloat = 0
        for time in data {
            x = x + margin
            
            let height = time * getChartRatio()
            
            let timeView = UIView(
                frame: CGRect(
                    x: Double(x),
                    y: Double(graphView.frame.height) - height,
                    width: 20.0,
                    height: height
                )
            )
            timeView.backgroundColor = .mainColor
            
            let timeLabel = UILabel(
                frame: CGRect(
                    x: 0,
                    y: -30,
                    width: 20,
                    height: 30
                )
            )
            if time > 0.0 {
                timeLabel.text = "\(time)"
            }
            timeLabel.textAlignment = .center
            timeLabel.font = Styles.standardFont
            timeLabel.sizeToFit()
            let test = (timeLabel.frame.width - timeView.frame.width) / 2
            timeLabel.frame.origin.x = -test
            
            x = x + 20 + margin
            timeView.addSubview(timeLabel)
            graphView.addSubview(timeView)
            
        }
        
        return graphView
        
    }
    
}

struct BarChart {
    
    var xCount: Int!
    var x: [CGFloat] { get {return self.x}  }
    var y: [CGFloat] { get {return self.y}  }
    
}
