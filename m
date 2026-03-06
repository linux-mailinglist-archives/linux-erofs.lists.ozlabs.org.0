Return-Path: <linux-erofs+bounces-2531-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL0gNfvcqmlqXwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2531-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Mar 2026 14:56:11 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4D22222F1
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Mar 2026 14:56:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fS7Gt1kWwz2xqm;
	Sat, 07 Mar 2026 00:56:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::236" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772805366;
	cv=pass; b=Rc7kL2iCJEvHFGXdjcKxwwOUyfvXYGR9KZFyskc4zqLaT2myfCac9VtiirNtCikt3NcJX6G7zhk6W2K5vgTyQpnQDgUU9O9aBVByqBVQidpJVzORNQWHB1KZ6R3RgQCpbojIBbh20t48b8wUMdRmncfJ/7lG8O2bMeZiMXFkBRlYSfdXJgEK4KeAZWJBqx7c0rDtlrTmflHGv7nBQvwqi6hb0U03p+VvM5GJ2/Vszf55PAPoW7knG4YS14+z24VBwPxEyU2bdoStqt/oMt0LPs5jjJICT5mVJ2TDB6jQMomqpuyI7U5l0VKBIHgAuI/zsn2kbTpMoSinNyKmH8AniQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772805366; c=relaxed/relaxed;
	bh=AhcgVF+rVAlbyPJryqQe1mCuLKgrnb29YUxE/nFuBj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeCYDt9LAFYb8iO3zb2PSEoHiN9jbFnUV1ivR46K7B4kAz4qfT0rmAbVVdZjsXRIwKS/Oa6SUWyyJFhoMBT55By+S+OBKe/2H9xjGZfGkZLUvMdGKRp8c/1c0YysAUkfQA4dy473tzj4agQo+GkujnCiuLo3XUEM5crNaxGm6xj9xl+cA/AoYYGarFfsJl0yOUqaiWBV8Kg0ZHq+PBDCLP9T8U9WpMbQj/cvQk/hxnUQVmRCZ2wJVG8ifXeGKSxCuaA8fZvaVwE4hNElNCt86E2Jnx4TcXr7nE6bzbDnn3NAGHIGYiY4qL9/VFqXPPt+TjThw0JKBXoWAM/TLU2Gew==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PS9CKCCh; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com; envelope-from=aayushmaan.chakraborty@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PS9CKCCh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com; envelope-from=aayushmaan.chakraborty@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS7Gq6XG2z2xYk
	for <linux-erofs@lists.ozlabs.org>; Sat, 07 Mar 2026 00:56:03 +1100 (AEDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-38a439f9b43so2181341fa.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 06 Mar 2026 05:56:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772805359; cv=none;
        d=google.com; s=arc-20240605;
        b=Tc/7LlGQwWMzOg2QT7GFvoQT6rBYzgdm21DASCZ6XJvWVrCtLeezyTbt/hkKvIFO90
         ah1kCJXMF7pnr04xDaNwGWeOdPI30cP1Mnigw+ca/glDeNLCWiunG6aBxcGxP61UGEdL
         /JiaPGtjZBIUWtstSSA4VFBAKvdRCzpzKLTNPgSdAUyfw0hnzJYA5tErpFIPmKf8vcYG
         RkhkCCKgpgVLXa+aM7nyeERccSFr88+QF4CeDAeIYrj3qsVkV0ggJwo8+kDTbpgp/Lrx
         xKj4kfr4/n8YWvqSDYbk6JmNo9DHsCyaNOWqCppgTKjLPB57q0HzED6NTjrVfxTiFHNq
         NMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AhcgVF+rVAlbyPJryqQe1mCuLKgrnb29YUxE/nFuBj0=;
        fh=WJhIciIiNZdDmLC1ZQ8ngNos9wKcoX5v3UjHHDA3Xes=;
        b=K9KD6nbf4/kIiWE5dpfwl7k8z8SRYreExwmEyX+WtWOQJTeN68Iv7b4O6xMm/mX0sA
         HzGIn/jCIgGolbs8H79IyHtNvIE61FsSc3an5qAg5KXIdcEni3Ni5W9xFCwlprmekTkl
         iUIblIn8kANTjaxSLs+QcoU5Yisc9wb/AkYlurokkG1zBrMlnwyNKX5vqqP3ExkmPFDQ
         G14bTyN3mhue6hvnp1ldAgYH5gTJMGxEdZoq0v4HtWo5ljDRNKs6rM8aGldWRI6jh97v
         WWqTNv0FJutNah6JZc0BKXGX4XxGymR7JQiKAxuQ3dVzkyCggLcsLL98j/bbNJTnxvpA
         O1GQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772805359; x=1773410159; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhcgVF+rVAlbyPJryqQe1mCuLKgrnb29YUxE/nFuBj0=;
        b=PS9CKCChQMENE8TbuBSS8noAIjqDiYaDweZJY59IayZYbdbZ2ING7IFqlDaik5JbaF
         0jc5CzZPSo+a1+VigUbLUeL/MxaEG2o7wVUzIAbYJH8chULLeQT+NoxhPkEczqOdEiii
         Mb2+gGTWH8YWXGLP0FBqVlYdEbtrIj3OlUl8DZa6RceyvfGjpirAodF1VJbi6W6ZCvK3
         6MKoP+ELUoWT5TMgfEZ08yq3xa36fJqH74ya87dkQsgdTsmvp0z3VJRhOL2+UlBNl2MF
         Q+o6hP0Xf6lrBMhZrS/5uDS3aaS+X0e0HxvGjg+iXQ4+MCZ+qwJhvotghmJY/yNtQA3I
         jeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772805359; x=1773410159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AhcgVF+rVAlbyPJryqQe1mCuLKgrnb29YUxE/nFuBj0=;
        b=Wa5ltzYvDrTCAZCrCzZVK2kAW81Nm0mkGnTqGxzBskBUalvfh9HaMpn2zC8dUWqacn
         6k1BwNt5rT5bnsrJAy/H5Lolyoktf2Di0wzdhLC4k9KpcxM9GPlSS08hyVg3+aCOQC26
         hyKXNo+kgonkyh49AR2wV0/fCIJBQj5pTLeEPXuyW7UgrgS8RiOCGHCF9TPaGsMotUNg
         6yHaeYajcn5UzDw98ASzi4DW/GRJGXPQOG/ORgmpSYTtbB5OPir74wNr2/wfwOS11eS1
         ojqXxucyHYOnpevzhEMoz4Xt7gpaUTJ8s2N5S1pLV26Y2ewCDNutKTjD06a3Jl/aO/SX
         zP5w==
X-Gm-Message-State: AOJu0YzgBqN73bvfluee3daMkR0kuvRN0YX1XG8nUlRpjlsMx3/mZWNn
	Tq7i9VMDVxsNy4/zxRLhETOfcuDaolrE7phf3NIbgzvc6Nk5ndOPSx/G+gWTsMbETxkDRzIXWMw
	r44CraRKQyZsPwoXL9wkeiTKGJFSfKRk=
X-Gm-Gg: ATEYQzx44IOff1s5UJcVnU/pn9V7kpCEgieKDYrFh8YJZGSeXVyjwcArnOVcOI5IHV4
	89XLJKRItajbYpBVu/4BKRjORMkWfJCDRrVErgtCUGm3smtYZkz9oLcZgVph16kxQHUMieK54LG
	c3ZZmL13gLv+2+oGj/aVxp8z+4xHRRWevZl+ZH0ZwLL53OGtYLWYCok2AJaza9o5w1LH4xnTAhG
	emZ1oyhUS7rnUCLIjBBgf8Z3d6dxO8XMihH8VX5GzvCH3UK7ecs9tH2FOmY/1ubJB8yc+dNHE9J
	o7LEHA==
X-Received: by 2002:a05:651c:41c8:b0:387:15c9:379a with SMTP id
 38308e7fff4ca-38a40b5ff81mr7180101fa.26.1772805358416; Fri, 06 Mar 2026
 05:55:58 -0800 (PST)
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
References: <CABCXVcmmXnEw6256sJsfGuG7eqLA0ytR-sJharrOHx+Yc2bLxA@mail.gmail.com>
 <b72aae71-fec9-4998-a5bd-ca5cc030b9a5@linux.alibaba.com>
In-Reply-To: <b72aae71-fec9-4998-a5bd-ca5cc030b9a5@linux.alibaba.com>
From: Aayushmaan Chakraborty <aayushmaan.chakraborty@gmail.com>
Date: Fri, 6 Mar 2026 19:25:47 +0530
X-Gm-Features: AaiRm52X_N3J-gQFdmdTC4T1ngdbTMoErsupyE3vK7VN0LL2o6t_ecFDXX-K4u4
Message-ID: <CABCXVckfa4mXrqzaTw9C80dGKWm=N=2g=iJmdgP2zp=TB5QeQw@mail.gmail.com>
Subject: Re: [PATCH] tests: add basic smoke/integration test script
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 6C4D22222F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aayushmaanchakraborty@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2531-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aayushmaanchakraborty@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

Thanks for the clarification.

On Thu, Mar 5, 2026 at 5:10=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
>
>
> On 2026/3/5 02:13, Aayushmaan Chakraborty wrote:
> > Hi Gao Xiang and linux-erofs team,
> >
> > The repository currently lacks any automated smoke or integration tests=
.
> No, automated integration tests are in another repo, we don't
> need anything here:
> https://github.com/erofs/erofsnightly

