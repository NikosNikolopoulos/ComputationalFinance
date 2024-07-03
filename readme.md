
# Contents
- [Prerequisites](#prerequisites)
- [Docker](#docker)
- [Pricing Financial Instruments](#pricing)
    - [Fourier Method](#fourier-method)
    - [Model Independent Approach](#model-free-bounds)
        - [IBM CPLEX](#ibm-optimization-cplex)
        - [European Basket Call Option](#european-basket-call-option) 
    - [Monte Carlo](#monte-carlo)
        - [European Call Option](#european-call-option)
        - [Geometric Asian Option](#geometric-asian-option)
        - [MSFT Stock Price](#msft-stock-price)
- [Trading Strategies](#trading-strategies)
    - [Trading Bot](#trading-bot)
- [References](#references)

# Prerequisites

The following environment configuration setup would guarantee reproducibility of the obtained results.

- The latest release of the Ubuntu Linux distribution was used, i.e. Ubuntu 24.04 LTS. In fact, any Linux distribution should also be sufficient.
- Docker Engine installation ([docker engine](https://docs.docker.com/engine/install/)).

# Docker

The linux bash script `run.sh` is responsible for building the docker image specified in the [Dockerfile](./docker/Dockerfile) and running the Jupyter application. 

```bash
> ./run.sh
```

![UbuntuCommands](./images/UbuntuCommands.gif)

Then simply copy the produced token value from the terminal and open your web browser and 
navigate to [http://localhost:8080](http://localhost:8080). 

Make sure to paste the token value to the corresponding authentication field to log in. 

![LocalhostConnect](./images/LocalhostConnect.gif)

# Pricing

## Fourier Method

### [European Put Option](./pynbs/Pricing/FourierMethod/EuropeanPutOption.ipynb) 

The payoff function of a European Put Option is the following.

```math
f(x) = (K - e^x)^+
```

The fourier transform corresponding to the put option is equivallent to the following expression.

```math
\hat{f}(u) = \int_{-\infty}^{\infty} e^{iux}(K - e^x)^+ dx
= \frac{K^{1+iu} - K}{1+iu} - \frac{K^{iu} - 1}{iu}
```

## Model Free Bounds

### IBM Optimization CPLEX

#### Use IBM Decision Optimization CPLEX Modeling for Python

Let's use the DOcplex Python library to write the mathematical model in Python.

#### Create the model

All objects of the model belong to one model instance.

#### Define the decision variables.
- The continuous variable *z* represents the dual variable corresponding to the probability measure in the primal problem.
- The continuous matrix variable **y** represents dual variable corresponding to the call prices in the primal problem.

#### Express the objective

We want to find the sub-replicating portfolio (interpretation of dual problem).

### [European Basket Call Option](./pynbs/Pricing/ModelFree/EuropeanBasketOption.ipynb)

Under a number of assumptions listed in this paper [here](https://www.researchgate.net/publication/287506572_Computing_lower_bounds_on_basket_option_prices_by_discretizing_semi-infinite_linear_programming), the model-free lower bound of the basket call is obtained by solving the following optimization problem.

```math
\begin{aligned}[t]
    \inf_{\pi}  \ \mathbb{E}_{\pi}\left [ \left ( \mathbf{w \cdot S}(T) - K \right )^+ \right ]&, \\ \\
    \mathbb{E}_{\pi}\left [ \left ( S_i(T) - K_{ij} \right )^+ \right ]&=c_{ij}, \quad i\in \{1, \dots,n\}, \quad j\in \{1,\dots,m\}.
\end{aligned}
```

The dual problem is given as follows.

```math
\begin{aligned}[t]
    \sup_{z \in \mathbb{R}, \ y \in \mathbb{R}^{n \times m}}  \ &z+ \sum \limits _{i=1}^n \sum \limits_{j=1}^m c_{ij} y_{ij}, \\ \\
    &z+ \sum \limits _{i=1}^n \sum \limits_{j=1}^m \left( s_i - K_{ij} \right)^+y_{ij} \le \left( \mathbf{w \cdot s} - K \right)^+, \quad \forall \ \mathbf{s} \in \mathbb{R}^n_{\ge 0}.
\end{aligned}
```

It is enough to check the constraints for each
```math
s \in \mathcal{C}_0
```
not for all
```math
s \in \mathbb{R}^n_{+}
```
where

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
\mathfrak{B}_k=\left\{s\in \mathbb{R}^n_+ \mid \forall i \not= k, s_i=0 \text{ or } K_{ij} \text{ for some }j, \ s_k=w_k^{-1}\Big( K- \sum\limits_{i=1,i\not=k}^n w_is_i \Big)\ge 0\right\}.
```

The resulting linear program can be written as follows.

```math
\begin{aligned}[t]
    \max_{z \in \mathbb{R}, \ y \in \mathbb{R}^{n \times m}}  \ &z+ \sum \limits _{i=1}^n \sum \limits_{j=1}^m c_{ij} y_{ij}, \\ \\
    &z+ \sum \limits _{i=1}^n \sum \limits_{j=1}^m \left( s_i - K_{ij} \right)^+y_{ij} \le \left( \mathbf{w \cdot s} - K \right)^+, \quad \forall \ \mathbf{s} \in \mathfrak{C}_0, \\
    &\sum \limits_{j=1}^m y_{ij} \le w_i, \quad \forall \ i \in \{1, \dots,n\}.
\end{aligned}
```

#### Separation Problem

```math
 \begin{align*}
        &\textbf{Check if } z+ \sum \limits _{i=1}^n \sum \limits_{j=1}^m \left( s_i - K_{ij} \right)^+y_{ij} \le \left( \mathbf{w \cdot s} - K \right)^+, \quad \forall \ \mathbf{s} \in \mathfrak{C}_0, \\
        &\textbf{or find } \quad \mathbf{s^*} \in \mathfrak{C}_0 \ \textbf{ such that the inequality is violated.} \\
    \end{align*}
```

#### Numerical Results

For the option strikes of the calls for each asset, the starting value is 100 and more calls are added with step size $\text{step} \mathrel{+}=1$ as m
increases.

The algorithm is dependent on the choice of the initial set of constraints $\mathcal{C}$.

Assume that C3 is defined as follows.

```math
\mathcal{C}_3=\left \{(s_1,\dots,s_n) \mid \text{ for some } i, s_i=K_{i0} \text{ or } K_{im} \text{ and for some }p, s_j=K_{jp} \ \forall \ j\not=i\right\}
```

Volatilities and weight vectors in the numerical tests.

|  $n$  | Values                                        |   |   |   |   |   |   |   |   |
|-------|-----------------------------------------------|---|---|---|---|---|---|---|---|
|   3   | $\boldsymbol{\sigma}$                         | 1.0  | 1.6  | 2.0  |   |   |   |   |   |
|       | $\mathbf{w}$                                  | 0.3  | 0.35 | 0.35 |   |   |   |   |   |
|   4   | $\boldsymbol{\sigma}$                         | 0.3  | 0.3  | 1.8  | 1.2 |   |   |   |   |
|       | $\mathbf{w}$                                  | 0.1  | 0.2  | 0.3  | 0.4 |   |   |   |   |
|   5   | $\boldsymbol{\sigma}$                         | 0.3  | 0.4  | 0.8  | 1.8 | 1.9 |   |   |   |
|       | $\mathbf{w}$                                  | 0.2  | 0.2  | 0.2  | 0.2 | 0.2 |   |   |   |
|   6   | $\boldsymbol{\sigma}$                         | 0.3  | 0.5  | 1.3  | 1.5 | 1.9 | 2.1 |   |   |
|       | $\mathbf{w}$                                  | 0.1  | 0.1  | 0.1  | 0.1 | 0.3 | 0.3 |   |   |
|   8   | $\boldsymbol{\sigma}$                         | 0.1  | 0.2  | 1.5  | 1.6 | 1.7 | 1.8 | 1.9 | 2.0 |
|       | $\mathbf{w}$                                  | 0.1  | 0.1  | 0.1  | 0.1 | 0.1 | 0.1 | 0.1 | 0.3 |

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

Paoyff functions of **arithmetic**

```math
\left( \frac{1}{n} \sum_{i=1}^{n} S_{t_i} - K \right)^+
```

and **geometric** Asian Options

```math
\left( \left( \prod_{i=1}^{n} S_{t_i} \right)  ^{1/n} - K \right)^+.
```

### [MSFT Stock Price](./pynbs/Pricing/MonteCarlo/StockPriceMSFT.ipynb)

Simulating the stock price of **Microsoft** for the upcoming 250 trading days MC techniques were used to forecast the prices (100 trajectories were simulated):

$$\text{PriceToday}=\text{PriceYesterday} \times e^{\underbrace{\mu -\frac{\sigma^2}{2}}\_{\text{drift}} + \underbrace{\sigma \mathbf{Z}(\text{Rand[0,1]})}_{\text{volatility}}}.$$ 

![MSFT Stock Price Forecast](/images/StockPriceTrajectoriesMSFT.png)

# Trading Strategies

## [Trading Bot](./pynbs/Trading/bot.py) 

Basic automated trading bot which implements strategies on real-time price data of the CRYPTO-market. The **Relative Strength Index (RSI)** measures the magintude of recent price changes to evaluate overbought or oversold conditions in the price of a stock:

$\text{RSI}= 100 - \frac{100}{1 + \frac{\overline{\text{Gain}}}{\overline{\text{Loss}}}}.$

# References
- [computational-finance-notes](http://www.math.ntua.gr/~papapan/teaching/Lecture_Notes_Bayer.pdf)
- [basket-option-pricing](https://www.researchgate.net/publication/287506572_Computing_lower_bounds_on_basket_option_prices_by_discretizing_semi-infinite_linear_programming)
- [heston-model](https://www.investopedia.com/terms/h/heston-model.asp)
- [binance](https://www.binance.com)
- [yahoo-finance](https://finance.yahoo.com/)
- [binance-spot-api](https://github.com/binance/binance-spot-api-docs)
- [python-binance](https://github.com/sammchardy/python-binance) 
- [TA-Lib](https://mrjbq7.github.io/ta-lib/) 
- [numpy](https://numpy.org/) 
- [websocket_client](https://pypi.org/project/websocket-client/)
