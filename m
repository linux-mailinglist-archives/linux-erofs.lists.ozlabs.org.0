Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B1214C51F
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jan 2020 05:14:12 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 486qqj5kZSzDqNb
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jan 2020 15:14:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::135;
 helo=mail-lf1-x135.google.com; envelope-from=saumya.iisc@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=k7uWLFL1; dkim-atps=neutral
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 486qqS0wWJzDqNF
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jan 2020 15:13:53 +1100 (AEDT)
Received: by mail-lf1-x135.google.com with SMTP id f24so10845276lfh.3
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jan 2020 20:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Kp+nCUsrBeXako4IYT77fj5zG8NT4OMwbwQTXyOHGD0=;
 b=k7uWLFL1OSwi7pbwN3CkeHrCUxgPIr1HsMu8eYuS2Hyy1lxXpnGGhucOiZXYNK8B7k
 9xeL4cAbBsDd+3M7DyQeUdsr3izLBK5Tuu6GOViY+xrI0AQfXWGArWodIqg5oO9M86Fn
 fYF8KYlNarDALx4VhmW113wvSQlXR/sDMT44sdK3BvB658I+y0zIuWR7IeCvLDZcOwsH
 XCtNA9U/o2uOKlPx2VN/TbAtKBQh3ZeAWTzCXl2qSJpFvGyVRh2Y4lnl8k1I0r73VWsp
 N9Ol9CWzxYpa38k8yLRvzf0sTCyLWudjWvDd4Md03eJMi5Pt+Ty0gyPPlZHLsfr8dVQ5
 7slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kp+nCUsrBeXako4IYT77fj5zG8NT4OMwbwQTXyOHGD0=;
 b=FP2ujZkzQgvuZLziHv6lG+xkWLdjGHsw/xEKSUILhbZOGyC3JLBf/VEKGXknct4bmW
 KLPydtFPiK8ec3V2INwkPPeeM7kHyLMSO1dFTVpW4NuCi8yY2qzqTTlJ02aRvoXvtqce
 2sR2xptcCFIlKmBTjl1Lomi58PCS6oLfFQKfgYKSGIbQ6dMVPw4I9IdFEaCxqRfZCZi4
 6TyQLzDrhzWUS3J3ydVQV2iwZ5E0njHd8FWPI3794s19mVUDXsyJVjbuPq46W/Fofzd/
 bBCxUEjk2JeJjROxtNvyZ4JoE/ngbMFiOCcxA74K/oqL01XD4mVANi97P4UrO9ndxecX
 20kA==
X-Gm-Message-State: APjAAAVzv+fXKoh9W1ZA6vxilYKzY8xwwTzoxUxZJ/yRfLn+X9KuZgDJ
 HFHzQcFa474aZCyD8/Vh8g170XD0R4weY85jWh8=
X-Google-Smtp-Source: APXvYqxi7ynYTUnFEJFYiCFo/2+0JGT3AVjYpAOfcAMTb0al/Exq9eNE99c7t9nWyPuDPK+4k9LyxQdfc/jdpLzx4t8=
X-Received: by 2002:ac2:5964:: with SMTP id h4mr2561907lfp.213.1580271228287; 
 Tue, 28 Jan 2020 20:13:48 -0800 (PST)
MIME-Version: 1.0
References: <CAHmfoRm7xUwuXfTZ2kr-x9fs59x7b707t183ggbLEtEyO_wznA@mail.gmail.com>
 <20200120073859.GA32421@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHmfoRn+YjEwxmZLTeDVN9Oja=7QTi14oEtpD5x7URT_X9dJ5w@mail.gmail.com>
 <20200122043655.GB6542@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20200122043655.GB6542@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Saumya Panda <saumya.iisc@gmail.com>
Date: Wed, 29 Jan 2020 09:43:37 +0530
Message-ID: <CAHmfoRmXxEXqxJwakbQZmMz62_7DNai3KVzGu=U_yNEgYQvG=w@mail.gmail.com>
Subject: Re: Problem in EROFS: Not able to read the files after mount
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="0000000000003607ba059d3f913d"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000003607ba059d3f913d
Content-Type: text/plain; charset="UTF-8"

Hi Gao,
  How you got the read amplification? I ran FIO on enwik9 (both Erofs and
SquashFs) and got the below output. Is there anyway to calculate the read
amplification from the below logs.

     Here filename (/mnt/enwik9_erofs/enwik9, /mnt/enwiki_sqfs/enwik9)
points to the mounted readonly file system(squasfs, erofs). But if I give
directory as a parameter instead of filename I am getting error(see the
logs at the end).

*FIO on Erofs:*

