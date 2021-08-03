#  Klein Sketch — Design

## Figure
* Draw in Context(come with use-cases, research animation problems/partial invalidation)
* layer
* inspector/panel
* encode itself in JSON
* Values: width, height, colour, position(NSPoint)

How to drag CALayers?
* CanvasView can handle draggin and notify **selected figure**

How to draw select controls?
* If Figre exposes CALayer it's not hard
* If Figure exposes only drain(in ctx: Context) method there might be problems

## Canvas(Document)
Incorporates figures

* Create figure
* Random figure
* Add, remove figure to
* Select — CALayer hittesting -> select
* Manages parent layer
* Save/restore document
* Values: figures, **selected figure**


* CanvasView — native counterpart of Canvas
   * Manages clicks and actions


# Use-Cases

* Deselect
* Select precisely
* Figure changeColor

## Click on the canvas
   1. Generates a new random figure and ~~selects it~~
   
## Click on a figure
   1. Selects it and updates the inspector view
   2. The previous selected figure must be deselected
   
## Click on the canvas when a figure is selected
   1. Deselects
   2. Then *Click on the canvas*
   
## Click on a figure that is obscured by another figure
   1. Click on the frontmost figure without handling shape/pixel perfect selection
   2. There should be a right-click action which allows you to select a figure from a menu

## Drag a figure
   1. Select a figure
   2. Drag it(the inspector view should be in sync)
   
   Outsite of the canvas?
   
## Update something in the inspector view
   1. Values should immediatly affect the selected figure
   
   Setting values much larger than actual canvas?
