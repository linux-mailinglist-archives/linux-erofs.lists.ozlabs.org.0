Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EC671A119
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jun 2023 16:56:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QX8N80V7Zz3dt7
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 00:56:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1685631384;
	bh=btMrIcorx9mgmBaOTCB52sBOLyGKYvIHwIq6+6cKAqM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=NT5am9of7IG+ywoGtcwUfe31zBldRWq7tvUsYmg5Fn2ys69lV5SiVwkv8vjwA2/Zy
	 xII9PQVFZCh7kq+qvQzIVLu+xE6d7liVe4MFmAMFUOBmOWckYikcwcYeULgBkxsORm
	 x//gG/ns8gmratBgev7EJm3D3Ri54w6jETpWIwJRUSqCZaT7EZWYT2PxS2lJff7t+6
	 M37xFylRbRj+TnUHd2+g+YJ2N5tWsG9UnJsMoAfUmiv3s/sOQ9JbI3ydQbJnIasorH
	 K+MLKUaJFEyXlatMlnH7QeLPOpNonRahPfY7k8Nd9Y4bev5ssr6Hlwzp0RpxjyN8vq
	 tBVm77xqVR/vg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com; envelope-from=zhangkelvin@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=SOb5npxw;
	dkim-atps=neutral
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QX8N20xPMz3cdK
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jun 2023 00:56:17 +1000 (AEST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1a86cdec6so1525191fa.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Jun 2023 07:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631369; x=1688223369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btMrIcorx9mgmBaOTCB52sBOLyGKYvIHwIq6+6cKAqM=;
        b=KAF9vJJluPiF7A/eMKkOe86O8O3sJi+uOBmXpHLQydBowtEDhU4s5BXefklHQKZRpU
         e77frJjg1/OHQgyRAZljvD3bwoGY+ZxM/F/5/ihq/zl+S4gRfrPtyqvCw4m/UlylR630
         VTje2P50FYmKLxcmlmfPLbUj594the1q1wfUmi1QHgM8zLJsvaJihbbzfNAS2PoZjbv8
         Y7up+uFyfm2Ujee1Ar13OUbXQL7ui759UrP7+17N5fRZUZFlrZDsPp1kRW5FnLiX4X4D
         P3xje6TPOpXVcVcG86brI9d0BOTP3M1lOfwCKmGyu2QH+nElNOtkLhH8W/bmmS08we+a
         /zoQ==
X-Gm-Message-State: AC+VfDy6W/W1282c7bKHCxwDZ3dqCMbKXz8EzRqlxKFIBzQNXEtMKA9c
	PxQSVCddWWCt2RH9c8Rpq+4VZBoDhvt7MR2VHuHfUF0jcigs6s9G9bs=
X-Google-Smtp-Source: ACHHUZ6P9Z/OvZ5J7emM6ZUVdGSnyX8fMpVuuRS/nt9Eh4jQIlfrhvagaL9IXzOz0sGj0cACfIpqOblHZJ4OoRi0RsE=
X-Received: by 2002:a2e:6801:0:b0:2af:2871:9a50 with SMTP id
 c1-20020a2e6801000000b002af28719a50mr4898147lja.47.1685631369060; Thu, 01 Jun
 2023 07:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <036ee477-af3c-14dd-8311-b9117f056542@linux.alibaba.com> <20230601145359.103536-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20230601145359.103536-1-hsiangkao@linux.alibaba.com>
Date: Thu, 1 Jun 2023 10:55:57 -0400
Message-ID: <CAOSmRzjB2mM9XnVGCyS8NhJuGtpjwFi4T3=cpYpJq6TmGj68bA@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: support detecting maximum block size
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000fa10a305fd12a2e4"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000fa10a305fd12a2e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good to me, please merge this patch

On Thu, Jun 1, 2023 at 10:54=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com>
wrote:

> Previously PAGE_SIZE was actually unset for most cases so that it was
> always hard-coded 4096.
>
> In order to set EROFS_MAX_BLOCK_SIZE correctly, let's detect the real
> page size when configuring and get rid of PAGE_SIZE.
>
> Cc: Kelvin Zhang <zhangkelvin@google.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> change since v1:
>  - get rid of PAGE_SIZE (Kelvin);
>
>  configure.ac             | 38 ++++++++++++++++++++++++++++++++++++++
>  include/erofs/internal.h | 10 ++--------
>  lib/namei.c              |  2 +-
>  mkfs/main.c              |  4 ++--
>  4 files changed, 43 insertions(+), 11 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 4dbe86f..2ade490 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -59,6 +59,8 @@ AC_DEFUN([EROFS_UTILS_PARSE_DIRECTORY],
>   fi
>  ])
>
> +AC_ARG_VAR([MAX_BLOCK_SIZE], [The maximum block size which erofs-utils
> supports])
> +
>  AC_ARG_ENABLE([debug],
>      [AS_HELP_STRING([--enable-debug],
>                      [enable debugging mode @<:@default=3Dno@:>@])],
> @@ -202,6 +204,35 @@ AC_CHECK_FUNCS(m4_flatten([
>         tmpfile64
>         utimensat]))
>
> +# Detect maximum block size if necessary
> +AS_IF([test "x$MAX_BLOCK_SIZE" =3D "x"], [
> +  AC_CACHE_CHECK([sysconf (_SC_PAGESIZE)], [erofs_cv_max_block_size],
> +               AC_RUN_IFELSE([AC_LANG_PROGRAM(
> +[[
> +#include <unistd.h>
> +#include <stdio.h>
> +]],
> +[[
> +    int result;
> +    FILE *f;
> +
> +    result =3D sysconf(_SC_PAGESIZE);
> +    if (result < 0)
> +       return 1;
> +
> +    f =3D fopen("conftest.out", "w");
> +    if (!f)
> +       return 1;
> +
> +    fprintf(f, "%d", result);
> +    fclose(f);
> +    return 0;
> +]])],
> +                             [erofs_cv_max_block_size=3D`cat conftest.ou=
t`],
> +                             [],
> +                             []))
> +], [erofs_cv_max_block_size=3D$MAX_BLOCK_SIZE])
> +
>  # Configure debug mode
>  AS_IF([test "x$enable_debug" !=3D "xno"], [], [
>    dnl Turn off all assert checking.
> @@ -367,6 +398,13 @@ if test "x${have_liblzma}" =3D "xyes"; then
>    AC_SUBST([liblzma_CFLAGS])
>  fi
>
> +# Dump maximum block size
> +AS_IF([test "x$erofs_cv_max_block_size" =3D "x"],
> +      [$erofs_cv_max_block_size =3D 4096], [])
> +
> +AC_DEFINE_UNQUOTED([EROFS_MAX_BLOCK_SIZE], [$erofs_cv_max_block_size],
> +                  [The maximum block size which erofs-utils supports])
> +
>  AC_CONFIG_FILES([Makefile
>                  man/Makefile
>                  lib/Makefile
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index b3d04be..370cfac 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -27,16 +27,10 @@ typedef unsigned short umode_t;
>  #define PATH_MAX        4096    /* # chars in a path name including nul =
*/
>  #endif
>
> -#ifndef PAGE_SHIFT
> -#define PAGE_SHIFT             (12)
> +#ifndef EROFS_MAX_BLOCK_SIZE
> +#define EROFS_MAX_BLOCK_SIZE   4096
>  #endif
>
> -#ifndef PAGE_SIZE
> -#define PAGE_SIZE              (1U << PAGE_SHIFT)
> -#endif
> -
> -#define EROFS_MAX_BLOCK_SIZE   PAGE_SIZE
> -
>  #define EROFS_ISLOTBITS                5
>  #define EROFS_SLOTSIZE         (1U << EROFS_ISLOTBITS)
>
> diff --git a/lib/namei.c b/lib/namei.c
> index 3d0cf93..3751741 100644
> --- a/lib/namei.c
> +++ b/lib/namei.c
> @@ -137,7 +137,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi=
)
>                 vi->u.chunkbits =3D sbi.blkszbits +
>                         (vi->u.chunkformat &
> EROFS_CHUNK_FORMAT_BLKBITS_MASK);
>         } else if (erofs_inode_is_data_compressed(vi->datalayout)) {
> -               if (erofs_blksiz() !=3D PAGE_SIZE)
> +               if (erofs_blksiz() !=3D EROFS_MAX_BLOCK_SIZE)
>                         return -EOPNOTSUPP;
>                 return z_erofs_fill_inode(vi);
>         }
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 3ec4903..a6a2d0e 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -532,7 +532,7 @@ static int mkfs_parse_options_cfg(int argc, char
> *argv[])
>                 cfg.c_dbg_lvl =3D EROFS_ERR;
>                 cfg.c_showprogress =3D false;
>         }
> -       if (cfg.c_compr_alg[0] && erofs_blksiz() !=3D PAGE_SIZE) {
> +       if (cfg.c_compr_alg[0] && erofs_blksiz() !=3D EROFS_MAX_BLOCK_SIZ=
E) {
>                 erofs_err("compression is unsupported for now with block
> size %u",
>                           erofs_blksiz());
>                 return -EINVAL;
> @@ -670,7 +670,7 @@ static void erofs_mkfs_default_options(void)
>  {
>         cfg.c_showprogress =3D true;
>         cfg.c_legacy_compress =3D false;
> -       sbi.blkszbits =3D ilog2(PAGE_SIZE);
> +       sbi.blkszbits =3D ilog2(EROFS_MAX_BLOCK_SIZE);
>         sbi.feature_incompat =3D EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
>         sbi.feature_compat =3D EROFS_FEATURE_COMPAT_SB_CHKSUM |
>                              EROFS_FEATURE_COMPAT_MTIME;
> --
> 2.24.4
>
>

--=20
Sincerely,

Kelvin Zhang

--000000000000fa10a305fd12a2e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Looks good to me, please merge this patch</div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 1, 20=
23 at 10:54=E2=80=AFAM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alib=
aba.com">hsiangkao@linux.alibaba.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Previously PAGE_SIZE was actually unset=
 for most cases so that it was<br>
always hard-coded 4096.<br>
<br>
In order to set EROFS_MAX_BLOCK_SIZE correctly, let&#39;s detect the real<b=
r>
page size when configuring and get rid of PAGE_SIZE.<br>
<br>
Cc: Kelvin Zhang &lt;<a href=3D"mailto:zhangkelvin@google.com" target=3D"_b=
lank">zhangkelvin@google.com</a>&gt;<br>
Signed-off-by: Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com"=
 target=3D"_blank">hsiangkao@linux.alibaba.com</a>&gt;<br>
---<br>
change since v1:<br>
=C2=A0- get rid of PAGE_SIZE (Kelvin);<br>
<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 38 ++++++=
++++++++++++++++++++++++++++++++<br>
=C2=A0include/erofs/internal.h | 10 ++--------<br>
=C2=A0lib/namei.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2=
 +-<br>
=C2=A0mkfs/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4=
 ++--<br>
=C2=A04 files changed, 43 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index 4dbe86f..2ade490 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -59,6 +59,8 @@ AC_DEFUN([EROFS_UTILS_PARSE_DIRECTORY],<br>
=C2=A0 fi<br>
=C2=A0])<br>
<br>
+AC_ARG_VAR([MAX_BLOCK_SIZE], [The maximum block size which erofs-utils sup=
ports])<br>
+<br>
=C2=A0AC_ARG_ENABLE([debug],<br>
=C2=A0 =C2=A0 =C2=A0[AS_HELP_STRING([--enable-debug],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0[enable debugging mode @&lt;:@default=3Dno@:&gt;@])],<br>
@@ -202,6 +204,35 @@ AC_CHECK_FUNCS(m4_flatten([<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmpfile64<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 utimensat]))<br>
<br>
+# Detect maximum block size if necessary<br>
+AS_IF([test &quot;x$MAX_BLOCK_SIZE&quot; =3D &quot;x&quot;], [<br>
+=C2=A0 AC_CACHE_CHECK([sysconf (_SC_PAGESIZE)], [erofs_cv_max_block_size],=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_RUN_IFELSE([AC_L=
ANG_PROGRAM(<br>
+[[<br>
+#include &lt;unistd.h&gt;<br>
+#include &lt;stdio.h&gt;<br>
+]],<br>
+[[<br>
+=C2=A0 =C2=A0 int result;<br>
+=C2=A0 =C2=A0 FILE *f;<br>
+<br>
+=C2=A0 =C2=A0 result =3D sysconf(_SC_PAGESIZE);<br>
+=C2=A0 =C2=A0 if (result &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
+<br>
+=C2=A0 =C2=A0 f =3D fopen(&quot;conftest.out&quot;, &quot;w&quot;);<br>
+=C2=A0 =C2=A0 if (!f)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
+<br>
+=C2=A0 =C2=A0 fprintf(f, &quot;%d&quot;, result);<br>
+=C2=A0 =C2=A0 fclose(f);<br>
+=C2=A0 =C2=A0 return 0;<br>
+]])],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[erofs_cv_max_block_size=3D`cat conftest.out=
`],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[]))<br>
+], [erofs_cv_max_block_size=3D$MAX_BLOCK_SIZE])<br>
+<br>
=C2=A0# Configure debug mode<br>
=C2=A0AS_IF([test &quot;x$enable_debug&quot; !=3D &quot;xno&quot;], [], [<b=
r>
=C2=A0 =C2=A0dnl Turn off all assert checking.<br>
@@ -367,6 +398,13 @@ if test &quot;x${have_liblzma}&quot; =3D &quot;xyes&qu=
ot;; then<br>
=C2=A0 =C2=A0AC_SUBST([liblzma_CFLAGS])<br>
=C2=A0fi<br>
<br>
+# Dump maximum block size<br>
+AS_IF([test &quot;x$erofs_cv_max_block_size&quot; =3D &quot;x&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 [$erofs_cv_max_block_size =3D 4096], [])<br>
+<br>
+AC_DEFINE_UNQUOTED([EROFS_MAX_BLOCK_SIZE], [$erofs_cv_max_block_size],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [The maximu=
m block size which erofs-utils supports])<br>
+<br>
=C2=A0AC_CONFIG_FILES([Makefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0man/Makefile<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lib/Makefile<=
br>
diff --git a/include/erofs/internal.h b/include/erofs/internal.h<br>
index b3d04be..370cfac 100644<br>
--- a/include/erofs/internal.h<br>
+++ b/include/erofs/internal.h<br>
@@ -27,16 +27,10 @@ typedef unsigned short umode_t;<br>
=C2=A0#define PATH_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 4096=C2=A0 =C2=A0 /* # ch=
ars in a path name including nul */<br>
=C2=A0#endif<br>
<br>
-#ifndef PAGE_SHIFT<br>
-#define PAGE_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(12)<br>
+#ifndef EROFS_MAX_BLOCK_SIZE<br>
+#define EROFS_MAX_BLOCK_SIZE=C2=A0 =C2=A04096<br>
=C2=A0#endif<br>
<br>
-#ifndef PAGE_SIZE<br>
-#define PAGE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;=
&lt; PAGE_SHIFT)<br>
-#endif<br>
-<br>
-#define EROFS_MAX_BLOCK_SIZE=C2=A0 =C2=A0PAGE_SIZE<br>
-<br>
=C2=A0#define EROFS_ISLOTBITS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 5<br>
=C2=A0#define EROFS_SLOTSIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1U &lt;&lt; =
EROFS_ISLOTBITS)<br>
<br>
diff --git a/lib/namei.c b/lib/namei.c<br>
index 3d0cf93..3751741 100644<br>
--- a/lib/namei.c<br>
+++ b/lib/namei.c<br>
@@ -137,7 +137,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vi-&gt;u.chunkbits =
=3D sbi.blkszbits +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (vi-&gt;u.chunkformat &amp; EROFS_CHUNK_FORMAT_BLKBITS_MASK);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (erofs_inode_is_data_compressed(vi-&g=
t;datalayout)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (erofs_blksiz() =
!=3D PAGE_SIZE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (erofs_blksiz() =
!=3D EROFS_MAX_BLOCK_SIZE)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EOPNOTSUPP;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return z_erofs_fill=
_inode(vi);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
diff --git a/mkfs/main.c b/mkfs/main.c<br>
index 3ec4903..a6a2d0e 100644<br>
--- a/mkfs/main.c<br>
+++ b/mkfs/main.c<br>
@@ -532,7 +532,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[=
])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg.c_dbg_lvl =3D E=
ROFS_ERR;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg.c_showprogress =
=3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cfg.c_compr_alg[0] &amp;&amp; erofs_blksiz(=
) !=3D PAGE_SIZE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cfg.c_compr_alg[0] &amp;&amp; erofs_blksiz(=
) !=3D EROFS_MAX_BLOCK_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erofs_err(&quot;com=
pression is unsupported for now with block size %u&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 erofs_blksiz());<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
@@ -670,7 +670,7 @@ static void erofs_mkfs_default_options(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg.c_showprogress =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg.c_legacy_compress =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sbi.blkszbits =3D ilog2(PAGE_SIZE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sbi.blkszbits =3D ilog2(EROFS_MAX_BLOCK_SIZE);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sbi.feature_incompat =3D EROFS_FEATURE_INCOMPAT=
_LZ4_0PADDING;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sbi.feature_compat =3D EROFS_FEATURE_COMPAT_SB_=
CHKSUM |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EROFS_FEATURE_COMPAT_MTIME;<br>
-- <br>
2.24.4<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Sincerely,<div><br></div><div>Kelvin Zhang</div></div></div>

--000000000000fa10a305fd12a2e4--
