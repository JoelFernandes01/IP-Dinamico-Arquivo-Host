<h2>Procedimento para o IP da máquina ser atualizado dentro do arquivo /etc/hosts automaticamente </h2>

<p>Preciso constantemente editar o arquivo /etc/hosts para colocar o IP atual da máquina</p>
<p>Usei o mesmo procedimento no Script com instalação do Zabbix, e durante o script funciona perfeitamente, mas e quando não tem script ?</p>

<p>Desenvolvido e personalizado por Joel Fernandes</p>
<h2>Meus contatos :</h2>
<p>- Celular:  (61) 98468-1921</p>
<p>- Linkedin: https://www.linkedin.com/in/joel-fernandes-25838425/</p>
<p>- Facebook: https://www.facebook.com/JoelFernandesSilvaFilho/</p>
--------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------#
Vamos primeiramente criar um serviço para executar um scrip shell
#--------------------------------------------------------------------------------------------------------------------------#
vim /etc/systemd/system/ip.service
[Unit]
Description=Update IP
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash /etc/ip.sh

[Install]
WantedBy=multi-user.target
#--------------------------------------------------------------------------------------------------------------------------#
Agora vamos criar o script que irá gerar a variável do IP
#--------------------------------------------------------------------------------------------------------------------------#
vim /etc/ip.sh
inet_value=$(ifconfig | awk '/inet / && $1 !~ /lo/{gsub("addr:",""); print $2; exit}')
echo $inet_value

Vamos tornar o arquivo executável
chmod +x /etc/ip.sh

#--------------------------------------------------------------------------------------------------------------------------#
Vamos iniciar o serviço 
#--------------------------------------------------------------------------------------------------------------------------#
systemctl start ip.service

#--------------------------------------------------------------------------------------------------------------------------#
Vamos habilitar o serviço 
#--------------------------------------------------------------------------------------------------------------------------#
systemctl enable ip.service
Created symlink /etc/systemd/system/multi-user.target.wants/ip.service → /etc/systemd/system/ip.service.

#--------------------------------------------------------------------------------------------------------------------------#
Vamos edite o arquivo /etc/hosts
#--------------------------------------------------------------------------------------------------------------------------#
vim /etc/hosts
127.0.0.1 localhost
127.0.1.1 ubuntu

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

'$inet_value'   ubuntu

#--------------------------------------------------------------------------------------------------------------------------#
Verifique se o comando funcionou e pegou o IP atual do servidor
#--------------------------------------------------------------------------------------------------------------------------#
 systemctl status ip.service
○ ip.service - Update IP
     Loaded: loaded (/etc/systemd/system/ip.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Sat 2024-02-10 01:27:28 UTC; 4s ago
    Process: 2371 ExecStart=/bin/bash /etc/ip.sh (code=exited, status=0/SUCCESS)
   Main PID: 2371 (code=exited, status=0/SUCCESS)
        CPU: 29ms

Feb 10 01:27:28 ubuntu systemd[1]: Started Update IP.
Feb 10 01:27:28 ubuntu bash[2371]: 192.168.1.53
Feb 10 01:27:28 ubuntu systemd[1]: ip.service: Deactivated successfully.

<h4>Observação:</h4>
<p>Esse procedimento me ajudou, espero que te ajude também </p>

Se achar que possa nos ajudar em melhorá-lo, entre em contato e vamos melhorar .

Agradeço a quem puder colaborar .

