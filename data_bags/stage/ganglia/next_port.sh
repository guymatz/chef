#!/usr/bin/env bash
grep -r port * | awk '{print $3}' | grep -v port | sort | tail -1
