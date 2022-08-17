//
//  Balloon.swift
//  SwiftUi Playground
//
//  Created by yukio on 2022/05/16.
//

import SwiftUI

struct BalloonSample: View {
    var body: some View {
        VStack {
            BalloonText("こんな吹き出しが\n欲しい!")
            Text("表示サンプル")
            BalloonText("SwiftUIから\nこんにちは")
            BalloonText("Swiftで長いテキストの例です。テキストの描画領域に合わせて、吹き出しの大きさも連動して表示されます。")
        }
        .padding()
    }
}

struct BalloonSample_Previews: PreviewProvider {
    static var previews: some View {
        BalloonSample()
    }
}

struct BalloonText: View {
    let text: String
    let color: Color
    let mirrored: Bool
    
    init(_ text: String,
         color: Color = Color(UIColor(red: 109/255, green: 230/255, blue: 123/255, alpha: 1.0)),
         mirrored: Bool = false
    ) {
        self.text = text
        self.color = color
        self.mirrored = mirrored
    }

    var body: some View {
        let cornerRadius = 8.0
        
        Text(text)
            .padding(.leading, 4 + (mirrored ? cornerRadius / 2 : 0))
            .padding(.trailing, 4 + (!mirrored ? cornerRadius / 2 : 0))
            .padding(.vertical, 2)
            .background(BalloonShape(
                cornerRadius: cornerRadius,
                color: color,
                mirrored: mirrored)
            )
    }
}

struct BalloonShape: View {
    var cornerRadius: Double
    var color: Color
    var mirrored = false
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let tailSize = CGSize(
                    width: cornerRadius / 2,
                    height: cornerRadius / 2)
                let shapeRect = CGRect(
                    x: 0,
                    y: 0,
                    width: geometry.size.width,
                    height: geometry.size.height)
                
                // 時計まわりに描いていく

                // 左上角丸
                path.addArc(
                    center: CGPoint(
                        x: shapeRect.minX + cornerRadius,
                        y: shapeRect.minY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 279), clockwise: false)
                
                // 右上角丸
                path.addArc(
                    center: CGPoint(
                        x: shapeRect.maxX - cornerRadius - tailSize.width,
                        y: shapeRect.minY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 270),
                    endAngle: Angle(degrees: 270 + 45), clockwise: false)

                // しっぽ上部
                //path.addLine(to: CGPoint(
                //    x: shapeRect.maxX,
                //    y: shapeRect.minY))
                path.addQuadCurve(
                    to: CGPoint(
                        x: shapeRect.maxX,
                        y: shapeRect.minY),
                    control: CGPoint(
                        x: shapeRect.maxX - (tailSize.width / 2),
                        y: shapeRect.minY))

                // しっぽ下部
                //path.addLine(to: CGPoint(
                //    x: shapeRect.maxX - tailSize.width,
                //    y: shapeRect.minY + cornerRadius + tailSize.height))
                path.addQuadCurve(
                    to: CGPoint(
                        x: shapeRect.maxX - tailSize.width,
                        y: shapeRect.minY + (cornerRadius / 2) + tailSize.height),
                    control: CGPoint(
                        x: shapeRect.maxX - (tailSize.width / 2),
                        y: shapeRect.minY))

                // 右下角丸
                path.addArc(
                    center: CGPoint(
                        x: shapeRect.maxX - cornerRadius - tailSize.width,
                        y: shapeRect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90), clockwise: false)

                // 左下角丸
                path.addArc(
                    center: CGPoint(
                        x: shapeRect.minX + cornerRadius,
                        y: shapeRect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180), clockwise: false)
            }
            .fill(self.color)
            .rotation3DEffect(.degrees(mirrored ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        }
        //.padding()
    }
}

// 吹き出し: https://dishware.sakura.ne.jp/swift/archives/111
// addQuadCurve解説: https://uruly.xyz/【swift3】uibezierpathで卵型を書こう【cashapelayer】
// LINEのような吹き出し: https://qiita.com/s2mr/items/fd2ba61e8233080bdf07
struct BalloonBackgroudView: View {
    let padding = 5.0
    let cornerRadius = 10.0
    
    var color: Color = .green
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let w = geometry.size.width
                let h = geometry.size.height

                let arrowWidth = 8.0
                let arrowHeight = 25.0
                let arrowTopCurveHeight = 4.0
                let leftX = 0.0 + arrowWidth
                let rightX = w
                let topY = 0.0
                let bottomY = h
                
                path.move(to: CGPoint(x: leftX, y: topY + cornerRadius))  // スタート地点
                arc(path: &path, x: leftX + cornerRadius, y: topY + cornerRadius, startAngle: 180.0, endAngle: 270.0)  // 1 から 2
                arc(path: &path, x: rightX - cornerRadius, y: topY + cornerRadius, startAngle: 270.0, endAngle: 0.0)  // 2 から 3
                arc(path: &path, x: rightX - cornerRadius, y: bottomY - cornerRadius, startAngle: 0.0, endAngle: 90.0)  // 3 から 4
                arc(path: &path, x: leftX + cornerRadius, y: bottomY - cornerRadius, startAngle: 90.0, endAngle: 135.0)  // 4 から 5
                path.addQuadCurve(
                    to: CGPoint(x: leftX - cornerRadius, y: bottomY),
                    control: CGPoint(x: leftX - arrowWidth, y: bottomY))  // 5 から 6 (吹き出しの先端です)
                path.addQuadCurve(
                    to: CGPoint(x: leftX, y: bottomY - arrowHeight),
                    control: CGPoint(x: leftX, y: bottomY - arrowTopCurveHeight))  // 6 から 7
                //path.closeSubpath()
            }
            //.stroke(lineWidth: 2)
            .fill(self.color)
            .rotationEffect(Angle(degrees: 0))
        }
    }

    private func arc(path: inout Path, x: CGFloat, y: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {

        path.addArc(center: CGPoint(x: x, y: y),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: startAngle),
                    endAngle: Angle(degrees: endAngle),
                    clockwise: false)
    }
}
