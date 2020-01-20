Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1AC142408
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2020 08:02:42 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 481N0H2PZMzDqD4
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2020 18:02:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22b;
 helo=mail-lj1-x22b.google.com; envelope-from=saumya.iisc@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=PNPBHbqg; dkim-atps=neutral
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 481MrG0hYLzDqWp
 for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2020 17:55:35 +1100 (AEDT)
Received: by mail-lj1-x22b.google.com with SMTP id a13so32606225ljm.10
 for <linux-erofs@lists.ozlabs.org>; Sun, 19 Jan 2020 22:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=EHIAHS+SGodrYevwbzPxyr+SKq78FjiPSgEvNtf2oNI=;
 b=PNPBHbqgfeIoHjq1ZhrxQG1n0V6+tpb5YpvOmCgcfRNdHlCCORn0t9UhDuP4dRgOab
 YvOJ0I84yC7ElFkZLot1OyM63hPM5DA4YeCcEVo36CjnrSbzfDjeGh69LFrONX3G/heW
 RYv7MuCRFT3Qa20krKsVXvYI9wS4KIa5ZUEC6LEOPxm1f/rlkgFzBDSne4RIWuLV2+t+
 36byho1BINUcXpTQ6L4xEg1VljDBtI/q/CfZ13KRI92H0uISnWBLdfEMcZf0rAUB9xy5
 IUXa0/Kv+0bR6MU264b+CBHBKFkCO2PVMT+mrGgjQ5u1X09bon3XegjJYjhXbGkkoGsY
 nPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=EHIAHS+SGodrYevwbzPxyr+SKq78FjiPSgEvNtf2oNI=;
 b=M5LeFCHg6OEa0uqAwvwye2tUxuCKEiPbpWrUh4ZvWFbNBv+HSSWsBziOFfhjs4bDeg
 N+NbdlmBXIOwYS0WvSq4lRvkZ6FSswy4g9lQixVY3R92SeQMtHtKHP1wi20G0unNvbPA
 bIO5uSlhmwMOUwR4OB7h4FnIaB840Gklmqc7tyei4ZeSI/R+dSXJYpGA0m4T2NDJCNU7
 C54lTWK7Glsj/NUEWh7fgTDQPhxjDAlTeaV0Dc9kolCZL2n7ex8Ech+ONir5xwrzHMGt
 Q9+FI+xrjUj5xPU0qfV62ftO8pu3q05QIqs7pyVB2HjoeYlmC+TgIpkJ/nMRxbwlnRLO
 I5FQ==
X-Gm-Message-State: APjAAAWrVXYbCw+Y7P36VRrcxR0TN3IZQPvAdyYZbRedH9kEt1NsK1y9
 +kDF7jvp68RLISK8FR+WtTL5oSw4/tOGneM0qtJh8n4GUAY=
X-Google-Smtp-Source: APXvYqwwrta4fEjnE1ZN/MhSftWnA/Ei4NZn5QAaOmGnhyh+XYpr70YS/JG59zald/YYmIUrPOJW7b8d8KKDGdAK/JY=
X-Received: by 2002:a2e:7d01:: with SMTP id y1mr12955105ljc.100.1579503327400; 
 Sun, 19 Jan 2020 22:55:27 -0800 (PST)
MIME-Version: 1.0
From: Saumya Panda <saumya.iisc@gmail.com>
Date: Mon, 20 Jan 2020 12:25:15 +0530
Message-ID: <CAHmfoRm7xUwuXfTZ2kr-x9fs59x7b707t183ggbLEtEyO_wznA@mail.gmail.com>
Subject: Problem in EROFS: Not able to read the files after mount
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000c05781059c8cc695"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000c05781059c8cc695
Content-Type: text/plain; charset="UTF-8"

Hi Experts,
   I am testing EROFS in openSuse(Kernel: 5.4.7-1-default). I used the
