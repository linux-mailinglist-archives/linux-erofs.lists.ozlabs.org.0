Return-Path: <linux-erofs+bounces-3081-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNiHD7aKyWlHzAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3081-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 22:25:26 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E6A353F3F
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 22:25:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkQqQ2Rvkz2ySS;
	Mon, 30 Mar 2026 07:25:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f31" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774815922;
	cv=pass; b=EZhR+Tcd0Crczx7kTXXmOw0dYrSLRER7+CGJqaHHzMVy7AGg+i9N+sCXxXAietoOMx8YodoDxBjvSHDiWl6VC44G2b5ESoXRhCtnJSf2NRe/LFsiDMKv2wq5hveiY8t3YK6Zdbgc+PTSM3/OdFYnMiLHXnhCSEU6r4yvjMWlo/jWXSmxWPoX2VgFImR645Xfb4twCU7FKEurEX2zewbFLJYiTViGeckOLbuwcyy6q8u3r49Yw5+UMLFcfkI1odKU5Tyj5GOEbfEgc79LeNOCw3HkfXfOc70P172dk1ahEu2XT9FRiJ7n2styl/ohTvWUNMCDmje7OGNVB4TQtWhScA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774815922; c=relaxed/relaxed;
	bh=A1GIlkJy84ys75qYGXLodOIzGZU1OgDEiMy4UeL+sI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gevS88lx9iTAkGx3/TDEzWtrY9G2H6+rb+M/xPLh0Qn7lBtKcU+U3kghD054n7RXefv1pQNSenlX5t9OefOjjO1fGiJkPui2XzBB2hBd7g9ozEIL4LeNZol4dBrpihtjw/AzeoD3y15gjyAy3qV0dM0gnV5pgqAGbQJvq9DoEOgdhNf/IzWY4jDqBLJw8vOZKzDkGbYPNXNj2I7KV9VLg5FkqFs6gc0rrrAFRTLq9PWQGirHAmmsD3/pEFs4JFLBiBEuELSDYfQEEOrZsKQjv+jElgimt4xvSJJP3nlDVPtnVtebC/Qbcq/Vjkr5y4bIm0Ufcz4uFRqyznmoAKTnwQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EXklKdPd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EXklKdPd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkQqP4MZRz2xQr
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 07:25:21 +1100 (AEDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-8a06007458bso188196d6.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 13:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774815919; cv=none;
        d=google.com; s=arc-20240605;
        b=dDMhv05X9OpNqdIHvZDDevj4E1Z+a7E1Xgj4mHQ/i/vC9SPcLnEoGCeVguHVZEeO0I
         Z1s8W/POkZz1NMD5Pf4+y+XIoLLYs7sZ2ReQWk452Y1pH8pMjUAV/GvbOqbFVmvcxmMg
         6W1iPm+byQJXR/1C+TAgO91Y/staeoTCxVQEk9mBqRVmMv2rEq3TnjlYEn5ZGlPldtrx
         1SMJns5xMHJ/pRNC6WUy2Ri76OHZ0vx1XNqpes9LRXqQtK8unjPn8Av2/A0jZ2BEAAZs
         F8czZre5lxkeU2G0bC2lL7ccAPyXvH9afJqaZtPRu/hpIl08xWIZFnTS+UhufmhIUuQS
         IWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A1GIlkJy84ys75qYGXLodOIzGZU1OgDEiMy4UeL+sI0=;
        fh=VwYNKeaPOXRcX/GbJiQlatLgyL4SoyMyaJNR6gpb6V4=;
        b=JD8wpC/Nqv+Hh7OxydYY/RNWcSaGjrQFZL18ZV8Yz4llCSF0b5TNF9aQFffAIH9pIQ
         ScMHKtxD7JwT+mQG4VYi8kegJQoZlKTYVJ0GywW7ABCgdT/k9xftksNHojSpYfVRAFBU
         5k8sCsuk/rTzICU1Kz6Jrve1Zz2mGan5/ykA1e52Klh52Op+LOFAgECNAwkN7fMLV8xE
         BKqJMAccc5dQgQWzCcabdku5DORjSRBgunZ6W0/ROMbrkGxdx06AQ7Kz+JoO8WX8582Y
         TDAu+UiXonm/2lxv049MwglV0mXe1vInljbGAH9whRpsunGGyV7ilWv1jfaqtfL5/YDD
         I6sw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774815919; x=1775420719; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1GIlkJy84ys75qYGXLodOIzGZU1OgDEiMy4UeL+sI0=;
        b=EXklKdPdCG6hQh11Sb4FZBfn1QSflqCwjQGKcqtEda8U1JPCURC6hwt14hnBjGkHmV
         cjvMkMafvKhgEko7nBGRS/jAmYLA+DJMcqeQHRg0/Hv8VhD/CQMXJxijboMeuEuUDK06
         Bq8o8PmnfvOA9O6/qD6ICuSxA9afDc6wJNGTLsTngGwnNeOzYxIRQXvvhuAXgUPBFYQn
         nCRkM/N2sNAa4uNrLvUAQjoFgE+IaLOAqG9v8RKInWaOQjSRDF+DHOSFotVxTJZYBIbU
         emy9l4QKwtQMSZXXbh2qd/pJy2ljGvHU+vPdG34515JaUQ0ZaGVT+V5DSv7LpHS6OiZ/
         H0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774815919; x=1775420719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A1GIlkJy84ys75qYGXLodOIzGZU1OgDEiMy4UeL+sI0=;
        b=p0pZoBFM9KsUPOOYc1Rlv67AS/BGqucjFjA+wLpy+m/N92Tr9uruQhC286oBeTRUYZ
         sVyKf+xnE7z1K7mXTCZ6iI+ohWuhbmoe2BaVo07nVH5nwQclE05kOgzFeOGLv+6gaARE
         9NJB2v+sdO/P3Aiz4xdHeUpBZc/pqO6hatt35mZzItUzGnOMbotILyfMEoZZgZVu5rLj
         SvA9QMtrTVN6cpHefXgCtEP3MM51fDsAMeUrbaSjVprY3hMnQa13LBE8JTFsY/fn3mNC
         uI3FWNLpXMUkzO6X7BXpjDLpFXSUfvXUAbf6C2BT9JMXGkobi5VqikN/ZtaSz2rfXRdT
         fYtg==
X-Forwarded-Encrypted: i=1; AJvYcCVWbThHARPwwfD1sIPN+J/syj6UEGpZv/VUF4gVNEYDGqP2MlirmET7UcOMdENBGi/whpi8tt3P9TmBLQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy4fCEPXy0uFkeiKqaPw4nmvKvS8EpQwty0gu/h3VM9q14thGKD
	UwSerN79zc91heO0UtkgRrAPgEfpfMwmhIz7bOKcfabCB8P9GMQ+a8W7qPRWO1WqDWk31jOaBTv
	RlpvcS/5N0gHhcsDvlj/kXeWl73LI3vs=
X-Gm-Gg: ATEYQzxcKAoCoFRFFpYzlzX0pBLNKhTHKX9eEcRwbDIRj0VIkE3MDvBMe1Q40eBApMg
	FMe7+h0SDwQ6E8Ru29QgZ/LyOJjNz/M0MHCcBnttoYiiem1WqOXlemKn3DFDlbDHsI254HphhzV
	R4owBSxTj34XPiuyid76Xi3G3MHinZzOvIigpLXrS/QuPgc8ZxsghoK3rT+FJBJaJh+WnBQMVBB
	IynYT9kcEJ+HIQ7eZ+dzhm5KfHNBPbd4uhM0MH4EtSgxhB8V5negi48/mWnfM+4arHeLG54XRh7
	OTlebEMBOvbuberIIqCvSIwcna7O9agWUBBpEIn8UkBvtjmyWjWSNx0wd6ccxjnkh5+k0sbT/Qh
	UwbJ7
X-Received: by 2002:ad4:5f09:0:b0:89c:c8a4:c54c with SMTP id
 6a1803df08f44-89ce8ce2eb2mr118847796d6.2.1774815919128; Sun, 29 Mar 2026
 13:25:19 -0700 (PDT)
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
References: <20260323052257.11377-1-singhutkal015@gmail.com> <20260323111901.44548-1-nithurshen.dev@gmail.com>
In-Reply-To: <20260323111901.44548-1-nithurshen.dev@gmail.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Mon, 30 Mar 2026 01:55:17 +0530
X-Gm-Features: AQROBzBtjIQXEXDJCaeO8HDuaKmPskZrUt_Vri7az8N4LnL9ZUXyo4k407IUVmY
Message-ID: <CAGSu4WO+q_zwjp_c3Bbk6eGEDiEpjhHf-8BOiKLaW02mJwS5Jg@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: switch ZSTD decompression to streaming API
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3081-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 48E6A353F3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Gentle ping on this =E2=80=94 happy to revise if there are concerns
about the approach or the streaming API choice.

Regards,
Utkal Singh

On Mon, 23 Mar 2026 at 16:49, Nithurshen <nithurshen.dev@gmail.com> wrote:
>
> Hi Xiang,
>
> Can I test and verify this patch?
>
> Thanks,
> Nithurshen

