<H1>Financial Engineering</H1>
  
<H3>Stochastic Numerical Methods in Financial Mathematics</H3>
The <B>Heston</B> Stochastic Volatiity Model assumes that the price of the <B>asset</B> is described by the equations:

<img src="https://render.githubusercontent.com/render/math?math=dS_{t}=rS_{t}dt+\sqrt{V_t} S_t dW_t, \quad S_0=s,">

<img src="https://render.githubusercontent.com/render/math?math=dV_t= \kappa(\theta-V_t)dt+\eta\sqrt{V_t}d\overline{W_{t}}, \quad V_0 =v.">

If <img src="https://render.githubusercontent.com/render/math?math=X_t=log(S_t)">
then by applying the <a href="https://en.wikipedia.org/wiki/It%C3%B4%27s_lemma#Mathematical_formulation_of_It%C3%B4's_lemma">Itô's lemma</a>
the aforementioned equations can be written in the equivallent form:
<img src="https://render.githubusercontent.com/render/math?math=dX_t= (r-\frac{V_t}{2})dt+\sqrt{V_t}dW_{t}, \quad X_0 =v,">
<img src="https://render.githubusercontent.com/render/math?math=dV_t= \kappa(\theta-V_t)dt+\eta\sqrt{V_t}d\overline{W_{t}}, \quad V_0 =v,">
where:
<img src="https://render.githubusercontent.com/render/math?math=\overline{W}= \rho W+\sqrt{1-\rho^2}\hat{W}">

<H3>Monte Carlo Techniques for Stock Pricing</H3>

<H3>References</H3>
[1] https://www.investopedia.com/terms/h/heston-model.asp

[2] https://www.binance.com
