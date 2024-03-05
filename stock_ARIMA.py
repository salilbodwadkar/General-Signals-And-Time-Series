import yfinance as yf
import numpy as np
import matplotlib.pyplot as plt
from statsmodels.tsa.stattools import adfuller
from statsmodels.graphics.tsaplots import plot_acf, plot_pacf
from statsmodels.tsa.arima.model import ARIMA

# Initial guess for p, d, q parameters
p = 3
d = 3
q = 3

# Check Stationarity through Augmented Dickey-Fuller test
def not_stationary(x):
    
    ADF = adfuller(x)
    print('ADF Statistic:', ADF[0])
    print('p-value:', ADF[1])
    print('Critical Values:')
    for key, value in ADF[4].items():
        print(f'{key}: {value}')
    if ADF[1] <= 0.05:
        print("Stationary: Data is stationary.")
    else:
        print("Non-Stationary: Data is not stationary. Performing differencing.")
        return True
        
# Function for plotting ACF and PACF
def plot_acf_pacf(x, lags=20):
    fig, ax = plt.subplots(2, figsize=(12, 8))
    
    # Plot autocorrelation function (ACF)
    plot_acf(x, lags=lags, ax=ax[0])
    ax[0].set_title('Autocorrelation Function (ACF)')
    
    # Plot partial autocorrelation function (PACF)
    plot_pacf(x, lags=lags, ax=ax[1])
    ax[1].set_title('Partial Autocorrelation Function (PACF)')
    
    plt.show()
    
# Function to fit the ARIMA Model
def fit_arima_model(x, order):
    model = ARIMA(x, order=order)
    fitted_model = model.fit()
    return fitted_model

# Function to update ARIMA model with new data
def update_arima_model(y, new_data):
    y = y.append(new_data)
    return y

# Function to forecast using ARIMA model
def forecast_arima_model(y, steps):
    forecast = y.forecast(steps=steps)
    return forecast


# Function to plot Forecast vs Actual
def plot_forecast(actual, forecast, forecast_steps):
    plt.plot(np.arange(len(actual)), actual, label='Actual')
    plt.plot(np.arange(len(actual), len(actual) + forecast_steps), forecast, color='red', label='Forecast')
    plt.xlabel('Time')
    plt.ylabel('Price')
    plt.title('Actual vs Forecasted Stock Prices')
    plt.legend()
    plt.show()

def stock_analytics(ticker, start_date, end_date, forecast_steps,p,q):
    d = 0
    x = yf.download(ticker, start=start_date, end=end_date)
        
    # Extract closing data, convert to NumPy array
    closing_data = np.array((x['Close'].values))
    
    # Check for Stationarity 
    if not_stationary(closing_data):
        closing_data = np.diff(closing_data)
    
    # Plot ACF and PACF
    plot_acf_pacf(closing_data)
 
    # Determine ARIMA parameters
    order = np.array([p,d,q])
 
    # Initialize ARIMA model with initial data
    arima_model = ARIMA(closing_data, order=order).fit()
    

    arima_model = fit_arima_model(closing_data, order)
    # Forecast using updated ARIMA model
    forecast = forecast_arima_model(arima_model, forecast_steps)
    #Visualize actual vs. forecasted values
    plot_forecast(closing_data[-100:], forecast, forecast_steps)

    return forecast
