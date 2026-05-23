
# Starting the container

## Build the image: 
```bash
docker build -t ml-data-request-anaconda-jupyter .
```
## Run the container:
```bash    
MSYS_NO_PATHCONV=1 docker run -d -p 8888:8888 -v "$(pwd):/app" --name machine_learning_data_request ml-data-request-anaconda-jupyter 
```
Notice that we needed to add "MSYS_NO_PATHCONV=1" in order to properly map the files from the container to the host due to Git rewriting paths.

## Open the link:
http://localhost:8888

## Kernel
Select "Python (TF2)" Kernel in Jupyter

## Docker issues with yfinance
Since yfinance throttles or blocks IPs from Docker, we would need to fetch information from our local and store it as CSV file.

install module:
```bash
py -m pip install yfinance
```

To check where the module is installed you can run:
```bash
py -m pipi show yfinance
```

After module installation you can run :
```bash
py SP500_fetch.py
```

This will create "market_data_cache".csv file so we can store it in the container