localhost:~> fio --name=randread --ioengine=libaio --iodepth=16
--rw=randread --bs=4k --direct=0 --size=512M --numjobs=4 --runtime=240
--group_reporting --filename=/mnt/enwik9_erofs/enwik9

randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
4096B-4096B, ioengine=libaio, iodepth=16

...

fio-3.17-90-gd9b7

Starting 4 processes

Jobs: 4 (f=4): [r(4)][100.0%][r=381MiB/s][r=97.6k IOPS][eta 00m:00s]

randread: (groupid=0, jobs=4): err= 0: pid=34282: Mon Jan 27 01:04:55 2020

  read: IOPS=36.7k, BW=144MiB/s (150MB/s)(2048MiB/14271msec)

    slat (nsec): min=1305, max=135688k, avg=106650.48, stdev=493480.73

    clat (nsec): min=1970, max=136593k, avg=1629459.90, stdev=2639786.83

     lat (usec): min=3, max=136625, avg=1736.29, stdev=2772.32

    clat percentiles (usec):

     |  1.00th=[    48],  5.00th=[    69], 10.00th=[   251], 20.00th=[
437],

     | 30.00th=[   570], 40.00th=[   701], 50.00th=[   848], 60.00th=[
1029],

     | 70.00th=[  1336], 80.00th=[  2147], 90.00th=[  4015], 95.00th=[
5932],

     | 99.00th=[ 11600], 99.50th=[ 13304], 99.90th=[ 17171], 99.95th=[
20579],

     | 99.99th=[135267]

   bw (  KiB/s): min=16510, max=295435, per=76.91%, avg=113025.79,
stdev=23830.42, samples=112

   iops        : min= 4126, max=73857, avg=28254.82, stdev=5957.62,
