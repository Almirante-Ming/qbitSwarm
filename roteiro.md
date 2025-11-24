
-Tracker (porta UDP 6969)

-Capturar com: tcpdump -i eth0 udp port 6969

Mostra anúncios e respostas de peers.

DHT (porta UDP 6881)

Capturar com: tcpdump -i eth0 udp port 6881

Mostra mensagens ping, find_node, get_peers, announce_peer.

- Peers/Leechers (porta TCP/UDP 51413)

Capturar com: tcpdump -i eth0 tcp port 51413

Mostra conexões diretas e troca de pedaços.


1- Suba os containers (tracker, peers, leechers).

2- Inicie o torrent público em todos os peers/leechers.

3- Abra tcpdump/wireshark em cada container:

4- No tracker → veja pacotes UDP 6969.

5- Nos peers → veja pacotes UDP 6881 (DHT) e TCP 51413 (P2P).

6- Derrube o tracker → os pacotes DHT continuam circulando.

7- Derrube um peer → os outros ainda trocam pedaços via DHT.


Tracker: central inicial de descoberta.

DHT: rede distribuída que mantém a lista de peers.

P2P: conexões diretas para troca de pedaços.



                ┌───────────────┐
                │   Tracker      │
                │ UDP 6969       │
                └───────▲───────┘
                        │
                        │ (Anúncios / respostas de peers)
                        │
 ┌───────────────┐       │       ┌───────────────┐
 │    Peer1       │◄─────┼─────►│    Peer2       │
 │ TCP/UDP 51413  │               │ TCP/UDP 51413 │
 │ UDP 6881 (DHT) │               │ UDP 6881 (DHT)│
 └───────▲────────┘               └───────▲───────┘
         │                                │
         │                                │
         │                                │
  ┌───────────────┐               ┌───────────────┐
│   Leecher1     │◄─────────────►│   Leecher2    │
 │ TCP/UDP 51413  │               │ TCP/UDP 51413 │
 │ UDP 6881 (DHT) │               │ UDP 6881 (DHT)│
 └───────▲────────┘               └───────▲───────┘
         │                                │
         │                                │
         └───────────────┐ ┌──────────────┘
                         ▼ ▼
                  ┌───────────────┐
                  │ Peer+Leecher  │
                  │ TCP/UDP 51413 │
                  │ UDP 6881 (DHT)│
                  └───────────────┘
