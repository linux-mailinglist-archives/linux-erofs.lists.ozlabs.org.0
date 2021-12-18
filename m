Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A087479831
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 03:35:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JG92N1kTDz305j
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 13:35:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=UCeWDaAd;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::131;
 helo=mail-il1-x131.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=UCeWDaAd; dkim-atps=neutral
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JG92J60FFz2ypK
 for <linux-erofs@lists.ozlabs.org>; Sat, 18 Dec 2021 13:35:50 +1100 (AEDT)
Received: by mail-il1-x131.google.com with SMTP id d14so3110109ila.1
 for <linux-erofs@lists.ozlabs.org>; Fri, 17 Dec 2021 18:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=BNPi3oZh0v+fMfO0ArAFItZSUyITFKfCJjvJRUP08a8=;
 b=UCeWDaAdlitY5NsC9/sI4Z2N8dHOZTnCkahBGhHlN9kCdESlZ4k501Nslia+4hniLm
 TqaQzF/0cbW/r3mdbmN4ZkjmyHGHKOrL1ERmhLEd5CzbMPhXTHvVLEBCGgFS3iUnjqgU
 YOh65Pkg4o9GAPd7AFrVmxHW4FWfUK2WOAn/VGXWPyAjjKxSnQgQWg3G5jjkpA5JL1oy
 RParozXesa1fg2hQRsIKUytHLc2ZD5kphCy1UWdgelPeQtrL9Ab3FsSSa+giIvwAZvBz
 3viZG0uVkc/Imvpw1X+FuHw0hvDLTqdm5rXNv+40K6xRX+Fi497Pz5x82NnI1UlRdvI0
 u7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=BNPi3oZh0v+fMfO0ArAFItZSUyITFKfCJjvJRUP08a8=;
 b=iBXT16tznFr+TqN5ofHcTCG8mAVCnOcsmi7km44dKj+nQ+w7Av1hQonggL/AXu4BGi
 a0LE+4lHs4OdoVe6BcG+iNk1j1bIwwaEX+3uW1L7EWvQ5Vq5GrbHQYgpOvo/Zb7ZHCCB
 dRA8B4q+l+qoZDGvk5ishzl1X7Xg7C9A30dYsLJAokaEBTwTwU7HJPphWruZDI/FI82i
 K0UVydifbZkUfRURRelW7z+BJkS12dQBLv4DOIBvCKCA8TF7Xm3wDnz1w1T9xRsvc26I
 iUpDVa//4wT4Wu1s8mBFuTTROiZxBqfN4gx+wnCsJsCbJvMQCmPuu4/7sgCVCvqfZHUZ
 i3Og==
X-Gm-Message-State: AOAM530/+ocfPA9LLFPVAfCDKR+Ln7a+Ueg4ftXGCModJUcltUmZyyZw
 tmmdOmUQR8kmbNn78T95lSBjmjTFOXhTGa+JCzTTnSlATXo=
X-Google-Smtp-Source: ABdhPJwEXRgD6QFHzIlOJLclO6v35u5adsO+1mFAtY+YvXJf4AZigBkPME7tuuXLkSKQHIqvsUp3xTvk6kE8SF20tng=
X-Received: by 2002:a05:6e02:1645:: with SMTP id
 v5mr3169167ilu.54.1639794947352; 
 Fri, 17 Dec 2021 18:35:47 -0800 (PST)
MIME-Version: 1.0
From: Igor Eisberg <igoreisberg@gmail.com>
Date: Sat, 18 Dec 2021 04:35:37 +0200
Message-ID: <CABjEcnET1aCa7yA3Vyk8RCBKK0d0wR_iPezr=N2jp6jRx6EB6w@mail.gmail.com>
Subject: erofs-utils: fix consistency + add NUL after root path
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000576e3e05d36283c4"
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

--000000000000576e3e05d36283c4
Content-Type: text/plain; charset="UTF-8"

From 8b209620abfbd8147a2c771cb0126dcca528e34f Mon Sep 17 00:00:00 2001
From: Igor Ostapenko <igoreisberg@gmail.com>
Date: Sat, 18 Dec 2021 04:30:17 +0200
Subject: erofs-utils: fix consistency + add NUL after root path

Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
---
 fsck/main.c | 2 +-
 lib/dir.c   | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index df4845d..30d0a1b 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -400,7 +400,7 @@ static int erofsfsck_check_inode(erofs_nid_t pnid,
erofs_nid_t nid)
  goto out;

  /* XXXX: the dir depth should be restricted in order to avoid loops */
