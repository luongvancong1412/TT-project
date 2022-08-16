<h1> Cài đặt Zimbra</h1>

<h2>Mục lục </h2>

- [Chuẩn bị](#chuẩn-bị)
- [Cài đặt phần mềm mã nguồn mở Zimbra](#cài-đặt-phần-mềm-mã-nguồn-mở-zimbra)
  - [https://www.zimbra.com/license/zimbra-public-eula-2-6.html](#httpswwwzimbracomlicensezimbra-public-eula-2-6html)


# Chuẩn bị

- Cài đặt các gói cần thiết:
```
yum update –y
sudo yum install bind-utils -y
sudo yum install epel-release -y
sudo yum install python-pip -y
yum -y install net-tools
```

- Đặt hostname
```
hostnamectl set-hostname "mail.proteccons.vn"
exec bash
```


- Thêm vào file hosts
```
# vi /etc/hosts file
192.168.10.128	 mail.proteccons.vn		mail   
```

# Cài đặt phần mềm mã nguồn mở Zimbra

- Cài đặt các phần mềm cần thiết:
```
yum install unzip net-tools sysstat openssh-clients perl-core libaio nmap-ncat libstdc++.so.6 wget –y
```

- Tải xuống bản mới nhất của zimbra:
```
mkdir zimbra && cd zimbra
wget https://files.zimbra.com/downloads/8.8.15_GA/zcs-8.8.15_GA_3869.RHEL7_64.20190918004220.tgz
```

- Giải nén file
```
tar zxpvf zcs-8.8.15_GA_3869.RHEL7_64.20190918004220.tgz
cd zcs-8.8.15_GA_3869.RHEL7_64.20190918004220/
```

- Chạy scripts cài đặt:
```
./install.sh
```

Quá trình chạy:
````
Operations logged to /tmp/install.log.c63RSW7C
Checking for existing installation...
    zimbra-drive...NOT FOUND
    zimbra-imapd...NOT FOUND
    zimbra-patch...NOT FOUND
    zimbra-mta-patch...NOT FOUND
    zimbra-proxy-patch...NOT FOUND
    zimbra-license-tools...NOT FOUND
    zimbra-license-extension...NOT FOUND
    zimbra-network-store...NOT FOUND
    zimbra-network-modules-ng...NOT FOUND
    zimbra-chat...NOT FOUND
    zimbra-talk...NOT FOUND
    zimbra-ldap...NOT FOUND
    zimbra-logger...NOT FOUND
    zimbra-mta...NOT FOUND
    zimbra-dnscache...NOT FOUND
    zimbra-snmp...NOT FOUND
    zimbra-store...NOT FOUND
    zimbra-apache...NOT FOUND
    zimbra-spell...NOT FOUND
    zimbra-convertd...NOT FOUND
    zimbra-memcached...NOT FOUND
    zimbra-proxy...NOT FOUND
    zimbra-archiving...NOT FOUND
    zimbra-core...NOT FOUND


----------------------------------------------------------------------
PLEASE READ THIS AGREEMENT CAREFULLY BEFORE USING THE SOFTWARE.
SYNACOR, INC. ("SYNACOR") WILL ONLY LICENSE THIS SOFTWARE TO YOU IF YOU
FIRST ACCEPT THE TERMS OF THIS AGREEMENT. BY DOWNLOADING OR INSTALLING
THE SOFTWARE, OR USING THE PRODUCT, YOU ARE CONSENTING TO BE BOUND BY
THIS AGREEMENT. IF YOU DO NOT AGREE TO ALL OF THE TERMS OF THIS
AGREEMENT, THEN DO NOT DOWNLOAD, INSTALL OR USE THE PRODUCT.

License Terms for this Zimbra Collaboration Suite Software:
https://www.zimbra.com/license/zimbra-public-eula-2-6.html
----------------------------------------------------------------------



Do you agree with the terms of the software license agreement? [N] Y

Use Zimbra's package repository [Y] y

Importing Zimbra GPG key

Configuring package repository

Checking for installable packages

Found zimbra-core (local)
Found zimbra-ldap (local)
Found zimbra-logger (local)
Found zimbra-mta (local)
Found zimbra-dnscache (local)
Found zimbra-snmp (local)
Found zimbra-store (local)
Found zimbra-apache (local)
Found zimbra-spell (local)
Found zimbra-memcached (repo)
Found zimbra-proxy (local)
Found zimbra-drive (repo)
Found zimbra-imapd (local)
Found zimbra-patch (repo)
Found zimbra-mta-patch (repo)
Found zimbra-proxy-patch (repo)


Select the packages to install

Install zimbra-ldap [Y] y

Install zimbra-logger [Y] y

Install zimbra-mta [Y] y

Install zimbra-dnscache [Y] y

Install zimbra-snmp [Y] y

Install zimbra-store [Y] y

Install zimbra-apache [Y] y

Install zimbra-spell [Y] y

Install zimbra-memcached [Y] y

Install zimbra-proxy [Y] y

Install zimbra-drive [Y] y

Install zimbra-imapd (BETA - for evaluation only) [N] y

Install zimbra-chat [Y] y
Checking required space for zimbra-core
Checking space for zimbra-store
Checking required packages for zimbra-store
zimbra-store package check complete.

Installing:
    zimbra-core
    zimbra-ldap
    zimbra-logger
    zimbra-mta
    zimbra-dnscache
    zimbra-snmp
    zimbra-store
    zimbra-apache
    zimbra-spell
    zimbra-memcached
    zimbra-proxy
    zimbra-drive
    zimbra-imapd
    zimbra-patch
    zimbra-mta-patch
    zimbra-proxy-patch
    zimbra-chat

The system will be modified.  Continue? [N] y
```

Sau khi cài đặt hoàn tất tiến hành mở port

```
firewall-cmd --permanent --add-port={25,80,110,143,443,465,587,993,995,5222,5223,9071,7071}/tcp
firewall-cmd –reload
```

