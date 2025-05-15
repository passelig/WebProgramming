# -*- coding: utf-8 -*-
"""
Serve temperature data via API on port 8088
"""

import serial
import threading
import time
from flask import Flask, jsonify
from flask_cors import CORS


# Global variable to store the latest temperature
latest_temperature = None

# Set up Flask app
app = Flask(__name__)
CORS(app)  # <-- This enables CORS for all routes

@app.route('/temperature', methods=['GET'])
def get_temperature():
    if latest_temperature is not None:
        return jsonify({'temperature': int(latest_temperature)})
    else:
        return jsonify({'error': 'No data yet'}), 503

def read_serial():
    global latest_temperature
    ser = serial.Serial('COM4', 115200, timeout=1)
    time.sleep(2)
    try:
        while True:
            if ser.in_waiting > 0:
                line = ser.readline().decode('utf-8').strip()
                print(f"Received: {line}")
                try:
                    latest_temperature = float(line)
                except ValueError:
                    print(f"Invalid data: {line}")
    except Exception as e:
        print(f"Serial reading error: {e}")
    finally:
        ser.close()

# Start the serial reader in a background thread
thread = threading.Thread(target=read_serial, daemon=True)
thread.start()

# Start the Flask API
if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8088)

