//
//  TaskCardView.swift
//  Pebble
//
//  Created by maria belen on 08/04/26.
//
import Foundation
import SwiftUI

struct TaskCardView: View {
    var body: some View {
        
        ZStack(alignment: .center) {
            RoundedRectangle(cornerSize: .init(width: 20, height: 20))
                .fill(Color.lightBlue)
                .stroke(Color.darkBlue,lineWidth: 3)
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                .padding(10)
            HStack {
                VStack(alignment: .leading, spacing: 7) {
                    Text("Task 1")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundColor(.darkBlue)
                    HStack {
                    Image(systemName: "calendar")
                            .foregroundStyle(Color.darkBlue)
                            
                        Text("01/02/2026")
                            .foregroundStyle(Color.darkBlue)
                    }
                }
                .padding(.leading, 20)
//                .frame(maxHeight: .infinity) //
                Spacer()//pushes circle to the right
                ZStack {
                    Circle()
                        .stroke(Color.darkBlue,lineWidth: 8)
                        .frame(width: 100, height: 100)
                        
                    Text("100%")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundColor(.darkBlue)
                }
                .padding(.trailing,40)
                
            }
        }
    }
}

#Preview {
    TaskCardView()
}

