# define rooms and items for game room

couch = {
    "name": "couch",
    "type": "furniture",
}

door_a = {
    "name": "door a",
    "type": "door",
}

key_a = {
    "name": "key for door a",
    "type": "key",
    "target": door_a,
}

piano = {
    "name": "piano",
    "type": "furniture",
}

game_room = {
    "name": "game room",
    "type": "room",
}

outside = {
  "name": "outside"
}

all_rooms = [game_room, outside]

all_doors = [door_a]

# define which items/rooms are related

object_relations = {
    "game room": [couch, piano, door_a],
    "piano": [key_a],
    "outside": [door_a],
    "door a": [game_room, outside]
}

INIT_GAME_STATE = {
    "current_room": game_room,
    "keys_collected": [],
    "target_room": outside
}

# adding dictionaries for objects in Bedroom1

queen_bed = {
    "name": "queen bed",
    "type": "furniture",
}

door_b = {
    "name": "door b",
    "type": "door",
}

door_c = {
    "name": "door c",
    "type": "door",
}

key_b = {
    "name": "key for door b",
    "type": "key",
    "target": door_b,
}

bedroom1 = {
    "name": "bedroom1",
    "type": "room",
}

outside = {
  "name": "outside"
}

all_rooms = [game_room, bedroom1, outside]

all_doors = [door_a,door_b,door_c]

# define which items/rooms are related

object_relations_b1 = {
    "bedroom1": [queen_bed,door_a,door_b,door_c],
    "queen bed": [key_b],
    "outside": [door_b],
    "door b": [bedroom1, outside]
}

# adding dictionaries for objects in Bedroom2

double_bed = {
    "name": "double bed",
    "type": "furniture",
}

dresser = {
    "name": "dresser",
    "type": "furniture",
}


door_d = {
    "name": "door d",
    "type": "door",
}

key_c = {
    "name": "key for door c",
    "type": "key",
    "target": door_c,
}

key_d = {
    "name": "key for door d",
    "type": "key",
    "target": door_d,
}

bedroom2 = {
    "name": "bedroom2",
    "type": "room",
}

outside = {
  "name": "outside"
}

all_rooms = [game_room, bedroom1, bedroom2, outside]

all_doors = [door_a,door_b,door_c,door_d]

# define which items/rooms are related

object_relations_b2 = {
    "bedroom2": [double_bed,dresser, door_b, door_c],
    "double bed": [key_c],
    "dresser":[key_d],
    "outside": [door_c],
    "door c": [bedroom2, outside]
}

#adding items for living room

dining_table = {
    "name": "dining table",
    "type": "furniture",
}

living_room = {
    "name": "living room",
    "type": "room",
}

outside = {
  "name": "outside"
}

all_rooms = [bedroom2, living_room, outside]

all_doors = [door_a,door_b,door_c,door_d]

# define which items/rooms are related

object_relations_lr = {
    "living room": [dining_table, door_c, door_d],
    "outside": [door_d],
    "door d": [living_room, outside]
}

#FUNCTIONS FOR GAME ROOM

def linebreak():
    """
    Print a line break
    """
    print("\n\n")

def start_game():
    """
    Start the game
    """
    print("You wake up on a couch and find yourself in a strange house with no windows which you have never been to before. You don't remember why you are here and what had happened before. You feel some unknown danger is approaching and you must get out of the house, NOW!")
    play_room(game_state["current_room"])

def play_room(room):
    """
    Play a room. First check if the room being played is the target room.
    If it is, the game will end with success. Otherwise, let player either
    explore (list all items in this room) or examine an item found here.
    """
    game_state["current_room"] = room
    if(game_state["current_room"] == game_state["target_room"]):
        print("Congrats! You escaped the room! You are now in Bedroom 1! Here you need to find another key")
    else:
        print("You are now in " + room["name"])
        intended_action = input("What would you like to do? Type 'explore' or 'examine'?").strip()
        if intended_action.lower() == "explore":
            explore_room(room)
            play_room(room)
        elif intended_action.lower() == "examine":
            examine_item(input("What would you like to examine?").strip())
        else:
            print("Not sure what you mean. Type 'explore' or 'examine'.")
            play_room(room)
        linebreak()

def explore_room(room):
    """
    Explore a room. List all items belonging to this room.
    """
    items = [i["name"] for i in object_relations[room["name"]]]
    print("You explore the room. This is " + room["name"] + ". You find " + ", ".join(items))

def get_next_room_of_door(door, current_room):
    """
    From object_relations, find the two rooms connected to the given door.
    Return the room that is not the current_room.
    """
    connected_rooms = object_relations[door["name"]]
    for room in connected_rooms:
        if(not current_room == room):
            return room