samples=112

  lat (usec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=1.37%

  lat (usec)   : 100=5.45%, 250=3.15%, 500=14.74%, 750=18.99%, 1000=14.99%

  lat (msec)   : 2=20.14%, 4=11.09%, 10=8.42%, 20=1.62%, 50=0.04%

  lat (msec)   : 250=0.01%

  cpu          : usr=1.87%, sys=8.28%, ctx=144023, majf=1, minf=114

  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%,
>=64=0.0%

     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>=64=0.0%

     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%,
>=64=0.0%

     issued rwts: total=524288,0,0,0 short=0,0,0,0 dropped=0,0,0,0

     latency   : target=0, window=0, percentile=100.00%, depth=16



Run status group 0 (all jobs):

   READ: bw=144MiB/s (150MB/s), 144MiB/s-144MiB/s (150MB/s-150MB/s),
io=2048MiB (2147MB), run=14271-14271msec



Disk stats (read/write):

  loop0: ios=137357/0, merge=0/0, ticks=23020/0, in_queue=460, util=97.70%


*FIO on SquashFs:*


localhost:~/Downloads/erofs-utils> fio --name=randread --ioengine=libaio
--iodepth=16 --rw=randread --bs=4k --direct=0 --size=512M --numjobs=4
--runtime=240 --group_reporting --filename=/mnt/enwik9_sqsh/enwik9

randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
4096B-4096B, ioengine=libaio, iodepth=16

...

fio-3.17-90-gd9b7

Starting 4 processes

Jobs: 4 (f=4): [r(4)][66.7%][r=1175MiB/s][r=301k IOPS][eta 00m:05s]

randread: (groupid=0, jobs=4): err= 0: pid=34389: Mon Jan 27 01:07:56 2020

  read: IOPS=55.4k, BW=216MiB/s (227MB/s)(2048MiB/9467msec)

    slat (nsec): min=1194, max=61065k, avg=67581.76, stdev=754174.73

    clat (usec): min=2, max=222014, avg=1075.25, stdev=5969.94

     lat (usec): min=3, max=235437, avg=1143.13, stdev=6341.32

    clat percentiles (usec):

     |  1.00th=[    39],  5.00th=[    40], 10.00th=[    40], 20.00th=[
41],

     | 30.00th=[    42], 40.00th=[    43], 50.00th=[    43], 60.00th=[
44],

     | 70.00th=[    45], 80.00th=[    48], 90.00th=[    63], 95.00th=[
3163],

     | 99.00th=[ 28443], 99.50th=[ 41157], 99.90th=[ 78119], 99.95th=[
89654],

     | 99.99th=[125305]

   bw (  KiB/s): min= 1985, max=991826, per=63.49%, avg=140649.83,
stdev=78204.76, samples=72

   iops        : min=  495, max=247955, avg=35161.00, stdev=19551.19,
samples=72

  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=84.82%, 100=8.18%

  lat (usec)   : 250=0.37%, 500=0.09%, 750=0.24%, 1000=0.54%

  lat (msec)   : 2=0.43%, 4=0.46%, 10=1.29%, 20=1.93%, 50=1.30%

  lat (msec)   : 100=0.33%, 250=0.02%

  cpu          : usr=1.76%, sys=16.29%, ctx=14519, majf=0, minf=104

  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%,
>=64=0.0%

     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>=64=0.0%

     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%,
>=64=0.0%

     issued rwts: total=524288,0,0,0 short=0,0,0,0 dropped=0,0,0,0

     latency   : target=0, window=0, percentile=100.00%, depth=16



Run status group 0 (all jobs):

   READ: bw=216MiB/s (227MB/s), 216MiB/s-216MiB/s (227MB/s-227MB/s),
io=2048MiB (2147MB), run=9467-9467msec



Disk stats (read/write):

  loop1: ios=177240/0, merge=0/0, ticks=199386/0, in_queue=75984,
util=73.95%



 Fio Test on SquashFs dir:


localhost:~/Downloads/erofs-utils> fio --name=randread --ioengine=libaio
--iodepth=16 --rw=randread --bs=4k --direct=0 --size=512M --numjobs=4
--runtime=240 --group_reporting --directory=/mnt/enwik9_sqsh/
randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
4096B-4096B, ioengine=libaio, iodepth=16
...
fio-3.17-90-gd9b7
Starting 4 processes
randread: Laying out IO file (1 file / 512MiB)
fio: pid=0, err=30/file:filesetup.c:150, func=unlink, error=Read-only file
system
randread: Laying out IO file (1 file / 512MiB)
fio: pid=0, err=30/file:filesetup.c:150, func=unlink, error=Read-only file
system
randread: Laying out IO file (1 file / 512MiB)
fio: pid=0, err=30/file:filesetup.c:150, func=unlink, error=Read-only file
system
randread: Laying out IO file (1 file / 512MiB)
fio: pid=0, err=30/file:filesetup.c:150, func=unlink, error=Read-only file
system


Run status group 0 (all jobs):


On Wed, Jan 22, 2020 at 10:07 AM Gao Xiang <hsiangkao@aol.com> wrote:

> On Wed, Jan 22, 2020 at 09:27:45AM +0530, Saumya Panda wrote:
> > Hi Gao,
> >   Thanks for the info. After I enabled the said configuration, I am now
> > able to read the files after mount. But I am seeing Squashfs has better
> > compression ratio compared to Erofs (more than 60% than that of Erofs).
> Am
> > I missing something? I used lz4hc while making the Erofs image.
> >
> > ls -l enwik*
> > -rw-r--r-- 1 saumya users  61280256 Jan 21 03:22 enwik8.erofs.img
> > -rw-r--r-- 1 saumya users  37355520 Jan 21 03:34 enwik8.sqsh
> > -rw-r--r-- 1 saumya users 558133248 Jan 21 03:25 enwik9.erofs.img
> > -rw-r--r-- 1 saumya users 331481088 Jan 21 03:35 enwik9.sqsh
>
> Yes, it's working as expect. Currently EROFS is compressed in 4k
> fixed-sized output compression granularity as mentioned in many
> available materials. That is the use case for our smartphones.
> You should compare with similar block configuration of squashfs.
> and there are some 3rd data by other folks as well [1].
>
> In the future, we will support other compression algorithms and
> larger compressed size (> 4k).
>
> [1] In chinese,
>     https://blog.csdn.net/scnutiger/article/details/102507596
>
> Thanks,
> Gao Xiang
>
>

-- 
Thanks,
Saumya Prakash Panda

--0000000000003607ba059d3f913d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Gao,</div><div>=C2=A0 How you got the read amplifi=
cation? I ran FIO on enwik9 (both Erofs and SquashFs) and got the below out=
put. Is there anyway to calculate the read amplification from the below log=
s. <br></div><div><br></div><div>=C2=A0=C2=A0=C2=A0=C2=A0 Here filename (/m=
nt/enwik9_erofs/enwik9, /mnt/enwiki_sqfs/enwik9) points to the mounted read=
only file system(squasfs, erofs). But if I give directory as a parameter in=
stead of filename I am getting error(see the logs at the end). <br></div><d=
iv><b><span style=3D"color:rgb(255,0,0)"><br></span></b></div><div><b><span=
 style=3D"color:rgb(255,0,0)">FIO on Erofs:</span></b></div><div><br></div>=
<div><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt=
;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-var=
iant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;tex=
t-decoration:none"><span>localhost:~&gt; fio --name=3Drandread --ioengine=
=3Dlibaio --iodepth=3D16 --rw=3Drandread --bs=3D4k --direct=3D0 --size=3D51=
2M --numjobs=3D4 --runtime=3D240 --group_reporting --<span style=3D"color:r=
gb(255,153,0)">filename</span>=3D/mnt/enwik9_erofs/enwik9=C2=A0=C2=A0=C2=A0=
=C2=A0<span></span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0c=
m 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);f=
ont-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;text-decoration:none"><span>randread: (g=3D0): rw=3Dr=
andread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=
=3Dlibaio, iodepth=3D16<span></span></span></p><p class=3D"MsoNormal" style=
=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:norm=
al;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;text-decoration:none"><span>...<span=
></span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;=
font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:n=
ormal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;text-decoration:none"><span>fio-3.17-90-gd9b7<span></span></span=
></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt=
;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-var=
iant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;tex=
t-decoration:none"><span>Starting 4 processes<span></span></span></p><p cla=
ss=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-famil=
y:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:n=
ormal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoratio=
n:none"><span>Jobs: 4 (f=3D4): [r(4)][100.0%][r=3D381MiB/s][r=3D97.6k IOPS]=
[eta 00m:00s]<span></span></span></p><p class=3D"MsoNormal" style=3D"margin=
:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0=
,0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;text-decoration:none"><span>randread: (groupid=
=3D0, jobs=3D4): err=3D 0: pid=3D34282: Mon Jan 27 01:04:55 2020<span></spa=
n></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-s=
ize:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;=
font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-alig=
n:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing=
:0px;text-decoration:none"><span>=C2=A0 read: IOPS=3D36.7k, BW=3D144MiB/s (=
150MB/s)(2048MiB/14271msec)<span></span></span></p><p class=3D"MsoNormal" s=
tyle=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-ser=
if;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:=
normal;letter-spacing:normal;text-align:start;text-indent:0px;text-transfor=
m:none;white-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=
=A0=C2=A0=C2=A0 slat (nsec): min=3D1305, max=3D135688k, avg=3D106650.48, st=
dev=3D493480.73<span></span></span></p><p class=3D"MsoNormal" style=3D"marg=
in:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb=
(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0=C2=A0=C2=
=A0 clat (nsec): min=3D1970, max=3D136593k, avg=3D1629459.90, stdev=3D26397=
86.83<span></span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm=
 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);fo=
