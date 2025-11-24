# primeiramente a criacao e permissao das pastas:

# linux:
    mkdir -p peer/{config,downloads/{complete,incomplete},watch}
    mkdir -p leecher1/{config,downloads/{complete,incomplete},watch}
    mkdir -p leecher2/{config,downloads/{complete,incomplete},watch}
    mkdir -p leecher3/{config,downloads/{complete,incomplete},watch}

    sudo chown -R 1000:1000 peer leecher1 leecher2 leecher3
    sudo chmod -R 755 peer leecher1 leecher2 leecher3

# Windows: 
    New-Item -ItemType Directory -Force -Path .\peer\config
    New-Item -ItemType Directory -Force -Path .\peer\downloads\complete
    New-Item -ItemType Directory -Force -Path .\peer\downloads\incomplete
    New-Item -ItemType Directory -Force -Path .\peer\watch

    foreach ($leecher in "leecher1","leecher2","leecher3") {
        New-Item -ItemType Directory -Force -Path ".\$leecher\config"
        New-Item -ItemType Directory -Force -Path ".\$leecher\downloads\complete"
        New-Item -ItemType Directory -Force -Path ".\$leecher\downloads\incomplete"
        New-Item -ItemType Directory -Force -Path ".\$leecher\watch"
    }

## criacao dos containers:

    1. Introdução
    Breve explicação do que é BitTorrent (rede P2P para compartilhamento de arquivos).

    Diferença entre seeder e leecher.

    Papel do tracker (coordena peers) e do DHT (descoberta distribuída).

    2. Configuração inicial
    Mostrar a estrutura de containers: 1 peer + 3 leechers.

    Explicar que o qBittorrent local está atuando como tracker.

    Destacar que o peer começa com DHT desabilitado.

    3. Criação do torrent
    Criar o .torrent no qBittorrent com o tracker HTTP:

    4. Fase 1 – Tracker ativo
    Peer sem DHT consegue baixar porque o tracker informa os seeders.

    Leechers começam a baixar e, ao completar, viram seeders também.

    Mostrar no monitor/logs os pacotes announce e scrape.

    5. Fase 2 – Derrubar o tracker
    Desativar o tracker no qBittorrent.

    Peer sem DHT não encontra mais seeders → download para.

    Leechers com DHT ativo continuam trocando pacotes entre si.

    Mostrar no monitor/logs mensagens get_peers e announce_peer.

    6. Fase 3 – Peer com DHT ativo
    Reiniciar o peer com TRANSMISSION_DHT_ENABLED=true.

    Agora ele participa da rede distribuída e encontra seeders via DHT.

    Mesmo sem tracker, o download continua.

    Mostrar no monitor/logs que o peer passa a enviar/receber mensagens DHT.

    7. Conclusão
    Tracker = ponto central de coordenação, mas dependente.

    DHT = rede distribuída, resiliente mesmo sem tracker.

    Demonstração prática da transição de centralizado → distribuído.

    Destacar que leechers viram seeders, aumentando a robustez da rede.

    Use logs separados por container para mostrar o tráfego em tempo real.

    Mostre a aba “Trackers” no Transmission para evidenciar status “Working” ou “Not Working”.

    Faça pausas entre fases para explicar o que está acontecendo.

    Termine reforçando a importância da DHT para a resiliência da rede.