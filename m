Return-Path: <linux-erofs+bounces-1329-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03EAC2C15E
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 14:29:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0XWT5JZGz2yrm;
	Tue,  4 Nov 2025 00:29:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762176597;
	cv=none; b=klix9h/aIQQNsofrZFEEw9OozPNGjrqTZMp9BMXqhKsNQq3szZsl2DnEETjKffAEkjx6GiUhEYRGQnlDVytTmVoetssxZKd7XoqZ7cFi4cETjKu5qeH1f2XMhWSmKfDtzIF9KTys3h2dNMALV9pJRz/JTR/x9DdE/MgR+LjozV3o4uTpGvq9Poq7AZ8cpSfq9wOL4Jynb8i9pCHWTLsaFPJQlUFfSLZpFzSACvEdqqd5/Hpb+6cHOY/y3ir83tWrmXbZUhCKwOjRcSu72xCXotQ5/f/CZdsJ0d3Rzf9u6C8u26QDzWELryz6qxls+5qrmOgDh/3yVOcZalNkx/sTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762176597; c=relaxed/relaxed;
	bh=a21JbFZrSRmyl+TIWUp5y75+miyXDqyFyLKW07xgMRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0kFcdFDNx65WHN+20ixj4GKiZ6dOcBleJTU6bLQyAhCM/w8Pgi2PtOJY0lrH+LMZzr+sBH1Xx4WPEwLn+3DzPn/C8H7TUu5CzjYbgQxyoc9ZkJYOF0xaU+8C7uKhXslAN4IOfvBGMpmnnkG27s+w1zyeD595dNcs1X8P3GIxTtHFY0wDJEpKoNa9j8J77gPrQJtq6EFAbZqUSZBo3CtU3Z0o8HS+nA87t2nI/gDrrpTFgdjGIKwkXVFxg1dQ7XRy6x+Lyw9DSezi9RWojBwKX4cee66d+mJDTQK75+BH6QH34R8UO/XCc3GAZykV+v0TlxPEBR/S9CaqSXzPe+iDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ANeUvegK; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ANeUvegK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0XWS50qNz2xS9
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 00:29:55 +1100 (AEDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-64091c2e520so3302138a12.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 03 Nov 2025 05:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762176593; x=1762781393; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a21JbFZrSRmyl+TIWUp5y75+miyXDqyFyLKW07xgMRE=;
        b=ANeUvegKymzMzTLs1OMSuHbaWS7x8Vg6thB/zzeFRfqgth7p5w6Sb4Tt6iPFaqJmpQ
         z1mGOWI+YECy+x1z60R7qvH3Xd53dARYNG1hypK6zN6B3ekIifwZILjUpaILaWH5fi51
         5Q6J72kAqchF6mys8LtxoqxuXN84kYTngFumRqLB3hYgfmYDljnOW+d5I4J5MIzvdA5H
         EqniyqaMKO4tPf0y7DlVK70GgYvb7mxrK7x5hVCydmS6CMgO/lW2eEMDSTo1QNLxvHd9
         vdB8Tik+sm1QrVeIGzee4o1wDCNP1ZxByN7kNK8ETik0O1n44bEyphfiyddWIkeqz6WV
         fttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176593; x=1762781393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a21JbFZrSRmyl+TIWUp5y75+miyXDqyFyLKW07xgMRE=;
        b=hk10EuDW+jk/JyVkCFqOXfSOBpG3mvaBdo++hweuuwkrhIRjR7GQi0gzHuN6VeuA1g
         8Hrqab9ydnSG+Lq5yUlKmVboZd6oLMtiTuIFsw+F/Yzr+CS9wyQlaGtmEgHjcA7cpXBU
         fTdi0sqddcoE3eu67UI/ZXPv+Yfl5eBsfj+KSksiLrxR9+6q9db+ba1D5eK4/rLfE2B1
         J/tOYiY6j6pSaPau7wK1467T/UMjkYSuf/6EM9fk7hOdvdTtT5MyOaQzy+ZKebPpXgjG
         WsFV36Cfrdb2AcHR0titiEI7Zaz59q0P4pbQaH8EEX8BLenLAhLw3SBESzvHdVR8KlS4
         bSdg==
X-Forwarded-Encrypted: i=1; AJvYcCWPopwrFte+cvRrLRPwrS2CJ+OApYvYZ9PclAuUjz+ydsO2fXkQKhSL0SDua4G9JKKo1TzXZ8TZoj/1RA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy8sJDQg1ZsWM6Rmg7PVIOYl2kJLdw43CaU69yje08bHNZXlCTG
	0X69kq3KhmIGfLpmo2f9By8g2E2J2LJJq0safANyxw1dpNITE2ghK8GDZhDyeNlVAaVn4+g4OFx
	o6UBnC5oPK4Je9a5qZR0B3FC085obkKA=
X-Gm-Gg: ASbGncs3zDeJxvND7Jxg7GB0dAPH2MpHAGabQ2OxBOSpTQDP5YYj7ejsJKg1hx669TT
	tA2dkMHHuEOCR5XKomDJUc8N/3VtlM/XHCjdQy+NgfSdSQ93zSwzSu1OGW1IUMN+x2Fq5pkF32b
	FnxfeEi7eT6pM6Uus4ljP+elS1y3YwWYQzE/qQn1yr/pTPMgVfq4whIFJcgPo/VXoVoRtRhx1yU
	ywPsZj1Nim4dSe8T0ngkLR2G2Nw6smNRFJmydcKz9GWFG8Zk8UGv1dwlTb0K2h56LmhsjIp54UY
	zg416N9DkNp8wEmqtt0i4rfJ2ICA27TbUVC5vs0D
X-Google-Smtp-Source: AGHT+IGWyTZduHZ2AUQOMuHAUDSKDxSYh2Boylo//kHY7uALzcMyPCHh3aobLMS0sfZ3SBLE+RqIGbSBBaWJY8VJe/k=
X-Received: by 2002:a05:6402:5108:b0:640:aa67:2933 with SMTP id
 4fb4d7f45d1cf-640aa672a40mr5173930a12.21.1762176592344; Mon, 03 Nov 2025
 05:29:52 -0800 (PST)
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
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Nov 2025 14:29:40 +0100
X-Gm-Features: AWmQ_bmz-aFyM_2e0ocdnrdFR9IUaRm9-CuMDUtbkHwY8CVjQjk6nDFhXg5Zzks
Message-ID: <CAOQ4uxgr33rf1tzjqdJex_tzNYDqj45=qLzi3BkMUaezgbJqoQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] credentials guards: the easy cases
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aio@kvack.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Nov 3, 2025 at 12:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> This converts all users of override_creds() to rely on credentials
> guards. Leave all those that do the prepare_creds() + modify creds +
> override_creds() dance alone for now. Some of them qualify for their own
> variant.

