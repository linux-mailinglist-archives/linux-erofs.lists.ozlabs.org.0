Return-Path: <linux-erofs+bounces-2860-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGFXMM4evGkvswIAu9opvQ
	(envelope-from <linux-erofs+bounces-2860-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 17:05:34 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58432CE529
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 17:05:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc9XC1mDZz2ypW;
	Fri, 20 Mar 2026 03:05:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::436" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773936331;
	cv=pass; b=CbQMl9UepiePg2rz38T78EC4PZkJzah5kxF8jdOnA1WFJ4nW14nv9Oe4xDMB0Cew0PmxYmOKaKPOB0/1dHm4YZr5cX90T5Izb9FgclSm9Bk1SwNVJu2P+Qh9NYihuLrmpGxqtW7xwmzj0rQptdXm6XWg1l+uuJfWk36+GKlkpDLsXojmbdMpTKGT9CIWNTf92+O2RyRdodWxHS8uHLRsHQRTBVQ4fH/Fvodvazoqdb+qZhrJVzxdv+emU2Betn7WKtzz+xCf5q7oWrCksm7yaX8f5eCvq3F9y4VKjKcGpq/mdwym7pYH5KTgh+oSFphL/QsgMj2HTKT1f1fqnyXWvg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773936331; c=relaxed/relaxed;
	bh=yaScdVISl5X8MabuerN24sPj0SlD06sZ93xv6EGI3tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOWbE9QTrKWvOoSu9APvyw29/yFA8/ijP7/HFs7ebEhlpu6n/asSKZ+lwUckV82IIk337By2q9VHKZs42YqK01p95gUGVtudEd4iISONuej8eJi6L/c6Esiu9ZV9Lbe0JGQLXIEdq+Btl4GZeKJPyvqMHhCPDdtINDowvdLERUNXw7jGG+dnBlddp3gKJx0Rlo91w84XmapSjQ4DAkBYgd0D2wO7YixWuYNLZ3DHPyB3ev1WyEq7L9lOvhxS+suwToYMa4MREBUthcD8sf6yBFYPV2ze0sI8TmEEv/iYFc2v7cRliIvTIzAYLd21jcw5zKfa1APHnwbTlHUERE6zvQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=h7JLJvvv; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=h7JLJvvv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc9XB2V7nz2xjQ
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 03:05:30 +1100 (AEDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-43b3f91a7abso631032f8f.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 09:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773936327; cv=none;
        d=google.com; s=arc-20240605;
        b=cDSQQHqIVUJC4ileAW4TjSvbe+d7YbnJtvlQdhK3UyZ6U2by5/ALuSJ1+l8KI/GzcD
         NDIOlro9ESCjm46gEKtLntxh0bT17mol29/tX9Cya6ALW7g94cr0WzrQex2WQ/wwYi+Y
         STXb7yOmYwuzwrcxKUTkYYOQQyH+cdeFn/krBBUuyu/JlzgBXAarkOqiLlcBd1F4fi2Y
         VAEeIY7bnTUFQ/KdNpDGPyJY6Izwrn69F7aji0c4Sk+FpggTNIeS8/XedvAGAH9g6LPS
         chgAeBjWhNdGvmv8Q3KrmVpDpDFJyasXH8ialYk0jgsV0CppCIXiECCvjtAYYwX70eSi
         0xqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yaScdVISl5X8MabuerN24sPj0SlD06sZ93xv6EGI3tg=;
        fh=h6uq7XjWFSBY/jwInOiPeoemBJWA2pJ/g0xZ2uxEeMY=;
        b=CTH5Y4BL6b1nAjGXucD6UbQl+1UXxRftaef+lGGfN6gch8VYAEkCRSvyr/2NfHkEF7
         YrZnEac5EGkA2abCLj8pI4YhwjEsKUgrF4J/sg0S2apbepHZWL6yZTAZQfTdy+LCt43k
         QTYmy3Rksy2h9RsS4kjDvSyzxBBxtk3RFTa369TeuWVkO+LKkOxi4GspoYnB+dgU8EME
         zn+01LrRmAuSKv0GBdQ8mcZ4y5/VgomGU9DoZIa+kFVRLrLkAZnNg/Y4vY3aEntTK35x
         rBBiN1Nyi00BcHur9pz+z1A7xckVnBsdCTnCm8Xzk4NyAWv7jKWsRZoW2PRipFic63EJ
         nC3Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773936327; x=1774541127; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yaScdVISl5X8MabuerN24sPj0SlD06sZ93xv6EGI3tg=;
        b=h7JLJvvvXHm1wjVXukWNtOA1yUHflF4/gnw5PgRqeNZNqMUdwWcI6Fb56K6Q8s4Lne
         stPCRf4IyF7t1gY/04ske3kvymK2zeF7NjRRECs74PD5qFkiu5IfK8xsERBBDKTvQ44a
         HlgQiRPLH1q0FOqZWpm4a1oT/6kD60P0EzyRW6bf6lscxdccaYqGB38I7TBI5AxcWTHi
         /BQ2NGEvxAAA6pEKQ13cPCFEpl0b5bv1RfaqSEfwydUVZtptf+G8amimRgnKiUojQXt+
         fARtY/+fClQidp1HxzfSTmnf7ndOFKu1869dhm0/BIKH1hwxOZJrjOSToqpj93Sy1YZT
         goLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773936327; x=1774541127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaScdVISl5X8MabuerN24sPj0SlD06sZ93xv6EGI3tg=;
        b=GMu1lg9qUxUXSKj0PPNYObH6DMqhKanWsODEIcpNn8UTXwUr8+NQpIPDXYKTK4YP1G
         MXK9zWUFC9azOMb+AWxEVNapolVSuu9VtufZuD7pd6LtNoH32TGauVeyofBAlWG4AceT
         kofXvRwz4XpM2ShpuGTysmH2dCALpakGOgyjDC1DUEt9ImStVm/vYMtFLpZYI6SfXkPa
         MxdVx+W/0yGcH+BpaIzFFVY2qWWrgKhp2MGIgsLIT0qDhLlcwhaJvpdNDC3pjWFa3hsN
         eTvgnQmOa2tvIi46BjqeXBckPX4DP8VVlPZH9M+fmsJt0ulKLm8FJm+0jW0rs6Kdcg3h
         ALsw==
X-Gm-Message-State: AOJu0YxHgCTkhhey/UgCdoAFHew5BE35I4lsFSLrm0ms2kZ04kLSvUvl
	f1JWoIwT6+iLf2A9F5/JvqzJogY3G3+5nwHRt9HVvYE/8W06vKa3Cjanq3Okb8G10hGFpeBPl1F
	7V0FFVcNLAMIWSgGLqcZXRQRTRP5Xd6VB4C8Cf3csZcpahkZoPrp1YJEnQWXO1+mhzN4Y3co=
X-Gm-Gg: ATEYQzycJ/A3EE+0lZeVa7Wo97clz5ynO7LdvmYw1altk2HW2X7BphhhGVo9LJiSoCK
	uLjynCxXxVmSzeY5s0aIQ/LNiSeLJYv8EyJOTwjEu6+C64ZcP0Thj2WVKcPKT96vrdg+3McIV4T
	53GRPYk6uE0PDno/ZDIJJa6J+BWsqhPR4+rc+n7mFqONyx7cj+EirhUctyiePhqLU574B9sxBtN
	QhRFLHMutP/ZxmrZ0PXLWLSAZtndcwdlW1+20ujj0TXqCmDzrG6ZQBgVrkjPerQxYFz5L7yTzkH
	wLRWBTXMKbxHCXVSHzQSvfg+hc6m6eKieGOo6XU3+A==
X-Received: by 2002:a05:6000:2483:b0:439:c67d:9fe8 with SMTP id
 ffacd0b85a97d-43b527a9895mr13432096f8f.22.1773936326179; Thu, 19 Mar 2026
 09:05:26 -0700 (PDT)
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
References: <20260319133948.396-1-newajay.11r@gmail.com> <66b9d19a-4022-4110-a15f-da31845caad9@linux.alibaba.com>
In-Reply-To: <66b9d19a-4022-4110-a15f-da31845caad9@linux.alibaba.com>
From: Ajay <newajay.11r@gmail.com>
Date: Thu, 19 Mar 2026 21:35:13 +0530
X-Gm-Features: AaiRm53NVarAXJq4ih_GruHqHZLdfDNQ4MOAV7JKFzwVI8io4y2oVHL8otnr5vQ
Message-ID: <CAMhhD9j75b-mM2BMW-gzA+6S9vCU1zF2nyErQmdALmvN0quySQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] erofs-utils: lib: replace bool locked with
 erofs_mutex_t for MT safety
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
Content-Type: multipart/alternative; boundary="000000000000938229064d62bc3a"
X-Spam-Status: No, score=-0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HTML_MESSAGE,MIME_HTML_MOSTLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain,text/vnd.google.email-reaction+json];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2860-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.970];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: C58432CE529
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000938229064d62bc3a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=F0=9F=91=8D

