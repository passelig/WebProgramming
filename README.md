# ThermometerSvgFromRestAPI
This GitHub repository is project focused on demonstrating how to create a dynamic SVG thermometer that displays temperature data retrieved from a REST API.

## Project Overview
The repository contains a folder named ThermometerSvgFromRestAPI, which includes:

A PowerShell script: RandomTemperatureAPI.ps1 — this script runs a local API server that serves random temperature values at http://localhost:8088/temperature/.

An HTML file: ThermometerFromAPI.html — this file fetches the temperature data from the API and displays it using an SVG-based thermometer graphic.

## UserManual

1. Run API in Powershell: /ThermometerSvgFromRestAPI/RandomTemperatureAPI.ps1
2. Open the API in browser http://localhost:8088/temperature/ . It should give something like:
<br>

![API in Browser](images/APIInBrowser.png)
<br>
4. Open the html file in browser file:///C:/WebProgramming/ThermometerSvgFromRestAPI/ThermometerFromAPI.html . Itshould give something like:
<br>

![API in Browser](images/ThermometerInBrowser.png) 
