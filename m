Return-Path: <linux-erofs+bounces-2482-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AqUNwZ/pmnhQQAAu9opvQ
	(envelope-from <linux-erofs+bounces-2482-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 07:26:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C89431E998E
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 07:26:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQ5R42lzKz2yFY;
	Tue, 03 Mar 2026 17:26:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f2b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772519168;
	cv=pass; b=lhHmSgUqMD4Omkrcdy2r9ypIuu7qlOKFzAm2kmBFX4PnWkvcxfg974DRORx4WsrG9oOqgxXzmoCVpHB6ZRBPNfvrikOd9yGP5FFovsbLLJbB2fZZVpsbKM3/Oe8H3nW11gXWhfDOoeNDPfWcifOxBmbRfF72Rxs1AzOvWkWZ2LYNN1sQVJxPV0hBFwxOKTv0LjMbg9wHla4f9+btw7LNr++VZOkXuCoddkdNe8T4J5p2POk39QtKDEEoc2JCaG19EayNefWDk/oyRKzpfVu/ksrvcIgWgOEji70klijxCUD+wk2zDGScuKfWZCCSzGIe6x6DYYNR2q+tdexK0E1vvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772519168; c=relaxed/relaxed;
	bh=yKa/eBHEshdTJztG/7jCKj54ip3xjCrEFtQwC8EZgdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/oqbDSH3NRqOPviBjK/KSvOjOOiAzxvgeA5il4cN9Jnei3KnEyblfzBVfnV302KBR8MILLjv6xUMyMaWYTNd88voyCVK2lBDAESWLcCI7l3nzx+K65CI74ju8bhOYoHPNKp2NwGGLnvdQAUBjLFfHdd18Zi8z/wqNnpoWiQBYhlpyy6ApnnRNW2vXE0NHgEy5N9A8Hlh0a3Vgq/kQkaK950SfcttnlNQazdamon6qlJWIYoNFq1weXEsiz4LmqeLZmJL6BDlaf9gt7i0zZ2834AhqPVELc0JR4ZKotsdHkoIptA0ZSMJUOX4Gr8UgeCF3Wt3yOpVzA4kNl7B02PwQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nY7hME65; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nY7hME65;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQ5R24m3Gz2xpk
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 17:26:05 +1100 (AEDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-89a09ef1e3aso5843406d6.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Mar 2026 22:26:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772519162; cv=none;
        d=google.com; s=arc-20240605;
        b=ipNFTAvvjhz5/7NJfzfa/6BsQsD3sfs9xAQCEDzPAG0gV6P8g84YF6QBVz8KC3ChOD
         A9UTc+7CMcEUH/RGMFbYE9rSFvN3uQMGVrfhbO+yX2gnFz7tCe59L2v3EPUkn07Y4PhF
         AkPutTg85B4/rlZRPtXIU06B0K2gtYPNje9M8AdjU5NTqvIAQRRrniYX2W+F8eDVIcYx
         Bq+sxX6E380oInS2gdDUQeoyi7vFqlQ0sDFwaOtmJCAdkhO022nTU5fnCD+tzObG9d2F
         0244/oQUPJT06ZIm61gTdDRxmFYbmCSegv0W4f+MazmyZ6iodl8DvXchiMpNR4AfP0wD
         tbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yKa/eBHEshdTJztG/7jCKj54ip3xjCrEFtQwC8EZgdw=;
        fh=oWDCkurTVXofLXyKwHsu00w5C9CkFDApgCjJdTzgfnk=;
        b=L+JYO/j48OU0X7TKpaRRtZaNCk5AZFkUvYJRpKbzFnv+FgXQxGf8M9pUcLig5xByLs
         mJJ+63myo0Ifj6qScgx3uHkkDCRJuHqKpUSvoeUF0PzyfmHtWMs1KNIs663UaIcU3QO9
         HudI6Qx4E8aokEJwp9Z77AMX9bwFcECiYoXabhK1Cx6BbwPeEYE3VcOzcnSma5dTmx4D
         3RqkqAZfv4XB51KI7vkMun8z0hNSb+9nhudV2ERgEyosck8gwOYAz7NmtO0dCr2RDXj2
         oQm+1LnY52eyuhgk8ZC6hNVLqSHv5oeg1tGz9vp7Y20wLVzyqjHr+YtI3IXZcFN9J4Ch
         /8Ww==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772519162; x=1773123962; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKa/eBHEshdTJztG/7jCKj54ip3xjCrEFtQwC8EZgdw=;
        b=nY7hME651EfOloR/IVre8tWgDl0LkU49Fh4hB2WVdkEFvHypi/tOn7JpxHjXd2gA0A
         15YLxNJ3vmZQYS1+/w4u26uCxwuwsgX1gLrNIBvvSOhAlyv5G/FxYN6AB2K6T7PM97zH
         pVDCJn077f/FGyP04p5foHPwhiATHhDf0fptFmb4pQA0MZ2jI+nt/VsE/TnD2yH419No
         F1hxL35qXTTr1mJdE+uyEu/16JMp+bn5/En0x77dhhK5575V8gLKI6hwvq8uaEDvXAsm
         A4EIhynWo4P9Of9AMTnfMkaOgmqv9gOJPteGdIAxIfuldQFuOedk7aVZv2uKBEHxsW1M
         kqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772519162; x=1773123962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yKa/eBHEshdTJztG/7jCKj54ip3xjCrEFtQwC8EZgdw=;
        b=amRSyWgSoAFqJq1Fk7F4kFE5ibgYoUS8osEvOa3cM1lDz+JTykvjmPk5mI/csmBeIa
         HfdgnJJTszD2SiKeJjshpIUAN2Qe2DIYuvW8ZnQESnzpzjFNJ3W88DJDwiU4NUgnRXm5
         d08rusinNAeT83kg5K3SAEmd/NgML1PAG1Xvd2HHEdPK8bRRKqe32cMTFlKgS7jR0r91
         3lwL5R8fPn3LdPj2Nma5SPKL4H5tZbnTGypuvHUqsnwpzY+npgv4Rw/mbuhe3A4I/AVe
         sDey5zgT4Ug281U5plO33ZIuQq0S9D3DjGdayt3ApFgWGQWxjfivRhiD5CRMdSR0a7uV
         A/6A==
X-Forwarded-Encrypted: i=1; AJvYcCXKoPUTaRWUJFoUGO5T8HRmJh/YtDEjiXGLli6ysd7NVh1/Pfoosvu70uYyXj+liHTmvk038q53ZjjwWw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxlb+Cb6CO+j6+aYiu7I6ZZZz5DmVjmuAPKBeufq4X7qg/hPsc/
	+HYMeewDmxQPA8q7obpf0ki9QC1m46D/6BKZQneMOfiyJVmZi+Plwb3YavgJ1EI6gm/+VxxXUxt
	hePX1kaVW4t6AasseLlCy51UYckSSx2E=
X-Gm-Gg: ATEYQzxKoT500mf60L9fM50ViEeJeauGnwsz6H1KkfTmkjWVxD6lK6dsSl3onSPrfDR
	SpFMeXYQhNMHBeD+qb/NNqWUgzCglzcag8q8Iw1G73xWltVfBjWCE4r6NsIQyMKU4T91gIWlGB3
	I+2lxg5McK4sVtgV8p6SrPJo+VA1OkEupSw8DlgF3jcWsKH4A5N7pee+6fIPfbmhSJ5nyqQ6jwS
	oNnF9bspXQpofD1/YC7YWjbGdHdHTyJyMGUJ/xlNN6X/CWifK9BMKkK2RlhgvxERudI
X-Received: by 2002:ad4:4ead:0:b0:896:17e6:b3da with SMTP id
 6a1803df08f44-899d1dba572mr215038516d6.26.1772519162030; Mon, 02 Mar 2026
 22:26:02 -0800 (PST)
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
References: <20260302073216.94384-1-nithurshen.dev@gmail.com> <1415c632-7a4f-40e6-af3d-09ca2c02244c@linux.alibaba.com>
In-Reply-To: <1415c632-7a4f-40e6-af3d-09ca2c02244c@linux.alibaba.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Tue, 3 Mar 2026 11:55:51 +0530
X-Gm-Features: AaiRm52Ix7bSfzCqftrijzYtGt3xsS_3TIbLEIgYdJTY-wr9eDXvs3h_wksdxQA
Message-ID: <CANRYsKh4ZYYiJxd2S11crsyt6G57L_3nmWmFEp4iMQ7use0+1Q@mail.gmail.com>
Subject: Re: [PATCH] fsck.erofs: introduce multi-threaded decompression PoC
 with pcluster batching
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: C89431E998E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2482-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshen.dev@gmail.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Xiang,

On Mon, Mar 2, 2026 at 9:22=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> Hi Nithurshen,
>
> Glad to see the improvements, I think there are more room
> to be improved anyway.
>
> Also there are still some follow-up works, I'm busy these
> two days, but I will release a formal gsoc page later.
>
> Thanks,
> Gao Xiang

I completely agree that there is significant room for improvement
beyond this initial batching implementation. In my formal GSoC
proposal, I plan to explore several key areas:
1) Dynamically scaling the batch size based on the algorithm's
complexity. Fast algorithms like LZ4 can handle larger batches to hide
latency, while compute-heavy LZMA/ZSTD may require smaller, more
frequent dispatches to keep cores saturated without bloating memory.
2) Currently, the directory traversal remains serial. I want to
investigate parallelizing the inode verification pass to ensure the
entire fsck process is truly multi-threaded.
3) Implementing a sliding-window or credit-based throttle to prevent
worker threads from over-consuming memory on low-resource devices when
disk I/O is slow.

Before I begin drafting my proposal based on these goals, can you
kindly let me know your thoughts on this?

Thanks for the guidance!

Best regards,
Nithurshen