- if ((inode.i_mode & S_IFMT) == S_IFDIR) {
+ if (S_ISDIR(inode.i_mode)) {
  struct erofs_dir_context ctx = {
  .flags = EROFS_READDIR_VALID_PNID,
  .pnid = pnid,
diff --git a/lib/dir.c b/lib/dir.c
index 340dce6..d5b8096 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -127,7 +127,7 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx,
bool fsck)
  erofs_off_t pos;
  char buf[EROFS_BLKSIZ];

- if ((dir->i_mode & S_IFMT) != S_IFDIR)
+ if (!S_ISDIR(dir->i_mode))
  return -ENOTDIR;

  ctx->flags &= ~EROFS_READDIR_ALL_SPECIAL_FOUND;
@@ -244,13 +244,14 @@ int erofs_get_pathname(erofs_nid_t nid, char *buf,
size_t size)
  };

  if (nid == root.nid) {
- if (size == 0) {
- erofs_err("get_pathname buffer not large enough: len 1, size %zd",
+ if (size < 2) {
+ erofs_err("get_pathname buffer not large enough: len 2, size %zd",
    size);
  return -ENOMEM;
  }

  buf[0] = '/';
+ buf[1] = '\0';
  return 0;
  }

-- 
2.30.2

--000000000000576e3e05d36283c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>From 8b209620abfbd8147a2c771cb0126dc=
ca528e34f Mon Sep 17 00:00:00 2001</div><div>From: Igor Ostapenko &lt;<a hr=
ef=3D"mailto:igoreisberg@gmail.com">igoreisberg@gmail.com</a>&gt;</div><div=
>Date: Sat, 18 Dec 2021 04:30:17 +0200</div><div>Subject: erofs-utils: fix =
consistency + add NUL after root path</div><div><br></div><div>Signed-off-b=
y: Igor Ostapenko &lt;<a href=3D"mailto:igoreisberg@gmail.com">igoreisberg@=
gmail.com</a>&gt;</div><div>---</div><div>=C2=A0fsck/main.c | 2 +-</div><di=
v>=C2=A0lib/dir.c=C2=A0 =C2=A0| 7 ++++---</div><div>=C2=A02 files changed, =
5 insertions(+), 4 deletions(-)</div><div><br></div><div>diff --git a/fsck/=
main.c b/fsck/main.c</div><div>index df4845d..30d0a1b 100644</div><div>--- =
a/fsck/main.c</div><div>+++ b/fsck/main.c</div><div>@@ -400,7 +400,7 @@ sta=
tic int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)</div><div>=
=C2=A0<span style=3D"white-space:pre">		</span>goto out;</div><div>=C2=A0</=
div><div>=C2=A0<span style=3D"white-space:pre">	</span>/* XXXX: the dir dep=
th should be restricted in order to avoid loops */</div><div>-<span style=
=3D"white-space:pre">	</span>if ((inode.i_mode &amp; S_IFMT) =3D=3D S_IFDIR=
) {</div><div>+<span style=3D"white-space:pre">	</span>if (S_ISDIR(inode.i_=
mode)) {</div><div>=C2=A0<span style=3D"white-space:pre">		</span>struct er=
ofs_dir_context ctx =3D {</div><div>=C2=A0<span style=3D"white-space:pre">	=
		</span>.flags =3D EROFS_READDIR_VALID_PNID,</div><div>=C2=A0<span style=
=3D"white-space:pre">			</span>.pnid =3D pnid,</div><div>diff --git a/lib/d=
ir.c b/lib/dir.c</div><div>index 340dce6..d5b8096 100644</div><div>--- a/li=
b/dir.c</div><div>+++ b/lib/dir.c</div><div>@@ -127,7 +127,7 @@ int erofs_i=
terate_dir(struct erofs_dir_context *ctx, bool fsck)</div><div>=C2=A0<span =
style=3D"white-space:pre">	</span>erofs_off_t pos;</div><div>=C2=A0<span st=
yle=3D"white-space:pre">	</span>char buf[EROFS_BLKSIZ];</div><div>=C2=A0</d=
iv><div>-<span style=3D"white-space:pre">	</span>if ((dir-&gt;i_mode &amp; =
S_IFMT) !=3D S_IFDIR)</div><div>+<span style=3D"white-space:pre">	</span>if=
 (!S_ISDIR(dir-&gt;i_mode))</div><div>=C2=A0<span style=3D"white-space:pre"=
>		</span>return -ENOTDIR;</div><div>=C2=A0</div><div>=C2=A0<span style=3D"=
white-space:pre">	</span>ctx-&gt;flags &amp;=3D ~EROFS_READDIR_ALL_SPECIAL_=
FOUND;</div><div>@@ -244,13 +244,14 @@ int erofs_get_pathname(erofs_nid_t n=
id, char *buf, size_t size)</div><div>=C2=A0<span style=3D"white-space:pre"=
>	</span>};</div><div>=C2=A0</div><div>=C2=A0<span style=3D"white-space:pre=
">	</span>if (nid =3D=3D root.nid) {</div><div>-<span style=3D"white-space:=
pre">		</span>if (size =3D=3D 0) {</div><div>-<span style=3D"white-space:pr=
e">			</span>erofs_err(&quot;get_pathname buffer not large enough: len 1, s=
ize %zd&quot;,</div><div>+<span style=3D"white-space:pre">		</span>if (size=
 &lt; 2) {</div><div>+<span style=3D"white-space:pre">			</span>erofs_err(&=
quot;get_pathname buffer not large enough: len 2, size %zd&quot;,</div><div=
>=C2=A0<span style=3D"white-space:pre">				</span>=C2=A0 size);</div><div>=
=C2=A0<span style=3D"white-space:pre">			</span>return -ENOMEM;</div><div>=
=C2=A0<span style=3D"white-space:pre">		</span>}</div><div>=C2=A0</div><div=
>=C2=A0<span style=3D"white-space:pre">		</span>buf[0] =3D &#39;/&#39;;</di=
v><div>+<span style=3D"white-space:pre">		</span>buf[1] =3D &#39;\0&#39;;</=
div><div>=C2=A0<span style=3D"white-space:pre">		</span>return 0;</div><div=
>=C2=A0<span style=3D"white-space:pre">	</span>}</div><div>=C2=A0</div><div=
>--=C2=A0</div><div>2.30.2</div><div><br></div></div></div>

--000000000000576e3e05d36283c4--
