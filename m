Return-Path: <linux-erofs+bounces-2852-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILAkGtv9u2mzqwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2852-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 14:44:59 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A17402CC21C
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 14:44:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc6Py0vBPz2ynW;
	Fri, 20 Mar 2026 00:44:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::430" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773927894;
	cv=pass; b=gYNL2SMnegamLLZBcBkzI1dD+Y04Cy4aBDq0VCb8WkZukaPCI5IHxsum+h5IvPZIuupdXvcJI1tjDzpj7m9gWqt6j3QLHQkFbF1ygwvbp0Yzj33l9vBsRBzalKEj9SlCdAuOk/CxEwdKitAhGQRIqirYJEGC4j2BnFfRIQM8UimetJk4EurftSNUv1bBDXzW1LJuicn/t1l/Cq2c4RbfV4Xsm4uO1F2p46u84XORt+H0hAxkWyfjE0prCNTXrLfIjd29LfRF02hRrATbqIR9b5SnUWGXkk/TClnk3z+fAVKBCpa0kr3IF43ly2s10egKjRquy/EQl/QKJCI8w/bShQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773927894; c=relaxed/relaxed;
	bh=v9R6nHOrcJhaC23UTQpNWE8SQ53vDX/e3FOov6oc2TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6eR7qOtHYQhhHS/hiAY3327ucTsnJY7scwePu4wAH+k+Dsh5H4vr0VjRtLTd18LDJbRm9nSRMaxjo5HYZVqyIuNr6rRooFSgKTknphArXBI3SxNt9vzieH4Uzfqoce2YpTkMd5AABhy0bKnVKdg7gjmZ3e8BZu11zwCtc7NQFra9MOXwbt39IOPomcgLg0fjiyl+aZUwl+6SwantUpdQynA6/xxpRviz1LupmdPjuq4d1JvDHo4qA0Yk5xXms+mRHB3iBvzs8QWw/q+ftMEftdvxDYnhdf/gqmHDPk7fBs0niVYHif+kv+gs05Zi64sm9/yoB3TIVDahKaQmEXLAQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LR6UL8SR; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LR6UL8SR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc6Px1Brdz2yLG
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 00:44:52 +1100 (AEDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so946378f8f.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 06:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773927884; cv=none;
        d=google.com; s=arc-20240605;
        b=QvSR/sUquvZtzqDl4iQ909UQG/YRct22Kwrib9AuReCzTQNqjs1C7t3ro1YjVLbLyq
         0+stoN30BqdUNx6klJXJfRN4GO3gSBm5qBrq/mTHbId+GZcGcF1bfs47To+O9MNPxTCo
         Dcrl9lQbOixsBLPMadrdGKovhxorRO5JvdN7VY3xjiwpnZimadZRNr7imj3QXjmofdMV
         gnynQVM5YqDpbDJU20jv7bHLsVcjA80HZPG+SS9QLEAWFRvHp7V7PsMrTRGrM6CrKy/h
         RKCYUuKVtzZZKn8ENAlQc5uIAagQuy4lIkIncCQnETwiqLH6TBwb/8AjK68xCwb1pzvV
         9cwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v9R6nHOrcJhaC23UTQpNWE8SQ53vDX/e3FOov6oc2TY=;
        fh=JcF7iGUjJsVSaM7oSS1RWcr27vz0aVsrVNsuXyQexrw=;
        b=ZozDCkpHeHqMDWLFLinNIrvgVcVnym0Vowlldt0HwMCDSbTilaj1a5Li0pkzoqrEUw
         OV3tYm/tsh2l4I4B2Nk74gSU7wkFOylHkJSSZn9Aa8NJ/Bp42/9+WWd9s3Y0+OCy7e0v
         LJG0XTtckMmQly0iPiE61f/xifxdtjlOuW4brfQ2Np4DLK4NPgpxRMUHVdJeFZN/5TeJ
         SFmNdwKaH4vk18F4E1d0LN6xakZE7kvdq4oJBpG2sALCwj7Zj0wjcb5IbxDwSJBKEmVi
         nrod1ufqfPZO5UzH2AYDuVK0N4pvjjAO+kRy+Q/a/2u3SoaKFYgG4ItC7aNdYJqwD5ki
         91Hg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773927884; x=1774532684; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9R6nHOrcJhaC23UTQpNWE8SQ53vDX/e3FOov6oc2TY=;
        b=LR6UL8SRxPaBlxO1QcOJ1Wmxk67Aw0iToRovz6PkgCyNOMzToKTNcWGLXrUTj3esCA
         Zuqc3UTKDgsv13aaaNxE8ub4gkrUtm0IdZV30muegDmE1an4AV7shNr9H6qFPMBVkjTh
         Il5HyLURcadZiiiIIWmfCoIh/sSDVmcqfT/i3DtrGq5QsXYS/7lvDWd/BxaKrfGMfg4n
         fkug+ELOnSeEwIW9xfB7xgiQ5P553w3CI1Iyq0Y4UKfOcJSd1gtzrZ6sAmq704rlviSD
         GgJZQFF3RC2xrDIb91eE6pSKaWy4s0yzjltQSFSqomFXcumsHObHT6Qkz5kZv5TYp0ao
         6Y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773927884; x=1774532684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v9R6nHOrcJhaC23UTQpNWE8SQ53vDX/e3FOov6oc2TY=;
        b=eY52PoXEc8IoJlH7BkqttcQxEOOJCy5rCH2Elglh9z0j9jf48Hx1TTBe9hxzV1t+X2
         watNwwGwg1zeXVc5vwwESgo+NoFhFWNjP1Zl+07zv9JIxKGB+gy/zZlTSbMSKEGFNI5e
         tRX7OfnPlhMd1X2N7DQErTbKHnC8T17TyliMafJ+jf2t1cUEzYWCvuoO1MDSJ0PpW0k2
         p/dQKGK26L6ITsmrJXNsrT/yK8V9myFNUWkDxLZxoohXYXlA7DG7av9jR7/QldS+kVoP
         Y1dHtbCRcC9iXoo9yOgZnX9hNznkGGI3tsfqOO2TxyaKCfhjT94YtE3e1n7aGY9hMAMy
         g1sA==
X-Gm-Message-State: AOJu0YzuEWpoflnhG2Okefwsayu2Y+XjYNGtOm8CZ6s9TAx5gnrqfZRP
	JkT6Oc6EyNjS1Dymk37wqRB73VeeyPMDJR4OkKkf7GaBQ35cOfkkV5ICtBrJbQkU2lnXvvUcd7A
	paL/HsgvDqUrWpFYZHLsjiiARH3ohszrONzRRpOM=
X-Gm-Gg: ATEYQzwkzLAudC3CMLBBrdjlVpjtVF/8j+C27quOYITJ17VrPn6iZA46Ts5KBOENfHx
	MmpSV8NzDqPBGE0bTUAOqY/QYqKuZitDzBy2NRO5Q7e6uP/hGMuJcDxhz+pln4fqLP7m6IrRRAF
	w9OWAp0SxuuuPdyHl/LzO1ye97nrOLcKPzCfBRv+U87UNO6jvo4RKZDLL2V6pFIHItdCgVBaJWB
	iIshVT9UuzSnztQ8FGdsYuFgyqa7HL5MWWX79+Z0MpedT5VIYK32FJ4IhPERz8dmGChHx/CMkle
	7WeZdGK4IJCQS2VnD9F+3SMPMlfOvMk5uo1ltGcFbA==
X-Received: by 2002:a05:6000:4011:b0:43b:4aba:8f4f with SMTP id
 ffacd0b85a97d-43b527c89eemr13067988f8f.45.1773927884290; Thu, 19 Mar 2026
 06:44:44 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260319133948.396-1-newajay.11r@gmail.com>
In-Reply-To: <20260319133948.396-1-newajay.11r@gmail.com>
From: Ajay <newajay.11r@gmail.com>
Date: Thu, 19 Mar 2026 19:14:32 +0530
X-Gm-Features: AaiRm52SO1Fm2IRQwO_mGXfz5Flpl3gOHX08MYrsXIreX4DGjj2omXH2CynJAjI
Message-ID: <CAMhhD9juE5tDzW3twCLQChUyLbQsJPvhJQSt-8BOdh_K_UgiCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] erofs-utils: lib: replace bool locked with
 erofs_mutex_t for MT safety
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2852-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A17402CC21C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, This is my first time submitting patches via git send-email to a
mailing list, so I apologize if there are any formatting issues or
mistakes in the submission process. Any feedback or suggestions for
improvement are appreciated.
Thanks, Ajay Rajera.

