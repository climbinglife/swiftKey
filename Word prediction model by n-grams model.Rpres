Word prediction model by n-grams model
========================================================
author: Jincheng Wu
date: 07/04/2016

Application overview
========================================================

**Function**: predict the next word entry based on previous text

**Method**: back-off n-grams model (n up to 5)

**Data source**: Swiftkey (556MB total, only using 33MB for model development)

Shiny app
========================================================
Shiny app link:
https://climbinglife.shinyapps.io/word_prediction/
![Shiny app snapshot](shinyapp.jpg)

Prediction model
========================================================
**Backoff n-grams model**

N-gram conditional probabilities can be estimated from raw text based on the relative frequency of word sequences.

As N increases, the power (expressiveness) of an N-gram model increases, but the ability to estimate accurate parameters from sparse data decreases (i.e. the smoothing problem gets worse).

A general approach is to combine the results of multiple N-gram models of increasing complexity (i.e. increasing N).



