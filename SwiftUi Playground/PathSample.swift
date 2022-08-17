//
//  Path.swift
//  SwiftUi Playground
//
//  Created by yukio on 2022/05/16.
//

import SwiftUI

// 【SwiftUI】Pathを使った図形の描画
// https://capibara1969.com/2723/

struct PathSample: View {
    var body: some View {
        VStack {
            ArcSample()
            QuadCurveSample()
        }
    }
}

struct PathSample_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PathSample()
            BackgroudSample()
        }
    }
}

struct ArcSample: View {
    var body: some View {
        Path { path in
            path.addArc(
                center: CGPoint(x: 100, y: 100),
                radius: 100,
                startAngle: .degrees(-90),
                endAngle: .degrees(0),
                clockwise: false
            )
            path.addLine(to: CGPoint(x: 100, y: 100))
            path.closeSubpath()
        }
        .stroke(lineWidth: 3)
        .fill(.green)
        .frame(width: 200, height: 200)
        
    }
}

struct QuadCurveSample: View {
    var body: some View {
        Path { path in
            //　しっぽの上部
            path.move(to: CGPoint(x:0 , y: 80))     // start point 1
            path.addQuadCurve(
                to: CGPoint(x: 200, y: 0),          // end point 1 (start point 2)
                control: CGPoint(x: 100, y: 0))     // control point
            
            //　しっぽの下部
            path.addQuadCurve(
                to: CGPoint(x: 0, y: 200),          // end point 2
                control: CGPoint(x: 100, y: 0))     // control point
        }
        .stroke(lineWidth: 3)
        .fill(.green)
        .frame(width: 200, height: 200)
    }
}

struct BackgroudSample: View {
    var body: some View {
        Text("背景サンプル")
            .background(BackgroundView())
    }
}

struct BackgroundView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            Path { path in
                let rect = CGRect(x: 0, y: 0, width: width, height: height)
                path.addRect(rect)
            }
            .fill(.green)
        }
    }
}

