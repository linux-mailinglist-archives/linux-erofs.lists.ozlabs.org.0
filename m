Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C2478D44
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Dec 2021 15:20:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JFrjc50vHz3c7v
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 01:20:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=HRaFI05E;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d36;
 helo=mail-io1-xd36.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=HRaFI05E; dkim-atps=neutral
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JFrjX4t7lz2xtC
 for <linux-erofs@lists.ozlabs.org>; Sat, 18 Dec 2021 01:20:14 +1100 (AEDT)
Received: by mail-io1-xd36.google.com with SMTP id x6so3047920iol.13
 for <linux-erofs@lists.ozlabs.org>; Fri, 17 Dec 2021 06:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=kLVK90eNRhY+/p9kLXQSNU084f3NQVG5+Gb42oRRNwI=;
 b=HRaFI05E3+kMBh4OjqPxJf1hAX71QyhSkpn07i47TkiiVmUzrtZVj0Hdu9O6BbNXxn
 kfpPsVw50crbTU4rDbZXiNTbxTl1IS72Au4om6B1owY2U4IBH/dvcSh0j8v6DBrhieC2
 rcBdd6nxDNaHv7BB3HWESnBf++hQ9yEFCXJC+4cOqQDEe+jVR4ddyXVGbOxhkmFRBeM4
 jgl+JGe+51NBj+0vmxrdPHq+EmvF577KfHQU8ojki4idozr8w2uKaF5dBJ5iEFahtWFV
 a6qhOh1VFnSzPtKGQFC6s3LfwHkR4CAKFYaHNpAKDU2gFJmPirZu0qUUT3HCQbVHFhvZ
 FKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=kLVK90eNRhY+/p9kLXQSNU084f3NQVG5+Gb42oRRNwI=;
 b=rK6SZ1ydiPq6Ec/Kf4FlZTo1vC5CYhc9IScPMixceDYt4SozMPaEl0Mx1Aoiseoe0/
 B2U/lw5ud0qS3R8rkASva45ORf71dAhwf66tYBhS247zuhHxM6fZFgs/kgLdGjhWX7y1
 4I3yLNqiC14B1q3ge9J408zkVHQm4FMwQY1eqRttnsgjZcjopF12qDDDu4uIEQFC+Jx/
 QAWxE+PWXy+wRKHx8+v0Ba6ltvAYlQPE48Mt4ZjMdgCeirD2Nh31+vIFOwyZSLnwReIZ
 SbPQtH6OspYxesnqJK/xUu8faW3R6YhKobJb4yhrRKWgiSgsTmvksardkC6wlrYsbzgo
 T+uw==
X-Gm-Message-State: AOAM531E6z9OpvLaQBpkUGRgg8W3Wgtd4D0u6CdryELz48xGDZSGhaBd
 ukx1KWBfvoer7PMTWa0966Js5paMYWZ7rTk8dsQtuMCF
X-Google-Smtp-Source: ABdhPJzaqV8ncuz69mGrtOhcMDmKMn2Jg74WmsnrJI9AQO2ZoWndPmuqv9OqMH7SMDvyxu+SoCwBWF8nXm31JCCMsPk=
X-Received: by 2002:a6b:b2c1:: with SMTP id b184mr1675666iof.24.1639750811052; 
 Fri, 17 Dec 2021 06:20:11 -0800 (PST)
MIME-Version: 1.0
References: <CABjEcnE84FNBgiHFk6Q+V3d-4L-93bUFDkdfN4ftPX19kpC=ww@mail.gmail.com>
In-Reply-To: <CABjEcnE84FNBgiHFk6Q+V3d-4L-93bUFDkdfN4ftPX19kpC=ww@mail.gmail.com>
From: Igor Eisberg <igoreisberg@gmail.com>
Date: Fri, 17 Dec 2021 16:20:01 +0200
Message-ID: <CABjEcnEnYhCSXvbhtas4J-vgBker-U1+FqjJ=Hvz-MOp--kJrw@mail.gmail.com>
Subject: Re: erofs-utils: lib: add API to get pathname of EROFS inode
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/mixed; boundary="0000000000009d072a05d3583c1e"
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

--0000000000009d072a05d3583c1e
Content-Type: multipart/alternative; boundary="0000000000009d072805d3583c1c"

--0000000000009d072805d3583c1c
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Dec 2021 at 14:30, Igor Eisberg <igoreisberg@gmail.com> wrote:

>
>

--0000000000009d072805d3583c1c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, 17 Dec 2021 at 14:30, Igor Eisberg &lt;<a href=
=3D"mailto:igoreisberg@gmail.com">igoreisberg@gmail.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><br=
></div>
</blockquote></div>

--0000000000009d072805d3583c1c--

--0000000000009d072a05d3583c1e
Content-Type: application/octet-stream; 
	name="0002-dump-remove-unused-function.patch"
Content-Disposition: attachment; 
	filename="0002-dump-remove-unused-function.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kxahacct0>
