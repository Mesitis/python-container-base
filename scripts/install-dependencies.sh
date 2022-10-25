#!/usr/bin/env bash
poetry config http-basic.artifact $ARTIFACT_USERNAME $ARTIFACT_PASSWORD
poetry install --only main