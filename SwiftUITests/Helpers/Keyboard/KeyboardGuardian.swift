//
//  KeyboardGuardian.swift
//  SwiftUITests
//
//  Created by YuriyFpc on 02.12.2021.
//

import Combine
import SwiftUI

/*
 Code updated for the Xcode, beta 7.

 You do not need padding, ScrollViews or Lists to achieve this. Although this solution will play nice with them too. I am including two examples here.

 The first one moves all textField up, if the keyboard appears for any of them. But only if needed. If the keyboard doesn't hide the textfields, they will not move.

 In the second example, the view only moves enough just to avoid hiding the active textfield.

 Both examples use the same common code found at the end: GeometryGetter and KeyboardGuardian

 First Example (show all textfields)

 When the keyboard is opened, the 3 textfields are moved up enough to keep then all visible

 struct ContentView: View {
     @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
     @State private var name = Array<String>.init(repeating: "", count: 3)

     var body: some View {

         VStack {
             Group {
                 Text("Some filler text").font(.largeTitle)
                 Text("Some filler text").font(.largeTitle)
             }

             TextField("enter text #1", text: $name[0])
                 .textFieldStyle(RoundedBorderTextFieldStyle())

             TextField("enter text #2", text: $name[1])
                 .textFieldStyle(RoundedBorderTextFieldStyle())

             TextField("enter text #3", text: $name[2])
                 .textFieldStyle(RoundedBorderTextFieldStyle())
                 .background(GeometryGetter(rect: $kGuardian.rects[0]))

         }.offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
     }

 }
 Second Example (show only the active field)

 When each text field is clicked, the view is only moved up enough to make the clicked text field visible.

 struct ContentView: View {
     @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
     @State private var name = Array<String>.init(repeating: "", count: 3)

     var body: some View {

         VStack {
             Group {
                 Text("Some filler text").font(.largeTitle)
                 Text("Some filler text").font(.largeTitle)
             }

             TextField("text #1", text: $name[0], onEditingChanged: { if $0 { self.kGuardian.showField = 0 } })
                 .textFieldStyle(RoundedBorderTextFieldStyle())
                 .background(GeometryGetter(rect: $kGuardian.rects[0]))

             TextField("text #2", text: $name[1], onEditingChanged: { if $0 { self.kGuardian.showField = 1 } })
                 .textFieldStyle(RoundedBorderTextFieldStyle())
                 .background(GeometryGetter(rect: $kGuardian.rects[1]))

             TextField("text #3", text: $name[2], onEditingChanged: { if $0 { self.kGuardian.showField = 2 } })
                 .textFieldStyle(RoundedBorderTextFieldStyle())
                 .background(GeometryGetter(rect: $kGuardian.rects[2]))

             }.offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0))
     }.onAppear { self.kGuardian.addObserver() }
 .onDisappear { self.kGuardian.removeObserver() }

 }
 */

///Work for all views, can move on selecting textField
final class KeyboardGuardian: ObservableObject {
    public var rects: Array<CGRect>
    public var keyboardRect: CGRect = CGRect()
    
    // keyboardWillShow notification may be posted repeatedly,
    // this flag makes sure we only act once per keyboard appearance
    public var keyboardIsHidden = true
    
    @Published var slide: CGFloat = 0
    
    var showField: Int = 0 { /// when view is activated you can update offset by setting the number of view in keyboardRect array
        didSet {
            updateSlide()
        }
    }
    
    init(viewsCount: Int) {
        self.rects = Array<CGRect>(repeating: CGRect(), count: viewsCount)
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyBoardWillShow(notification: Notification) {
        if keyboardIsHidden {
            keyboardIsHidden = false
            if let rect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
                keyboardRect = rect
                updateSlide()
            }
        }
    }
    
    @objc private func keyBoardDidHide(notification: Notification) {
        keyboardIsHidden = true
        updateSlide()
    }
    
    private func updateSlide() {
        if keyboardIsHidden {
            slide = 0
        } else {
            let tfRect = self.rects[self.showField]
            let diff = keyboardRect.minY - tfRect.maxY
            
            if diff > 0 {
                slide += diff
            } else {
                slide += min(diff, 0)
            }
        }
    }
}
