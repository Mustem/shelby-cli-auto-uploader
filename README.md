# shelby-cli-auto-uploader

A simple WSL/Ubuntu-based automation setup for Shelby CLI.

This project creates text files automatically, fills them with web3-related content, and attempts scheduled uploads to Shelby using cron. It is designed to be isolated from other node environments and easy to monitor with logs.

## Features

- Isolated Shelby CLI setup on WSL/Ubuntu
- Automatic text file generation
- Random file sizes between 1 KB and 50 KB
- Web3-focused text content
- Scheduled upload attempts with cron
- Processed queue to avoid duplicate retries
- Simple log-based monitoring

## Folder Structure

testShelby/
- incoming/
- processed/
- logs/
- make_test_file.sh
- upload_one_shelby.sh

## How it works

- Every hour, a new .txt file is created
- At minute 20 of every hour, one file is uploaded through Shelby CLI
- After the upload attempt, the file is moved to processed/
- Logs are written for both generation and upload steps

## Notes

- This setup is intended for WSL/Ubuntu
- Shelby CLI runs in an isolated directory
- The system is designed not to interfere with other node setups
- In testing, Shelby may sometimes return an upload error even when the blob appears later in the web interface

## Example cron schedule

0 * * * * /mnt/c/testShelby/make_test_file.sh
20 * * * * /mnt/c/testShelby/upload_one_shelby.sh

## Logs

tail -n 20 /mnt/c/testShelby/logs/make_test_file.log
tail -n 40 /mnt/c/testShelby/logs/upload_one_shelby.log

## Status

This project was created as a practical automation example for Shelby CLI users who want a lightweight scheduled upload workflow on WSL.
## Why this project exists

Shelby CLI is useful, but some users may want a simple scheduled workflow instead of manually creating and uploading files one by one.

This project provides a lightweight WSL-based automation example that:

- generates text files automatically
- fills them with meaningful web3-related content
- uploads them on a schedule
- avoids duplicate retries by moving attempted files into a processed folder
- keeps logs for easier monitoring

## Known behavior observed during testing

During testing on shelbynet, uploads could sometimes return an error in the CLI or web interface while the blob later appeared in the Shelby web interface.

Because of that behavior, this workflow is designed to avoid repeated retries for the same file.
## Feedback submitted to Shelby

Observed upload behavior has also been reported here:
https://github.com/shelby/feedback/issues/31