nt-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:=
normal;text-align:start;text-indent:0px;text-transform:none;white-space:nor=
mal;word-spacing:0px;text-decoration:none"><span>=C2=A0=C2=A0=C2=A0=C2=A0 l=
at (usec): min=3D3, max=3D136625, avg=3D1736.29, stdev=3D2772.32<span></spa=
n></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-s=
ize:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;=
font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-alig=
n:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing=
:0px;text-decoration:none"><span>=C2=A0=C2=A0=C2=A0 clat percentiles (usec)=
:<span></span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0=
001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-s=
tyle:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;text-decoration:none"><span>=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1.00th=3D[=C2=A0=C2=A0=C2=A0 48],=C2=A0 5.00th=3D[=C2=A0=C2=A0=C2=A0 69=
], 10.00th=3D[=C2=A0=C2=A0 251], 20.00th=3D[=C2=A0=C2=A0 437],<span></span>=
</span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-siz=
e:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;fo=
nt-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;text-decoration:none"><span>=C2=A0=C2=A0=C2=A0=C2=A0 | 30.00th=3D[=C2=A0=
=C2=A0 570], 40.00th=3D[=C2=A0=C2=A0 701], 50.00th=3D[=C2=A0=C2=A0 848], 60=
.00th=3D[=C2=A0 1029],<span></span></span></p><p class=3D"MsoNormal" style=
=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:norm=
al;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0=
=C2=A0=C2=A0=C2=A0 | 70.00th=3D[=C2=A0 1336], 80.00th=3D[=C2=A0 2147], 90.0=
0th=3D[=C2=A0 4015], 95.00th=3D[=C2=A0 5932],<span></span></span></p><p cla=
ss=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-famil=
y:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:n=
ormal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoratio=
n:none"><span>=C2=A0=C2=A0=C2=A0=C2=A0 | 99.00th=3D[ 11600], 99.50th=3D[ 13=
304], 99.90th=3D[ 17171], 99.95th=3D[ 20579],<span></span></span></p><p cla=
ss=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-famil=
y:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:n=
ormal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoratio=
n:none"><span>=C2=A0=C2=A0=C2=A0=C2=A0 | 99.99th=3D[135267]<span></span></s=
pan></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:1=
1pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-=
variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
text-decoration:none"><span>=C2=A0=C2=A0 bw (=C2=A0 KiB/s): min=3D16510, ma=
x=3D295435, per=3D76.91%, avg=3D113025.79, stdev=3D23830.42, samples=3D112<=
span></span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.000=
1pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-sty=
le:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal=
;text-align:start;text-indent:0px;text-transform:none;white-space:normal;wo=
rd-spacing:0px;text-decoration:none"><span>=C2=A0=C2=A0 iops=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 : min=3D 4126, max=3D73857, avg=3D28254.82, std=
ev=3D5957.62, samples=3D112<span></span></span></p><p class=3D"MsoNormal" s=
tyle=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-ser=
if;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:=
normal;letter-spacing:normal;text-align:start;text-indent:0px;text-transfor=
m:none;white-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=
=A0 lat (usec)=C2=A0=C2=A0 : 2=3D0.01%, 4=3D0.01%, 10=3D0.01%, 20=3D0.01%, =
50=3D1.37%<span></span></span></p><p class=3D"MsoNormal" style=3D"margin:0c=
m 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,=
0);font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;white-spac=
e:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0 lat (usec)=C2=
=A0=C2=A0 : 100=3D5.45%, 250=3D3.15%, 500=3D14.74%, 750=3D18.99%, 1000=3D14=
.99%<span></span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm =
0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);fon=
t-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;white-space:norm=
al;word-spacing:0px;text-decoration:none"><span>=C2=A0 lat (msec)=C2=A0=C2=
=A0 : 2=3D20.14%, 4=3D11.09%, 10=3D8.42%, 20=3D1.62%, 50=3D0.04%<span></spa=
n></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-s=
ize:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;=
font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-alig=
n:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing=
:0px;text-decoration:none"><span>=C2=A0 lat (msec)=C2=A0=C2=A0 : 250=3D0.01=
%<span></span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0=
001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-s=
tyle:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;text-decoration:none"><span>=C2=A0 cpu=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : usr=3D1.87%, sys=3D8.28%, ctx=3D1440=
23, majf=3D1, minf=3D114<span></span></span></p><p class=3D"MsoNormal" styl=
e=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;=
color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:nor=
mal;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0 =
IO depths=C2=A0=C2=A0=C2=A0 : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D=
100.0%, 32=3D0.0%, &gt;=3D64=3D0.0%<span></span></span></p><p class=3D"MsoN=
ormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,=
sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font=
-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;text-decoration:none"><s=
pan>=C2=A0=C2=A0=C2=A0=C2=A0 submit=C2=A0=C2=A0=C2=A0 : 0=3D0.0%, 4=3D100.0=
%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<span></span>=
</span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-siz=
e:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;fo=
nt-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;text-decoration:none"><span>=C2=A0=C2=A0=C2=A0=C2=A0 complete=C2=A0 : 0=
=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.1%, 32=3D0.0%, 64=3D0.0%, &gt;=3D64=
=3D0.0%<span></span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0=
cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);=
font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;text-decoration:none"><span>=C2=A0=C2=A0=C2=A0=C2=A0=
 issued rwts: total=3D524288,0,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0<span><=
