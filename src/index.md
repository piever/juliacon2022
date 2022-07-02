class: center, middle
# Data Analysis and Visualization with AlgebraOfGraphics
## Pietro Vertechi - JuliaCon 2022
---

### Structure

- Introduction (from data to visualizations).
--
- The philosophy of AlgebraOfGraphics.
--
- The building blocks of AlgebraOfGraphics.
--
- Combining building blocks via algebraic operations.
--
- Gallery and GUI showcase.

---

### From data to visualization: representing data graphically

While a wide array of different visualizations exists,
<br>many plots follow a similar procedure.

--

<ol class="width-half float-left">
  <li>Group and process the data.</li>
  <br>
  <li>Encode graphically
    <ul>
      <li>categorical variables (color palette, marker shape, line style, etc.),</li>
      <li>continuous quantities (x, y position, marker size, color gradient, etc.).</li>
    </ul>
  </li>
  <br>
  <li>Select a plot type and theme some plot attributes.</li>
  <br>
  <li>Finally, combine many such plots to generate a complex figure.</li>
  <br>
</ol>

--

<img src="assets/exampleplot.svg" alt="" class="float-right plot">

--

<p class="width-half"><b>Key observation:</b> the two layers (scatter and lines) share a lot of information.</p>

---

### Philosophy of AlgebraOfGraphics

AlgebraOfGraphics is a language for data visualization (based on Makie).

#### Aims

- Translate questions about data into relevant visualizations *declaratively*.
--
- Remove cognitive overhead via opinionated graphical defaults and broad data format support.
--
- Support predefined as well as custom analyses, transformations, and plotting recipes.
--
- Encourage users to define and reuse their own custom building blocks.
--
- Create complex plots from basic building blocks via `*` and `+` operations.

---

### How does AlgebraOfGraphics work?

```@setup introplot
mkpath("assets")
using AlgebraOfGraphics, CairoMakie
bg = (backgroundcolor=:transparent,)
theme = Theme(AlgebraOfGraphics.aog_theme())
update_theme!(theme; Axis=bg, bg...)
set_theme!(theme)

CairoMakie.activate!(type="svg")
using PalmerPenguins, DataFrames
penguins = dropmissing(DataFrame(PalmerPenguins.load()))
```

.width-two-thirds.float-left[

```@example introplot
# tabular dataset
dataset = data(penguins)

# graphically encode bill size (converted to centimeters)
bill_encoding = mapping(
    :bill_length_mm => (t -> t / 10) => "bill length (cm)",
    :bill_depth_mm => (t -> t / 10) => "bill depth (cm)"
)

# `*` combines information
plt = dataset * bill_encoding

# additional layout customization
draw(
    plt,
    axis = (width = 225, height = 225)
)
save("assets/exampleplotscatterpartial.svg", current_figure()) # hide
```

]

--

<img src="assets/exampleplotscatterpartial.svg" alt="" class="float-left plot">

---

### How does AlgebraOfGraphics work?

.width-two-thirds.float-left[

```@example introplot
# tabular dataset
dataset = data(penguins)

# graphically encode bill size (converted to centimeters)
bill_encoding = mapping(
    :bill_length_mm => (t -> t / 10) => "bill length (cm)",
    :bill_depth_mm => (t -> t / 10) => "bill depth (cm)"
)

# mappings specific to the scatter plot
scatter_layer = mapping(
    color = :body_mass_g => (t -> t / 1000) => "body mass (kg)",
    marker = :species
)

# `*` combines information
plt = dataset * bill_encoding * scatter_layer

# additional layout customization
draw(
    plt,
    axis = (width = 225, height = 225),
    legend = (position = :top,)
)
save("assets/exampleplotscatter.svg", current_figure()) # hide
```

]

<img src="assets/exampleplotscatter.svg" alt="" class="float-left plot">

---

### How does AlgebraOfGraphics work?

.width-two-thirds.float-left[
```@example introplot
# tabular dataset
dataset = data(penguins)

# graphically encode bill size (converted to centimeters)
bill_encoding = mapping(
    :bill_length_mm => (t -> t / 10) => "bill length (cm)",
    :bill_depth_mm => (t -> t / 10) => "bill depth (cm)"
)

# settings specific to the lines plot
lines_layer = mapping(group = :species) * linear()

# `*` combines information
plt = dataset * bill_encoding * lines_layer

# additional layout customization
draw(
    plt,
    axis = (width = 225, height = 225)
)
save("assets/exampleplotlines.svg", current_figure()) # hide
```
]

--

<img src="assets/exampleplotlines.svg" alt="" class="float-left plot">


---

### How does AlgebraOfGraphics work?

.width-two-thirds.float-left[

```@example introplot
# `+` overlays layers
layers = scatter_layer + lines_layer

# `*` combines information
plt = dataset * bill_encoding * layers

# additional layout customization
draw(
    plt,
    axis = (width = 225, height = 225),
    legend = (position = :top,)
)
save("assets/exampleplot.svg", current_figure()) # hide
```

]

--

<img src="assets/exampleplot.svg" alt="" class="float-left plot">

---

count: false

### How does AlgebraOfGraphics work?

.width-two-thirds.float-left[

```@example introplot
# `+` overlays layers
layers = scatter_layer + lines_layer * visual(color = :slategray)

# `*` combines information
plt = dataset * bill_encoding * layers

# additional layout customization
draw(
    plt,
    axis = (width = 225, height = 225),
    legend = (position = :top,)
)
save("assets/exampleplotalpha.svg", current_figure()) # hide
```

]

<img src="assets/exampleplotalpha.svg" alt="" class="float-left plot">

---

### Thank you!

<h4 style="margin-bottom: 0;">Learn more</h4>

<div class="width-half float-left">
  <h4 style="margin-bottom: 0;">Makie</h4>
  <a href="https://makie.juliaplots.org/stable/">
    <p>https://makie.juliaplots.org/stable/</p>
    <img src="assets/makie-logo.svg" style="height:4em">
  </a>
</div>

<div class="width-half float-right">
  <h4 style="margin-bottom: 0;">AlgebraOfGraphics</h4>
  <a href="http://juliaplots.org/AlgebraOfGraphics.jl/stable/">
    <p>http://juliaplots.org/AlgebraOfGraphics.jl/stable/</p>
    <img src="assets/aog-logo.svg" style="height:4em">
  </a>
</div>

<div style="margin-top: 11em;">
  <h4 style="margin-bottom: 0;">DashiBoard</h4>
  <a href="https://github.com/BeaverResearch/DashiBoard.jl">
    <p>https://github.com/BeaverResearch/DashiBoard.jl</p>
  </a>
  <p>Ongoing collaboration with Mattia Bergomi.</p>
</div>

<div style="position: absolute; bottom: 0; margin-bottom: 1em;">
<b>Financial support: </b><img src="assets/pumas-logo.svg" class="inline-img"> and Veos Digital <img src="assets/veos-digital-logo.png" class="inline-img">.
</div>