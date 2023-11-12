import json
import datetime
import holidays
import paho.mqtt.client as mqtt

config_file = json.load(open('config.json'))
country = config_file.get('country', 'US')
mqtt_server = config_file.get('mqtt_server', 'localhost')
mqtt_port = config_file.get('mqtt_port', 1883)
mqtt_user = config_file.get('mqtt_user', 'mqtt')
mqtt_password = config_file.get('mqtt_password', 'mqtt')
mqtt_topic = config_file.get('mqtt_topic', 'workday')


def main():
    if is_workday() and not is_holiday():
        publish_mqtt(True)
    else:
        publish_mqtt(False)


def is_workday():
    today = datetime.datetime.today().weekday()
    return 0 <= today < 5


def is_holiday():
    today = datetime.datetime.today()
    holidays_list = holidays.country_holidays(country)
    return today in holidays_list


def publish_mqtt(workday):

    client = mqtt.Client()
    client.username_pw_set(mqtt_user, mqtt_password)
    try:
        client.connect(mqtt_server, port=mqtt_port)
        print("Connected to MQTT server: {}:{}".format(mqtt_server, mqtt_port))
        client.publish(mqtt_topic, workday, retain=True)
        print("Published to MQTT topic: {} {}".format(mqtt_topic, workday))
    except Exception as e:
        print("Error connecting to MQTT server: {}".format(e))
        exit(1)

    client.disconnect()
    print("Disconnected from MQTT server")


if __name__ == '__main__':
    main()