/span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;fo=
nt-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:nor=
mal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:0px;text-decoration:none"><span>=C2=A0=C2=A0=C2=A0=C2=A0 latency=C2=A0=
=C2=A0 : target=3D0, window=3D0, percentile=3D100.00%, depth=3D16<span></sp=
an></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-=
size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal=
;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;text-decoration:none"><span><span>=C2=A0</span></span></p><p class=3D=
"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Cal=
ibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal=
;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;text-decoration:non=
e"><span>Run status group 0 (all jobs):<span></span></span></p><p class=3D"=
MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;=
font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;text-decoration:none=
"><span>=C2=A0=C2=A0 READ: bw=3D144MiB/s (150MB/s), 144MiB/s-144MiB/s (150M=
B/s-150MB/s), io=3D2048MiB (2147MB), run=3D14271-14271msec<span></span></sp=
an></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11=
pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-v=
ariant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:star=
t;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;t=
ext-decoration:none"><span><span>=C2=A0</span></span></p><p class=3D"MsoNor=
mal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-w=
eight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;white-space:normal;word-spacing:0px;text-decoration:none"><spa=
n>Disk stats (read/write):<span></span></span></p><p class=3D"MsoNormal" st=
yle=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-seri=
f;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:n=
ormal;letter-spacing:normal;text-align:start;text-indent:0px;text-transform=
:none;white-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=
=A0 loop0: ios=3D137357/0, merge=3D0/0, ticks=3D23020/0, in_queue=3D460, ut=
il=3D97.70%</span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001=
pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-styl=
e:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;text-decoration:none"><br></p><p class=3D"MsoNormal" style=3D=
"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;font=
-style:normal;font-variant-caps:normal;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px"=
><span style=3D"color:rgb(255,0,0)"><b>FIO on SquashFs:</b></span></p><p cl=
ass=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-fami=
ly:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:=
normal;font-weight:normal;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decorati=
on:none"><br></p><span><span></span></span><p class=3D"MsoNormal" style=3D"=
margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color=
:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;text-decoration:none"><span>localhost:~/=
Downloads/erofs-utils&gt; fio --name=3Drandread --ioengine=3Dlibaio --iodep=
th=3D16 --rw=3Drandread --bs=3D4k --direct=3D0 --size=3D512M --numjobs=3D4 =
--runtime=3D240 --group_reporting --<span style=3D"color:rgb(255,153,0)">fi=
lename</span>=3D/mnt/enwik9_sqsh/enwik9<span></span></span></p><p class=3D"=
MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;=
font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;text-decoration:none=
"><span>randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4=
096B, (T) 4096B-4096B, ioengine=3Dlibaio, iodepth=3D16<span></span></span><=
/p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;f=
ont-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-varia=
nt-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none"><span>...<span></span></span></p><p class=3D"MsoNormal" st=
yle=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-seri=
f;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:n=
ormal;letter-spacing:normal;text-align:start;text-indent:0px;text-transform=
:none;white-space:normal;word-spacing:0px;text-decoration:none"><span>fio-3=
.17-90-gd9b7<span></span></span></p><p class=3D"MsoNormal" style=3D"margin:=
0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,=
0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;text-decoration:none"><span>Starting 4 processe=
s<span></span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0=
001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-s=
tyle:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;text-decoration:none"><span>Jobs: 4 (f=3D4): [r(4)][66.7%]=
[r=3D1175MiB/s][r=3D301k IOPS][eta 00m:05s]<span></span></span></p><p class=
=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:=
Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:nor=
mal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0=
px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:=
none"><span>randread: (groupid=3D0, jobs=3D4): err=3D 0: pid=3D34389: Mon J=
an 27 01:07:56 2020<span></span></span></p><p class=3D"MsoNormal" style=3D"=
margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color=
:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0 read:=
 IOPS=3D55.4k, BW=3D216MiB/s (227MB/s)(2048MiB/9467msec)<span></span></span=
