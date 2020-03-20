Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 098A818C869
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2020 09:01:11 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kGS43yVtzDrRY
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2020 19:01:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::230;
 helo=mail-lj1-x230.google.com; envelope-from=saumya.iisc@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=cL3Sh57D; dkim-atps=neutral
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kGRw2snPzDrRM
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2020 19:00:56 +1100 (AEDT)
Received: by mail-lj1-x230.google.com with SMTP id a2so5413113ljk.6
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2020 01:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WlqTsU1LH0SFT701GywuIVxi08/XIi9opLynsugRwL0=;
 b=cL3Sh57D80e2i+Cc3uTYf1lfkUE777a0Uy8FvsdagrjU3DtdoRzIh+wuuQcz7UjHXA
 Ve/MPxTDX9PKEMWT+7P8Dd7cI64wzFRiAi738RXBCy+vgACJpavdTw7CHk2Lk6wBvcf2
 FZMIwyvk/cPwXDdCRufs9x49HPb71BsDvXEoos6VFhNyxDVgkGsZvrmTSAqWSTae6NKI
 6rLpp5Ni9mHAtkjS4xUrBo/LphpDVI6GNUUt63rBFesDegJLKPWuQCP38bsez8pvFC/I
 F2p3K3wOjmertzM7XEVH2PXuUBkOKiohgRDUD96FItKTdv4hwym1RKKBw8ukgDzffInP
 kiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WlqTsU1LH0SFT701GywuIVxi08/XIi9opLynsugRwL0=;
 b=BdhkpAj/uqbIH6gcY4m8d9jAi0iAYa3PClUSxkosrrwlmMNJh8G7YuRjJxDHPDtTlC
 DNn3nULuTLozrWPzoVc55IEn3UVo3GZsiCfR3bv4GLjjs914DbO9hg2aZC3aiGmSrmi7
 NWL9jYOFaH2fk+MxXJhR2Ec2sCgQ1BsruHF/xampwDqN82AYYf9Bx95F02WylV3O3snT
 +PqLcYSQi7lrvdPfLs6DfT8Omk10eMYFG2XdlD1yxkDOJXI6CPL8cibljwqYnXBbvgSu
 CdRXu1XeLUzFPTr+k/KZoqXwWu28Syv1I26T7hVObOwZriaCMwQrySQARL3+R7MtV21z
 jYuQ==
X-Gm-Message-State: ANhLgQ0MiVu2KmSNmJ5ENf9Ajml0xwz5p8f//i+PE0qGZrz0YEpRli9j
 YGFGYGTNd+OGGILKJAHilj41Ni71+7Sk6YpkzCw=
X-Google-Smtp-Source: ADFU+vs4ftp5G3W4ZOrjh/xrUAc7YexjqUPj1JloRIgwOVJHERMn+G+TBaYaEz8a2ui6vB3pB+tGskcV4oZ6vTYFyNM=
X-Received: by 2002:a2e:7a0c:: with SMTP id v12mr4527493ljc.274.1584691251746; 
 Fri, 20 Mar 2020 01:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmfoRm7xUwuXfTZ2kr-x9fs59x7b707t183ggbLEtEyO_wznA@mail.gmail.com>
 <20200120073859.GA32421@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHmfoRn+YjEwxmZLTeDVN9Oja=7QTi14oEtpD5x7URT_X9dJ5w@mail.gmail.com>
 <20200122043655.GB6542@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHmfoRmXxEXqxJwakbQZmMz62_7DNai3KVzGu=U_yNEgYQvG=w@mail.gmail.com>
 <20200129045942.GB7472@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20200129045942.GB7472@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Saumya Panda <saumya.iisc@gmail.com>
Date: Fri, 20 Mar 2020 13:30:39 +0530
Message-ID: <CAHmfoRm8mfUdup7yPotvG7HEc21sCB3TB6FvMZhoV_zevxUdsQ@mail.gmail.com>
Subject: Re: Problem in EROFS: Not able to read the files after mount
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="00000000000023b10e05a144afc3"
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

--00000000000023b10e05a144afc3
Content-Type: text/plain; charset="UTF-8"

Hi Gao,
  I am trying to evaluate Erofs on my device. Right now SquashFS is used
