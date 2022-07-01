class: center, middle
# Data Analysis and Visualization with AlgebraOfGraphics
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
- Defining visualizations graphically.

---

### From data to visualization

<p class="width-half">
  Representing data graphically is a ubiquitous problems. While a wide array of different visualizations exists, many plots follow a similar procedure.
</p>

--

<ol class="width-half float-left">
  <li>Group and process the data.</li>
  <li>Encode graphically
    <ul>
      <li>categorical variables (color palette, marker shape, line style, etc.),</li>
      <li>continuous quantities (x, y position, marker size, color gradient, etc.).</li>
    </ul>
  </li>
  <li>Select a plot type and theme some plot attributes.</li>
  <li>Finally, combine many such plots to generate a complex figure.</li>
</ol>

--

<img src="assets/exampleplot.svg" alt="" class="float-right plot">

--

<p class="width-half"><b>Key observation:</b> the two layers (scatter and lines) share a lot of information.</p>

---

### How does AlgebraOfGraphics work?

```@setup introplot
mkpath("assets") # hide
using AlgebraOfGraphics, CairoMakie # hide
set_aog_theme!() # hide
CairoMakie.activate!(type="svg") # hide
using PalmerPenguins, DataFrames # hide
penguins = dropmissing(DataFrame(PalmerPenguins.load())) # hide
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

# mappings specific to the scatter plot
scatter_encoding = mapping(
    color = :body_mass_g => (t -> t / 1000) => "body mass (kg)",
    marker = :species
)

# `*` combines information
scatter_layer = dataset * bill_encoding * scatter_encoding

# additional layout customization
draw(
    scatter_layer,
    axis = (width = 225, height = 225),
    legend = (position = :top,)
)
save("assets/exampleplotscatter.svg", current_figure()) # hide
```

]

--

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

# mappings specific to the lines plot
lines_encoding = mapping(group = :species)

# `*` combines information
lines_layer = dataset * bill_encoding * lines_encoding * linear()

# additional layout customization
draw(
    lines_layer,
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
plt = scatter_layer + lines_layer # `+` overlays layers
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