Ajay reacted via Gmail
<https://www.google.com/gmail/about/?utm_source=3Dgmail-in-product&utm_medi=
um=3Det&utm_campaign=3Demojireactionemail#app>

On Thu, 19 Mar 2026 at 19:12, Gao Xiang <hsiangkao@linux.alibaba.com> wrote=
:

> Hi Ajay,
>
> On 2026/3/19 21:39, Ajay Rajera wrote:
> > Replace the bool locked field in erofs_diskbufstrm with erofs_mutex_t
> lock to provide proper mutual exclusion for multi-threaded disk buffer
> operations. This addresses the TODO comment 'need a real lock for MT' by
> using the erofs mutex API
> (erofs_mutex_lock/erofs_mutex_unlock/erofs_mutex_init) instead of a simpl=
e
> boolean flag that provided no actual synchronization.
>
> The commit message should be 72-char at maximum each line.
>
> Otherwise it seems a good improvement.
>
> >
> > Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
> > ---
> >   lib/diskbuf.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/diskbuf.c b/lib/diskbuf.c
> > index 0bf42da..4218df8 100644
> > --- a/lib/diskbuf.c
> > +++ b/lib/diskbuf.c
> > @@ -3,6 +3,7 @@
> >   #include "erofs/internal.h"
> >   #include "erofs/print.h"
> >   #include <stdio.h>
> > +#include "erofs/lock.h"
> >   #include <errno.h>
> >   #include <sys/stat.h>
> >   #include <unistd.h>
> > @@ -14,7 +15,7 @@ static struct erofs_diskbufstrm {
> >       u64 tailoffset, devpos;
> >       int fd;
> >       unsigned int alignsize;
> > -     bool locked;
> > +     erofs_mutex_t lock;
> >   } *dbufstrm;
> >
> >   int erofs_diskbuf_getfd(struct erofs_diskbuf *db, u64 *fpos)
> > @@ -34,6 +35,7 @@ int erofs_diskbuf_reserve(struct erofs_diskbuf *db,
> int sid, u64 *off)
> >   {
> >       struct erofs_diskbufstrm *strm =3D dbufstrm + sid;
> >
> > +     erofs_mutex_lock(&strm->lock);
> >       if (strm->tailoffset & (strm->alignsize - 1)) {
> >               strm->tailoffset =3D round_up(strm->tailoffset,
> strm->alignsize);
> >       }
> > @@ -42,7 +44,6 @@ int erofs_diskbuf_reserve(struct erofs_diskbuf *db,
> int sid, u64 *off)
> >               *off =3D db->offset + strm->devpos;
> >       db->sp =3D strm;
> >       (void)erofs_atomic_inc_return(&strm->count);
> > -     strm->locked =3D true;    /* TODO: need a real lock for MT */
> >       return strm->fd;
> >   }
> >
> > @@ -51,9 +52,9 @@ void erofs_diskbuf_commit(struct erofs_diskbuf *db,
> u64 len)
> >       struct erofs_diskbufstrm *strm =3D db->sp;
> >
> >       DBG_BUGON(!strm);
> > -     DBG_BUGON(!strm->locked);
> >       DBG_BUGON(strm->tailoffset !=3D db->offset);
> >       strm->tailoffset +=3D len;
> > +     erofs_mutex_unlock(&strm->lock);
> >   }
> >
> >   void erofs_diskbuf_close(struct erofs_diskbuf *db)
> > @@ -115,6 +116,7 @@ int erofs_diskbuf_init(unsigned int nstrms)
> >   setupone:
> >               strm->tailoffset =3D 0;
> >               erofs_atomic_set(&strm->count, 1);
> > +             erofs_mutex_init(&strm->lock);
> >               if (fstat(strm->fd, &st))
> >                       return -errno;
> >               strm->alignsize =3D max_t(u32, st.st_blksize, getpagesize=
());
>
>

