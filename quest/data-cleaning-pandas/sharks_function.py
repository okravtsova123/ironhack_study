def countries_clean(country):
    if country in ['Mexico', 'MeXICO']:
        sharky_final["Country"]='MEXICO'
    elif country in ['New Zealand']:
        country='NEW ZEALAND'
    elif country=='TURKS and CaICOS':
        country='TURKS AND CAICOS'
    elif country=='South Africa':
        country="SOUTH AFRICA"
    return country


def gender_clean(gender):
    if gender==" M":
        gender='M'
    return gender


def injury_clean(injury):
    if injury in ['Fatal','Fatal, bite to leg, shoulder and head','Presumed fatal, body not recovered','FATAL, Multiple injuries','Fatal attack','Presumed fatal  PROVOKED INCIDENT']:
        injury="FATAL"
    return injury


def age_clean (age):
    if age=='30s':
        age=30
    elif age=='20/30':
        age=30
    elif age=='20s':
        age=20
    elif age=='!2':
        age=2
    elif age=='50s':
        age=50
    elif age=='40s':
        age=40
    elif age in['teen', 'Teen']:
        age=19
    elif age in ['M','!!']:
        age=0
    elif age=='!6':
        age=6
    elif age=='45 and 15':
        age=45
    elif age=='28 & 22':
        age=28
    elif age=='60s':
        age=60
    elif age=="20's":
        age=20
    elif age=='9 & 60':
        age=60
    elif age=='22, 57, 31':
        age=57
    elif age=='':
        age=0
    return age


def sorting_injuries(injury):
    if type(injury) != str:
        print(injury)
    if 'fatal' in injury.lower():
        return 'fatal'
    else:
        return 'other'
    
def sorting_activity(activity):
    if type(activity) != str:
        print(activity)
    if 'boarding' in activity.lower():
        return 'risky'
    elif 'fishing' in activity.lower():
        return 'high risk'
    elif 'diving' in activity.lower():
        return 'extreme risk'
    else:
        return 'minimum risk'
    
