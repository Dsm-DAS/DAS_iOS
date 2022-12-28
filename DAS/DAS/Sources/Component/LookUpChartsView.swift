import UIKit
import Charts
import SnapKit
import Then

class LookUpChartsView: UIView {
    private let lookUpLabel = UILabel().then {
        $0.text = "조회 수"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    let lookUpCountLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
        $0.text = ""
    }

    let lineChartView = LineChartView()

    var graphArray: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"]
    
    var firstUnitsSold = [20.0, 30.0, 24.0, 40.0, 52.0, 80.0, 64.0]
    
    override func layoutSubviews() {
        for i in 0..<7 {
            firstUnitsSold[i] = Double(Int.random(in: 10..<120))
        }
        self.layer.cornerRadius = 8
        
        setChart(dataPoints: graphArray, lineValues: firstUnitsSold)
        
        
        [
            lookUpLabel,
            lookUpCountLabel,
            lineChartView
            
        ].forEach { addSubview($0) }
        lookUpLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(12)
        }
        lookUpCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.top.equalTo(lookUpLabel.snp.bottom).offset(4)
        }
        lineChartView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(lookUpCountLabel.snp.bottom).offset(8)
        }
    }
    
    
    func setChart(dataPoints: [String], lineValues: [Double]) {

        var lineDataEntries: [ChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let firstDataEntry = ChartDataEntry(x: Double(i), y: lineValues[i])
            lineDataEntries.append(firstDataEntry)
        }

        let lineChartDataSet = LineChartDataSet(entries: lineDataEntries)
        lineChartDataSet.colors = [.clear]
        lineChartDataSet.label = nil
        let r : CGFloat = CGFloat.random(in: 0...0.9)
        let g : CGFloat = CGFloat.random(in: 0...0.9)
        let b : CGFloat = CGFloat.random(in: 0...0.9)
        lineChartDataSet.fillColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        lineChartDataSet.circleColors = [.clear]
        lineChartDataSet.drawFilledEnabled = true
        lineChartDataSet.valueTextColor = .clear
        lineChartDataSet.circleHoleRadius = 5.0
        lineChartDataSet.circleRadius = 5.0
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.highlightEnabled = false
        
        lineChartView.data = LineChartData(dataSet: lineChartDataSet)
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: graphArray)
        lineChartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
        lineChartView.leftAxis.axisLineColor = .clear
        lineChartView.xAxis.axisLineColor = .clear
        lineChartView.xAxis.setLabelCount(graphArray.count, force: true)
        lineChartView.xAxis.gridColor = .clear
        lineChartView.leftAxis.gridColor = .clear
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.leftAxis.axisMaximum = 120
        lineChartView.leftAxis.axisMinimum = 0
        lineChartView.rightAxis.enabled = false
        lineChartView.extraLeftOffset = 30
        lineChartView.leftAxis.labelXOffset = -30
        lineChartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 8, weight: .regular)
        lineChartView.doubleTapToZoomEnabled = false
    }
    
}
