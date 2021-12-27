<H1>Financial Engineering</H1>
  
<H3><A HREF=/StochasticNumericalMethods>Stochastic Numerical Methods in Financial Mathematics</A></H3>
The <B>Heston</B> Stochastic Volatility Model assumes that the price of the <B>asset</B> is described by the equations:

<img src="https://render.githubusercontent.com/render/math?math=dS_{t}=rS_{t}dt+\sqrt{V_t} S_t dW_t, \quad S_0=s,">

<img src="https://render.githubusercontent.com/render/math?math=dV_t= \kappa(\theta-V_t)dt+\eta\sqrt{V_t}d\overline{W_{t}}, \quad V_0 =v.">

If <img src="https://render.githubusercontent.com/render/math?math=X_t=log(S_t)">
then by applying the <a href="https://en.wikipedia.org/wiki/It%C3%B4%27s_lemma#Mathematical_formulation_of_It%C3%B4's_lemma">Itô's lemma</a>
the aforementioned equations can be written in the equivallent form:
<img src="https://render.githubusercontent.com/render/math?math=dX_t= (r-\frac{V_t}{2})dt+\sqrt{V_t}dW_{t}, \quad X_0 =v,">

<img src="https://render.githubusercontent.com/render/math?math=dV_t= \kappa(\theta-V_t)dt+\eta\sqrt{V_t}d\overline{W_{t}}, \quad V_0 =v,">
where:
<img src="https://render.githubusercontent.com/render/math?math=\overline{W}= \rho W+\sqrt{1-\rho^2}\hat{W}.">

For the purposes of this exercise the parameters passed to the model can be found in the following model:

<TABLE>
  <TR>
    <TH>Parameters</TH> <TH>Symbol</TH> <TH>Values</TH>
  </TR>
  <TR>  
  <TD>Mean Reverison</TD> <TD><img src="https://render.githubusercontent.com/render/math?math=\kappa"></TD><TD>1</TD>
  </TR>
  <TR>
    <TD>Long Run Variance</TD> <TD><img src="https://render.githubusercontent.com/render/math?math=\theta"></TD> <TD>0.09</TD>
  </TR>
  <TR>
    <TD>Current Variance</TD> <TD> v </TD> <TD>0.09</TD>
  </TR>
  <TR>
    <TD>Correlation</TD> <TD><img src="https://render.githubusercontent.com/render/math?math=\rho"></TD><TD>-0.3</TD>
  </TR>
  <TR>
    <TD>Volatility</TD> <TD><img src="https://render.githubusercontent.com/render/math?math=\eta"></TD><TD>1</TD> 
  </TR>
  <TR>
    <TD>Maturity</TD> <TD>T</TD> <TD>1</TD>
  </TR>
  <TR>
    <TD>Interest Rate</TD><TD>r</TD><TD>0</TD>
  </TR>
  <TR>
    <TD>Strike Prices</TD><TD>K</TD><TD><img src="https://render.githubusercontent.com/render/math?math=\{80,100,120\}"></TD>
  </TR>
</TABLE>

<H3><A HREF=/MonteCarloPricing>Monte Carlo Techniques for Stock Pricing</A></H3>

Simulating the stock price of <B>Microsoft</B> for the upcoming 250 trading days MC techniques to forecast the prices:
<img src="https://render.githubusercontent.com/render/math?math=\begin{equation*}\text{PriceToday}=\text{PriceYesterday} \times e^{\underbrace{\mu -\frac{\sigma^2}{2}}_{\text{drift}} %2B \underbrace{\sigma \mathbf{Z}(\text{Rand[0,1]})}_{\text{volatility}}}.\end{equation*}">

<IMG SRC=/MonteCarloPricing/IMG/PriceTrajectories.png alt="MSFT Stock Price Forecast" width="800" height="300">

<H3><A HREF=/TradingBot>Automated Trading Strategies</A></H3>

<H3>References</H3>
[1] https://www.investopedia.com/terms/h/heston-model.asp

[2] https://www.binance.com

[3] https://finance.yahoo.com/
