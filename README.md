<h2>Procedimento para o IP da máquina ser atualizado dentro do arquivo /etc/hosts automaticamente </h2>

<p>Preciso constantemente editar o arquivo /etc/hosts para colocar o IP atual da máquina</p>
<p>Usei o mesmo procedimento no Script com instalação do Zabbix, e durante o script funciona perfeitamente, mas e quando não tem script ?</p>

<h2>Meus contatos :</h2>
<p>- Celular:  (61) 98468-1921</p>
<p>- Linkedin: https://www.linkedin.com/in/joel-fernandes-25838425/</p>
<p>- Facebook: https://www.facebook.com/JoelFernandesSilvaFilho/</p>

Vamos primeiramente criar um serviço para executar um script shell
<b><p>#vim /etc/systemd/system/ip.service</p></b>
<p>[Unit]</p>
<p>Description=Update IP</p>
<p>After=network.target</p>

<p>[Service]</p>
<p>Type=simple</p>
<p>ExecStart=/bin/bash /etc/ip.sh</p>

<p>[Install]</p>
<p>WantedBy=multi-user.target</p>

Agora vamos criar o script que irá gerar a variável do IP
<b><p>#vim /etc/ip.sh</p></b>
<p>inet_value=$(ifconfig | awk '/inet / && $1 !~ /lo/{gsub("addr:",""); print $2; exit}')</p>
<p>echo $inet_value</p>

<p>Vamos tornar o arquivo executável</p>
<b><p>#chmod +x /etc/ip.sh</p></b>

Vamos iniciar o serviço
<b><p>#systemctl start ip.service</p></b>

Vamos habilitar o serviço 
<b><p>#systemctl enable ip.service</p></b>
<p>Created symlink /etc/systemd/system/multi-user.target.wants/ip.service → /etc/systemd/system/ip.service.</p>

Vamos editar o arquivo /etc/hosts
<b><p>#vim /etc/hosts</p></b>
<p>127.0.0.1 localhost</p>
<p>127.0.1.1 ubuntu</p>

<p># The following lines are desirable for IPv6 capable hosts</p>
<p>::1     ip6-localhost ip6-loopback</p>
<p>fe00::0 ip6-localnet</p>
<p>ff00::0 ip6-mcastprefix</p>
<p>ff02::1 ip6-allnodes</p>
<p>ff02::2 ip6-allrouters</p>

<p><b>'$inet_value'</b>   ubuntu  <b><-------- linha adicionada com a variável</b></p>

Verifique se o comando funcionou e pegou o IP atual do servidor
<b><p>#systemctl status ip.service</p></b>
<p>○ ip.service - Update IP</p>
<p>     Loaded: loaded (/etc/systemd/system/ip.service; enabled; vendor preset: enabled)</p>
<p>     Active: inactive (dead) since Sat 2024-02-10 01:27:28 UTC; 4s ago</p>
<p>    Process: 2371 ExecStart=/bin/bash /etc/ip.sh (code=exited, status=0/SUCCESS)</p>
<p>   Main PID: 2371 (code=exited, status=0/SUCCESS)</p>
<p>        CPU: 29ms</p>

<p>Feb 10 01:27:28 ubuntu systemd[1]: Started Update IP.</p>
<p>Feb 10 01:27:28 ubuntu bash[2371]: <b><i>192.168.1.53</i></b>  <b><-------- Olha o IP da máquina</b></p>
<p>Feb 10 01:27:28 ubuntu systemd[1]: ip.service: Deactivated successfully.</p>

<h4>Observação:</h4>
<p>Esse procedimento me ajudou, espero que te ajude também </p>

Se achar que possa nos ajudar em melhorá-lo, entre em contato e vamos melhorar .

Agradeço a quem puder colaborar .

