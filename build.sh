#!/usr/bin/env bash

stack build && ccjs .stack-work/dist/x86_64-linux/Cabal-1.24.0.0_ghcjs/build/jsonFormatter/jsonFormatter.jsexe/all.js --compilation_level=SIMPLE_OPTIMIZATIONS > jsonFormatter.js
