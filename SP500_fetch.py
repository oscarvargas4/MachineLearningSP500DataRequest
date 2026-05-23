import yfinance as yf
import time, random
import os

def _yf_download_with_retry(ticker_or_list, start, end, max_retries=20, **kwargs):
    """Wrapper around yf.download with exponential backoff for rate-limit errors."""
    
    for attempt in range(1, max_retries + 1):
        try:
            df = yf.download(ticker_or_list, start=start, end=end,
                             progress=False, auto_adjust=True, **kwargs)
            if df is not None and len(df) > 0:
                return df
            raise ValueError("Empty response from yfinance")
        except Exception as exc:
            wait = (2 * attempt) + random.uniform(0, 2)
            print(f"  [attempt {attempt}/{max_retries}] {exc} -- retrying in {wait:.1f}s ...")
            time.sleep(wait)
    raise RuntimeError(
        f"Failed to download {ticker_or_list} after {max_retries} attempts. "
        "Yahoo Finance rate-limits Docker/cloud IPs. Wait a few minutes and retry."
    )

start="1950-01-01"
end="2026-05-23"

sp500 = _yf_download_with_retry("^GSPC", start=start, end=end)
current_dir = os.getcwd()
cache_csv = os.path.join(current_dir, "market_data_cache.csv")
sp500.to_csv(cache_csv)