X-Attachment-Id: f_kxahacct0

RnJvbSAwMWYzOGZmYjMzYTgxMDhlZjQyNjA3ODQzZDc3YWU4YjU1NWVlZmNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBJZ29yIE9zdGFwZW5rbyA8aWdvcmVpc2JlcmdAZ21haWwuY29t
PgpEYXRlOiBGcmksIDE3IERlYyAyMDIxIDE2OjE2OjU0ICswMjAwClN1YmplY3Q6IGVyb2ZzLXV0
aWxzOiBkdW1wOiByZW1vdmUgdW51c2VkIGZ1bmN0aW9uCgplcm9mc19jaGVja2RpcmVudCBpcyBu
byBsb25nZXIgbmVlZGVkLgoKU2lnbmVkLW9mZi1ieTogSWdvciBPc3RhcGVua28gPGlnb3JlaXNi
ZXJnQGdtYWlsLmNvbT4KLS0tCiBkdW1wL21haW4uYyB8IDMxIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kdW1wL21haW4uYyBiL2R1bXAvbWFpbi5jCmluZGV4IDNjM2NjM2YuLjgzZDYyODAgMTAwNjQ0
Ci0tLSBhL2R1bXAvbWFpbi5jCisrKyBiL2R1bXAvbWFpbi5jCkBAIC0yOTcsMzcgKzI5Nyw2IEBA
IHN0YXRpYyBpbnQgZXJvZnNkdW1wX3JlYWRkaXIoc3RydWN0IGVyb2ZzX2Rpcl9jb250ZXh0ICpj
dHgpCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbmxpbmUgaW50IGVyb2ZzX2NoZWNrZGlyZW50
KHN0cnVjdCBlcm9mc19kaXJlbnQgKmRlLAotCQlzdHJ1Y3QgZXJvZnNfZGlyZW50ICpsYXN0X2Rl
LAotCQl1MzIgbWF4c2l6ZSwgY29uc3QgY2hhciAqZG5hbWUpCi17Ci0JaW50IGRuYW1lX2xlbjsK
LQl1bnNpZ25lZCBpbnQgbmFtZW9mZiA9IGxlMTZfdG9fY3B1KGRlLT5uYW1lb2ZmKTsKLQllcm9m
c19uaWRfdCBuaWQgPSBsZTY0X3RvX2NwdShkZS0+bmlkKTsKLQotCWlmIChuYW1lb2ZmIDwgc2l6
ZW9mKHN0cnVjdCBlcm9mc19kaXJlbnQpIHx8Ci0JCQluYW1lb2ZmID49IFBBR0VfU0laRSkgewot
CQllcm9mc19lcnIoImludmFsaWQgZGVbMF0ubmFtZW9mZiAldSBAIG5pZCAlbGx1IiwKLQkJCQlu
YW1lb2ZmLCBuaWQgfCAwVUxMKTsKLQkJcmV0dXJuIC1FRlNDT1JSVVBURUQ7Ci0JfQotCi0JZG5h
bWVfbGVuID0gKGRlICsgMSA+PSBsYXN0X2RlKSA/IHN0cm5sZW4oZG5hbWUsIG1heHNpemUgLSBu
YW1lb2ZmKSA6Ci0JCQkJbGUxNl90b19jcHUoZGVbMV0ubmFtZW9mZikgLSBuYW1lb2ZmOwotCS8q
IGEgY29ycnVwdGVkIGVudHJ5IGlzIGZvdW5kICovCi0JaWYgKG5hbWVvZmYgKyBkbmFtZV9sZW4g
PiBtYXhzaXplIHx8Ci0JCQlkbmFtZV9sZW4gPiBFUk9GU19OQU1FX0xFTikgewotCQllcm9mc19l
cnIoImJvZ3VzIGRpcmVudCBAIG5pZCAlbGx1IiwgbmlkIHwgMFVMTCk7Ci0JCURCR19CVUdPTigx
KTsKLQkJcmV0dXJuIC1FRlNDT1JSVVBURUQ7Ci0JfQotCWlmIChkZS0+ZmlsZV90eXBlID49IEVS
T0ZTX0ZUX01BWCkgewotCQllcm9mc19lcnIoImludmFsaWQgZmlsZSB0eXBlICVsbHUiLCBuaWQg
fCAwVUxMKTsKLQkJcmV0dXJuIC1FRlNDT1JSVVBURUQ7Ci0JfQotCXJldHVybiBkbmFtZV9sZW47
Ci19Ci0KIHN0YXRpYyBpbnQgZXJvZnNkdW1wX21hcF9ibG9ja3Moc3RydWN0IGVyb2ZzX2lub2Rl
ICppbm9kZSwKIAkJc3RydWN0IGVyb2ZzX21hcF9ibG9ja3MgKm1hcCwgaW50IGZsYWdzKQogewot
LSAKMi4zMC4yCgo=
--0000000000009d072a05d3583c1e--