--000000000000938229064d62bc3a
Content-Type: text/vnd.google.email-reaction+json; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

{
  "emoji": "=F0=9F=91=8D",
  "version": 1
}
--000000000000938229064d62bc3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><p style=3D"font-size:50px;margin-top:0;margin-bottom:0">=F0=9F=91=8D<=
/p><p style=3D"margin-top:10px;margin-bottom:0">Ajay reacted via <a href=3D=
"https://www.google.com/gmail/about/?utm_source=3Dgmail-in-product&amp;utm_=
medium=3Det&amp;utm_campaign=3Demojireactionemail#app">Gmail</a></p></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, 19 Mar 2026 at 19:12, Gao Xiang &lt;<a href=3D"mail=
to:hsiangkao@linux.alibaba.com">hsiangkao@linux.alibaba.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">Hi Ajay,<br>
<br>
On 2026/3/19 21:39, Ajay Rajera wrote:<br>
&gt; Replace the bool locked field in erofs_diskbufstrm with erofs_mutex_t =
lock to provide proper mutual exclusion for multi-threaded disk buffer oper=
ations. This addresses the TODO comment &#39;need a real lock for MT&#39; b=
y using the erofs mutex API (erofs_mutex_lock/erofs_mutex_unlock/erofs_mute=
x_init) instead of a simple boolean flag that provided no actual synchroniz=
ation.<br>
<br>
The commit message should be 72-char at maximum each line.<br>
<br>
Otherwise it seems a good improvement.<br>
<br>
&gt; <br>
&gt; Signed-off-by: Ajay Rajera &lt;<a href=3D"mailto:newajay.11r@gmail.com=
" target=3D"_blank">newajay.11r@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0lib/diskbuf.c | 8 +++++---<br>
&gt;=C2=A0 =C2=A01 file changed, 5 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/lib/diskbuf.c b/lib/diskbuf.c<br>
&gt; index 0bf42da..4218df8 100644<br>
&gt; --- a/lib/diskbuf.c<br>
&gt; +++ b/lib/diskbuf.c<br>
&gt; @@ -3,6 +3,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;erofs/internal.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;erofs/print.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &lt;stdio.h&gt;<br>
&gt; +#include &quot;erofs/lock.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &lt;errno.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;sys/stat.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;unistd.h&gt;<br>
&gt; @@ -14,7 +15,7 @@ static struct erofs_diskbufstrm {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 tailoffset, devpos;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int alignsize;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0bool locked;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_mutex_t lock;<br>
&gt;=C2=A0 =C2=A0} *dbufstrm;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0int erofs_diskbuf_getfd(struct erofs_diskbuf *db, u64 *fpo=
s)<br>
&gt; @@ -34,6 +35,7 @@ int erofs_diskbuf_reserve(struct erofs_diskbuf *db, =
int sid, u64 *off)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_diskbufstrm *strm =3D dbufstrm =
+ sid;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_mutex_lock(&amp;strm-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strm-&gt;tailoffset &amp; (strm-&gt;alig=
nsize - 1)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strm-&gt;tailoff=
set =3D round_up(strm-&gt;tailoffset, strm-&gt;alignsize);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -42,7 +44,6 @@ int erofs_diskbuf_reserve(struct erofs_diskbuf *db, =
int sid, u64 *off)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*off =3D db-&gt;=
offset + strm-&gt;devpos;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0db-&gt;sp =3D strm;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(void)erofs_atomic_inc_return(&amp;strm-&gt;=
count);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0strm-&gt;locked =3D true;=C2=A0 =C2=A0 /* TODO: n=
eed a real lock for MT */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return strm-&gt;fd;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -51,9 +52,9 @@ void erofs_diskbuf_commit(struct erofs_diskbuf *db, =
u64 len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_diskbufstrm *strm =3D db-&gt;sp=
;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_BUGON(!strm);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0DBG_BUGON(!strm-&gt;locked);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_BUGON(strm-&gt;tailoffset !=3D db-&gt;of=
fset);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0strm-&gt;tailoffset +=3D len;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_mutex_unlock(&amp;strm-&gt;lock);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void erofs_diskbuf_close(struct erofs_diskbuf *db)<br>
&gt; @@ -115,6 +116,7 @@ int erofs_diskbuf_init(unsigned int nstrms)<br>
&gt;=C2=A0 =C2=A0setupone:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strm-&gt;tailoff=
set =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_atomic_set=
(&amp;strm-&gt;count, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_mutex_init(&amp=
;strm-&gt;lock);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fstat(strm-&=
gt;fd, &amp;st))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -errno;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strm-&gt;alignsi=
ze =3D max_t(u32, st.st_blksize, getpagesize());<br>
<br>
</blockquote></div>

--000000000000938229064d62bc3a--

