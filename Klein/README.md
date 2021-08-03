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


