Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6659D586D20
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Aug 2022 16:42:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LxLSr3t84z2ypf
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Aug 2022 00:42:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=CidRb8AO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=jnhuang95@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=CidRb8AO;
	dkim-atps=neutral
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LxLSj716Wz2y27
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Aug 2022 00:42:44 +1000 (AEST)
Received: by mail-ej1-x62f.google.com with SMTP id tl27so2910436ejc.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 01 Aug 2022 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc;
        bh=TM3wHl2zIiH+doyf4Cq9j4NhGaV5/aPn5dvdANtCHAw=;
        b=CidRb8AOUXImsPDkLHU1CPcZyEKk7wKK8VCye+Vne3gtAhPKNcCRcNHaR1bjtJQ5ba
         5d9XmiJawoLLKuZ+sYrrHnzuRfq7K6vYufbq05Svy/akyzfdELtmC+GYDtolvZs28oO+
         RdfqklHsEFss/Gh4Knl8hcFVXQkyq6pP2xyESeHBKdhlDnvbPedjP5A0MOmP0OimP/XF
         /YLBCsLCMaz4Ulnxd/93S5HoNk8zFBzudzpBdS7wJN9SERI0DjCd/Au96eQBATBv7jpk
         1UidW7Zx9rWQB/9tczGU6S9F89mudg4H4ZwW+5JjZSZ7MsROH5lJ30UrKdtQ+SZlSS9M
         rFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TM3wHl2zIiH+doyf4Cq9j4NhGaV5/aPn5dvdANtCHAw=;
        b=sBx9Ui9aEwARxWQjP54AEOxD25ikMGOf5lvconBtUQm3sliChX0E+LXGmLjHPVN/qa
         a8pBbOfzcxJTgOgZzex7L7t6utmuYgWjX+mbmWVjS66j9KXyyB+7AzJ6VETa5G4J9f8B
         4ZiSrfbJKWdEcvvBQnIuONkLjqy/9KJI5SNIOe7uZXkiDm5hC1kkNAoM/VELlu3G+0Kl
         01y49BLrNdSiASDKiMo/FpIeCivM3i2HjhkDhU0bP/21XbYlo5Z6gWS7tU1IO6aFUayo
         P2a9k6XIXOGgv34A9t53u6dRrHlgvvBZykqK2mYwC5r5qF16J5ukme7iTSfWu9/pXed2
         ehRQ==
X-Gm-Message-State: ACgBeo2yv4jZueE2eW4JVXT4Q5/RkjWkLfPsL0LAwmoz51in91q9qliT
	Ep4tQx2AZQMoM1sr3OU1YGpn58uVjPEcHjpG+ek=
X-Google-Smtp-Source: AA6agR5AFIWJ+E9Nj7vXiMFNaVVtqhK4KayE7m6RflmbfS6jLCwELxMyByfqsKKq/7fAwYMbbMNvptm6gxpfTSFDWd0=
X-Received: by 2002:a17:906:cc4a:b0:730:850f:5cb5 with SMTP id
 mm10-20020a170906cc4a00b00730850f5cb5mr4117016ejb.658.1659364957593; Mon, 01
 Aug 2022 07:42:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:8395:b0:20:75fc:d540 with HTTP; Mon, 1 Aug 2022
 07:42:36 -0700 (PDT)
In-Reply-To: <20220801132711.353837-1-heinrich.schuchardt@canonical.com>
References: <20220801132711.353837-1-heinrich.schuchardt@canonical.com>
From: Huang Jianan <jnhuang95@gmail.com>
Date: Mon, 1 Aug 2022 22:42:36 +0800
Message-ID: <CAJfKizpC5tqeXavYtLQG413U3m7i71BHYDvWs1PGOFSwBEkLJw@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs/erofs: silence erofs_probe()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Type: multipart/alternative; boundary="000000000000d9a54905e52f029d"
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
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000d9a54905e52f029d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2022=E5=B9=B48=E6=9C=881=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=80=EF=
=BC=8CHeinrich Schuchardt <heinrich.schuchardt@canonical.com> =E5=86=99=E9=
=81=93=EF=BC=9A

