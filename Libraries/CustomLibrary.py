import requests
import json
import csv
import RequestExceptions
import Logger


def get_external_ip():
    ip = requests.get('https://api.ipify.org').text
    return ip

def get_clan_by_name(name, location, token):
    url = 'https://api.clashroyale.com/v1/clans?name=' + name.replace(' ', '%20')
    headers = {"Authorization": "Bearer " + token}

    Logger.log.info(f'Realizando requisicao para selecionar clãs em: {url}')
    response = requests.get(url, headers=headers)

    if (response.status_code == 200):
        Logger.log.debug(f'Resposta da requisicao: {response.json()}')
        Logger.log.info('Filtrando a resposta para obter a Tag do clã em específico.')

        clan = [x for x in response.json()['items'] if x['location']['name'] == location]
        tag = clan[0]['tag']

        Logger.log.info(f'Tag obtida: {tag}')
        get_clan_members_by_tag(tag, headers)
    else:
        Logger.log.error(RequestExceptions.get_exception(response))


def get_clan_members_by_tag(tag, headers):
    url = 'https://api.clashroyale.com/v1/clans/' + tag.replace('#', '%23') + '/members'

    Logger.log.info(f'Realizando requisicao para coletar membros do clã em: {url}')
    response = requests.get(url, headers=headers)

    if (response.status_code == 200):
        Logger.log.debug(f'Resposta da requisicao: {response.json()}')
        generate_csv(response.json()['items'])
    else:
        Logger.log.error(RequestExceptions.get_exception(response))


def generate_csv(membersList):
    Logger.log.info(f'Ordenando dados dos membros para exportar em CSV.')
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
    Logger.log.info(f'CSV exportado com sucesso.')