for system files. Hence I am trying to compare Erofs with SquashFs. On my
device with the below environment I am seeing Erofs is 3 times faster than
SquashFS 128k (I used enwik8 (100MB) as testing file)) while doing Seq
Read. Your test result shows it is near to SquasFs 128k. How Erofs is so
fast for Seq Read?  I also tested  it on Suse VM with low memory(free
memory 425MB) and I am seeing Erofs is pretty fast.

Also Can you tell me how to run FIO on directory instead of files ?
 fio -filename=$i -rw=read -bs=4k -name=seqbench

             Test on Embedded Device:

Total Memory 5.5 GB:

 Free Memory 1515

 No Swap


$: /fio/erofs_test]$ free -m

              total        used        free      shared  buff/cache
available

Mem:           5384        2315        1515        1378        1553
1592

Swap:             0           0           0





Seq Read



Rand Read





squashFS 4k



51.8MB/s

1931msec

45.7MB/s

2187msec



SquashFS 128k



116MB/s

861msec

14MB/s

877msec



SquashFS 1M



124MB/s-124MB/s

805msec

119MB/s

837msec





Erofs 4k



658MB/s-658MB/s

152msec



103MB

974msec







 Test on Suse VM:


Total Memory 1.5 GB:

 Free Memory 425

 No Swap

localhost:/home/saumya/Documents/erofs_test # free -m
              total        used        free      shared  buff/cache
available
Mem:           1436         817         425           5         192
444
Swap:             0           0           0






Seq Read



Rand Read





squashFS 4k



30.7MB/s

3216msec

9333kB/s

10715msec



SquashFS 128k



318MB/s

314msec

5946kB/s

16819msec











Erofs 4k



469MB/s

213msec



11.9MB/s

8414msec











On Wed, Jan 29, 2020 at 10:30 AM Gao Xiang <hsiangkao@aol.com> wrote:

> On Wed, Jan 29, 2020 at 09:43:37AM +0530, Saumya Panda wrote:
> >
> > localhost:~> fio --name=randread --ioengine=libaio --iodepth=16
> > --rw=randread --bs=4k --direct=0 --size=512M --numjobs=4 --runtime=240
> > --group_reporting --filename=/mnt/enwik9_erofs/enwik9
> >
> > randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> > 4096B-4096B, ioengine=libaio, iodepth=16
>
> And I don't think such configuration is useful to calculate read
> ampfication
> since you read 100% finally, use multi-thread without memory limitation
> (all
> compressed data will be cached, so the total read is compressed size).
>
> I have no idea what you want to get via doing comparsion between EROFS and
> Squashfs. Larger block size much like readahead in bulk. If you benchmark
> uncompressed file systems, you will notice such filesystems cannot get such
> high 100% randread number.
>
> Thank,
> Gao Xiang
>
>

-- 
Thanks,
Saumya Prakash Panda

--00000000000023b10e05a144afc3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Gao,</div><div>=C2=A0 I am trying to evaluate Erof=
s on my device. Right now SquashFS is used for system files. Hence I am try=
ing to compare Erofs with SquashFs. On my device with the below environment=
 I am seeing Erofs is 3 times faster than SquashFS 128k (I used enwik8 (100=
MB) as testing file)) while doing Seq Read. Your test result shows it is ne=
ar to SquasFs 128k. How Erofs is so fast for Seq Read?=C2=A0 I also tested=
=C2=A0 it on Suse VM with low memory(free memory 425MB) and I am seeing Ero=
fs is pretty fast.</div><div><br></div><div>Also Can you tell me how to run=
 FIO on directory instead of files ? <br></div><div>=C2=A0fio -filename=3D<=