def examine_item(item_name):
    """
    Examine an item which can be a door or furniture.
    First make sure the intended item belongs to the current room.
    Then check if the item is a door. Tell player if key hasn't been
    collected yet. Otherwise ask player if they want to go to the next
    room. If the item is not a door, then check if it contains keys.
    Collect the key if found and update the game state. At the end,
    play either the current or the next room depending on the game state
    to keep playing.
    """
    current_room = game_state["current_room"]
    next_room = ""
    output = None

    for item in object_relations[current_room["name"]]:
        if(item["name"] == item_name):
            output = "You examine " + item_name + ". "
            if(item["type"] == "door"):
                have_key = False
                for key in game_state["keys_collected"]:
                    if(key["target"] == item):
                        have_key = True
                if(have_key):
                    output += "You unlock it with a key you have."
                    next_room = get_next_room_of_door(item, current_room)
                else:
                    output += "It is locked but you don't have the key."
            else:
                if(item["name"] in object_relations and len(object_relations[item["name"]])>0):
                    item_found = object_relations[item["name"]].pop()
                    game_state["keys_collected"].append(item_found)
                    output += "You find " + item_found["name"] + "."
                else:
                    output += "There isn't anything interesting about it."
            print(output)
            break

    if(output is None):
        print("The item you requested is not found in the current room.")

    if(next_room and input("Do you want to go to the next room? Ener 'yes' or 'no'").strip() == 'yes'):
        play_room(next_room)
        current_room='bedroom1'
        play_room_b1(bedroom1)

    else:
        play_room(current_room)

#functions for bedroom 1
def play_room_b1(room):
    """
    Play a room. First check if the room being played is the target room.
    If it is, the game will end with success. Otherwise, let player either
    explore (list all items in this room) or examine an item found here.
    """
    game_state["current_room"] = room

    if(game_state["current_room"] == game_state["target_room"]):
        print("Congrats! You escaped the room! You are going to Bedroom 2, and you need to find 2 keys there! Don't leave until you have 2 keys")
    else:
        print("You are now in " + room["name"])
        intended_action = input("What would you like to do? Type 'explore' or 'examine'?").strip()
        if intended_action.lower() == "explore":
            explore_room_b1(room)
            play_room_b1(room)
        elif intended_action.lower() == "examine":
            examine_item_b1(input("What would you like to examine?").strip())
        else:
            print("Not sure what you mean. Type 'explore' or 'examine'.")
            play_room_b1(room)
        linebreak()

def explore_room_b1(room):
    """
    Explore a room. List all items belonging to this room.
    """
    items = [i["name"] for i in object_relations_b1[room["name"]]]
    print("You explore the room. This is " + room["name"] + ". You find " + ", ".join(items))

def examine_item_b1(item_name):
    """
    Examine an item which can be a door or furniture.
    First make sure the intended item belongs to the current room.
    Then check if the item is a door. Tell player if key hasn't been
    collected yet. Otherwise ask player if they want to go to the next
    room. If the item is not a door, then check if it contains keys.
    Collect the key if found and update the game state. At the end,
    play either the current or the next room depending on the game state
    to keep playing.
    """
    current_room = game_state["current_room"]
    next_room = ""
    output = None

    for item in object_relations_b1[current_room["name"]]:
        if(item["name"] == item_name):
            output = "You examine " + item_name + ". "
            if(item["type"] == "door"):
                have_key = False
                for key in game_state["keys_collected"]:
                    if(key["target"] == item):
                        have_key = True
                if(have_key):
                    output += "You unlock it with a key you have."
                    next_room = get_next_room_of_door_b1(item, current_room)
                else:
                    output += "It is locked but you don't have the key."
            else:
                if(item["name"] in object_relations_b1 and len(object_relations_b1[item["name"]])>0):
                    item_found = object_relations_b1[item["name"]].pop()
                    game_state["keys_collected"].append(item_found)
                    output += "You find " + item_found["name"] + "."
                else:
                    output += "There isn't anything interesting about it."
            print(output)
            break

    if(output is None):
        print("The item you requested is not found in the current room.")

    if(next_room and input("Do you want to go to the next room? Ener 'yes' or 'no'").strip() == 'yes'):
        play_room_b2(next_room)
        current_room='bedroom2'
        play_room_b2(bedroom2)

    else:
        play_room_b1(current_room)

def get_next_room_of_door_b1(door, current_room):
    """
    From object_relations, find the two rooms connected to the given door.
    Return the room that is not the current_room.
    """
    connected_rooms = object_relations_b1[door["name"]]
    for room in connected_rooms:
        if(not current_room == room):
            return room
        
#functions for bedroom2
def play_room_b2(room):
    """
    Play a room. First check if the room being played is the target room.
    If it is, the game will end with success. Otherwise, let player either
    explore (list all items in this room) or examine an item found here.
    """
    game_state["current_room"] = room

    if(game_state["current_room"] == game_state["target_room"]):
        print("Congrats! You escaped the room! you're now in Bedroom 2, you need to find 2 keys here")
    else:
        print("You are now in " + room["name"])
        intended_action = input("What would you like to do? Type 'explore' or 'examine'?").strip()
        if intended_action.lower() == "explore":
            explore_room_b2(room)
            play_room_b2(room)
        elif intended_action.lower() == "examine":
            examine_item_b2(input("What would you like to examine?").strip())
        else:
            print("Not sure what you mean. Type 'explore' or 'examine'.")
            play_room_b2(room)
        linebreak()

