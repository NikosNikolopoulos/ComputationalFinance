# syntax=docker/dockerfile:1
FROM python:3.6.5

WORKDIR /usr/src/app

COPY docker/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY pynbs/Pricing/FourierMethod/EuropeanPutOption.ipynb ./Pricing/FourierMethod/
COPY pynbs/Pricing/ModelFree/EuropeanBasketOption.ipynb ./Pricing/ModelFree/
COPY pynbs/Pricing/MonteCarlo/EuropeanCallOption.ipynb ./Pricing/MonteCarlo/
COPY pynbs/Pricing/MonteCarlo/GeometricAsianOption.ipynb ./Pricing/MonteCarlo/

COPY pynbs/Trading/bot.py ./Trading/

EXPOSE 8080

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8080", "--no-browser", "--allow-root"]