span class=3D"gmail-pl-smi">$i</span> -rw=3Dread -bs=3D4k -name=3Dseqbench<=
/div><div><br></div><div><font size=3D"2">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span style=3D"color:rgb(255,153,0)"=
> Test on Embedded Device: </span></font><br></div><div><p class=3D"MsoNorm=
al" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-family:Calibr=
i,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;fo=
nt-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;text-decoration:none">=
<span lang=3D"EN-US">Total Memory 5.5 GB:</span><span></span></p><p class=
=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-fa=
mily:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-cap=
s:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decora=
tion:none"><span lang=3D"EN-US">=C2=A0Free Memory 1515</span></p><p class=
=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-fa=
mily:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-cap=
s:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decora=
tion:none">=C2=A0No Swap</p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm =
0.0001pt 36pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0=
);font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;text-decoration:none"><br></p><p class=3D"MsoNorma=
l" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-family:Calibri=
,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;fon=
t-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text=
-transform:none;white-space:normal;word-spacing:0px;text-decoration:none"><=
span lang=3D"EN-US"></span><span></span></p><p class=3D"MsoNormal" style=3D=
"margin:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-family:Calibri,sans-serif=
;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:no=
rmal;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;text-decoration:none"><span lang=
=3D"EN-US">$: /fio/erofs_test]$ free -m</span><span></span></p><p class=3D"=
MsoNormal" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-family=
:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:no=
rmal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:=
0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration=
:none"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 used=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span class=3D"gmail-A=
pple-converted-space">=C2=A0</span><span style=3D"color:red">free=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0<span class=3D"gmail-Apple-converted-space">=C2=A0</sp=
an></span>shared=C2=A0 buff/cache=C2=A0=C2=A0 available</span><span></span>=
</p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:=
11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font=
-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;text-decoration:none"><span lang=3D"EN-US">Mem:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5384=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 2315=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span class=3D"gmail-A=
pple-converted-space">=C2=A0</span><span style=3D"color:red">1515=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<span class=3D"gmail-Apple-converted-space=
">=C2=A0</span></span>1378=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1553=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1592</span><span></span></p><p c=
lass=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:11pt;fon=
t-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant=
-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-de=
coration:none"><span lang=3D"EN-US">Swap:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0</span><span></span></p><p class=3D"MsoNormal" style=3D"ma=
rgin:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-family:Calibri,sans-serif;co=
lor:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:norma=
l;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;white-space:normal;word-spacing:0px;text-decoration:none">=C2=A0<span></s=
pan></p><table class=3D"gmail-MsoNormalTable" style=3D"font-family:-webkit-=
standard;letter-spacing:normal;text-indent:0px;text-transform:none;word-spa=
cing:0px;text-decoration:none;margin-left:36pt;border-collapse:collapse" ce=
llspacing=3D"0" cellpadding=3D"0" border=3D"0"><tbody><tr><td style=3D"widt=
h:108.3pt;border:1pt solid windowtext;padding:0cm 5.4pt" width=3D"144" vali=
gn=3D"top"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-siz=
e:11pt;font-family:Calibri,sans-serif;text-align:justify"><span>=C2=A0</spa=
n><span></span></p></td><td style=3D"width:108.6pt;border-top:1pt solid win=
dowtext;border-right:1pt solid windowtext;border-bottom:1pt solid windowtex=
t;border-style:solid solid solid none;padding:0cm 5.4pt" width=3D"145" vali=
gn=3D"top"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-siz=
e:11pt;font-family:Calibri,sans-serif"><span>Seq Read</span><span></span></=
p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;fo=
nt-family:Calibri,sans-serif;text-align:justify"><span>=C2=A0</span><span><=
/span></p></td><td style=3D"width:108.65pt;border-top:1pt solid windowtext;=
border-right:1pt solid windowtext;border-bottom:1pt solid windowtext;border=
-style:solid solid solid none;padding:0cm 5.4pt" width=3D"145" valign=3D"to=
p"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;f=
ont-family:Calibri,sans-serif"><span>Rand Read</span><span></span></p><p cl=
ass=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-fami=
ly:Calibri,sans-serif;text-align:justify"><span>=C2=A0</span><span></span><=
/p></td><td style=3D"width:105.45pt;border-top:1pt solid windowtext;border-=
right:1pt solid windowtext;border-bottom:1pt solid windowtext;border-style:=
solid solid solid none;padding:0cm 5.4pt" width=3D"141" valign=3D"top"><p c=
lass=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-fam=
ily:Calibri,sans-serif;text-align:justify"><span>=C2=A0</span><span></span>=
</p></td></tr><tr><td style=3D"width:108.3pt;border-right:1pt solid windowt=
ext;border-bottom:1pt solid windowtext;border-left:1pt solid windowtext;bor=
der-style:none solid solid;padding:0cm 5.4pt" width=3D"144" valign=3D"top">=
<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif"><span>squashFS 4k</span><span></span></p><p cla=
ss=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-famil=
y:Calibri,sans-serif;text-align:justify"><span>=C2=A0</span><span></span></=
p></td><td style=3D"width:108.6pt;border-style:none solid solid none;border=
-bottom:1pt solid windowtext;border-right:1pt solid windowtext;padding:0cm =
5.4pt" width=3D"145" valign=3D"top"><p class=3D"MsoNormal" style=3D"margin:=
0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;text-align:j=
ustify"><span lang=3D"EN-US">51.8MB/s</span><span></span></p><p class=3D"Ms=
oNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibr=
i,sans-serif;text-align:justify"><span lang=3D"EN-US">1931msec</span><span>=
</span></p></td><td style=3D"width:108.65pt;border-style:none solid solid n=
one;border-bottom:1pt solid windowtext;border-right:1pt solid windowtext;pa=
dding:0cm 5.4pt" width=3D"145" valign=3D"top"><p class=3D"MsoNormal" style=
=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;t=
ext-align:justify"><span lang=3D"EN-US">45.7MB/s</span><span></span></p><p =
class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-fa=
mily:Calibri,sans-serif;text-align:justify"><span lang=3D"EN-US">2187msec</=
span><span></span></p></td><td style=3D"width:105.45pt;border-style:none so=
lid solid none;border-bottom:1pt solid windowtext;border-right:1pt solid wi=
ndowtext;padding:0cm 5.4pt" width=3D"141" valign=3D"top"><p class=3D"MsoNor=
mal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sa=
ns-serif;text-align:justify"><span>=C2=A0</span><span></span></p></td></tr>=
<tr><td style=3D"width:108.3pt;border-right:1pt solid windowtext;border-bot=
tom:1pt solid windowtext;border-left:1pt solid windowtext;border-style:none=
 solid solid;padding:0cm 5.4pt" width=3D"144" valign=3D"top"><p class=3D"Ms=
oNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibr=
i,sans-serif"><span>SquashFS 128k</span><span></span></p><p class=3D"MsoNor=
mal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sa=
ns-serif;text-align:justify"><span>=C2=A0</span><span></span></p></td><td s=
tyle=3D"width:108.6pt;border-style:none solid solid none;border-bottom:1pt =
solid windowtext;border-right:1pt solid windowtext;padding:0cm 5.4pt" width=
=3D"145" valign=3D"top"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.00=
01pt;font-size:11pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">11=
6MB/s</span><span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm=
 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><span lang=3D"EN-U=
S">861msec</span><span></span></p></td><td style=3D"width:108.65pt;border-s=
tyle:none solid solid none;border-bottom:1pt solid windowtext;border-right:=
1pt solid windowtext;padding:0cm 5.4pt" width=3D"145" valign=3D"top"><p cla=
ss=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-famil=
y:Calibri,sans-serif;text-align:justify"><span lang=3D"EN-US">14MB/s</span>=
<span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;fo=
nt-size:11pt;font-family:Calibri,sans-serif;text-align:justify"><span lang=
=3D"EN-US">877msec</span><span></span></p></td><td style=3D"width:105.45pt;=
border-style:none solid solid none;border-bottom:1pt solid windowtext;borde=
r-right:1pt solid windowtext;padding:0cm 5.4pt" width=3D"141" valign=3D"top=
"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;fo=
nt-family:Calibri,sans-serif;text-align:justify"><span>=C2=A0</span><span><=
/span></p></td></tr><tr><td style=3D"width:108.3pt;border-right:1pt solid w=
indowtext;border-bottom:1pt solid windowtext;border-left:1pt solid windowte=
xt;border-style:none solid solid;padding:0cm 5.4pt" width=3D"144" valign=3D=
"top"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11p=
t;font-family:Calibri,sans-serif"><span>SquashFS 1M</span><span></span></p>=
<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif"><span>=C2=A0</span><span></span></p></td><td st=
yle=3D"width:108.6pt;border-style:none solid solid none;border-bottom:1pt s=
olid windowtext;border-right:1pt solid windowtext;padding:0cm 5.4pt" width=
=3D"145" valign=3D"top"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.00=
01pt;font-size:11pt;font-family:Calibri,sans-serif;text-align:justify"><spa=
n lang=3D"EN-US">124MB/s-124MB/s</span><span></span></p><p class=3D"MsoNorm=
al" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,san=
s-serif;text-align:justify"><span lang=3D"EN-US">805msec</span><span></span=
></p></td><td style=3D"width:108.65pt;border-style:none solid solid none;bo=
rder-bottom:1pt solid windowtext;border-right:1pt solid windowtext;padding:=
0cm 5.4pt" width=3D"145" valign=3D"top"><p class=3D"MsoNormal" style=3D"mar=
gin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;text-ali=
gn:justify"><span lang=3D"EN-US">119MB/s</span><span></span></p><p class=3D=
"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Cal=
ibri,sans-serif"><span lang=3D"EN-US">837msec</span><span></span></p><p cla=
ss=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-famil=
y:Calibri,sans-serif;text-align:justify"><span>=C2=A0</span><span></span></=
p></td><td style=3D"width:105.45pt;border-style:none solid solid none;borde=
r-bottom:1pt solid windowtext;border-right:1pt solid windowtext;padding:0cm=
 5.4pt" width=3D"141" valign=3D"top"><p class=3D"MsoNormal" style=3D"margin=
:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;text-align:=
justify"><span>=C2=A0</span><span></span></p></td></tr><tr style=3D"height:=
29.7pt"><td style=3D"width:108.3pt;border-right:1pt solid windowtext;border=
-bottom:1pt solid windowtext;border-left:1pt solid windowtext;border-style:=
none solid solid;padding:0cm 5.4pt;height:29.7pt" width=3D"144" valign=3D"t=
op"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;=
font-family:Calibri,sans-serif"><span>Erofs 4k</span><span></span></p><p cl=
ass=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-fami=
ly:Calibri,sans-serif"><span>=C2=A0</span><span></span></p></td><td style=
=3D"width:108.6pt;border-style:none solid solid none;border-bottom:1pt soli=
d windowtext;border-right:1pt solid windowtext;padding:0cm 5.4pt;height:29.=
7pt" width=3D"145" valign=3D"top"><p class=3D"MsoNormal" style=3D"margin:0c=
m 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><span lang=3D=
"EN-US">658MB/s-658MB/s</span><span></span></p><p class=3D"MsoNormal" style=
=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif">=
<span lang=3D"EN-US">152msec</span><span></span></p><p class=3D"MsoNormal" =
style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-se=
rif"><span>=C2=A0</span><span></span></p></td><td style=3D"width:108.65pt;b=
order-style:none solid solid none;border-bottom:1pt solid windowtext;border=
-right:1pt solid windowtext;padding:0cm 5.4pt;height:29.7pt" width=3D"145" =
valign=3D"top"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font=
-size:11pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">103MB</span=
><span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;f=
ont-size:11pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">974msec<=
/span><span></span></p></td><td style=3D"width:105.45pt;border-style:none s=
olid solid none;border-bottom:1pt solid windowtext;border-right:1pt solid w=
indowtext;padding:0cm 5.4pt;height:29.7pt" width=3D"141" valign=3D"top"><p =
class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-fa=
mily:Calibri,sans-serif;text-align:justify"><span>=C2=A0</span><span></span=
></p></td></tr></tbody></table><p class=3D"MsoNormal" style=3D"margin:0cm 0=
cm 0.0001pt 36pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,=
0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;letter-s=
pacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;text-decoration:none;text-align:justify"><span style=3D"font-siz=
e:12pt;color:white">=C2=A0</span><span></span></p><p class=3D"MsoNormal" st=
yle=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-family:Calibri,sans=
-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-wei=
ght:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;text-decoration:none">=C2=A0=
<span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt 36=
pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-styl=
e:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;text-decoration:none"><span style=3D"color:rgb(255,153,0)">=
=C2=A0Test on Suse VM: </span><br></p><p class=3D"MsoNormal" style=3D"margi=
n:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-family:Calibri,sans-serif;color=
:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;text-decoration:none"><br></p><p class=
=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-fa=
mily:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-variant-cap=
s:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decora=
tion:none"><span lang=3D"EN-US">Total Memory 1.5 GB:</span><span></span></p=
><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:11p=
t;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-va=
riant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;te=
xt-decoration:none"><span lang=3D"EN-US">=C2=A0Free Memory 425<br></span></=
p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:11=
pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-v=
ariant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:star=
t;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;t=
ext-decoration:none">=C2=A0No Swap</p><p class=3D"MsoNormal" style=3D"margi=
n:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-family:Calibri,sans-serif;color=
:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;text-decoration:none">localhost:/home/sa=
umya/Documents/erofs_test # free -m<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 total =C2=A0 =C2=A0 =C2=A0 =C2=A0used =C2=A0 =C2=A0 =C2=A0 =
=C2=A0free =C2=A0 =C2=A0 =C2=A0shared =C2=A0buff/cache =C2=A0 available<br>=
Mem: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1436 =C2=A0 =C2=A0 =C2=A0 =C2=A0 81=
7 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"color:rgb(255,0,0)">425</span>=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5 =C2=A0 =C2=A0 =C2=A0 =C2=A0 192 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 444<br>Swap: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0</p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt 36pt;fo=
nt-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:nor=
mal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:0px;text-decoration:none"><br></p><p class=3D"MsoNormal" style=3D"marg=
in:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-family:Calibri,sans-serif;colo=
r:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-weight:normal;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;text-decoration:none">=C2=A0<span></spa=
n></p><table class=3D"gmail-MsoNormalTable" style=3D"font-family:-webkit-st=
andard;letter-spacing:normal;text-indent:0px;text-transform:none;word-spaci=
ng:0px;text-decoration:none;margin-left:36pt;border-collapse:collapse" cell=
spacing=3D"0" cellpadding=3D"0" border=3D"0"><tbody><tr><td style=3D"width:=
108.3pt;border:1pt solid windowtext;padding:0cm 5.4pt" width=3D"144" valign=
=3D"top"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:=
11pt;font-family:Calibri,sans-serif;text-align:justify"><span>=C2=A0</span>=
<span></span></p></td><td style=3D"width:108.6pt;border-top:1pt solid windo=
wtext;border-right:1pt solid windowtext;border-bottom:1pt solid windowtext;=
border-style:solid solid solid none;padding:0cm 5.4pt" width=3D"145" valign=
=3D"top"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:=
11pt;font-family:Calibri,sans-serif"><span>Seq Read</span><span></span></p>=
<p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font=
-family:Calibri,sans-serif;text-align:justify"><span>=C2=A0</span><span></s=
pan></p></td><td style=3D"width:108.65pt;border-top:1pt solid windowtext;bo=
rder-right:1pt solid windowtext;border-bottom:1pt solid windowtext;border-s=
tyle:solid solid solid none;padding:0cm 5.4pt" width=3D"145" valign=3D"top"=
><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;fon=
t-family:Calibri,sans-serif"><span>Rand Read</span><span></span></p><p clas=
s=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family=
:Calibri,sans-serif;text-align:justify"><span>=C2=A0</span><span></span></p=
></td><td style=3D"width:105.45pt;border-top:1pt solid windowtext;border-ri=
ght:1pt solid windowtext;border-bottom:1pt solid windowtext;border-style:so=
lid solid solid none;padding:0cm 5.4pt" width=3D"141" valign=3D"top"><p cla=
ss=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-famil=
y:Calibri,sans-serif;text-align:justify"><span>=C2=A0</span><span></span></=
p></td></tr><tr><td style=3D"width:108.3pt;border-right:1pt solid windowtex=
t;border-bottom:1pt solid windowtext;border-left:1pt solid windowtext;borde=
r-style:none solid solid;padding:0cm 5.4pt" width=3D"144" valign=3D"top"><p=
 class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif"><span>squashFS 4k</span><span></span></p><p class=
