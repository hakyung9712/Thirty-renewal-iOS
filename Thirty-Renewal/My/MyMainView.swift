//
//  MyView.swift
//  Thirty-Renewal
//
//  Created by 송하경 on 2023/06/12.
//

import SwiftUI

struct MyMainView: View {
    var body: some View {
        NavigationView {
            Text("MyView")
                .navigationTitle("My")
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyMainView()
    }
}
