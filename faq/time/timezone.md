# Get and set timezone information

Use the ```timedatectl``` command to query or change system time and date settings.

```
timedatectl [OPTIONS...] COMMAND ...

Query or change system time and date settings.

  -h --help                Show this help message
     --version             Show package version
     --no-pager            Do not pipe output into a pager
     --no-ask-password     Do not prompt for password
  -H --host=[USER@]HOST    Operate on remote host
  -M --machine=CONTAINER   Operate on local container
     --adjust-system-clock Adjust system clock when changing local RTC mode

Commands:
  status                   Show current time settings
  set-time TIME            Set system time
  set-timezone ZONE        Set system time zone
  list-timezones           Show known time zones
  set-local-rtc BOOL       Control whether RTC is in local time
  set-ntp BOOL             Control whether NTP is enabled

```

## Get current time settings
```
$ timedatectl status

      Local time: Sat 2020-04-25 10:47:35 CST
  Universal time: Sat 2020-04-25 02:47:35 UTC
        RTC time: Sat 2020-04-25 14:47:20
       Time zone: Asia/Shanghai (CST, +0800)
     NTP enabled: n/a
NTP synchronized: no
 RTC in local TZ: no
      DST active: n/a
```

## Set current time

Use the set-time to set current time

```shell
timedatectl set-time "yyyy-MM-dd HH:mm:ss"
```

```
timedatectl set-time "2020-04-25 23:13:14"
timedatectl status

      Local time: Sat 2020-04-25 23:13:14 CST
  Universal time: Sat 2020-04-25 15:13:14 UTC
        RTC time: Sat 2020-04-25 15:13:15
       Time zone: Asia/Shanghai (CST, +0800)
     NTP enabled: n/a
NTP synchronized: no
 RTC in local TZ: no
      DST active: n/a
```
![set-time screenshot](/screenshot/time/Set%20current%20datetime.png?raw=true)
