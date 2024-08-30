Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ED9966B77
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2024 23:46:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725054395;
	bh=G/XuapKUcT1TztD7B4lsNhQAQHU+6KnpXw+FtG7FqCg=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=BVw8OIcVz9GHqhc/Z+GUkjh1O9veb1xy8HyrDCyfNTDklFnVMe8xngO4onbhkZZvo
	 jzZMszl0dXkjvOq8TZEW9cUxWO6oMlRLz8nahphfMHcnGv1EY/x2+8pn1whYYhHKlu
	 RuVISFJvgFrVCckER4O/3Hc6cA8/d+TZvWCFv8djg6t0VLXoTQ/eBTnhOd44+JRtgr
	 Qq0J4lqNoiE4c9hYacHABK9rFlOBhwJ30pMHNRZQe+3GU1waYRtJaPg95AoAxVGOgQ
	 e9Oz6VJKJKidrfwtrjM7+Hd+z3PTuvcbw/0jLHMY7HXIjCAuqSj68zkeWg8wHNncMF
	 NQjwpczxyFd0w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WwWtz37kRz30RJ
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2024 07:46:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725054393;
	cv=none; b=mapwM2ves8DdaqGiDA0/ODHlG+aUO99nUXfRkBxAqaUFscxntcYV1XRVD/480aDMJxKqthf/i/JVUTscPhm08VcHecjJqbc9qz/EYVpEVr0FPzi+BrRuyarYprBJXHYdoakxEUXTWn3Xj1JryabZABjssqI/RI+f/DOAKj0lCtC1j87T4kl/CGjCo8TwDRrcobg17agjHnGExBGRvTpMkuXDQVvAfzMGQZLB6E/kDcvN0maNO2px5Ri5ZiA5lk1odS7qX1FEnAKAljt4GucpuwK45mZZrx3dxD86jOMWGakIiPeIAwIv+WgU2DgK8rV0jux4gR3kjBuC41SV/cgSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725054393; c=relaxed/relaxed;
	bh=G/XuapKUcT1TztD7B4lsNhQAQHU+6KnpXw+FtG7FqCg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Google-Smtp-Source:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	b=ONPx0NtMEKOVETzYWFGz2FHn/Zi5qZ2qXf6YJzDjgIkxkD3RqYoL5FGChh3satrfePRdRa968zCw2fXXemozDlK0TZ5sM8evS3J74aTGm2xopMtu0NiSTLVJA7A9hybd8DglI9ORGjZvBDBBEL9on6LI3iq1H0VvJU7POi1IOGKyDI74iXNaFxVpDeHjCi2ySka80+vpDZTw59hvvc8DkTpCRDUvs8WlW0i/YLHFbthWXE0G4AEW8h2g9ITfl1MUmsCf4I6nZ00JwGzmld6Tg946OXxSqROmzaoe1aM+9wNxq9V8M7lX6/OWSBthxssh1MJlaTvNH48NvXFfZxExLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=UU7qVxfK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=UU7qVxfK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WwWtw6ff8z3089
	for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2024 07:46:31 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-20219a0fe4dso20634885ad.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2024 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725054388; x=1725659188; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/XuapKUcT1TztD7B4lsNhQAQHU+6KnpXw+FtG7FqCg=;
        b=UU7qVxfKNLQsUlhCnQMsEQGSPf1odJb+pdmOD5QSlQ/xsUa6E9SU5uz8Pnycw4pbpp
         ebBPSc0d3UOggI7jd/qsAyWbPydJf86yjub7Uz3Y447LV4UVu1XNFk1bio85JaPOcSIW
         RMH64XNVQOtgr0LJmrJQMEsa06B4mGYAjbBhIkdRX8c1flMtrskyh9e0GtO6ENqjM/uh
         KIdxN0AmNXSEs6EFg5gldPwm4hfVRT+iK4IIL5b64Z71yTdY85P0KOIrPfTrRrAvjd+T
         LVuStZ7yYPWuoAh2sKdisck6QEIsFlfM/2bQzmO2C6iS/YqVj6PWDEc5gsjfLOyTNN6L
         8Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725054388; x=1725659188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/XuapKUcT1TztD7B4lsNhQAQHU+6KnpXw+FtG7FqCg=;
        b=VylWwlkbxwX0D0M4hDXWy14yrvlUlFXSBdjfnN1mL3E7hXO1t9HVjrRKOtluNVAQ8K
         b6E/uEIbsGJtKSAErwSMlcuPt7TU4hLUcBuxNAFp/2woTu8/WsSlAx0olkBHcXwg6a9u
         hq132+qOXLsZqo2nmgq9sB++EPCY98jYr5B+NA1oSi3c9IsspHtEjMFd76Z/AkZR8kOi
         4VHpwDtu+yR27tIYwGi4UbPW6orCBlIpl+JZtlIQfuI2QTwsy4Ry81zOHjy9CfdgpYwe
         2ryNLt+mtd5hJVYbY2m+cnWObO3kF255m3i7yrTRnrRRXedBg2rxHjuFgYDwmtngHEaL
         XLyA==
