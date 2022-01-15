//
//  ContentView.swift
//  Table
//
//  Created by YuriyFpc on 07.12.2021.
//

import SwiftUI

struct Table: View {
    
    var rows: [[String]]
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                ForEach(rows, id: \.self) { row in
                    VStack(alignment: .leading) {
                        ForEach(row, id: \.self) { text in
                            Text(text)
                                .bold()
                                .lineLimit(1)
                        }
                    }
                    if row != rows.last {
                        Spacer()
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    
    let rows = [["100000000000000000000000000", "1", "1", "1"], ["2","20000000000","2","2"] ,["3","3000000000000000000000000000000000000000000","3","3"], ["4","4","4","40000000000000000"]]
    var body: some View {
        GeometryReader { proxy in
            Table(rows: rows)
            .padding(EdgeInsets(top: 50, leading: 16, bottom: 0, trailing: 16))
            .frame(width: proxy.size.width)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