></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt=
;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-var=
iant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;tex=
t-decoration:none"><span>=C2=A0=C2=A0=C2=A0 slat (nsec): min=3D1194, max=3D=
61065k, avg=3D67581.76, stdev=3D754174.73<span></span></span></p><p class=
=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:=
Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:nor=
mal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0=
px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:=
none"><span>=C2=A0=C2=A0=C2=A0 clat (usec): min=3D2, max=3D222014, avg=3D10=
75.25, stdev=3D5969.94<span></span></span></p><p class=3D"MsoNormal" style=
=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:norm=
al;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0=
=C2=A0=C2=A0=C2=A0 lat (usec): min=3D3, max=3D235437, avg=3D1143.13, stdev=
=3D6341.32<span></span></span></p><p class=3D"MsoNormal" style=3D"margin:0c=
m 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,=
0);font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;white-spac=
e:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0=C2=A0=C2=A0 cl=
at percentiles (usec):<span></span></span></p><p class=3D"MsoNormal" style=
=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:norm=
al;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1.00th=3D[=C2=A0=C2=A0=C2=A0 39],=C2=A0 5.00th=
=3D[=C2=A0=C2=A0=C2=A0 40], 10.00th=3D[=C2=A0=C2=A0=C2=A0 40], 20.00th=3D[=
=C2=A0=C2=A0=C2=A0 41],<span></span></span></p><p class=3D"MsoNormal" style=
=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:norm=
al;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0=
=C2=A0=C2=A0=C2=A0 | 30.00th=3D[=C2=A0=C2=A0=C2=A0 42], 40.00th=3D[=C2=A0=
=C2=A0=C2=A0 43], 50.00th=3D[=C2=A0=C2=A0=C2=A0 43], 60.00th=3D[=C2=A0=C2=
=A0=C2=A0 44],<span></span></span></p><p class=3D"MsoNormal" style=3D"margi=
n:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(=
0,0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0=C2=A0=C2=
=A0=C2=A0 | 70.00th=3D[=C2=A0=C2=A0=C2=A0 45], 80.00th=3D[=C2=A0=C2=A0=C2=
=A0 48], 90.00th=3D[=C2=A0=C2=A0=C2=A0 63], 95.00th=3D[=C2=A0 3163],<span><=
/span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;fo=
nt-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:nor=
mal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:0px;text-decoration:none"><span>=C2=A0=C2=A0=C2=A0=C2=A0 | 99.00th=3D[=
 28443], 99.50th=3D[ 41157], 99.90th=3D[ 78119], 99.95th=3D[ 89654],<span><=
