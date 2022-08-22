//
//  NavigationBarWithButton.swift
//  MyAsset
//
//  Created by 강태준 on 2022/08/17.
//

import SwiftUI

struct NavigationBarWithButton: ViewModifier {
    var title: String
    
    func body(content: Content) -> some View {
        content
            .navigationBarItems(
                leading: Text(title)
                    .font(
                        .system(
                            size: 24,
                            weight: .bold
                        )
                    )
                    .padding(),
                trailing: Button(
                    action: {
                        print("clicked asset plus button")
                    }, label: {
                        Image(systemName: "plus")
                            .font(.system(size: 12, weight: .semibold))
                        Text("자산 추가")
                            .font(.system(size: 12, weight: .semibold))
                    }
                )
                .accentColor(.black)
                .padding(EdgeInsets(
                    top: 8,
                    leading: 5,
                    bottom: 8,
                    trailing: 15)
                )
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 10
                    )
                    .stroke(.black)
                )
            )
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.backgroundColor = UIColor.white.withAlphaComponent(1)
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
            .padding(.top)
    }
}


extension View {
    func navigationBarWithButton(title: String) -> some View {
        return self.modifier(NavigationBarWithButton(title: title))
    }
}


struct NavigationBarWithButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Color.white
                .edgesIgnoringSafeArea(.all)
                .navigationBarWithButton(title: "내 자산")
        }
    }
}
