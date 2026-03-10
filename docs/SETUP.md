# Setup Guide

This project is designed for WSL/Ubuntu users who want a lightweight Shelby CLI automation workflow.

## Overview

The workflow does the following:

- creates text files automatically
- fills them with web3-related content
- attempts uploads on a schedule
- moves attempted files into a processed folder
- writes logs for monitoring

## Main directories

- `/mnt/c/testShelby/incoming`
- `/mnt/c/testShelby/processed`
- `/mnt/c/testShelby/logs`

## Main scripts

- `scripts/make_test_file.sh`
- `scripts/upload_one_shelby.sh`

## Example cron schedule

0 * * * * /mnt/c/testShelby/make_test_file.sh
20 * * * * /mnt/c/testShelby/upload_one_shelby.sh

## Log checks

tail -n 20 /mnt/c/testShelby/logs/make_test_file.log
tail -n 40 /mnt/c/testShelby/logs/upload_one_shelby.log

## Notes

- This workflow is intended for isolated Shelby CLI setups
- It is designed to avoid duplicate retries by moving files after an upload attempt
- During testing on shelbynet, uploads could sometimes return an error while the blob later appeared in the web interface

## Recommended usage

- keep WSL running
- keep cron active
- check logs regularly
- monitor processed files