/span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;fo=
nt-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:nor=
mal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:0px;text-decoration:none"><span>=C2=A0=C2=A0=C2=A0=C2=A0 | 99.99th=3D[=
125305]<span></span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0=
cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);=
font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;text-decoration:none"><span>=C2=A0=C2=A0 bw (=C2=A0 =
KiB/s): min=3D 1985, max=3D991826, per=3D63.49%, avg=3D140649.83, stdev=3D7=
8204.76, samples=3D72<span></span></span></p><p class=3D"MsoNormal" style=
=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:norm=
al;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0=
=C2=A0 iops=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : min=3D=C2=A0 495, m=
ax=3D247955, avg=3D35161.00, stdev=3D19551.19, samples=3D72<span></span></s=
pan></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:1=
1pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-=
variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
text-decoration:none"><span>=C2=A0 lat (usec)=C2=A0=C2=A0 : 4=3D0.01%, 10=
=3D0.01%, 20=3D0.01%, 50=3D84.82%, 100=3D8.18%<span></span></span></p><p cl=
ass=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-fami=
ly:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:=
normal;font-weight:normal;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decorati=
on:none"><span>=C2=A0 lat (usec)=C2=A0=C2=A0 : 250=3D0.37%, 500=3D0.09%, 75=
0=3D0.24%, 1000=3D0.54%<span></span></span></p><p class=3D"MsoNormal" style=
=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:norm=
al;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0 l=
at (msec)=C2=A0=C2=A0 : 2=3D0.43%, 4=3D0.46%, 10=3D1.29%, 20=3D1.93%, 50=3D=
1.30%<span></span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm=
 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);fo=
nt-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:=
normal;text-align:start;text-indent:0px;text-transform:none;white-space:nor=
mal;word-spacing:0px;text-decoration:none"><span>=C2=A0 lat (msec)=C2=A0=C2=
=A0 : 100=3D0.33%, 250=3D0.02%<span></span></span></p><p class=3D"MsoNormal=
" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-=
serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weig=
ht:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;text-decoration:none"><span>=
=C2=A0 cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : usr=3D1.=
76%, sys=3D16.29%, ctx=3D14519, majf=3D0, minf=3D104<span></span></span></p=
><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;fon=
t-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant=
-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-de=
coration:none"><span>=C2=A0 IO depths=C2=A0=C2=A0=C2=A0 : 1=3D0.1%, 2=3D0.1=
%, 4=3D0.1%, 8=3D0.1%, 16=3D100.0%, 32=3D0.0%, &gt;=3D64=3D0.0%<span></span=
></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-si=
ze:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;f=
ont-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align=
:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:=
0px;text-decoration:none"><span>=C2=A0=C2=A0=C2=A0=C2=A0 submit=C2=A0=C2=A0=
=C2=A0 : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &=
gt;=3D64=3D0.0%<span></span></span></p><p class=3D"MsoNormal" style=3D"marg=
in:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb=
(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0=C2=A0=C2=
=A0=C2=A0 complete=C2=A0 : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.1%, 32=3D=
0.0%, 64=3D0.0%, &gt;=3D64=3D0.0%<span></span></span></p><p class=3D"MsoNor=
mal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-w=
eight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;white-space:normal;word-spacing:0px;text-decoration:none"><spa=
n>=C2=A0=C2=A0=C2=A0=C2=A0 issued rwts: total=3D524288,0,0,0 short=3D0,0,0,=
0 dropped=3D0,0,0,0<span></span></span></p><p class=3D"MsoNormal" style=3D"=
margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color=
:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;text-decoration:none"><span>=C2=A0=C2=A0=
=C2=A0=C2=A0 latency=C2=A0=C2=A0 : target=3D0, window=3D0, percentile=3D100=
.00%, depth=3D16<span></span></span></p><p class=3D"MsoNormal" style=3D"mar=
gin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rg=
b(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;lett=
er-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whit=
e-space:normal;word-spacing:0px;text-decoration:none"><span><span>=C2=A0</s=
pan></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font=
-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:norma=
l;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;white-space:normal;word-spaci=
ng:0px;text-decoration:none"><span>Run status group 0 (all jobs):<span></sp=
an></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-=
size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal=
;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;text-decoration:none"><span>=C2=A0=C2=A0 READ: bw=3D216MiB/s (227MB/s=
), 216MiB/s-216MiB/s (227MB/s-227MB/s), io=3D2048MiB (2147MB), run=3D9467-9=
467msec<span></span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0=
cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);=
font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;text-decoration:none"><span><span>=C2=A0</span></spa=
n></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11p=
t;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-va=
riant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;te=
xt-decoration:none"><span>Disk stats (read/write):<span></span></span></p><=
p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-=
family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-c=
aps:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-deco=
ration:none"><span>=C2=A0 loop1: ios=3D177240/0, merge=3D0/0, ticks=3D19938=
6/0, in_queue=3D75984, util=3D73.95%</span></p><p class=3D"MsoNormal" style=
=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:norm=
al;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;text-decoration:none"><br></p><p cla=
ss=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-famil=
y:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:n=
ormal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoratio=
n:none"><br></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;fon=
t-size:11pt;font-family:Calibri,sans-serif;font-style:normal;font-variant-c=
aps:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-deco=
ration:none"><span style=3D"color:rgb(255,0,0)">=C2=A0Fio Test on SquashFs =
dir:</span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font=
-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:norma=
l;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;white-space:normal;word-spaci=
ng:0px;text-decoration:none"><br></p><p class=3D"MsoNormal" style=3D"margin=
:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0=
,0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;text-decoration:none">localhost:~/Downloads/er=
ofs-utils&gt; fio --name=3Drandread --ioengine=3Dlibaio --iodepth=3D16 --rw=
=3Drandread --bs=3D4k --direct=3D0 --size=3D512M --numjobs=3D4 --runtime=3D=
240 --group_reporting --<span style=3D"color:rgb(255,153,0)">directory</spa=
n>=3D/mnt/enwik9_sqsh/ <br>randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B=
-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=3Dlibaio, iodepth=3D16<b=
r>...<br>fio-3.17-90-gd9b7<br>Starting 4 processes<br>randread: Laying out =
IO file (1 file / 512MiB)<br>fio: pid=3D0, err=3D30/file:filesetup.c:150, f=
unc=3Dunlink, error=3DRead-only file system<br>randread: Laying out IO file=
 (1 file / 512MiB)<br>fio: pid=3D0, err=3D30/file:filesetup.c:150, func=3Du=
