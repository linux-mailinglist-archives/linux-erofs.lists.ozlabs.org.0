Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1243C852
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 13:12:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfQxv4xcXz2yL7
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 22:12:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ERPF61OA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::432;
 helo=mail-wr1-x432.google.com; envelope-from=t.i.ivanov@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=ERPF61OA; dkim-atps=neutral
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfQxq1GPbz2xDf
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 22:11:57 +1100 (AEDT)
Received: by mail-wr1-x432.google.com with SMTP id d10so3541696wrb.1
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 04:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=PA9G5SuG3ZrRc291O92NOmb72d6gZhPyMJb11hAQthw=;
 b=ERPF61OAjEBo5C8Z4GKi9Nq2B6K+JV9yjcbqGiMnz8xkZSM6CA0luMpib/9Pe+gxrh
 qXWBduizzQOeSZYrUTQxGcA85avfrjfvsAus2wlAbJHbW+oK1n3oj6Ff+t20CcqdsmHB
 0UPKMWPPBXZG754TJTCc0+jjWn4QxOMgfMXCLpSyDsQTNE4ikZUDPqyflmxWSgqGtVkr
 kJhb+al91fcE0LEN/O1sdiu+HbJ0IbFGKbet2QeJW6JxQuQq3TNFNGd7jowId2WgDL0e
 ZIcEZ7OfhZ6eVcu8kfNtiBZTSYwfWB1EJSQxhiy5V7Z6c6xpnAADvjSasn4bDSm1Fw2j
 avNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=PA9G5SuG3ZrRc291O92NOmb72d6gZhPyMJb11hAQthw=;
 b=RXUcuYUoqa+fAn1hMEkumSbLEmL8EH4PHLzc2uXfZ+GrUzF7UflsL/zO1EfdAHL7CC
 uqoEWsJglgrUKpG+T8ZQZShRVD99ktbSexVJEULXL5NV6N1aPFtmsFNkvC4OnScmc7PJ
 F4dOU3K1Z4ryBASqAEZsIXIBpIgtjsYQMp78CFLo36tMx7ndkKFJvOU3XEMUIF++IaV4
 BJ9dUloVCKwmcSnYY5FEuWOfIcCSgStB0YPWJC3wfh5QeTiv5OrBy9v6TqHoQjtTadmd
 vA/6Qbyi5gKyPIZBeGyJwlmYV6XsOP4W5o4jUAeDk5OPHPC5jRoAB9AYNgUBDhcyDD3R
 XqtA==
X-Gm-Message-State: AOAM533NMFTb9/OD29HBeqM0yhg9W1nfSRGcMWf4oOJEuAdc0dUxu8cb
 LzJpPydXi4ZGkduwcdq1j8Fa376YqUdYtZoivrs8eRss
X-Google-Smtp-Source: ABdhPJzt3SK0Mej9FuN7ejWkLk4dwsqUTrpteGku+k5n7c7cLF0KyHx9eIzybNyqOvBA/jXAPIOlqWLyQtP6iw/KB7g=
X-Received: by 2002:adf:f202:: with SMTP id p2mr1918585wro.93.1635333110471;
 Wed, 27 Oct 2021 04:11:50 -0700 (PDT)
MIME-Version: 1.0
From: Todor Ivanov <t.i.ivanov@gmail.com>
Date: Wed, 27 Oct 2021 14:11:24 +0300
Message-ID: <CAOv4OrXs9-4o0JvCdSus=WBjPqUbm+YES_QrsuXkv13dt7SKjQ@mail.gmail.com>
Subject: Question about mkfs.erofs and reproducible builds
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000239ff505cf53a910"
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

--000000000000239ff505cf53a910
Content-Type: text/plain; charset="UTF-8"

        Hello,

        We are trying to replace squashfs with erofs and face an issue with
reproducing the build from one and the same source folder. The source
folder is "/etc" actually taken from an offline ubuntu 20.04 image and
mounted as read-only.
        I managed to narrow down the scope and it turns out that the issue
is when you have a file starting with "." (dot) in this folder. I.e.:

etc/.anyfilename

If I remove this file the erofs image of "etc" is reproducible (-T and -U
are used as well)

The issue is somehow related to the other 76 subfolders of etc and this
file starting with dot. For example if I create such .anyfilename in usr or
var, there is no issue. Also if I create this file under
etc/xdg/.anyfilename, this is fine as well.
I also tried with etc from debian10 and the result is the same. Removing
any file that starts with dot directly under etc, makes the erofs build
reproducible.
Do you have any advice on this?

Regards,
Todor

--000000000000239ff505cf53a910
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hello,</di=
v><div><br></div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 We are try=
ing to replace squashfs with erofs and face an issue with reproducing the b=
uild from one and the same source folder. The source folder is &quot;/etc&q=
uot; actually taken from an offline ubuntu 20.04 image and mounted as read-=
only.</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I managed to nar=
row down the scope and it turns out that the issue is when you have a file =
starting with &quot;.&quot; (dot) in this folder. I.e.:</div><div><br></div=
><div>etc/.anyfilename<br></div><div><br></div><div>If I remove this file t=
he erofs image of &quot;etc&quot; is reproducible (-T and -U are used as we=
ll)<br><br></div><div>The issue is somehow related to the other 76 subfolde=
rs of etc and this file starting with dot. For example if I create such .an=
yfilename in usr or var, there is no issue. Also if I create this file unde=
r etc/xdg/.anyfilename, this is fine as well.</div><div>I also tried with e=
tc from debian10 and the result is the same. Removing any file that starts =
with dot directly under etc, makes the erofs build reproducible.</div><div>=
Do you have any advice on this?<br></div><div><br></div><div>Regards,</div>=
<div>Todor<br></div></div>

--000000000000239ff505cf53a910--
