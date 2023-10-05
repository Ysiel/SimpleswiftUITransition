import Foundation
import SwiftUI

private struct AdvancedAndFadeTransitionModifier: ViewModifier {

    private let animation: Animation
    private let scale: CGFloat
    private let anchor: UnitPoint

    init(animation: Animation, scale: CGFloat, anchor: UnitPoint) {
        self.scale = scale
        self.anchor = anchor
        self.animation = animation
    }

    func body(content: Content) -> some View {
        content
            .transition(
                .scale(scale: scale, anchor: anchor).combined(with: .opacity)
                    .animation(animation)
            )
    }
}

private struct AdvancedAsymmetricTransitionModifier: ViewModifier {

    private let animation: Animation
    private let insertion: AnyTransition
    private let removal: AnyTransition

    init(animation: Animation, insertion: AnyTransition, removal: AnyTransition) {
        self.insertion = insertion
        self.removal = removal
        self.animation = animation
    }

    func body(content: Content) -> some View {
        content
            .transition(
                .asymmetric(
                    insertion: insertion,
                    removal: removal
                )
                .animation(animation)
            )
    }
}

extension View {
    @warn_unqualified_access @ViewBuilder func scaleAndFadeTransition(
        _ personality: Animation = .flat,
        _ scale: CGFloat = 0.5,
        from anchor: UnitPoint = .top
    ) -> some View {
        modifier(AdvancedAndFadeTransitionModifier(animation: personality, scale: scale, anchor: anchor))
    }

    @warn_unqualified_access @ViewBuilder func asymetricTransition(
        _ personality: Animation = .flat,
        insertion: AnyTransition,
        removal: AnyTransition
    ) -> some View {
        modifier(AdvancedAsymmetricTransitionModifier(animation: personality, insertion: insertion, removal: removal))
    }
}

