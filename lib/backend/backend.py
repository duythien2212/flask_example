from flask import Flask, jsonify, request
import json
import flask_cors

app = Flask(__name__)

@app.route('/api/data', methods=['GET'])
def get_data():
    data = {'message': 'Hello from Python!'}
    return jsonify(data)

@app.route('/endpoint', methods=['POST'])
def receive_data():
  request_data = request.data
  data = json.loads(request_data.decode("utf-8"))
  print(f"Received data: {data['message']}")
  return "OK"


    

if __name__ == '__main__':
    flask_cors.CORS(app, max_age=3600)
    app.run(port=5000)  # Run on all interfaces