using Remark
slideshowdir = Remark.slideshow(
    @__DIR__,
    options = Dict("ratio" => "16:9", "countIncrementalSlides" => false),
    title = "AlgebraOfGraphics"
)
