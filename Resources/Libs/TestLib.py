import random
import re
from faker import Faker
from faker.generator import random


class TestLib(object):
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def Extraction(self, texte):
        #         return re.findall(r'[A-Z]..[a-zA-Z- \S]*', texte)
        return re.findall(r'[aA-zZ].*[a-aZ-Z-\s]*', texte)

    def Extraction2(self, texte):
        return re.findall(r'[a-zA-Z]+[^A-Z]*', texte)

    def Text(nb_mot, graine):
        fake = Faker('fr_FR')

        fake.seed_instance(graine)

        return fake.sentence( )

    def dateRep(self, date_limit):
        fake = Faker('fr_FR')

        DateReponse = fake.future_date(end_date="date_limit")

        return DateReponse

    def Agence(self):
        with open("../Utils/agence.txt") as A:
            # print(random.choice(A.readlines()))
            return random.choice(A.readlines( ))

    def Skill(self):
        with open('../Utils/skill.txt') as S:
            skill = random.choice(S.readlines( ))
            return skill

    def Logement(self):
        with open('../Utils/location.txt') as L:
            return random.choice(L.readlines( ))

    def Client_Aer(self):
        with open('../Utils/client-aer.txt') as C:
            return random.choice(C.readlines( ))

    def Statut_Aer(self):
        with open('../Utils/statut-aer.txt') as C:
            return random.choice(C.readlines( ))

    def Type_Aer(self):
        with open('../Utils/type-aer.txt') as C:
            return random.choice(C.readlines( ))
