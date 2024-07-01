
# Contents
- [Prerequisites](#prerequisites)
- [Docker](#docker)
- [Pricing Financial Instruments](#pricing)
    - [Fourier Method](#fourier-method)
    - [Model Independent Approach](#model-free)
        - [IBM CPLEX](#ibm-optimization-(cplex))
        - [European Basket Call Option](#european-basket-call-option) 
    - [Monte Carlo](#monte-carlo)
        - [European Call Option](#european-call-option)
        - [Geometric Asian Option](#geometric-asian-option)
        - [MSFT Stock Price](#msft-stock-price)
- [Trading Strategies](#trading-strategies)
    - [Trading Bot](#trading-bot)
- [References](#references)

# [Prerequisites](./docker/requirements.txt)

# Docker

To reproduce the results, simply run the `run.sh` bash script in any linux distribution.

```bash
> ./run.sh
```

# Pricing

## Fourier Method

### [European Put Option](./pynbs/Pricing/FourierMethod/EuropeanPutOption.ipynb) 

## Model Free

### IBM Optimization (CPLEX)

#### Use IBM Decision Optimization CPLEX Modeling for Python

Let's use the DOcplex Python library to write the mathematical model in Python.

#### Set up the prescriptive model

#### Create the model

All objects of the model belong to one model instance.

#### Define the decision variables.
- The continuous variable *z* represents the dual variable corresponding to the probability measure in the primal problem.
- The continuous matrix variable **y** represents dual variable corresponding to the call prices in the primal problem.

#### Express the objective

We want to find the sub-replicating portfolio (interpretation of dual problem).

### [European Basket Call Option](./pynbs/Pricing/ModelFree/EuropeanBasketOption.ipynb)

```math
\mathcal{C}_0=\mathcal{C}_1\cup \mathcal{C}_2
```
```math
\mathcal{C}_1=\left \{s\in \mathbb{R}^n_+ \mid \forall i, s_i=0 \text{ or } K_{ij} \text{ for some }j\right\}
```
```math
\mathcal{C}_2=\bigcup\limits_{k=1}^n\mathfrak{B}_k
```
```math
\mathfrak{B}_k=\left\{s\in \mathbb{R}^n_+ \mid \forall i \not= k, s_i=0 \text{ or } K_{ij} \text{ for some }j, \ s_k=w_k^{-1}\Big( K- \sum\limits_{i=1,i\not=k}^n w_is_i \Big)\ge 0\right\}
```
```math
\mathcal{C}_3=\left \{(s_1,\dots,s_n) \mid \text{ for some } i, s_i=K_{i0} \text{ or } K_{im} \text{ and for some }p, s_j=K_{jp} \ \forall \ j\not=i\right\}
```

## Monte Carlo

### [European Call Option](./pynbs/Pricing/MonteCarlo/EuropeanCallOption.ipynb)

The **Heston** Stochastic Volatility Model assumes that the price of an **asset** is described by the equations:

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

| Parameters | Symbol | Values |
| --- | --- | --- |
| Mean Reverison | $\kappa$ | 1   |
| Long Run Variance | $\theta$ | 0.09 |
| Current Variance | v   | 0.09 |
| Correlation | $\rho$ | \-0.3 |
| Volatility | $\eta$ | 1   |
| Maturity | T   | 1   |
| Interest Rate | r   | 0   |
| Strike Prices | K   | $\{80,100,120\}$ |

### [Geometric Asian Option](./pynbs/Pricing/MonteCarlo/GeometricAsianOption.ipynb)

### [MSFT Stock Price](./pynbs/Pricing/MonteCarlo/StockPriceMSFT.ipynb)

Simulating the stock price of **Microsoft** for the upcoming 250 trading days MC techniques were used to forecast the prices (100 trajectories were simulated):

$$\text{PriceToday}=\text{PriceYesterday} \times e^{\underbrace{\mu -\frac{\sigma^2}{2}}\_{\text{drift}} + \underbrace{\sigma \mathbf{Z}(\text{Rand[0,1]})}_{\text{volatility}}}.$$ 

![MSFT Stock Price Forecast](/images/StockPriceTrajectoriesMSFT.png)

# Trading Strategies

## [Trading Bot](./pynbs/Trading/bot.py) 

Basic automated trading bot which implements strategies on real-time price data of the CRYPTO-market. The **Relative Strength Index (RSI)** measures the magintude of recent price changes to evaluate overbought or oversold conditions in the price of a stock:

$\text{RSI}= 100 - \frac{100}{1 + \frac{\overline{\text{Gain}}}{\overline{\text{Loss}}}}.$

# References
- [heston-model](https://www.investopedia.com/terms/h/heston-model.asp)
- [binance](https://www.binance.com)
- [yahoo-finance](https://finance.yahoo.com/)
- [binance-spot-api](https://github.com/binance/binance-spot-api-docs)
- [python-binance](https://github.com/sammchardy/python-binance) 
- [TA-Lib](https://mrjbq7.github.io/ta-lib/) 
- [numpy](https://numpy.org/) 
- [websocket_client](https://pypi.org/project/websocket-client/)
