# Observacoes
 irei incluir o arquivo utilizado para exibir e configurar a rede, tambem esta incluso o html q utilizei para servir a pagina com as senhas dos container, para fins de teste, tambem estou deixando o arquivo de exemplo embora ele nao ira funcionar, pois se trata de um arquivo privado da minha maquina, apontando para o meu ip, sendo assim, recomento criar outro atraves de um programa adequado, seja qbit ou transmission

 tambem esta incluso o pdf com o material que compilamos para apresentar no dia 3/12, o mesmo esta com a data de hoje, pois quando criei o arquivo latex de base, havia definido que a data exibida era o dia atual, no momento da compilacao ele ira gerar com a data do dia, no caso 5/12.

## Pré-requisitos

- Docker instalado e funcionando
- Docker Compose instalado
- Permissões de sudo (para Linux)
- Portas 8080-8085 e 51412-51417 disponíveis

---

## Criar Estrutura de Diretórios

### No Linux:

```bash
# Criar diretórios para todas as instâncias
mkdir -p peer{1,2,3,4,5}/{config,downloads,watch}
mkdir -p seed/{config,downloads,watch}

# Definir permissões corretas
sudo chown -R 1000:1000 peer*
sudo chown -R 1000:1000 seed
sudo chmod -R 755 peer*
sudo chmod -R 755 seed
```

### No Windows (PowerShell):

```powershell
for ($i = 1; $i -le 5; $i++) {
    New-Item -ItemType Directory -Force -Path ".\peer$i\config"
    New-Item -ItemType Directory -Force -Path ".\peer$i\downloads"
    New-Item -ItemType Directory -Force -Path ".\peer$i\watch"
}

New-Item -ItemType Directory -Force -Path ".\seed\config"
New-Item -ItemType Directory -Force -Path ".\seed\downloads"
New-Item -ItemType Directory -Force -Path ".\seed\watch"
```

---

## Verificar o Docker Compose

Certifique-se de que o arquivo `docker-compose.yml` está na raiz do projeto com todas as 6 instâncias configuradas:
- 1 seed (porta 8080)
- 5 peers (portas 8081-8085)

Todas as instâncias estão configuradas com `network_mode: host` para acesso direto à rede.

*caso esteja utilizando docker desktop no windows ou mac, altere o network_mode para bridge, devido a limitacoes de implementacao, o docker desktop nao possui acesso para mapear portas dentro do windows, este eh um problema conhecido que pode ser contornado caso utilize docker dentro de uma maquina wsl ao inves do docker desktop

---

## Iniciar os Containers

### Iniciação básica:

```bash
# Subir todos os containers em background
docker-compose up -d

# Verificar status dos containers
docker-compose ps

# Ver logs em tempo real (opcional)
docker-compose logs -f
```

---

## Acessar as Instâncias

Aguarde 30-60 segundos para que os containers iniciem completamente.

### URLs de Acesso:

| Instância | URL | Porta |
|-----------|-----|-------|
| Seed | `http://0.0.0.0:8080/` | 8080 |
| Peer 1 | `http://0.0.0.0:8081/` | 8081 |
| Peer 2 | `http://0.0.0.0:8082/` | 8082 |
| Peer 3 | `http://0.0.0.0:8083/` | 8083 |
| Peer 4 | `http://0.0.0.0:8084/` | 8084 |
| Peer 5 | `http://0.0.0.0:8085/` | 8085 |

Se estiver acessando de outro equipamento, substitua `0.0.0.0` pelo IP da máquina.

---

## Autenticação

As credenciais padrão para acesso à Web UI são:
- **Usuário:** admin
- **Senha:** (gerada aleatoriamente ao iniciar o container, verifique o log para capturar a senha do painel)


---
## Verificação Final

Para confirmar que tudo está funcionando:

```bash
# 1. Todos containers rodando
docker-compose ps

# 2. Portas abertas
netstat -an | grep LISTEN | grep 808
netstat -an | grep LISTEN | grep 5141

# 3. Acessar Web UI
curl http://0.0.0.0:8080

# em windows ou mac como o docker desktop faz o papel de maquina virtual, ele apenas aponta para o localhost,
# em linux 0.0.0.0 normalmente ira funcionar, enquanto que no widows/mac o recomendado e utilizar localhost.

# 4. Ver logs sem erros
docker-compose logs | grep -i error
```