> fs_set_blk_dev() probes all file-systems until it finds one that matches
> the volume. We do not expect any console output for non-matching
> file-systems.
>
> Convert error messages in erofs_read_superblock() to debug output.
>
> Fixes: 830613f8f5bb ("fs/erofs: add erofs filesystem support")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v2:
>         keep erofs_err() for block size mismatch
> ---
>  fs/erofs/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


Looks good to me.
Reviewed-by: Huang Jianan <jnhuang95@gmail.com>

Thanks,
Jianan

>
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 4cca322b9e..8277d9b53f 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -65,14 +65,14 @@ int erofs_read_superblock(void)
>
>         ret =3D erofs_blk_read(data, 0, 1);
>         if (ret < 0) {
> -               erofs_err("cannot read erofs superblock: %d", ret);
> +               erofs_dbg("cannot read erofs superblock: %d", ret);
>                 return -EIO;
>         }
>         dsb =3D (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
>
>         ret =3D -EINVAL;
>         if (le32_to_cpu(dsb->magic) !=3D EROFS_SUPER_MAGIC_V1) {
> -               erofs_err("cannot find valid erofs superblock");
> +               erofs_dbg("cannot find valid erofs superblock");
>                 return ret;
>         }
>
> --
> 2.36.1
>
>

--000000000000d9a54905e52f029d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=E5=9C=A8 2022=E5=B9=B48=E6=9C=881=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=
=80=EF=BC=8CHeinrich Schuchardt &lt;<a href=3D"mailto:heinrich.schuchardt@c=
anonical.com">heinrich.schuchardt@canonical.com</a>&gt; =E5=86=99=E9=81=93=
=EF=BC=9A<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">fs_set_blk_dev() probes all fil=
e-systems until it finds one that matches<br>
the volume. We do not expect any console output for non-matching<br>
file-systems.<br>
<br>
Convert error messages in erofs_read_superblock() to debug output.<br>
<br>
Fixes: 830613f8f5bb (&quot;fs/erofs: add erofs filesystem support&quot;)<br=
>
Signed-off-by: Heinrich Schuchardt &lt;<a href=3D"mailto:heinrich.schuchard=
t@canonical.com">heinrich.schuchardt@<wbr>canonical.com</a>&gt;<br>
Reviewed-by: Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org">sjg@chromi=
um.org</a>&gt;<br>
---<br>
v2:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 keep erofs_err() for block size mismatch<br>
---<br>
=C2=A0fs/erofs/super.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)</blockquote><div><br>=
</div><div>Looks good to me.</div><div>Reviewed-by: Huang Jianan &lt;<a hre=
f=3D"mailto:jnhuang95@gmail.com">jnhuang95@gmail.com</a>&gt;=C2=A0</div><di=
v><br></div><div>Thanks,</div><div>Jianan=C2=A0=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
<br>
diff --git a/fs/erofs/super.c b/fs/erofs/super.c<br>
index 4cca322b9e..8277d9b53f 100644<br>
--- a/fs/erofs/super.c<br>
+++ b/fs/erofs/super.c<br>
@@ -65,14 +65,14 @@ int erofs_read_superblock(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D erofs_blk_read(data, 0, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;can=
not read erofs superblock: %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_dbg(&quot;can=
not read erofs superblock: %d&quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dsb =3D (struct erofs_super_block *)(data + ERO=
FS_SUPER_OFFSET);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (le32_to_cpu(dsb-&gt;magic) !=3D EROFS_SUPER=
_MAGIC_V1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;can=
not find valid erofs superblock&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_dbg(&quot;can=
not find valid erofs superblock&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0<br>
-- <br>
2.36.1<br>
<br>
</blockquote>

--000000000000d9a54905e52f029d--