enwik8 and enwik9 as source file (
https://cs.fit.edu/~mmahoney/compression/textdata.html) for compression.
But after I mount the erofs image, I am not able to read it (it is saying
operation not permitted). Simple "ls" command is not working. But if I
create EROFS image without compression flag, then after mount I am able to
read the files. Seems there is some problem during compression.

I will appreciate if someone can help me out why this is happening.

Steps followed:
*Erofs image creation & mount: *
mkfs.erofs -zlz4hc enwik8.erofs.img enwik8/
mkfs.erofs 1.0
        c_version:           [     1.0]
        c_dbg_lvl:           [       0]
        c_dry_run:           [       0]
mount enwik8.erofs.img /mnt/enwik8/ -t erofs -o loop

ls -l /mnt/enwik8/
ls: cannot access '/mnt/enwik8/enwik8': Operation not supported
total 0
-????????? ? ? ? ?            ? enwik8

The problem seen for both lz4 & lz4hc.

*Erofs image creation & mount without compression: *
mkfs.erofs  enwik8_nocomp.erofs.img enwik8/
mkfs.erofs 1.0
        c_version:           [     1.0]
        c_dbg_lvl:           [       0]
        c_dry_run:           [       0]

mount enwik8_nocomp.erofs.img /mnt/enwik8_nocomp/ -t erofs -o loop

ls -l /mnt/enwik8_nocomp/
total 97660
-rw-r--r-- 1 root root 100000000 Jan 20 01:27 enwik8

*Original enwik8 file:*
ls -l enwik8
total 97660
-rw-r--r-- 1 root root 100000000 Jan 20 01:14 enwik8

*Source code used for Lz4 and Erofs utils:*
https://github.com/hsiangkao/erofs-utils
https://github.com/lz4/lz4

-- 
Thanks,
Saumya Prakash Panda

--000000000000c05781059c8cc695
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Experts, <br></div><div>=C2=A0=C2=A0 I am testing =
EROFS in openSuse(Kernel: 5.4.7-1-default). I used the enwik8 and enwik9 as=
 source file  (<a href=3D"https://cs.fit.edu/~mmahoney/compression/textdata=
.html">https://cs.fit.edu/~mmahoney/compression/textdata.html</a>) for comp=
ression. But after I mount the erofs image, I am not able to read it (it is=
 saying operation not permitted). Simple &quot;ls&quot; command is not work=
ing. But if I create EROFS image without compression flag, then after mount=
 I am able to read the files. Seems there is some problem during compressio=
n. <br></div><div><br></div><div>I will appreciate if someone can help me o=
ut why this is happening.<br></div><div><br></div><div>Steps followed: <br>=
</div><div><u>Erofs image creation &amp; mount: </u><br></div><div>mkfs.ero=
fs -zlz4hc enwik8.erofs.img enwik8/</div><div>mkfs.erofs 1.0<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 c_version: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ =C2=A0 =
=C2=A0 1.0]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 c_dbg_lvl: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 [ =C2=A0 =C2=A0 =C2=A0 0]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 c_dr=
y_run: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ =C2=A0 =C2=A0 =C2=A0 0]<br></di=
v><div>mount enwik8.erofs.img /mnt/enwik8/ -t erofs -o loop</div><div><br><=
/div><div>ls -l /mnt/enwik8/<br>ls: cannot access &#39;/mnt/enwik8/enwik8&#=
39;: Operation not supported<br>total 0<br>-????????? ? ? ? ? =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0? enwik8<br></div><div><br></div><div>The probl=
em seen for both lz4 &amp; lz4hc. <br></div><div><br></div><div><u>Erofs im=
age creation &amp; mount without compression: </u></div><div>mkfs.erofs =C2=
=A0enwik8_nocomp.erofs.img enwik8/<br>mkfs.erofs 1.0<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 c_version: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ =C2=A0 =C2=A0 1.=
0]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 c_dbg_lvl: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 [ =C2=A0 =C2=A0 =C2=A0 0]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 c_dry_run: =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [ =C2=A0 =C2=A0 =C2=A0 0]</div><div><br>=
</div><div>mount enwik8_nocomp.erofs.img /mnt/enwik8_nocomp/ -t erofs -o lo=
op</div><div><br></div><div>ls -l /mnt/enwik8_nocomp/<br>total 97660<br>-rw=
-r--r-- 1 root root 100000000 Jan 20 01:27 enwik8</div><div><br></div><div>=
<div><u>Original enwik8 file:</u><br></div><div>ls -l enwik8<br>total 97660=
<br>-rw-r--r-- 1 root root 100000000 Jan 20 01:14 enwik8</div></div><div><b=
r></div><div><u>Source code used for Lz4 and Erofs utils:</u><br></div><div=
><a href=3D"https://github.com/hsiangkao/erofs-utils">https://github.com/hs=
iangkao/erofs-utils</a></div><div><a href=3D"https://github.com/lz4/lz4">ht=
tps://github.com/lz4/lz4</a></div><div><br>-- <br><div dir=3D"ltr" class=3D=
"gmail_signature" data-smartmail=3D"gmail_signature">Thanks,<br>Saumya Prak=
ash Panda<br><br></div></div></div>

--000000000000c05781059c8cc695--
