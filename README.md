# AnimatedTransition

<table>
<tr>
<td><img src="doc/pig.gif"/></td>
</tr>
</table>

## How to use?
1. Present view controller modally 
2. Set `transitioningDelegate`
```mermaid
graph TB
A[UIViewController 1]
B[UIViewController 2] -- transitioningDelegate --> C(AlphaTransition)

A == Present ==> B
C -.-> UIViewControllerTransitioningDelegate

style A fill:#f9f,stroke:#333
style B fill:#f9f,stroke:#333
style C fill:#fdf,stroke:#333
```
3. Implement `AlphaTransitionPresenter` for your first ViewController
4. Implement `AlphaTransitionPresentable` for your second ViewController
```mermaid
graph TB
A[UIViewController 1]
B[UIViewController 2]
A -.-> AlphaTransitionPresenter
B -.-> AlphaTransitionPresentable
AlphaTransitionPresenter --> C(AlphaTransition)
AlphaTransitionPresentable --> C
C ==> PresentAnimator
C ==> DismissAnimator
PresentAnimator -.-> UIViewControllerAnimatedTransitioning
DismissAnimator -.-> UIViewControllerAnimatedTransitioning

style A fill:#f9f,stroke:#333
style B fill:#f9f,stroke:#333
style C fill:#fdf,stroke:#333
```
`AlphaTransition` will check this protocols and start present or dismiss animator otherwise you will see default animations.