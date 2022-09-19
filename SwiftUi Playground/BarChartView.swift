//
//  BarChartView.swift
//  SwiftUi Playground
//  
//  Created on 2022/09/19
//  

// Ref: https://morioh.com/p/99cdda285661

import SwiftUI

struct BarView: View {
    var datum: Double
    var colors: [Color]
    
    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
    }
    
    var body: some View {
        Rectangle()
            .fill(gradient)
            .opacity(datum == 0.0 ? 0.0 : 1.0)
    }
}

struct BarChartView: View {
    var data: [Double]
    var colors: [Color]
    var topMargin = 12.0
    
    var highestData: Double {
        let max = data.max() ?? 1.0
        if max == 0 { return 1.0 }
        return max
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: 4.0) {
                ForEach(data.indices, id: \.self) { index in
                    let width = (geometry.size.width / CGFloat(data.count)) - 4.0
                    let height = (geometry.size.height - topMargin) * data[index] / highestData
                    
                    VStack(spacing: 0) {
                        Text(String(Int(data[index])))
                            .font(.caption2)
                        
                        BarView(datum: data[index], colors: colors)
                            .frame(width: width, height: height, alignment: .bottom)
                    }
                }
            }
        }
    }
}

struct TestView: View {
    @State private var moveValues: [Double] = TestView.mockData(7, in: 0...300)
    @State private var exerciseValues: [Double] = TestView.mockData(7, in: 0...60)
    @State private var standValues: [Double] = TestView.mockData(7, in: 0...10)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Move").bold()
                .foregroundColor(.red)
            
            BarChartView(data: moveValues, colors: [.red, .orange])
            
            Text("Exercise").bold()
                .foregroundColor(.green)
            
            BarChartView(data: exerciseValues, colors: [.green, .yellow])
            
            Text("Stand").bold()
                .foregroundColor(.blue)
            
            BarChartView(data: standValues, colors: [.blue, .purple])
        }
        .padding()
    }
    
    static func mockData(_ count: Int, in range: ClosedRange<Double>) -> [Double] {
        (0..<count).map { _ in .random(in: range) }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
