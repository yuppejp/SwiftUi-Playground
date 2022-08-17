//
//  TransitionSample.swift
//  SwiftUi Playground
//
//  Created by yukio on 2022/06/21.
//

import SwiftUI

struct TransitionSample: View {
    @State private var flag = true
    var body: some View {
        VStack {
            Button("トランジション") {
                withAnimation() {
                    self.flag.toggle()
                }
            }
            if flag {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 100)
                /// 非対称トランジションを指定
                    .transition(.asymmetric(insertion: .scale, removal: .slide))
            }
        }
    }
    
}

struct TransitionSample_Previews: PreviewProvider {
    static var previews: some View {
        TransitionSample()
    }
}
