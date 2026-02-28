import uuid
import time

class TwitterSnowflakeIdGenerator:
    def __init__(self, machine_id: int):
        self.machine_id = machine_id
        self.sequence_number = 0


def twitter_snowflake_id_generator():
    generator = TwitterSnowflakeIdGenerator(machine_id=1)

    # 41 bits epoch, 10 bits machine id, 12 bits sequence number
    epoch = int(time.time() * 1000) << 22
    machine_id = generator.machine_id << 12
    sequence_number = generator.sequence_number
    generator.sequence_number += 1
    return epoch | machine_id | sequence_number




if __name__ == "__main__":
    new_id = twitter_snowflake_id_generator()
    print(f"Generated ID: {new_id}")