Nice!

What about with_ovl_creator_cred()/scoped_with_ovl_creator_cred()?
Is there any reason not to do it as well?

I can try to clear some time for this cleanup.

For this series, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Christian Brauner (16):
>       cred: add {scoped_}with_creds() guards
>       aio: use credential guards
>       backing-file: use credential guards for reads
>       backing-file: use credential guards for writes
>       backing-file: use credential guards for splice read
>       backing-file: use credential guards for splice write
>       backing-file: use credential guards for mmap
>       binfmt_misc: use credential guards
>       erofs: use credential guards
>       nfs: use credential guards in nfs_local_call_read()
>       nfs: use credential guards in nfs_local_call_write()
>       nfs: use credential guards in nfs_idmap_get_key()
>       smb: use credential guards in cifs_get_spnego_key()
>       act: use credential guards in acct_write_process()
>       cgroup: use credential guards in cgroup_attach_permissions()
>       net/dns_resolver: use credential guards in dns_query()
>
>  fs/aio.c                     |   6 +-
>  fs/backing-file.c            | 147 ++++++++++++++++++++++---------------=
------
>  fs/binfmt_misc.c             |   7 +--
>  fs/erofs/fileio.c            |   6 +-
>  fs/nfs/localio.c             |  59 +++++++++--------
>  fs/nfs/nfs4idmap.c           |   7 +--
>  fs/smb/client/cifs_spnego.c  |   6 +-
>  include/linux/cred.h         |  12 ++--
>  kernel/acct.c                |   6 +-
>  kernel/cgroup/cgroup.c       |  10 ++-
>  net/dns_resolver/dns_query.c |   6 +-
>  11 files changed, 133 insertions(+), 139 deletions(-)
> ---
> base-commit: fea79c89ff947a69a55fed5ce86a70840e6d719c
> change-id: 20251103-work-creds-guards-simple-619ef2200d22
>
>

