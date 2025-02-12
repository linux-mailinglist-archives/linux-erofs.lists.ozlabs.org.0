Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177A0A3283C
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 15:17:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtL4h2xG9z3bgV
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Feb 2025 01:17:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::934"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739369874;
	cv=none; b=kSfDcVSL0M9WPw7zrGmblGxQT4GgtF0dsdTCJLClnOf3tsdzcsIme8L0WUpsAfhjzPmIjnclwvIAcPobh4z1REZGkMLbgUdxpaMIqxdCRRT0mzQN3h4J/rkhbPUkQbGdZ6XZjQMkjydnMdHl1HiWRkTj9UP6E5y0jTSHlhC0alOy8UwbJ8oSjykwW+7fJc2XOWop8Rv7g9fyb8+sNSU98h0zn5pCQwWTRhgSQDluiUXPRhNVRsEDfVceXPITsyEueNLmAtLCz1kchAOW9aocv8dMYj2IR4Owhsw1RTXAiKYrAo74xY5siDJQH2HspKRbzXTcNSg7get3gKA0HAiDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739369874; c=relaxed/relaxed;
	bh=sMTOEpIGPzDjriMcfE3z1fAYuZCnOU9pT8OdLZbYB2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BV+9mfy1/1Y+zvew2S/t0Opo8HOMmLghNSL4E0PhdYRf3/dueQsdA6ggEeahkHDbdV/tE5uBFRJTVNzRbFU4EbBLnES+5sjokf/MtOTjDkI+wZulxIDYnwcnhPABlsQIzW41Xe7DEBin5qgrxw/mbSOOUuTplW9Rb7AxyI3bE3OhkRv4vAkmK/sEy5bpTesol2wzvu0/rHf5DSvXxeywvQU9X5I5MODEPVhezts5MtGD8jvkn/o6/7E4TZbWYKS4/zDS2YkAEqjgIn1vylUswHt9MnbaUGKZm+CM+MPFpQ5iYzAFuyfCNwzxnriHBG7JsCK0sY0HMuAQeoMu9JjyPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SI+t7l2n; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::934; helo=mail-ua1-x934.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SI+t7l2n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::934; helo=mail-ua1-x934.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtL4d1rDZz2yD8
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Feb 2025 01:17:52 +1100 (AEDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-86715793b1fso1270119241.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2025 06:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739369869; x=1739974669; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sMTOEpIGPzDjriMcfE3z1fAYuZCnOU9pT8OdLZbYB2s=;
        b=SI+t7l2nxWiWqv2pPm5sIqNpj68Pdcdy6+g4a5mb3PdDwoJ5ptErEFgL0egQB/NlWy
         RdtZjJRZsiQB4EpL8TD+GsjapCZKn42FZeQit5Ay1MrzCa5kNfQUF5aTZtlro4uSSx80
         MTjC6fuHaSweK1nnZXTrh06KSRRaeoOyyTkZ+m2kX24tlbJ+9FbioSyutpP2yuDRwu1O
         6e9aSVD0ouPoGaOi04iBKzOxhVo/nrPN/56s0kO5Mz5qqrhw7x8AlX22iCBdOFIMe1pA
         /phXnyGe2yQtpPqNYz099axkBTb2iU+A77G/tdDkoktNJ00PLqLiYyhfS37xIj31UMIj
         hr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739369869; x=1739974669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMTOEpIGPzDjriMcfE3z1fAYuZCnOU9pT8OdLZbYB2s=;
        b=P8E4Z/P/ZzQYFsfEpS69AROeMa0tOiQ/LLV8XFMNB8SZQQ2jjgAaypouGfMFVcSsbV
         63RWVd2vTUQGoj/YKQKpI8WwnR5QLZrUpuSXq2xuepjH1t1MdBK2XogJTgXlY6Q7lH10
         9w6OzoawNCKbYIS/bFRr7tYZ/OS/Z06xthaJ8vxDBeW1agyAdzlxK98J/is0vAiMVzOZ
         mWI+gq8ylnnorpTl95ki2KlT0vwvhgtwZcp4CCN47hhTBIiRVXUcAql8yG1qIMTjCXcH
         ylTIS1dBDGOKDHlRuKJypQIkJJnlHftaoAFIECR7XgeuugvACYJiPZ+0lKxJrMpx64l8
         y6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVeBDxVJHAlQV3NfSubZek9OX/UhB6difqKIFlwTVff7VaVMFi/8xNlEBBPXcyD3UZ2D2Tjx3X53gdGBA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxhmaqLvW/RhBjKBrj/RIY4ciIhPOop4QwQE6DPXa1QdoGWZdRf
	vhyHPxRxvWiTsg+Vdr+da9FLLs00ryZVHqXEY5GSd+mXo3wPDBUjCI/ZgCW0dqsoGrM885eUFNs
	2bsXkqTLt1Dbu/J45yXWXyz/HmszO6vZuG0s=
X-Gm-Gg: ASbGncuKDK6o4G/T0IE8flVfrsA7bCgZR7cCFSjOfl2jU1dklM5k3LZ++aYA0NdQcTV
	x7a8WQaaxlKcrR/8D2PX7Qpz1Xb1xg8RwhwXZfo3sFfFECNXoNf6CGrHa8kyScQb0Ar72h1ccA4
	/vudNPQias7nSIrDvAKWIXFIk2ip/5
X-Google-Smtp-Source: AGHT+IF4p5XbCQk3FJC0EJmp3js78LUq1/V2TdVqNhXrMKYwDkdg4YRxVP+t0hMiXAq0xk+EYRHlg0P1QsMMDYmjNVs=
X-Received: by 2002:a05:6102:510b:b0:4ba:9a20:dd05 with SMTP id
 ada2fe7eead31-4bbf21e5e76mr2484187137.10.1739369869481; Wed, 12 Feb 2025
 06:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20250212093057.3975104-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20250212093057.3975104-1-hsiangkao@linux.alibaba.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Wed, 12 Feb 2025 06:17:38 -0800
X-Gm-Features: AWEUYZmcsZ6sfMf4c1fdlvjM2nz5ygGVNhDxhNwJ60-ie_Pa9NhvYLrzqEgoL6Y
Message-ID: <CABMsoEFTGzKhFn7eB0cjg2peCd_DubF-X6Rpq2+1cRVm_J0Q0g@mail.gmail.com>
Subject: Re: [PATCH] fs/erofs: fix an integer overflow in symlink resolution
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000342251062df29b7d"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org, Tom Rini <trini@konsulko.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000342251062df29b7d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is good, but may I suggest using __builtin_add_overflow instead?

Jonathan

On Wed, Feb 12, 2025, 1:31=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.co=
m> wrote:

> See the original report [1], otherwise len + 1 will be overflowed.
>
> Note that EROFS archive can record arbitary symlink sizes in principle,
> so we don't assume a short number like 4096.
>
> [1] https://lore.kernel.org/r/20250210164151.GN1233568@bill-the-cat
> Fixes: 830613f8f5bb ("fs/erofs: add erofs filesystem support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/fs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/erofs/fs.c b/fs/erofs/fs.c
> index 7bd2e8fcfc..64a6c8cad8 100644
> --- a/fs/erofs/fs.c
> +++ b/fs/erofs/fs.c
> @@ -63,6 +63,9 @@ static int erofs_readlink(struct erofs_inode *vi)
>         char *target;
>         int err;
>
> +       if (len >=3D SIZE_MAX)
> +               return -EFSCORRUPTED;
> +
>         target =3D malloc(len + 1);
>         if (!target)
>                 return -ENOMEM;
> --
> 2.43.5
>
>

--000000000000342251062df29b7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">This is good, but may I suggest using __builtin_add_overflow=
 instead?</p>
<p dir=3D"ltr">Jonathan</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Feb 12, 2025, 1:31=E2=80=AFAM Gao Xiang &lt;<a href=
=3D"mailto:hsiangkao@linux.alibaba.com">hsiangkao@linux.alibaba.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">See the original report [1]=
, otherwise len + 1 will be overflowed.<br>
<br>
Note that EROFS archive can record arbitary symlink sizes in principle,<br>
so we don&#39;t assume a short number like 4096.<br>
<br>
[1] <a href=3D"https://lore.kernel.org/r/20250210164151.GN1233568@bill-the-=
cat" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore.kernel.or=
g/r/20250210164151.GN1233568@bill-the-cat</a><br>
Fixes: 830613f8f5bb (&quot;fs/erofs: add erofs filesystem support&quot;)<br=
>
Signed-off-by: Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com"=
 target=3D"_blank" rel=3D"noreferrer">hsiangkao@linux.alibaba.com</a>&gt;<b=
r>
---<br>
=C2=A0fs/erofs/fs.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/fs/erofs/fs.c b/fs/erofs/fs.c<br>
index 7bd2e8fcfc..64a6c8cad8 100644<br>
--- a/fs/erofs/fs.c<br>
+++ b/fs/erofs/fs.c<br>
@@ -63,6 +63,9 @@ static int erofs_readlink(struct erofs_inode *vi)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *target;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (len &gt;=3D SIZE_MAX)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFSCORRUPTE=
D;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 target =3D malloc(len + 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!target)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
-- <br>
2.43.5<br>
<br>
</blockquote></div>

--000000000000342251062df29b7d--