nlink, error=3DRead-only file system<br>randread: Laying out IO file (1 fil=
e / 512MiB)<br>fio: pid=3D0, err=3D30/file:filesetup.c:150, func=3Dunlink, =
error=3DRead-only file system<br>randread: Laying out IO file (1 file / 512=
MiB)<br>fio: pid=3D0, err=3D30/file:filesetup.c:150, func=3Dunlink, error=
=3DRead-only file system<br><br><br>Run status group 0 (all jobs):<br><br><=
span><span></span></span></p></div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 22, 2020 at 10:07 AM Gao Xia=
ng &lt;<a href=3D"mailto:hsiangkao@aol.com" target=3D"_blank">hsiangkao@aol=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Wed, Jan 22, 2020 at 09:27:45AM +0530, Saumya Panda wrote:<br>
&gt; Hi Gao,<br>
&gt;=C2=A0 =C2=A0Thanks for the info. After I enabled the said configuratio=
n, I am now<br>
&gt; able to read the files after mount. But I am seeing Squashfs has bette=
r<br>
&gt; compression ratio compared to Erofs (more than 60% than that of Erofs)=
. Am<br>
&gt; I missing something? I used lz4hc while making the Erofs image.<br>
&gt; <br>
&gt; ls -l enwik*<br>
&gt; -rw-r--r-- 1 saumya users=C2=A0 61280256 Jan 21 03:22 enwik8.erofs.img=
<br>
&gt; -rw-r--r-- 1 saumya users=C2=A0 37355520 Jan 21 03:34 enwik8.sqsh<br>
&gt; -rw-r--r-- 1 saumya users 558133248 Jan 21 03:25 enwik9.erofs.img<br>
&gt; -rw-r--r-- 1 saumya users 331481088 Jan 21 03:35 enwik9.sqsh<br>
<br>
Yes, it&#39;s working as expect. Currently EROFS is compressed in 4k<br>
fixed-sized output compression granularity as mentioned in many<br>
available materials. That is the use case for our smartphones.<br>
You should compare with similar block configuration of squashfs.<br>
and there are some 3rd data by other folks as well [1].<br>
<br>
In the future, we will support other compression algorithms and<br>
larger compressed size (&gt; 4k).<br>
<br>
[1] In chinese,<br>
=C2=A0 =C2=A0 <a href=3D"https://blog.csdn.net/scnutiger/article/details/10=
2507596" rel=3D"noreferrer" target=3D"_blank">https://blog.csdn.net/scnutig=
er/article/details/102507596</a><br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr">Thanks,<br=
>Saumya Prakash Panda<br><br></div>

--0000000000003607ba059d3f913d--
