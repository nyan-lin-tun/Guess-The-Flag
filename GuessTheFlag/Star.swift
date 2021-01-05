//
//  Star.swift
//  GuessTheFlag
//
//  Created by Nyan Lin Tun on 19/12/2020.
//

import SwiftUI

struct Star: Shape {
    // store how many corners the star has, and how smooth/pointed it is
    let corners: Int
    let smoothness: CGFloat

    func path(in rect: CGRect) -> Path {
        // ensure we have at least two corners, otherwise send back an empty path
        guard corners >= 2 else { return Path() }

        // draw from the center of our rectangle
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)

        // start from directly upwards (as opposed to down or to the right)
        var currentAngle = -CGFloat.pi / 2

        // calculate how much we need to move with each star corner
        let angleAdjustment = .pi * 2 / CGFloat(corners * 2)

        // figure out how much we need to move X/Y for the inner points of the star
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness

        // we're ready to start with our path now
        var path = Path()

        // move to our initial position
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))

        // track the lowest point we draw to, so we can center later
        var bottomEdge: CGFloat = 0

        // loop over all our points/inner points
        for corner in 0..<corners * 2  {
            // figure out the location of this point
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: CGFloat

            // if we're a multiple of 2 we are drawing the outer edge of the star
            if corner.isMultiple(of: 2) {
                // store this Y position
                bottom = center.y * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                // we're not a multiple of 2, which means we're drawing an inner point

                // store this Y position
                bottom = innerY * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }

            // if this new bottom point is our lowest, stash it away for later
            if bottom > bottomEdge {
                bottomEdge = bottom
            }

            // move on to the next corner
            currentAngle += angleAdjustment
        }

        // figure out how much unused space we have at the bottom of our drawing rectangle
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2

        // create and apply a transform that moves our path down by that amount, centering the shape vertically
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        return path.applying(transform)
    }
}

/*
ZStack {
//            Color(red: 1, green: 0.8, blue: 0)
//            Color.red.ignoresSafeArea(.all)
//            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
//            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
//            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    
}
*/
/*
ZStack {
    
    VStack(spacing: 0) {
        Color.yellow.frame(width: 300, height: 70, alignment: .center)
        Color.green.frame(width: 300, height: 70, alignment: .center)
        Color.red.frame(width: 300, height: 70, alignment: .center)
    }
    Star(corners: 5, smoothness: 0.4)
                .fill(Color.white)
                .frame(width: 150, height: 150)
                .background(Color.clear)
}
*/

/*
 
 VStack {
     
     Button("Tap me") {
         print("I am hit")
         self.showingAlert = true
     }
     .alert(isPresented: $showingAlert, content: {
         Alert(title: Text("Hello SwiftUI"), message: Text("This is the message"), dismissButton: .default(Text("Dismiss")))
     })
     Button(action: {
         self.showingAlert = true

     }, label: {
         VStack {
             Image(systemName: "pencil").renderingMode(.original)
             Text("Pencil")
         }
     })
 }
 
 */
