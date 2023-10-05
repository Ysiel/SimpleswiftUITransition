import Foundation
import SwiftUI

extension AnyTransition {
    static var moveInOutFromRight_v2: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .move(edge: .trailing).combined(with: .opacity)
        )
    }
}
