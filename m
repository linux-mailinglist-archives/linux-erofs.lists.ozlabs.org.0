Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED0D6C1B1
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2019 21:48:04 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45pnqk0NPvzDqH2
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 05:48:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="b2qLkGUN"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45pnqc6vfczDqDN
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2019 05:47:56 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id w20so27288818edd.2
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2019 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=cA7ciaHpY0NWS6BILwkaF3zJbP8FEEfUGD527eGuwws=;
 b=b2qLkGUNW7mRKZiNKn7UKid3m2oNRdCJSTNRfr8aaYDIIiHV4Z6aY051wOpy7wZp+K
 HwDgR13KQzaHJaBWIl3r5ZH7UKBBSf9abdwPl8T2jHDJUyKC4KGPsB7SCpOvfofkrTOZ
 ePh0TBwZA/ov+N54wODuveUHoRYbvQdHjWF6pP0QcP+kX4vwRe2wLUJR12dR/l+VsJPt
 1zOwtRscUNlhz2piXHjF/kK6MQfeWgUwJ7hk0Y5QBIxpccTjGw7iUEAX9Cj7vEgJfj6I
 nJEFcHyvfAPYYrQvP5cqOIG4/+eiBG7iMDfcPz7OlNUVPlA7cqtxmEaIE/tAu0edUoz6
 TOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=cA7ciaHpY0NWS6BILwkaF3zJbP8FEEfUGD527eGuwws=;
 b=nPMJjnEKAMjWsIf8lBPTbGMYSICnl5dIgmPZ7sUq+X01VBEKvamQJpR57DB2hrnVE9
 vXAD2v94dhFu4tKblZ3Yoj3Ei1sqmq3Pq49jpB9B72VNATjvLimXkecQpmANXRatHAd4
 qFf+VfpxHcm6XPUnF17QQ1GF/qh1ZdJLcijBAzZNLFCW5uyyv3KS3oAeTY00xutvK6SS
 Iq8XBpBmDwXnYR8ageacyp1K7jZNdQA1/xRDCI4znxRdj1JM9XhX3Sa2mMTkvF13i0+c
 yId4ogolaIUvPWEfZLc0HRA+3TKKSLewohpNBNUxa6If9cMzGv6b/OilNrpD55iV8BwT
 oLAw==
X-Gm-Message-State: APjAAAU+wGQx+am0zq4RfNTSCrt2AJG/YpjKXXj0sy2nb/3M87xHHDUb
 bgG3OM6ZHwAEWdTUS/NTX1+c7O/Uqizmm6NWlHiLWlyZ
X-Google-Smtp-Source: APXvYqzx9cQlzP0uP47ZjyxjCv6DBzx5DbuKr6F7X8kdCmhBMyFg0vKNw96oT36JPToAYvw+HHpTmcAiNYWyBcdWfW0=
X-Received: by 2002:a50:a942:: with SMTP id m2mr36791301edc.73.1563392866931; 
 Wed, 17 Jul 2019 12:47:46 -0700 (PDT)
MIME-Version: 1.0
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Thu, 18 Jul 2019 01:17:35 +0530
Message-ID: <CAGu0czSPMpsmWxxmBYk96t3ixO=_vnNXXveZNzR-dhQSg_mtfg@mail.gmail.com>
Subject: erofs compilation failure.
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000007a5978058de5c428"
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

--0000000000007a5978058de5c428
Content-Type: text/plain; charset="UTF-8"

Hi All,

I hope this is the correct channel to talk about this issue.
I am trying to compile erofs with latest kernel source as follows:

ps@ps:~/linux/drivers/staging/erofs$ pwd
/home/ps/linux/drivers/staging/erofs
ps@ps:~/linux/drivers/staging/erofs$  make -C ~/linux  M=`pwd`
make: Entering directory '/home/ps/linux'
make[1]: *** No rule to make target
'/home/ps/linux/drivers/staging/erofs/super.o', needed by
'/home/ps/linux/drivers/staging/erofs/erofs.o'.  Stop.
Makefile:1612: recipe for target
'_module_/home/ps/linux/drivers/staging/erofs' failed
make: *** [_module_/home/ps/linux/drivers/staging/erofs] Error 2
make: Leaving directory '/home/ps/linux'

I ran the above make command under strace, it looks like make is not able
to locate dependent '.o' files, e.g data.o, super.o etc. But, its should
compile those dependencies first ? In the strace I cannot see gcc invoked
on this '.c' files.

Is this the correct way of compiling the source ?
Help appreciated. !

Thank you.
--Pratik.

--0000000000007a5978058de5c428
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi All,</div><div><br></div><div>I hope this is the c=
orrect channel to talk about this issue.</div><div>I am trying to compile e=
rofs with latest kernel source as follows:</div><div><br></div><div>ps@ps:~=
/linux/drivers/staging/erofs$ pwd<br>/home/ps/linux/drivers/staging/erofs<b=
r>ps@ps:~/linux/drivers/staging/erofs$ =C2=A0make -C ~/linux=C2=A0 M=3D`pwd=
`</div><div>make: Entering directory &#39;/home/ps/linux&#39;<br><span styl=
e=3D"background-color:rgb(255,153,0)"><span style=3D"background-color:rgb(2=
43,243,243)"><span style=3D"color:rgb(153,0,255)">make[1]: *** No rule to m=
ake target &#39;/home/ps/linux/drivers/staging/erofs/super.o&#39;, needed b=
y &#39;/home/ps/linux/drivers/staging/erofs/erofs.o&#39;.=C2=A0 Stop</span>=
</span>.</span><br>Makefile:1612: recipe for target &#39;_module_/home/ps/l=
inux/drivers/staging/erofs&#39; failed<br>make: *** [_module_/home/ps/linux=
/drivers/staging/erofs] Error 2<br>make: Leaving directory &#39;/home/ps/li=
nux&#39;</div><div><br></div><div>I ran the above make command under strace=
, it looks like make is not able to locate dependent &#39;.o&#39; files, e.=
g data.o, super.o etc. But, its should compile those dependencies first ? I=
n the strace I cannot see gcc invoked on this &#39;.c&#39; files. <br></div=
><div><br></div><div>Is this the correct way of compiling the source ? <br>=
</div><div>Help appreciated. !</div><div><br></div><div>Thank you.<br></div=
><div>--Pratik.<br></div><div><br></div></div>

--0000000000007a5978058de5c428--
