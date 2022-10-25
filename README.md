> Latest version: `1.0.1`

## Python Base Images

### 1) `<version>-toolkit-base`

A [`python:3.9-slim`](https://hub.docker.com/_/python) image containing 

1. `curl`
2. `nano`
3. `logrotate`
4. An `app` user and group with UID/GID of `1000`
5. [dumb-init](https://github.com/Yelp/dumb-init)
6. [supercronic](https://github.com/aptible/supercronic)

### 2) `<version>-toolkit-builer`

Everything in `<version>-toolkit-base`, and 

1. Poetry
2. C / C++ toolchain (via `build-essential`)

### 3) `<version>-toolkit`

Everything in `<version>-toolkit-base`, and some standard python dependencies

```
aioredis           2.0.1     asyncio (PEP 3156) Redis support
async-property     0.2.1     Python decorator for async properties.
async-timeout      4.0.2     Timeout context manager for asyncio programs
asyncio-helpers    0.0.2     Nifty helpers to work with asyncio
asyncio-pool       0.5.2     Pool of asyncio coroutines with familiar interface
asyncpg            0.26.0    An asyncio PostgreSQL driver
boto3              1.25.0    The AWS SDK for Python
botocore           1.28.0    Low-level, data-driven core of boto 3.
cacheout           0.14.1    A caching library for Python
canopy-toolkit     1.3.11    Nifty utilities to access Canopy resources via python.
certifi            2022.9.24 Python package for providing Mozilla's CA Bundle.
cffi               1.15.1    Foreign Function Interface for Python calling C code.
charset-normalizer 2.1.1     The Real First Universal Charset Detector. Open, modern and actively maintained alternative to Chardet.
cryptography       38.0.1    cryptography is a package which provides cryptographic recipes and primitives to Python developers.
ecdsa              0.18.0    ECDSA cryptographic signature library (pure python)
hiredis            2.0.0     Python wrapper for hiredis
hvac               0.10.14   HashiCorp Vault API client
idna               3.4       Internationalized Domain Names in Applications (IDNA)
jmespath           1.0.1     JSON Matching Expressions
paco               0.2.3     Small utility library for coroutine-based asynchronous generic programming
psycopg2-binary    2.9.5     psycopg2 - Python-PostgreSQL Database Adapter
pyasn1             0.4.8     ASN.1 types and codecs
pycparser          2.21      C parser in Python
pycryptodomex      3.15.0    Cryptographic library for Python
pydantic           1.10.2    Data validation and settings management using python type hints
pyotp              2.7.0     Python One Time Password Library
python-dateutil    2.8.2     Extensions to the standard Python datetime module
python-dotenv      0.21.0    Read key-value pairs from a .env file and set them as environment variables
python-jose        3.3.0     JOSE implementation in Python
requests           2.28.1    Python HTTP for Humans.
requests-toolbelt  0.10.1    A utility belt for advanced users of python-requests
rsa                4.9       Pure-Python RSA implementation
s3transfer         0.6.0     An Amazon S3 Transfer Manager
six                1.16.0    Python 2 and 3 compatibility utilities
structlog          22.1.0    Structured Logging for Python
tenacity           8.1.0     Retry code until it succeeds
typing-extensions  4.4.0     Backported and Experimental Type Hints for Python 3.7+
urllib3            1.26.12   HTTP library with thread-safe connection pooling, file post, and more.
websockets         10.3      An implementation of the WebSocket Protocol (RFC 6455 & 7692)
```