=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:=
Calibri,sans-serif;text-align:justify"><span>=C2=A0</span><span></span></p>=
</td><td style=3D"width:108.6pt;border-style:none solid solid none;border-b=
ottom:1pt solid windowtext;border-right:1pt solid windowtext;padding:0cm 5.=
4pt" width=3D"145" valign=3D"top"><p class=3D"MsoNormal" style=3D"margin:0c=
m 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;text-align:jus=
tify"><span lang=3D"EN-US">30.7MB/s</span><span></span></p><p class=3D"MsoN=
ormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,=
sans-serif;text-align:justify"><span lang=3D"EN-US">3216msec</span><span></=
span></p></td><td style=3D"width:108.65pt;border-style:none solid solid non=
e;border-bottom:1pt solid windowtext;border-right:1pt solid windowtext;padd=
ing:0cm 5.4pt" width=3D"145" valign=3D"top"><p class=3D"MsoNormal" style=3D=
"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;text=
-align:justify"><span lang=3D"EN-US">9333kB/s</span><span></span></p><p cla=
ss=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-famil=
y:Calibri,sans-serif;text-align:justify"><span lang=3D"EN-US">10715msec</sp=
an></p></td><td style=3D"width:105.45pt;border-style:none solid solid none;=
border-bottom:1pt solid windowtext;border-right:1pt solid windowtext;paddin=
g:0cm 5.4pt" width=3D"141" valign=3D"top"><p class=3D"MsoNormal" style=3D"m=
argin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;text-a=
lign:justify"><span>=C2=A0</span><span></span></p></td></tr><tr><td style=
=3D"width:108.3pt;border-right:1pt solid windowtext;border-bottom:1pt solid=
 windowtext;border-left:1pt solid windowtext;border-style:none solid solid;=