On Thu, 19 Mar 2026 at 19:09, Ajay Rajera <newajay.11r@gmail.com> wrote:
>
> Replace the bool locked field in erofs_diskbufstrm with erofs_mutex_t loc=
k to provide proper mutual exclusion for multi-threaded disk buffer operati=
ons. This addresses the TODO comment 'need a real lock for MT' by using the=
 erofs mutex API (erofs_mutex_lock/erofs_mutex_unlock/erofs_mutex_init) ins=
tead of a simple boolean flag that provided no actual synchronization.
>
> Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
> ---
>  lib/diskbuf.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/lib/diskbuf.c b/lib/diskbuf.c
> index 0bf42da..4218df8 100644
> --- a/lib/diskbuf.c
> +++ b/lib/diskbuf.c
> @@ -3,6 +3,7 @@
>  #include "erofs/internal.h"
>  #include "erofs/print.h"
>  #include <stdio.h>
> +#include "erofs/lock.h"
>  #include <errno.h>
>  #include <sys/stat.h>
>  #include <unistd.h>
> @@ -14,7 +15,7 @@ static struct erofs_diskbufstrm {
>         u64 tailoffset, devpos;
>         int fd;
>         unsigned int alignsize;
> -       bool locked;
> +       erofs_mutex_t lock;
>  } *dbufstrm;
>
>  int erofs_diskbuf_getfd(struct erofs_diskbuf *db, u64 *fpos)
> @@ -34,6 +35,7 @@ int erofs_diskbuf_reserve(struct erofs_diskbuf *db, int=
 sid, u64 *off)
