
import os
import logging
import datetime

currentDirectory = os.getcwd() + '\\'
currentDate = datetime.datetime.now().strftime('%Y%m%d_%H%M%S')

# Verifica se o diretório de Log existe, caso contrário, criá-lo
isdir = os.path.isdir(f'{currentDirectory}\\Log')
if (not isdir):
    os.mkdir('Log') 
    
# Define as configurações do gerador de logs
log = logging.getLogger()
fhandler = logging.FileHandler(
    filename=f'{currentDirectory}/Log/{currentDate}_log.log', mode='w')
formatter = logging.Formatter(
    '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
fhandler.setFormatter(formatter)
log.addHandler(fhandler)
log.setLevel(logging.INFO)