def explore_room_b2(room):
    """
    Explore a room. List all items belonging to this room.
    """
    items = [i["name"] for i in object_relations_b2[room["name"]]]
    print("You explore the room. This is " + room["name"] + ". You have access to " + ", ".join(items))

def examine_item_b2(item_name):
    """
    Examine an item which can be a door or furniture.
    First make sure the intended item belongs to the current room.
    Then check if the item is a door. Tell player if key hasn't been
    collected yet. Otherwise ask player if they want to go to the next
    room. If the item is not a door, then check if it contains keys.
    Collect the key if found and update the game state. At the end,
    play either the current or the next room depending on the game state
    to keep playing.
    """
    current_room = game_state["current_room"]
    next_room = ""
    output = None

    for item in object_relations_b2[current_room["name"]]:
        if(item["name"] == item_name):
            output = "You examine " + item_name + ". "
            if(item["type"] == "door"):
                have_key = False
                for key in game_state["keys_collected"]:
                    if(key["target"] == item):
                        have_key = True
                if(have_key):
                    output += "You unlock it with a key you have."
                    next_room = get_next_room_of_door_b2(item, current_room)
                else:
                    output += "It is locked but you don't have the key."
            else:
                if(item["name"] in object_relations_b2 and len(object_relations_b2[item["name"]])>0):
                    item_found = object_relations_b2[item["name"]].pop()
                    game_state["keys_collected"].append(item_found)
                    output += "You find " + item_found["name"] + "."
                else:
                    output += "There isn't anything interesting about it."
            print(output)
            break

    if(output is None):
        print("The item you requested is not found in the current room.")

    if(next_room and input("Do you want to go to the next room? Ener 'yes' or 'no'").strip() == 'yes'):
        play_room_lr(next_room)
        current_room='living_room'
        play_room_lr(living_room)

    else:
        play_room_b2(current_room)

def get_next_room_of_door_b2(door, current_room):
    """
    From object_relations, find the two rooms connected to the given door.
    Return the room that is not the current_room.
    """
    connected_rooms = object_relations_b2[door["name"]]
    for room in connected_rooms:
        if(not current_room == room):
            return room
        
#functions for living room
def play_room_lr(room):
    """
    Play a room. First check if the room being played is the target room.
    If it is, the game will end with success. Otherwise, let player either
    explore (list all items in this room) or examine an item found here.
    """
    game_state["current_room"] = room

    if(game_state["current_room"] == game_state["target_room"]):
        print("Congrats! You'are now in living room (last room on the way out)")
    else:
        print("You are now in " + room["name"])
        intended_action = input("What would you like to do? Type 'explore' or 'examine'?").strip()
        if intended_action.lower() == "explore":
            explore_room_lr(room)
            play_room_lr(room)
        elif intended_action.lower() == "examine":
            examine_item_lr(input("What would you like to examine?").strip())
        else:
            print("Not sure what you mean. Type 'explore' or 'examine'.")
            play_room_lr(room)
        linebreak()

def explore_room_lr(room):
    """
    Explore a room. List all items belonging to this room.
    """
    items = [i["name"] for i in object_relations_lr[room["name"]]]
    print("You explore the room. This is " + room["name"] + ". You find " + ", ".join(items))

def examine_item_lr(item_name):
    """
    Examine an item which can be a door or furniture.
    First make sure the intended item belongs to the current room.
    Then check if the item is a door. Tell player if key hasn't been
    collected yet. Otherwise ask player if they want to go to the next
    room. If the item is not a door, then check if it contains keys.
    Collect the key if found and update the game state. At the end,
    play either the current or the next room depending on the game state
    to keep playing.
    """
    current_room = game_state["current_room"]
    next_room = ""
    output = None

    for item in object_relations_lr[current_room["name"]]:
        if(item["name"] == item_name):
            output = "You examine " + item_name + ". "
            if(item["type"] == "door"):
                have_key = False
                for key in game_state["keys_collected"]:
                    if(key["target"] == item):
                        have_key = True
                if(have_key):
                    output += "You unlock it with a key you have."
                    next_room = get_next_room_of_door_lr(item, current_room)
                else:
                    output += "It is locked but you don't have the key."
            else:
                if(item["name"] in object_relations_lr and len(object_relations_lr[item["name"]])>0):
                    item_found = object_relations_lr[item["name"]].pop()
                    game_state["keys_collected"].append(item_found)
                    output += "You find " + item_found["name"] + "."
                else:
                    output += "There isn't anything interesting about it."
            print(output)
            break

    if(output is None):
        print("The item you requested is not found in the current room.")

    if(next_room and input("Do you want to go to the next room? Ener 'yes' or 'no'").strip() == 'yes'):
        print("Congratulation! You've survived! Winner!")

    else:
        play_room_b2(current_room)

def get_next_room_of_door_lr(door, current_room):
    """
    From object_relations, find the two rooms connected to the given door.
    Return the room that is not the current_room.
    """
    connected_rooms = object_relations_lr[door["name"]]
    for room in connected_rooms:
        if(not current_room == room):
            return room