(define (script-fu-re-icon   img
                     shape-layer)
   (let* (
        (width (car (gimp-drawable-width shape-layer)))
        (height (car (gimp-drawable-height shape-layer)))
        (blur 3)
        (diffuse-layer (car (gimp-layer-new img
                                   width height RGB-IMAGE
                                     "Diffuse" 100 NORMAL-MODE)))
        (diffuse-layer-mask (car (gimp-layer-create-mask diffuse-layer
                                             ADD-BLACK-MASK)))
        (shadow-layer (car (gimp-layer-new img
                                  width height RGBA-IMAGE
                                    "Shadow" 80 NORMAL-MODE)))
        (highlight-layer (car (gimp-layer-new img
                                  width height RGB-IMAGE
                                    "Highlight" 60 SOFTLIGHT-MODE)))
        (highlight-layer-mask (car (gimp-layer-create-mask highlight-layer
                                              ADD-WHITE-MASK)))
        )
          
      (gimp-context-push)
      (gimp-context-set-defaults)
      (gimp-image-undo-group-start img)
      
      (script-fu-util-image-resize-from-layer img shape-layer)
      (script-fu-util-image-add-layers img highlight-layer)
      (script-fu-util-image-add-layers img diffuse-layer)
      (script-fu-util-image-add-layers img shadow-layer)
      (gimp-layer-add-mask diffuse-layer diffuse-layer-mask)
      (gimp-layer-add-mask highlight-layer highlight-layer-mask)
      (gimp-selection-none img)
      (gimp-context-set-foreground '(240 240 240))
      (gimp-context-set-background '(140 140 140))
      (gimp-edit-blend diffuse-layer FG-BG-RGB NORMAL-MODE
                     GRADIENT-LINEAR 100 0 REPEAT-NONE FALSE
                     FALSE 0 0 TRUE
                     0 (/ height 6) 0 (- height (/ height 8)))
      (gimp-image-select-item img CHANNEL-OP-REPLACE shape-layer)
      (gimp-context-set-background '(255 255 255))
      (gimp-edit-fill diffuse-layer-mask BACKGROUND-FILL)
      (gimp-context-set-foreground '(0 0 0))
      (gimp-image-select-item img CHANNEL-OP-REPLACE shape-layer)
      (gimp-edit-fill shadow-layer FOREGROUND-FILL)
      (gimp-selection-none img)
      (plug-in-gauss-iir  RUN-NONINTERACTIVE img shadow-layer (* 3 (/ (max width height) 128)) TRUE TRUE)
      (gimp-layer-translate shadow-layer (/ width 85) (/ height 256))
      (gimp-edit-fill highlight-layer FOREGROUND-FILL)
      (gimp-image-select-item img CHANNEL-OP-REPLACE shape-layer)
      (gimp-edit-fill highlight-layer BACKGROUND-FILL)
      (gimp-selection-none img)
      (plug-in-sobel RUN-NONINTERACTIVE img highlight-layer TRUE TRUE TRUE)
      (gimp-layer-add-alpha highlight-layer)
      (plug-in-colortoalpha RUN-NONINTERACTIVE img highlight-layer '(0 0 0))
      (gimp-context-set-foreground '(180 180 180))
      (gimp-edit-blend highlight-layer-mask FG-BG-RGB NORMAL-MODE
                     GRADIENT-LINEAR 100 0 REPEAT-NONE FALSE
                     FALSE 0 0 TRUE
                     (- width (/ width 6)) (- height (/ height 6)) (/ width 6) (/ height 6))
      (gimp-item-set-visible shape-layer FALSE)
      
      (gimp-image-undo-group-end img)
      (gimp-displays-flush)
      
      (gimp-context-pop)
    )
)

(script-fu-register "script-fu-re-icon"
  _"RE Style Icon..."
  _"Created with a white image and a transparent background a symbol suitable for Red Eclipse."
  "Viktor Hahn"
  ""
  "2014"
  "RGBA"
  SF-IMAGE       "Image"                  0
  SF-DRAWABLE    "Drawable"               0
)

(script-fu-menu-register "script-fu-re-icon"
                         "<Image>/Filters/Alpha to Logo")