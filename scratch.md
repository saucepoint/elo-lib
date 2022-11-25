$expectedScore = \frac{1}{1 + 10^{\frac{ratingB - ratingA}{400}}}$

$newRating = oldRating + K(score - expectedScore)$

---

$ratingChange = K(score - expectedScore)$

$ratingChange = K * score - K * expectedScore$

$K * expectedScore = \frac{K}{1 + 10^{\frac{ratingB - ratingA}{400}}}$

---

$10^{\frac{ratingB - ratingA}{400}}$

$10^{\frac{ratingB - ratingA}{400}} = \sqrt[400]{10^{ratingB-ratingA}}$


$10^{\frac{ratingB - ratingA}{400}} = 10^{\frac{ratingB - ratingA}{25}/16}$

$10^{\frac{ratingB - ratingA}{400}} =\sqrt[16]{10^{\frac{ratingB - ratingA}{25}}}$

$10^{\frac{ratingB - ratingA}{400}} = \sqrt{\sqrt{\sqrt{\sqrt{10^{\frac{ratingB - ratingA}{25}}}}}}$

$ratingChange = K * score - \frac{K}{1+\sqrt{\sqrt{\sqrt{\sqrt{10^{\frac{ratingB - ratingA}{25}}}}}}}$
