Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AA33F2C32
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 14:34:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Grh0k6TfDz3d88
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 22:34:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=lutN4JU3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::12c;
 helo=mail-il1-x12c.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=lutN4JU3; dkim-atps=neutral
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Grh0B1VW9z3cLP
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 22:34:17 +1000 (AEST)
Received: by mail-il1-x12c.google.com with SMTP id u7so9374879ilk.7
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 05:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=JWCUufuuwhNarbqsGFPFj/uqXOuC4DDjcyui5VTRZhU=;
 b=lutN4JU3MlzsDojz3hHjI1LdCZ0Zx2i4KpDVcRDahTvPW3hx95WUj74gKzItp5mDCH
 zIiOIVkVCFkqWIyUgTWzPYwfCPbRYaG7Ayb+q6E1hR+XUgYzhZL8CS050CvT2+daat5L
 TfEXDvMP5Qr8kbfYC2KXPVQar52lLQAhZJDu65eMMHeeiGeRK8TTEFPeKQIXGACJixbp
 C0wZouv0C88iNbG/NtyjCB6uPxYdE03P27UDdUPF0qBCfxRZzJQCf8MugSBctpyCXLo6
 MR6wm5zbIBb+y3qa7+KwXJuhYwWEKaAAOcXGxtqx5TCoHkPixzDkseeHwgMGpuKq3wai
 rmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=JWCUufuuwhNarbqsGFPFj/uqXOuC4DDjcyui5VTRZhU=;
 b=U/pYG9GD1emgED+LPC9qvyS19NRWJtal80OMJ+VKkHncQQVL9VxABKtiqCC9k3g+Hc
 wo6vQEOo5B2A3Lur4AAwj6eyj0PnUtDYprPFB52Fdo6Exzul4W3EgrTcgZHEH1JuSqpF
 vmxyRoUSTSqA1ONsW/mlg777Xzo60yhXNJyBm5vCiHFDT5aKyZEkaoXxWAMgBdmepNpN
 3xsnOmh54lc9xa3YT/m2yXZ4/lpgohlRNzTc/m5qr/tyiFj7JSPmHrh051yCZiE6jnqe
 l+fjaAanvzShoFp0bxs91xK529UYW2gFsAjvWIt/s6kUl+NAKp9L9kYwwPRJXtEI5deh
 KrCQ==
X-Gm-Message-State: AOAM530AZ/Ox53nL0H3YG2svUz3KPxMGA8bw3Jnh0BuAHAnoZbjl4i3D
 NXg41tpJ7kRnE1lIodARK2TCdBO9MKP1Mio5iBgMoJqiHII=
X-Google-Smtp-Source: ABdhPJxIrn3EJJn5vWuYAdvi98s3XHjBggqaA+lc8qaxtyd+wyOMDOGPTqD77ZKt1wgo27jYOuAfeqN6dEOG1NtVEGY=
X-Received: by 2002:a92:dd12:: with SMTP id n18mr13852155ilm.180.1629462853592; 
 Fri, 20 Aug 2021 05:34:13 -0700 (PDT)
MIME-Version: 1.0
From: Igor Eisberg <igoreisberg@gmail.com>
Date: Fri, 20 Aug 2021 15:34:05 +0300
Message-ID: <CABjEcnGniBcadC4DDV4xCio8UmZyhSGWt+_gi_ESbYwoOQ2E0w@mail.gmail.com>
Subject: An issue with erofsfuse
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000902a0305c9fce2dc"
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

--000000000000902a0305c9fce2dc
Content-Type: text/plain; charset="UTF-8"

Hey there, getting straight to the point.
Our team is using Debian 10, in which erofs mounting is not supported and
we have no option of updating the kernel, nor do we have sudo permissions
on this server.

Our only choice is to use erofsfuse to mount an Android image (compression
was used on that image), for the sole purpose of extracting its contents to
another folder for processing.
Tried on Debian 10, pop_OS! and even the latest Kubuntu (where native
mounting is supported), but on all of them I could not copy files which are
compressed from the mounted image to another location (ext4 file system).

The error I'm getting is: "Operation not supported (95)"

Notes:
* Only extremely small (< 1 KB) files which are stored uncompressed are
copied successfully.
* Copying works perfectly when mounting the image with "sudo mount" on the
latest Kubuntu, so it has to be something with erofsfuse.

Anything you can do to help resolve this?

Best,
Igor.

--000000000000902a0305c9fce2dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hey there, getting straight to the point.=
<div>Our team is using Debian 10, in which erofs mounting is not supported =
and we have no option of updating the kernel, nor do we have sudo permissio=
ns on this server.</div><div><br></div><div>Our only choice is to use erofs=
fuse to mount an Android image (compression was used on that image), for th=
e sole purpose of extracting its contents to another folder for processing.=
</div><div>Tried on Debian 10, pop_OS! and even the latest Kubuntu (where n=
ative mounting is supported), but on all of them I could not copy files whi=
ch are compressed from the mounted image to another location (ext4 file sys=
tem).</div><div><br></div><div>The error I&#39;m getting is: &quot;Operatio=
n not supported (95)&quot;</div><div><br></div><div>Notes:</div><div>* Only=
 extremely small (&lt; 1 KB) files which are stored uncompressed are copied=
 successfully.</div><div>* Copying works perfectly when mounting the image =
with &quot;sudo mount&quot; on the latest Kubuntu, so it has to be somethin=
g with erofsfuse.</div><div><br></div><div>Anything=C2=A0you can do to help=
 resolve this?</div><div><br></div><div>Best,</div><div>Igor.</div></div></=
div>

--000000000000902a0305c9fce2dc--
