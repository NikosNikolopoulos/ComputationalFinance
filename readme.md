<H1>Financial Engineering</H1>
  
<H3><A HREF=/StochasticNumericalMethods>Stochastic Numerical Methods in Financial Mathematics</A></H3>
The <B>Heston</B> Stochastic Volatility Model assumes that the price of an <B>asset</B> is described by the equations:

$S_{t}=rS_{t}dt+\sqrt{V_t} S_t dW_t, \quad S_0=s$

$dV_t= \kappa(\theta-V_t)dt+\eta\sqrt{V_t}d\overline{W_{t}}, \quad V_0 =v.$

If $X_t=log(S_t)$
then by applying the <a href="https://en.wikipedia.org/wiki/It%C3%B4%27s_lemma#Mathematical_formulation_of_It%C3%B4's_lemma">Itô's lemma</a>
the aforementioned equations can be written in the equivallent form:
$dX_t= (r-\frac{V_t}{2})dt+\sqrt{V_t}dW_{t}, \quad X_0 =x$

$dV_t= \kappa(\theta-V_t)dt+\eta\sqrt{V_t}d\overline{W_{t}}, \quad V_0 =v,$
where:
$\overline{W}= \rho W+\sqrt{1-\rho^2}\hat{W}.$

The parameters passed to the model can be found in the following table:

<TABLE>
  <TR>
    <TH>Parameters</TH> <TH>Symbol</TH> <TH>Values</TH>
  </TR>
  <TR>  
  <TD>Mean Reverison</TD> <TD>$\kappa$</TD><TD>1</TD>
  </TR>
  <TR>
    <TD>Long Run Variance</TD> <TD>$\theta$</TD> <TD>0.09</TD>
  </TR>
  <TR>
    <TD>Current Variance</TD> <TD> v </TD> <TD>0.09</TD>
  </TR>
  <TR>
    <TD>Correlation</TD> <TD>$\rho$</TD><TD>-0.3</TD>
  </TR>
  <TR>
    <TD>Volatility</TD> <TD>$\eta$</TD><TD>1</TD> 
  </TR>
  <TR>
    <TD>Maturity</TD> <TD>T</TD> <TD>1</TD>
  </TR>
  <TR>
    <TD>Interest Rate</TD><TD>r</TD><TD>0</TD>
  </TR>
  <TR>
    <TD>Strike Prices</TD><TD>K</TD><TD>$\{80,100,120\}$</TD>
  </TR>
</TABLE>

<H3><A HREF=/MonteCarloPricing>Monte Carlo Techniques for Stock Pricing</A></H3>

Simulating the stock price of <B>Microsoft</B> for the upcoming 250 trading days MC techniques were used to forecast the prices (100 trajectories were simulated):

$$\text{PriceToday}=\text{PriceYesterday} \times e^{\underbrace{\mu -\frac{\sigma^2}{2}}\_{\text{drift}} + \underbrace{\sigma \mathbf{Z}(\text{Rand[0,1]})}_{\text{volatility}}}.$$ 

<IMG SRC=/MonteCarloPricing/IMG/PriceTrajectories.png alt="MSFT Stock Price Forecast" width="800" height="300">

<H3><A HREF=/TradingBot>Automated Trading Strategies</A></H3>
<H4>Overview</H4>
Basic automated trading bot which implements strategies on real-time price data of the CRYPTO-market. The <B>Relative Strength Index (RSI)</B> measures the magintude of recent price changes to evaluate overbought or oversold conditions in the price of a stock:

$\text{RSI}= 100 - \frac{100}{1 + \frac{\overline{\text{Gain}}}{\overline{\text{Loss}}}}.$
  
<H4>Requirements</H4>
  
- [x] <A HREF=https://github.com/sammchardy/python-binance>python-binance</A>
- [x] <A HREF=https://mrjbq7.github.io/ta-lib/>TA-Lib</A>
- [x] <A HREF=https://numpy.org/>numpy</A>
- [x] <A HREF=https://pypi.org/project/websocket-client/>websocket_client</A>

<H3>References</H3>
[1] https://www.investopedia.com/terms/h/heston-model.asp

[2] https://www.binance.com

[3] https://finance.yahoo.com/
  
[4] https://github.com/binance/binance-spot-api-docs
