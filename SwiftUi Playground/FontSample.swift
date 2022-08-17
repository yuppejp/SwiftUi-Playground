//
//  FontSample.swift
//  SwiftUi Playground
//
//  Created by yukio on 2022/06/19.
//

import SwiftUI

struct FontSample: View {
    var body: some View {
        VStack {
            Group{
                Text("largeTitle").font(.largeTitle)
                Text("title").font(.title)
                Text("title2").font(.title2)
                Text("title3").font(.title3)
                Text("headline").font(.headline)
                Text("subheadline").font(.subheadline)
                Text("body").font(.body)
            }
            Text("callout").font(.callout)
            Text("caption").font(.caption)
            Text("caption2").font(.caption2)
            Text("footnote").font(.footnote)
            Text("default")
        }
    }
}

struct FontSample_Previews: PreviewProvider {
    static var previews: some View {
        FontSample()
    }
}
