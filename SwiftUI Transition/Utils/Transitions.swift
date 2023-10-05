import Foundation
import SwiftUI

// https://www.objc.io/blog/2022/04/14/transitions/
// https://swiftui-lab.com/advanced-transitions/
// https://nerdyak.tech/development/2020/10/12/transitions-in-swiftui.html

extension AnyTransition {
    static var scaleAndFade: AnyTransition { .scale.combined(with: .opacity) }

    static func scaleAndFade(scale: CGFloat = 0.5, from anchor: UnitPoint = .top) -> AnyTransition {
        AnyTransition.scale(scale: scale, anchor: anchor).combined(with: .opacity)
    }

    static var moveInOutFromLeft: AnyTransition {
        AnyTransition.move(edge: .leading).combined(with: .opacity)
    }

    static var moveInOutFromRight: AnyTransition {
        AnyTransition.move(edge: .trailing).combined(with: .opacity)
    }

    static var moveInFromRightOutToLeft: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .move(edge: .leading).combined(with: .opacity)
        )
    }
}
