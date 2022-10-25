FROM python:3.9-slim as base

    # python
ENV PYTHONUNBUFFERED=1 \
    # prevents python creating .pyc files
    PYTHONDONTWRITEBYTECODE=1 \
    \
    # pip
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    \
    # poetry
    # https://python-poetry.org/docs/configuration/#using-environment-variables
    POETRY_VERSION=1.2.2 \
    # make poetry install to this location
    POETRY_HOME="/opt/poetry" \
    # make poetry create the virtual environment in the project's root
    # it gets named `.venv`
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    # do not ask any interactive question
    POETRY_NO_INTERACTION=1 \
    # paths
    # this is where our requirements + virtual environment will live
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv" \
    PYTHONPATH=/app \
    #
    #
    #
    SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.2.1/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=d7f4c0886eb85249ad05ed592902fa6865bb9d70


RUN groupadd --gid 1000 app \
    && useradd --uid 1000 --gid app --shell /bin/bash --create-home app \
    && mkdir -p /app \
    && chown app:app /app \
    && apt-get update \
    && apt-get install --no-install-recommends -y logrotate dumb-init nano procps curl ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSLO "$SUPERCRONIC_URL" \
    && echo "${SUPERCRONIC_SHA1SUM} ${SUPERCRONIC}" | sha1sum -c - \
    && chmod +x "$SUPERCRONIC" \
    && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
    && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

# prepend poetry and venv to path
ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

ENTRYPOINT ["python"]

# `builder` stage is used to build deps + create our virtual environment
FROM base as builder
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        # deps for building python deps
        build-essential

# install poetry - respects $POETRY_VERSION & $POETRY_HOME
RUN curl -sSL https://install.python-poetry.org | python

COPY scripts /scripts

FROM builder AS dependencies

WORKDIR $PYSETUP_PATH
COPY poetry.lock pyproject.toml ./

ARG ARTIFACT_USERNAME=aws
ARG ARTIFACT_PASSWORD

# install runtime deps - uses $POETRY_VIRTUALENVS_IN_PROJECT internally
RUN /scripts/install-dependencies.sh

FROM base AS app

USER app
WORKDIR /app

COPY --from=dependencies $PYSETUP_PATH $PYSETUP_PATH
