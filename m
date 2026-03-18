Return-Path: <linux-erofs+bounces-2832-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNZLBDenumk6aQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2832-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 14:23:03 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A252BC14D
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 14:23:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbTz73Nnlz2yjV;
	Thu, 19 Mar 2026 00:22:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f29" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773840179;
	cv=pass; b=c6WSDHssydbPAdY7W4qkIPju8qY1NjZqY1/q88wnO2r2WuzY5zlbNg3GeQoBpB8PK/wDBsHXms6nH/Py+TYHGvcWOc15i22oojfja0YCsZFZQyWE53PsZvXlrc1FGGP96M+6r4LDfj8tyLb7PD1NqdZM9CvDg3aby/Kgp4KAbqRwV2HBB4DIBZMwspKLCpJHsjCwWETodVb+bbdDfXfwB2O6HZxOI81I412aL/8fSAIPeXr1AYnP2gJviB1O0280swFo/9hLbJz0NkJQukw8bl2wWLK2DISmg8a3f0P46+oL8UfOp9OSh+xMyrGLopAhVYb2glGHuLS9PFRY9L5vwA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773840179; c=relaxed/relaxed;
	bh=laNxBvwe1QTGUGwbbVAcD58GngvnKWdxivSIlxFAioc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIBKujEZX1viK296i8uhF7j48EceylgOEXcXsc5wVopPU3j2uVKI1QEWyzS+CcNx8GUJRPnvynJycj3bOAXZPGKnDmQ8BbOezEMEIG7x1xMOtPh0JAXdYYM95zujgctZkZf61M7YFm0mGmmBbeia832eWvLFy4n+OiyQjrBPP17m+Hq/C73UUsm3FyTSG08sPOJz3cXRZPBivfMA/8kLs9N+Y3UM1lF8GJzoNYvhe9OqaDNClsdb1gnucpQM7kGNdWwuqcHx8LI4L7s9OksMZWc8Bu+tNkrgBgJMIEaEcn8yABvd3BsK15yWPiojFOpxfQI+GvcODLfmp8WURtvgiA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fdXwKadD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f29; helo=mail-qv1-xf29.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fdXwKadD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f29; helo=mail-qv1-xf29.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbTz62hSQz2yTH
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 00:22:57 +1100 (AEDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-899f3cc8e4dso6663196d6.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 06:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773840174; cv=none;
        d=google.com; s=arc-20240605;
        b=VoXYWlqJGRO8L4nPqNrvqHuqb82A5fKm6T8H5cY2jaqQ5iH9xz64AJCSyi2m8YTFcJ
         SgD9Rhi0nWG6sUevsnQdx3/cm0iqIVXJ0merEwuXRtGxqJHYfWmtSCXztrJ5ce0QSSov
         us0QU6QNt88wSLq03zbX1A/uOx8UaaU1RVMa/JruOZTLQm9rnRFSjD9KEU9embaey5wx
         47YZDFtl56HIBHDc36JOU0kGOxvic6vy0IlrGgSHmqhwd4ZGGbRiCwm6DlnOW5CirjCt
         pxrHtYktaNRvx6O4MzzhYPYkeXAtbXKhOMcXoyDqW0u8lte7WsAO9cXiZp/xSdWyna6V
         ALVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=laNxBvwe1QTGUGwbbVAcD58GngvnKWdxivSIlxFAioc=;
        fh=/f06KFD83xW3QRpLb3peFa8ssu/nXeh3zjn6ME+bAzs=;
        b=BSdvqkm0tkuybKqJXReA/N7zOO9zSeZEX/bmdENV/hONNsjfnrfD36rvGOAZPa/njZ
         XxuRJjbYm/ld1TFxOiendrQ9Pb/Eqo3Bg23RO0nUqTkUgPFcRPIJKanCAx8fESPIOF55
         AB5pH+hHwdSjOHcOrGLUvdCjum+qboZhDBbmwk7LJCnhtHVCCaDYrv9xfECCTjDeym6z
         wk1d0WUUramnsnx5r0shu9L+rvgv6EGgGXhUygUm1h6jfXlLtVV39BBSoA+ieM8b33xT
         1mdPOpOyo++te7zHF2b6noplnI2B7VivWq0UJSFknBXLgkAIiK9y40/Qvzv+BUHWgyC3
         3SmQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773840174; x=1774444974; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=laNxBvwe1QTGUGwbbVAcD58GngvnKWdxivSIlxFAioc=;
        b=fdXwKadDKy67fzlNNzuadLvBmfjsyc4wbyXeCqfODE3UDxivelxhZktzOjGGD5PbsU
         EM2zjFLQ6//4kuW/aH/0N+P++nT1BtZyctiNE9tpFRu4bGWTCTZkHtBgIJLk5yjlxe2s
         MsZjIpbhfxwrnXh8+ijPomEPR4XA0z+a8J/cRR8Hyw6gNn8DadzgNQTh0FFrvSiDnsVz
         jJ4d+2eMC6DjGfEZw0lHYm59UDVr0q+e4Ir/SgOA8FCsC63bQ9/D/lir7CMqVwIAGe2H
         phJccmeKWiwIZ0MFMSozdQZA0xgWpjij6MN970OYExZ378BwFEmtjx/sEkn+iT7YMwi8
         Kk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773840174; x=1774444974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laNxBvwe1QTGUGwbbVAcD58GngvnKWdxivSIlxFAioc=;
        b=PDKFT6b1qcGC8/Ci7q+LcN7B/VfJ4osWmvhzkIpKvbwwzp31pgzqUWmnWAUY64dxL/
         caVUtjUq6qedlVpXkhNFrBrGRUNoIH06OZOKDEz05w0QpKqHKC5/QJhNTUTGw1bMAbge
         8z0+1cF8lOy6f4WUOGo8JXguYboSvzuEXJOwtTxmngeiBCyPKnU7oVZDM85Tw416WMY6
         d4NaSAzhwXlwzZ61PKNTnUePa6plvXXIxQ+We3dh0n22/ER0ipZbVIjXgU7d4P/DsQEc
         iMCaK6R8eNNmKmLwAUMQusqvg125An+ScLnjOlkSxNZYRrPge/gSDlltmhc2E5oRm+Hy
         ypFA==
X-Gm-Message-State: AOJu0YwQ4/aJ2AidyIFNe2xvj+tAAKCWozUpy9oU86z3bIDjQxaCNqID
	DWXg8yOT2ZElB+bMqKqFdxB99lEmYBJ3+FtpDQcdx01B3KvuYIbl/FA4kALCcuOzHByVjg+KzXg
	MpjSGkdmxLiJPY0S419uzYPufAtmSIAI=
X-Gm-Gg: ATEYQzy16TGyOSwBLd++y0qEloPU7v0mSpu3Wj9yg2bvoMp8QbPfCXsMT7PDozy4WGF
	OyiuBWg2DkDX4z2kgLVwMVKLXmZxEypRP9HeKR1DTDSVmvg1KmOTv6zpBGmkQOBa87GgR2FKqJs
	eyEvTtVvTWnPxNdg/6DJzmhJxZeZzdb8hq6qjls7I5a1vmnR/CB1Xc7CWLjA9B2/eIe7JOlKrA2
	ueRZ/l5jRqWsOTiecqfWSp2YMwJht9HJLlDTFMTRNMOX1BlcIA58DBBva1OLTT2rkLb8aBTt/lm
	nif9C6H/VeAl3dFbSdJkJ21bj/c0xs/drHTJtBOAPbMpBKZHTih77rcXsYddB5xf99vt
X-Received: by 2002:a05:6214:528c:b0:89a:4b00:bf42 with SMTP id
 6a1803df08f44-89c6b592d3cmr38120696d6.4.1773840173674; Wed, 18 Mar 2026
 06:22:53 -0700 (PDT)
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
References: <20260316085300.19229-1-lasyaprathipati@gmail.com>
In-Reply-To: <20260316085300.19229-1-lasyaprathipati@gmail.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Wed, 18 Mar 2026 18:52:47 +0530
X-Gm-Features: AaiRm53stU89Ke-aE2DjKA7OnhvJbkvvecM1pL8aFQIYhkHzlfIocAFC_tk82G8
Message-ID: <CAGSu4WMDvSLrVZOXn5y-5b5-7xPSpc2vHUT9dNeKUA6HLWDqdw@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: lib: fix potential NULL pointer
 dereference in docker_config.c
To: lasyaprathipati@gmail.com
Cc: linux-erofs@lists.ozlabs.org, gaoxiang25@kernel.org
Content-Type: multipart/alternative; boundary="00000000000070b342064d4c59f1"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2832-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:lasyaprathipati@gmail.com,m:linux-erofs@lists.ozlabs.org,m:gaoxiang25@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 22A252BC14D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000070b342064d4c59f1
Content-Type: text/plain; charset="UTF-8"

Hi Sri Lasya,

Thanks for the v2.

The fix looks correct. In the original code, if
json_object_iter_peek_value() returned NULL (iterator at end),
calling continue without first advancing via json_object_iter_next()
would result in an infinite loop on the same invalid position.

This patch correctly advances the iterator before continuing, which
prevents that scenario.

Thanks ,

 Utkal Singh <singhutkal015@gmail.com>

On Mon, 16 Mar 2026 at 14:23, <lasyaprathipati@gmail.com> wrote:

> From: Sri Lasya <lasyaprathipati@gmail.com>
>
> ---
>  lib/remotes/docker_config.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/remotes/docker_config.c b/lib/remotes/docker_config.c
> index b346ee8..6401c1b 100644
> --- a/lib/remotes/docker_config.c
> +++ b/lib/remotes/docker_config.c
> @@ -202,8 +202,10 @@ int erofs_docker_config_lookup(const char *registry,
>                 }
>
>                 entry = json_object_iter_peek_value(&it);
> -                if (!entry)
> +                if (!entry) {
> +                       json_object_iter_next(&it);
>                         continue;
> +               }
>                 if (json_object_object_get_ex(entry, "auth", &auth_field))
> {
>                         b64 = json_object_get_string(auth_field);
>                         if (b64 && *b64) {
> --
> 2.43.0
>
>
>

--00000000000070b342064d4c59f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Sri Lasya,<br><br>Thanks for the v2.<br><br>The fix loo=
ks correct. In the original code, if<br>json_object_iter_peek_value() retur=
ned NULL (iterator at end),<br>calling continue without first advancing via=
 json_object_iter_next()<br>would result in an infinite loop on the same in=
valid position.<br><br>This patch correctly advances the iterator before co=
ntinuing, which<br>prevents that scenario.<div><br></div><div>Thanks ,</div=
><div><br>=C2=A0Utkal Singh &lt;<a href=3D"mailto:singhutkal015@gmail.com">=
singhutkal015@gmail.com</a>&gt;</div></div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 16 Mar 2=
026 at 14:23, &lt;<a href=3D"mailto:lasyaprathipati@gmail.com">lasyaprathip=
ati@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">From: Sri Lasya &lt;<a href=3D"mailto:lasyaprathipati@gmail.co=
m" target=3D"_blank">lasyaprathipati@gmail.com</a>&gt;<br>
<br>
---<br>
=C2=A0lib/remotes/docker_config.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/remotes/docker_config.c b/lib/remotes/docker_config.c<br>
index b346ee8..6401c1b 100644<br>
--- a/lib/remotes/docker_config.c<br>
+++ b/lib/remotes/docker_config.c<br>
@@ -202,8 +202,10 @@ int erofs_docker_config_lookup(const char *registry,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry =3D json_obje=
ct_iter_peek_value(&amp;it);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!entry)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!entry) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0json_object_iter_next(&amp;it);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (json_object_obj=
ect_get_ex(entry, &quot;auth&quot;, &amp;auth_field)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 b64 =3D json_object_get_string(auth_field);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (b64 &amp;&amp; *b64) {<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div>

--00000000000070b342064d4c59f1--