>  {
>         struct erofs_diskbufstrm *strm =3D dbufstrm + sid;
>
> +       erofs_mutex_lock(&strm->lock);
>         if (strm->tailoffset & (strm->alignsize - 1)) {
>                 strm->tailoffset =3D round_up(strm->tailoffset, strm->ali=
gnsize);
>         }
> @@ -42,7 +44,6 @@ int erofs_diskbuf_reserve(struct erofs_diskbuf *db, int=
 sid, u64 *off)
>                 *off =3D db->offset + strm->devpos;
>         db->sp =3D strm;
>         (void)erofs_atomic_inc_return(&strm->count);
> -       strm->locked =3D true;    /* TODO: need a real lock for MT */
>         return strm->fd;
>  }
>
> @@ -51,9 +52,9 @@ void erofs_diskbuf_commit(struct erofs_diskbuf *db, u64=
 len)
>         struct erofs_diskbufstrm *strm =3D db->sp;
>
>         DBG_BUGON(!strm);
> -       DBG_BUGON(!strm->locked);
>         DBG_BUGON(strm->tailoffset !=3D db->offset);
>         strm->tailoffset +=3D len;
> +       erofs_mutex_unlock(&strm->lock);
>  }
>
>  void erofs_diskbuf_close(struct erofs_diskbuf *db)
> @@ -115,6 +116,7 @@ int erofs_diskbuf_init(unsigned int nstrms)
>  setupone:
>                 strm->tailoffset =3D 0;
>                 erofs_atomic_set(&strm->count, 1);
> +               erofs_mutex_init(&strm->lock);
>                 if (fstat(strm->fd, &st))
>                         return -errno;
>                 strm->alignsize =3D max_t(u32, st.st_blksize, getpagesize=
());
> --
> 2.51.0.windows.1
>

