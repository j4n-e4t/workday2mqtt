# workday2mqtt

## 🖥️ Installation

### 🐳 Docker

1. Install [Docker](https://docs.docker.com/get-docker/)
2. Create the config.json file (see below)
3. Run the container
    
    ```bash
    docker run -d --name workday2mqtt -v ./config.json:/workday2mqtt/config.json --restart unless-stopped j4n-e4t/workday2mqtt:latest
    ```

### 🐍 Python Script

1. Install [Python 3](https://www.python.org/downloads/)
2. Clone this repository
3. Install the dependencies

    ```bash
    pip install -r requirements.txt
    ```

4. Modify the config.json file
5. Run the script
    
    ```bash
    python3 main.py
    ```

## ⚙️ Configuration

- **country:** The country code of the country you want to track. (default: `US`)
- **mqtt_server**: The IP address or hostname of your MQTT server. (default: `localhost`)
- **mqtt_port**: The port of your MQTT server. (default: `1883`)
- **mqtt_username**: The username for your MQTT server. (default: `mqtt`)
- **mqtt_password**: The password for your MQTT server. (default: `mqtt`)
- **mqtt_topic**: The topic to publish the data to. (default: `workday`)

