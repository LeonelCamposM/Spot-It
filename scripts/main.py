import csv
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Login using service key
cred = credentials.Certificate("key.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

file = open('deck.csv')

csvreader = csv.reader(file)

for row in csvreader:
    #deck_ref definition
    deck_ref = db.collection(u'Deck').document(row[0])
    deck_ref.set({
        u'iconOne': row[1],
        u'iconTwo': row[2],
        u'iconThree': row[3],
        u'iconFour': row[4],
        u'iconFive': row[5],
        u'iconSix' : row[6],
        u'iconSeven': row[7],
        u'iconEight': row[8]
    })
    