padding:0cm 5.4pt" width=3D"144" valign=3D"top"><p class=3D"MsoNormal" styl=
e=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"=
><span>SquashFS 128k</span><span></span></p><p class=3D"MsoNormal" style=3D=
"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;text=
-align:justify"><span>=C2=A0</span><span></span></p></td><td style=3D"width=
:108.6pt;border-style:none solid solid none;border-bottom:1pt solid windowt=
ext;border-right:1pt solid windowtext;padding:0cm 5.4pt" width=3D"145" vali=
gn=3D"top"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-siz=
e:11pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">318MB/s</span><=
span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;fon=
t-size:11pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">314msec</s=
pan><span></span></p></td><td style=3D"width:108.65pt;border-style:none sol=
id solid none;border-bottom:1pt solid windowtext;border-right:1pt solid win=
dowtext;padding:0cm 5.4pt" width=3D"145" valign=3D"top"><p class=3D"MsoNorm=
al" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,san=
s-serif;text-align:justify"><span lang=3D"EN-US">5946kB/s</span><span></spa=
n></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11p=
t;font-family:Calibri,sans-serif;text-align:justify"><span lang=3D"EN-US">1=
6819msec</span><span></span></p></td><td style=3D"width:105.45pt;border-sty=
le:none solid solid none;border-bottom:1pt solid windowtext;border-right:1p=
t solid windowtext;padding:0cm 5.4pt" width=3D"141" valign=3D"top"><p class=
=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:=
Calibri,sans-serif;text-align:justify"><span>=C2=A0</span><span></span></p>=
</td></tr><tr><td style=3D"width:108.3pt;border-right:1pt solid windowtext;=
border-bottom:1pt solid windowtext;border-left:1pt solid windowtext;border-=
style:none solid solid;padding:0cm 5.4pt" width=3D"144" valign=3D"top"><p c=
lass=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-fam=
ily:Calibri,sans-serif"><span><br></span><span></span></p><p class=3D"MsoNo=
rmal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,s=
ans-serif"><span>=C2=A0</span><span></span></p></td><td style=3D"width:108.=
6pt;border-style:none solid solid none;border-bottom:1pt solid windowtext;b=
order-right:1pt solid windowtext;padding:0cm 5.4pt" width=3D"145" valign=3D=
"top"><br><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size=
:11pt;font-family:Calibri,sans-serif;text-align:justify"><span lang=3D"EN-U=
S"></span><span></span></p></td><td style=3D"width:108.65pt;border-style:no=
ne solid solid none;border-bottom:1pt solid windowtext;border-right:1pt sol=
id windowtext;padding:0cm 5.4pt" width=3D"145" valign=3D"top"><br><p class=
=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:=
Calibri,sans-serif"><span lang=3D"EN-US"></span><span></span></p><p class=
=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:=
Calibri,sans-serif;text-align:justify"><span>=C2=A0</span><span></span></p>=
</td><td style=3D"width:105.45pt;border-style:none solid solid none;border-=
bottom:1pt solid windowtext;border-right:1pt solid windowtext;padding:0cm 5=
.4pt" width=3D"141" valign=3D"top"><p class=3D"MsoNormal" style=3D"margin:0=
cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;text-align:ju=
stify"><span>=C2=A0</span><span></span></p></td></tr><tr style=3D"height:29=
.7pt"><td style=3D"width:108.3pt;border-right:1pt solid windowtext;border-b=
ottom:1pt solid windowtext;border-left:1pt solid windowtext;border-style:no=
ne solid solid;padding:0cm 5.4pt;height:29.7pt" width=3D"144" valign=3D"top=
"><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;fo=
nt-family:Calibri,sans-serif"><span>Erofs 4k</span><span></span></p><p clas=
s=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family=
:Calibri,sans-serif"><span>=C2=A0</span><span></span></p></td><td style=3D"=
width:108.6pt;border-style:none solid solid none;border-bottom:1pt solid wi=
ndowtext;border-right:1pt solid windowtext;padding:0cm 5.4pt;height:29.7pt"=
 width=3D"145" valign=3D"top"><p class=3D"MsoNormal" style=3D"margin:0cm 0c=