X-Forwarded-Encrypted: i=1; AJvYcCWCIEq8v+C1QaLNATa5xE/AKUvbKD+NXTnvwkW56E22lPJi+ZquKf3I+g0gCNLKzZzZrvp7KB2OoqKaZw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwRisAyY/o3CXJTrkBBpyC8X3RtZWAW/cW45L+BQ1uLoAU8jabs
	QKLs2WJJewB8pElf1hekclKIf4ep8XdPVbBOyBUZ2cDP5e0jZuhT+DdkXL5ZsopDjbIQiJksKmx
	b1jkDxRhwbtyOWPBk5qDIBfu4rLY9BpMKTSkP
X-Google-Smtp-Source: AGHT+IG5sVfJ54FU36mBDFZI5PUuNySzE0n00ILvaruKwUqOndxAJcaMwDsDM59g8qBNSvY9wvSFAeSNY7LadPhxEZo=
X-Received: by 2002:a17:902:f543:b0:1fa:fc24:afa5 with SMTP id
 d9443c01a7336-2050c350429mr82073645ad.27.1725054387396; Fri, 30 Aug 2024
 14:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240829122342.309611-1-jinbaoliu365@gmail.com>
In-Reply-To: <20240829122342.309611-1-jinbaoliu365@gmail.com>
Date: Fri, 30 Aug 2024 14:46:16 -0700
Message-ID: <CAB=BE-QfSB_BZNA_ZPt6G6WTbruHs8QtN9guGfZTkyjGjJNy5Q@mail.gmail.com>
Subject: Re: [PATCH v2] erofs: Prevent entering an infinite loop when i is 0
To: liujinbao1 <jinbaoliu365@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: mazhenhua@xiaomi.com, kernel-team@android.com, linux-erofs@lists.ozlabs.org, liujinbao1 <liujinbao1@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Liujinbao,
On Thu, Aug 29, 2024 at 5:24=E2=80=AFAM liujinbao1 <jinbaoliu365@gmail.com>=
 wrote:
>
> From: liujinbao1 <liujinbao1@xiaomi.com>
>
> When i=3D0 and err is not equal to 0,
> the while(-1) loop will enter into an
> infinite loop. This patch avoids this issue
>
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
> ---
>  fs/erofs/decompressor.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index c2253b6a5416..672f097966fa 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -534,18 +534,18 @@ int z_erofs_parse_cfgs(struct super_block *sb, stru=
ct erofs_super_block *dsb)
>
>  int __init z_erofs_init_decompressor(void)
>  {
> -       int i, err;
> +       int i, err =3D 0;
>
>         for (i =3D 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>                 err =3D z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0=
;
> -               if (err) {
> -                       while (--i)
> +               if (err && i) {
> +                       while (i--)
Actually there is a subtle bug in this fix. We will never enter the if
block here when i=3D0 and err is set which we were trying to fix.
This will cause z_erofs_decomp[0]->init() error to get masked and we
will continue the outer for loop (i.e. when i=3D0 and err is set).

Yes original code had the bug but probably simpler and readable fix could b=
e

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c2253b6a5416..abf2db2ba10c 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -539,7 +539,7 @@ int __init z_erofs_init_decompressor(void)
        for (i =3D 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
                err =3D z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
                if (err) {
-                       while (--i)
+                       while (i-- > 0)
                                if (z_erofs_decomp[i])
                                        z_erofs_decomp[i]->exit();
                        return err;

Let me know if you want me to send a fix with your Reported-by or you
can send quick v3.

Thanks,
Sandeep.

>                                 if (z_erofs_decomp[i])
>                                         z_erofs_decomp[i]->exit();
> -                       return err;
> +                       break;
>                 }
>         }
> -       return 0;
> +       return err;
>  }
>
> (1) The use of "break" is to enable a jump out of the for loop,
> otherwise it may not be able to exit the loop.
> (2) --i should be changed to i-- because when i is equal to 1,
> the "while (--i)" statement would exit the loop prematurely.
>
> and sorry for the delay in the response.
>
