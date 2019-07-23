# AnimatedTransition

<table>
<tr>
<td><img src="doc/pig.gif"/></td>
</tr>
</table>

## How to use?
1. Present view controller modally 
2. Set `transitioningDelegate`

![](doc/1.png)

3. Implement `AlphaTransitionPresenter` for your first ViewController
4. Implement `AlphaTransitionPresentable` for your second ViewController

![](doc/2.png)

`AlphaTransition` will check this protocols and start present or dismiss animator otherwise you will see default animations.