m 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><span lang=3D"EN-=
US">469MB/s</span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001=
pt;font-size:11pt;font-family:Calibri,sans-serif"><span lang=3D"EN-US">213m=
sec<br><br></span><span></span></p><p class=3D"MsoNormal" style=3D"margin:0=
cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif"><span>=C2=A0=
</span><span></span></p></td><td style=3D"width:108.65pt;border-style:none =
solid solid none;border-bottom:1pt solid windowtext;border-right:1pt solid =
windowtext;padding:0cm 5.4pt;height:29.7pt" width=3D"145" valign=3D"top"><p=
 class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif"><span lang=3D"EN-US">11.9MB/s</span><span></span>=
</p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;=
font-family:Calibri,sans-serif"><span lang=3D"EN-US">8414msec</span></p><p =
class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt;font-size:11pt;font-fa=
mily:Calibri,sans-serif"><span lang=3D"EN-US"></span><span></span></p></td>=
<td style=3D"width:105.45pt;border-style:none solid solid none;border-botto=
m:1pt solid windowtext;border-right:1pt solid windowtext;padding:0cm 5.4pt;=
height:29.7pt" width=3D"141" valign=3D"top"><p class=3D"MsoNormal" style=3D=
"margin:0cm 0cm 0.0001pt;font-size:11pt;font-family:Calibri,sans-serif;text=
-align:justify"><span>=C2=A0</span><span></span></p></td></tr></tbody></tab=
le><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:1=
1pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-=
variant-caps:normal;font-weight:normal;letter-spacing:normal;text-indent:0p=
x;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:n=
one;text-align:justify"><span style=3D"font-size:12pt;color:white">=C2=A0</=
span><span></span></p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001=
pt 36pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font=
-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;text-decoration:none">=C2=A0</p><p class=3D"MsoNormal" s=
tyle=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-family:Calibri,san=
s-serif;color:rgb(0,0,0);font-style:normal;font-variant-caps:normal;font-we=
ight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;white-space:normal;word-spacing:0px;text-decoration:none"><br><=
/p><p class=3D"MsoNormal" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:1=
1pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);font-style:normal;font-=
variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
text-decoration:none"><br></p><p class=3D"MsoNormal" style=3D"margin:0cm 0c=
m 0.0001pt 36pt;font-size:11pt;font-family:Calibri,sans-serif;color:rgb(0,0=
,0);font-style:normal;font-variant-caps:normal;font-weight:normal;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;text-decoration:none"><br></p></div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan =
29, 2020 at 10:30 AM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@aol.com">hsi=
angkao@aol.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Wed, Jan 29, 2020 at 09:43:37AM +0530, Saumya Panda wrote:=
<br>
&gt; <br>
&gt; localhost:~&gt; fio --name=3Drandread --ioengine=3Dlibaio --iodepth=3D=
16<br>
&gt; --rw=3Drandread --bs=3D4k --direct=3D0 --size=3D512M --numjobs=3D4 --r=
untime=3D240<br>
&gt; --group_reporting --filename=3D/mnt/enwik9_erofs/enwik9<br>
&gt; <br>
&gt; randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096=
B, (T)<br>
&gt; 4096B-4096B, ioengine=3Dlibaio, iodepth=3D16<br>
<br>
And I don&#39;t think such configuration is useful to calculate read ampfic=
ation<br>
since you read 100% finally, use multi-thread without memory limitation (al=
l<br>
compressed data will be cached, so the total read is compressed size).<br>
<br>
I have no idea what you want to get via doing comparsion between EROFS and<=
br>
Squashfs. Larger block size much like readahead in bulk. If you benchmark<b=
r>
uncompressed file systems, you will notice such filesystems cannot get such=
<br>
high 100% randread number.<br>
<br>
Thank,<br>
Gao Xiang<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Thanks,<br>Saumya Prakash Panda<br><br></div>

--00000000000023b10e05a144afc3--
