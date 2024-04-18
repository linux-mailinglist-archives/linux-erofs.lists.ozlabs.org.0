Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EF28A929E
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 07:52:56 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=YGN9ES1E;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKn4P5gJpz3cQx
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 15:52:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=YGN9ES1E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::b34; helo=mail-yb1-xb34.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKn4B3j5Yz3cJW
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 15:52:42 +1000 (AEST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso570317276.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 22:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1713419559; x=1714024359; darn=lists.ozlabs.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5rY3bUmj06meXYKfiJ01fMjAXvGnp5cudsSj92o3+Q=;
        b=YGN9ES1EiP7IQKvEP18kMQD71syqSkraLNM52+yTPrucJ832K9jt4762vi1HBt+jBj
         TyuayZNmvFLmx3ujK/KOUb8UsYkUkdUhQhfok80tuGlv0UHufl2CX1BMcAhRgwIZxi16
         CHEB9G0Y8quHIf8DG8yz+s7hgENfAtH9u9gGgPTnXE3fhfFnvab2XxUXlekbeR9vePzT
         6ctsW3VOSTH/ST6MzupaojD9pDNlbN7eLh9jMn7TQQU81GcmgjPhjIUD3fzEA09KQPu4
         uo6vP3dsva7kvszBtw5K3QkhRki9sHBo+d40pEkeut2tSRM7NG3T5xtuBBNKG2qvrdCZ
         XXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713419559; x=1714024359;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5rY3bUmj06meXYKfiJ01fMjAXvGnp5cudsSj92o3+Q=;
        b=ZNfTxUK47NQGGT5WN38ItTEbd7NsDYu3bKEeCLc78HXkLZnxrCB3Xt5QIjzz8EJui7
         PWor8Lrid31kee3VSZMxg7/+Vt/+DX9/DH+p467QS7Jnuptxa5GKcUEiIJYG6Gf9bwjS
         3dghk3GCkubXREIyNgql5jjW9AzN1DqSDjSQPRVkBwy5RsKYfYmnFhX9b89BnjZdBibT
         YM3c3MF/TcpW1PQCU3jqGxYFKDEN4KIfMiRzJzOGqPT8hMORDpWWqou1X/2pdEPBJtBU
         3OYxIYgc81umLSKm9SzA2hA5VRMxb5f0TCJnuBISUA2vOpjqiCs7X0U5Ex2yjEqUKwxn
         GGrA==
X-Forwarded-Encrypted: i=1; AJvYcCWdHqeWmdP4CfbYeY+4sQGXeCxumpu/+Ujg85RjD/zOamAVGk07h0peStMHNpniMuyf8lZoj2FNJ1DHHgxm6QKoY/o+h+fwe6uWcACQ
X-Gm-Message-State: AOJu0YwgfnZTlU52J4QvPbKJXAODPms0ykM0iDQc2uYdTQtGtt0AFfuk
	8jQPZp/zhFwn9AUpVuIl1b+MPP42M1B1jpfVH8vJMwLRttt4WQpsGTHjSK+eMWgTfD2EgXeVX/S
	M+3jo5FkDtSFPhGKshDl3izBcEsoMp/4EBaUO7g==
X-Google-Smtp-Source: AGHT+IGyLQKFfJIL+SpLvSs45eVieYf/iwIN01zDeiF0bmRdarIQlYhiENMfD3xTz9/xS99S566INsMwrOMspMdGGRM=
X-Received: by 2002:a25:2d10:0:b0:de0:f737:95f with SMTP id
 t16-20020a252d10000000b00de0f737095fmr1959445ybt.7.1713419559342; Wed, 17 Apr
 2024 22:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240417144251.1845355-1-zhaoyifan@sjtu.edu.cn>
 <CAFoAo-KboSBKuna87DWQMjphVPorgnYiMMEAf5PPwEhD4hZv=w@mail.gmail.com> <ZiCoVYoxW7NFHeUr@debian>
In-Reply-To: <ZiCoVYoxW7NFHeUr@debian>
From: Noboru Asai <asai@sijam.com>
Date: Thu, 18 Apr 2024 14:52:28 +0900
Message-ID: <CAFoAo-KZG8MEbSHaf2LrRdoj1MsjbvWFTcaeaZy5UuNqKNJ-HA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: skip the redundant write for
 ztailpacking block
To: Noboru Asai <asai@sijam.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

I made a patch set and send it. I'm grad that this patch set help your thin=
king.


2024=E5=B9=B44=E6=9C=8818=E6=97=A5(=E6=9C=A8) 13:58 Gao Xiang <xiang@kernel=
.org>:
>
> Hi Noboru,
>
> On Thu, Apr 18, 2024 at 10:09:22AM +0900, Noboru Asai wrote:
> > In this patch, the value of blkaddr in z_erofs_lcluster_index
> > corresponding to the ztailpacking block in the extent list
> > is invalid value. It looks that the linux kernel doesn't refer to this
> > value, but what value is correct?
> > 0 or -1 (EROFS_NULL_ADDR) or don't care?
>
> Thanks for pointing out!
>
> On the kernel side, it doesn't care this value if it's really
> _inlined_.
>
> But on the mkfs side, since we have inline fallback so I don't
> think an invalid blkaddr is correct.  The next blkaddr should
> be filled for inline fallback instead.
>
> Let me think more about it and update the patch.
>
> Thanks,
> Gao Xiang
