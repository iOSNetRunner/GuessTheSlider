//
//  UISliderRepresentation.swift
//  GuessTheSlider
//
//  Created by Dmitrii Galatskii on 29.07.2023.
//

import SwiftUI

struct UISliderRepresentation: UIViewRepresentable {
    
    @Binding var value: Int
    
    let action: () -> Int
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.setValue(Float.random(in: 1...100).rounded(), animated: true)
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueSelected),
            for: .valueChanged)
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        value = Int(uiView.value)
        let opacity = CGFloat(Double(action())) / 100
        uiView.thumbTintColor = .cyan.withAlphaComponent(opacity)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }
}

struct UISliderRepresentation_Previews: PreviewProvider {
    static var previews: some View {
        UISliderRepresentation(value: .constant(50)) {
            30
        }
    }
}


extension UISliderRepresentation {
    
    class Coordinator: NSObject {
        @Binding var value: Int
        
        init(value: Binding<Int>) {
            self._value = value
        }
        
        @objc func valueSelected(_ sender: UISlider) {
            value = Int(sender.value)
        }
    }
}
