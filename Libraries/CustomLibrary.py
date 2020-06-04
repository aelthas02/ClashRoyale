import requests
import json
import csv
import logging
import datetime

currentDate = datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
logging.basicConfig(format='%(asctime)s %(message)s', datefmt='%m/%d/%Y %I:%M:%S %p', filename=f'{currentDate}_LoggerDebug.log', filemode='w', level=logging.DEBUG)
token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjhlMjQ3MTY4LWQ5ODYtNGY3My04YzAyLTBmMjk3MTI2OWYyOSIsImlhdCI6MTU5MTI4NDkzOCwic3ViIjoiZGV2ZWxvcGVyLzRlNDI5NWI3LTU0YWUtMjhhMi0xNmJkLTQxMTNhZjZlNWE4ZCIsInNjb3BlcyI6WyJyb3lhbGUiXSwibGltaXRzIjpbeyJ0aWVyIjoiZGV2ZWxvcGVyL3NpbHZlciIsInR5cGUiOiJ0aHJvdHRsaW5nIn0seyJjaWRycyI6WyIyMDEuNDIuMTMyLjEzNSJdLCJ0eXBlIjoiY2xpZW50In1dfQ.jgCpPmGI_iOJzt5spVqphLMa32TVzzZSE8xioCnOqfHSsyg9YVyiLsGSgQI5YqY11lBUhc-zH0ifpjdJrt9xKA'
headers = {"Authorization": "Bearer " + token }

def get_clan_by_name(name, location):
    url = 'https://api.clashroyale.com/v1/clans?name=' + name.replace(' ','%20')

    logging.info(f'Realizando requisição para selecionar clãs em: {url}')
    response = requests.get(url, headers=headers).json()
    logging.debug(f'Resposta da requisição: {response}')
    
    logging.info('Filtrando a resposta capara obter a Tag do clã em específico.')
    clan = [x for x in response['items'] if x['location']['name'] == location]
    tag = clan[0]['tag']
    logging.debug(f'Tag obtida: {tag}')
    get_clan_members_by_tag(tag)


def get_clan_members_by_tag(tag):
    url = 'https://api.clashroyale.com/v1/clans/' + tag.replace('#','%23') + '/members'

    logging.info(f'Realizando requisição para coletar membros do clã em: {url}')
    response = requests.get(url, headers=headers).json()
    logging.debug(f'Resposta da requisição: {response}')

    generate_csv(response['items'])


def generate_csv(membersList):        
    logging.info(f'Ordenando dados dos membros para exportar em CSV.')
    with open('csvFile.csv', 'w', newline='', encoding='utf-8') as f:
        fieldNames = ['Nome', 'Level', 'Troféus', 'Papel']
        str = csv.DictWriter(f, fieldnames=fieldNames, delimiter=';')
        str.writeheader()

        for x in membersList:
            str.writerow({
                'Nome': x['name'], 
                'Level': x['expLevel'], 
                'Troféus': x['trophies'], 
                'Papel': x['role']
            })
    logging.info(f'CSV exportado com sucesso.')
            