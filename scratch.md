
&nbsp;

$expectedScore = \frac{1}{1 + 10^{\frac{ratingB - ratingA}{400}}}$

&nbsp;

$newRating = oldRating + K(score - expectedScore)$

&nbsp;

&nbsp;

&nbsp;

---

&nbsp;

$newRating = oldRating + K(score - expectedScore)$

&nbsp;

$ratingChange = K(score - expectedScore)$

&nbsp;

$ratingChange = K * score - K * expectedScore$


&nbsp;

$K * expectedScore = \frac{K}{1 + 10^{\frac{ratingB - ratingA}{400}}}$

&nbsp;

---

&nbsp;

$10^{\frac{ratingB - ratingA}{400}}$

&nbsp;

&nbsp;


$10^{\frac{ratingB - ratingA}{400}} = \sqrt[400]{10^{ratingB-ratingA}}$

&nbsp;

&nbsp;

$10^{\frac{ratingB - ratingA}{400}} = 10^{\frac{ratingB - ratingA}{25}/16}$

&nbsp;

$10^{\frac{ratingB - ratingA}{400}} =\sqrt[16]{10^{\frac{ratingB - ratingA}{25}}}$

&nbsp;

$10^{\frac{ratingB - ratingA}{400}} = \sqrt{\sqrt{\sqrt{\sqrt{10^{\frac{ratingB - ratingA}{25}}}}}}$

&nbsp;

---

&nbsp;

&nbsp;

&nbsp;

$ratingChange = K * score - \frac{K}{1+\sqrt{\sqrt{\sqrt{\sqrt{10^{\frac{ratingB - ratingA}{25}}}}}}}$
