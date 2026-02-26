Return-Path: <linux-erofs+bounces-2437-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Y+6aET7ZoGkDngQAu9opvQ
	(envelope-from <linux-erofs+bounces-2437-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 00:37:34 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715341B0F22
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 00:37:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMSYN0P2zz3bf2;
	Fri, 27 Feb 2026 10:37:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::332" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772149047;
	cv=pass; b=dPz5EnZBz3/rtkxJAwI7LBw028LcTDnZMmfQOgXsn3dtQfzeIkQ2IF2xAkV6ygSv1DJEohkRm7kjP8mGDdqPC+lsEZnsyXyJFZRLFcg/gI3H/ePSvQSq5Chkd3zxCdN2yDmp0NbZDxFLnrjHm5xUJQiDX9NCVbs4yvlqZ1D9Dj1SmSKqPpVm6wPlNEEUQL9VexP+Oq13rygv75gE8g3JL28d0qX35B4x5HFfvXyUdq6WMK9ZSEPRcFASEnwvFLHRCdYVV2qQ1ubTFtJcGaUACPP+DGjWPyp8sXkYtXsDpDfhunQWpkvTtaVB/7FQ+25gAFcaPb6/g+mfhwu17hr3ow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772149047; c=relaxed/relaxed;
	bh=KEMFGMuDeUZB2kl5lM5hDNuIRnQG+Wt/6kYxLRPB0zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bppLqjJiaXDutX2WmwbweUOfzTqcYXQv42sCoUZtKXBdphGHx0HJUxISZ05m+wNhlfHtNfgvoxHRVgqbSBpaVfK/uj49zDppQFvhoABLL/zGQo4S7in+NaeAc7n9bAYhAp8d8SwZ7lD/4HrwhOeDjec4iffkcep47+i/c6Qo/DmMVk5lcWYqEfetmxAqXKo/IOkE2mYvvxlQ4snfTr27PCrO7JQdM1SKEHn2957Lv1uK/WIYVmdFfdzo70xLLug3xdb0LixnK3Mxz0Vm9f/3Js3QmHkSE81NAmMtwRklbvSOiYPE5H2psJ06tG4MgLQ3zJBpVbHVOVPJOcFwQ239OQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YDeSnNJI; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=yester1324@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YDeSnNJI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=yester1324@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMSYL1l5wz3bcf
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Feb 2026 10:37:25 +1100 (AEDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso15324775e9.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 15:37:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772149037; cv=none;
        d=google.com; s=arc-20240605;
        b=E/YiPbu9gnaJ7z1mDRJsffheClSCIQ0tSTeFyv8hGQGc+Okd6jDDUfAyv27D4t3+4e
         DWpDE70NcUj/PXPO0ySkm+KrhMOCZG1mUH8fm11Kzr5UdHkUFYak1hedkBAD+yMWdxEP
         YOrooLUEHnyIJtqZincHO1aNn6CSmN2baXzv5LOwEwAeGGJ1UHz8tEtfWLbZ2tc+Rib4
         Vvr4Muxb6zIxWiry48xoD1CqA8D4X4vI3Iula2nH6G3503wvdrnuFcJlgYbTTbYbDdYn
         A3kM1JCsHlBgtu4t4Jg7t257jSxNYI7yippLz3VkHhmPcIzFynfQ5OCgIVCotaQxAlVl
         Z/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KEMFGMuDeUZB2kl5lM5hDNuIRnQG+Wt/6kYxLRPB0zw=;
        fh=1B1+PHblCUVa3z3dinz/uYIOXx9+4nNLqhrHc2P0nN0=;
        b=E6YC6+IEnsFeP/LnKCRtefXauRxx4Xw4CM/lWqvyfJcCI+7iUPZFLvHBxHV0I7GB+y
         10UlwJXLwwg70YD41JHMnn0pfQ++o9CykDo65CLNfHCHn+xrn0aRW5gJx+3RJ/eBUdZv
         aDDwSI2xT2RVL2cYBaHiEVu2fiufVEHh457P5VDSjeZm8ELmuiFuSbJMlCqn6VJ/ynQR
         oeJkyOoNm7N0me9F4/Wt2sDZLvyZ9sKwjRRviugD9k41MuI7kE/grF9TXxn4G0xdmAyp
         CQkTND2A0iYS0oNyhCEPvJEjgTYhw/QTdrz8oV01kzTu3F4ohdqAcWo+/y5GPT02QChI
         8rzw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772149037; x=1772753837; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KEMFGMuDeUZB2kl5lM5hDNuIRnQG+Wt/6kYxLRPB0zw=;
        b=YDeSnNJIjNicxfRHU6qEKcegNwmVjRXWiJYKajOI6XsD0d9MR0EolmOHBP4t5fZFPq
         Xi2amDYSuRFwQv+EFUqJaQdkMWj0XGCJC+WCA4kjK6T5tTwko4nwhueEq7yqp6jAlPCU
         7Nmleo1W543KpB246VVP6oEP1z5Gup2QjbAdSFWPwUcBGrR56d1WAhQPebmpt057x8nS
         vsja3LjwXoyEUxYkEp5y+S9pbv4OrwszSZfP//H5WHJm2RZ3KGiCbtQUMDZ9fYPhCPhz
         +scbeeuGuQYItKXyRXH1dDxryiSqQY9rWJ2p2qVAXn1q6WnjM+ZyqYHUWG2Obj7F1UT5
         Vxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772149037; x=1772753837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEMFGMuDeUZB2kl5lM5hDNuIRnQG+Wt/6kYxLRPB0zw=;
        b=LtA8dP4DjIB//vUd6U+1KeDlFQCQpg6GKrKlBoaOhIuSk/JfZohRyWAp1yFcuMC9n2
         U95L+/CgsXuGyk6k0Jg9DxHUHWhiDK/X5yx4IcO7eUbPDtkVWwRLxi02Wu9N2nVU/csc
         770s69KjB86OwZz01GXyac141V0/6+xi+fK2YVWKXg4Tk1GOD54JHTnmYcnNe9Wwq2co
         v2vHG8nG+PAy8EVKauoJ8u/vpjsYZ6GjWHXyPiu+VlgaFXfPfGEF/Fx0t+KLc4z+Bdw/
         rUHJLhXrdEZcMrkD0LOKI1Gy6M/ITbw3DOwFU+F44swlwLuyt6Dyp3ruwx5zINW7ckPq
         xFSg==
X-Forwarded-Encrypted: i=1; AJvYcCUbls2FaxwR5eOiZuinpw4lZ8vSysxWg6VHz6uVNsyf8BfA2k/PgZBvO/O10bkdj1uuJQWJi5xv/t1r7A==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzU8oXMqe1ZOx1ORQOuNoZzeEv7tme4B/T06HESGi3R9BhygjwK
	jwu4s2kWpc7b5n2mGgDZKVEuVulus3wC6/dnzP44M0FDDT2CfjlvLwDYHowvJ5KsZylOO9BwFHl
	Z7+mnEvV0h6fp+FJbdl/o02dNGyGmjyk=
X-Gm-Gg: ATEYQzxpcl9CepN2LLDtnZ+/H2/pjOWyIz6QinTPi6eezPZPjI7eCu1tOVI75MOf5hr
	RwduwC+fnHoHRdlnebK3newi1l3769f1iklgbTxZtgJAuWkd1LpsIqqzO4tvc6Ot2CeFFuzkiUC
	mW92Pu5oDW7acWDVKtiDvLLnQdIW5qBN5I/sLXiQErpjNdn2aY4ZmlBxNWnxxGiQiHYmBB1+B8P
	sIt7Od4+7vwyJ4bu0LKuVw9EbC0E72Ju7DnWtIerxHYnygCIbvTI1gxZ9LkDCWX8LW2sP2eBMf1
	+0fCpA1CoUXu8rvyLQ==
X-Received: by 2002:a5d:5c89:0:b0:439:87ce:27f1 with SMTP id
 ffacd0b85a97d-4399de1c4d0mr1082642f8f.37.1772149036848; Thu, 26 Feb 2026
 15:37:16 -0800 (PST)
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
References: <20260225173036.194311-1-yester1324@gmail.com> <tencent_E8B3BD7F4663756DD9915EF539DC95AB1805@qq.com>
 <555e6fbb-79f9-422f-9b43-bc655a106229@linux.alibaba.com>
In-Reply-To: <555e6fbb-79f9-422f-9b43-bc655a106229@linux.alibaba.com>
From: Ashley Lee <yester1324@gmail.com>
Date: Thu, 26 Feb 2026 15:37:05 -0800
X-Gm-Features: AaiRm53_3eC7WQo-2jrrhuSw34M8cxOL9iPU1S33iPcnzuvdJ12oRI9r43qZboY
Message-ID: <CAJvxkqdnEMMBOBnXoVz7Ox6crwjWZVMm_Ve9bN7gGzFRHY-vwQ@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: lib: converted division to shift in z_erofs_load_compact_lcluster
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yifan Zhao <yifan.yfzhao@foxmail.com>, linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2437-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:yifan.yfzhao@foxmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yester1324@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[foxmail.com,lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yester1324@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 715341B0F22
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 at 18:40, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
>
>
> On 2026/2/26 10:32, Yifan Zhao wrote:
> >
> > A quick search shows that x86 kernel implementation also use `div` instruction
> >
> > under Linux v6.19 and GCC 15.2.1, add GCC correctly generate shift instruction
>
> Could we try more GCC versions and find the impacts?
>
> Does it a recent GCC regression?
>
>
> >
> > in my arm64 machine with GCC 14.2.0.
> >
> > Could you also consider evaluate this optimization in kernel?
>
> Yes, but I wonder if `div` is already used for these years on x86,
> could you check this?

Hello all,

I'll attempt to perform benchmarks on as many architectures and
compiler variants as I can. I was looking into lkp-tests to perform
this however I was facing trouble running on my OS. Is there a
simple way to do this?

Thank you,

Ashley

