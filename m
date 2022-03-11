Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F9F4D594B
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 04:53:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFBqW0pFTz308J
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 14:53:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1646970807;
	bh=6m/JtugylOHqH6vaTtm5woVeq07ihA8XiTw8JG8K03E=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=M/RKtnYtKmdmcocK5DDcDLle87PUE/finwJ/pGSq5dRLRSxs9/GLWxsYfINvFvaCi
	 VNFi6U4kgYNCmz5Y6d06T+eidyrvV1556x2LMD8M+m9em4fPY0h6SycU0W0nUcdfLH
	 M7stTL9a1Ze6EW/S8epm1tpqUqcCq+TZMVFJlEVx3TTgATy1T3csPoneRfVEWiPu7U
	 8g03ELEEOHRSfJzhh3T179JoqXJzme9VBijY59kVQA2l+LmX7wBU+dRwrxk6AQOzrL
	 M5N17USl81RzBHjceVgO1nioogiXcKUr+X9GdBXr3E8UOY0EI80bu9B5gM2r5gBBQY
	 kbOypdkzI1yLw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::a2d;
 helo=mail-vk1-xa2d.google.com; envelope-from=dvander@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=m4dflNGw; dkim-atps=neutral
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFBqS2bZJz2yHp
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 14:53:22 +1100 (AEDT)
Received: by mail-vk1-xa2d.google.com with SMTP id d6so3992537vkn.7
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 19:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6m/JtugylOHqH6vaTtm5woVeq07ihA8XiTw8JG8K03E=;
 b=HjZW602Q3ct6LMZDJlCi+yWmizQEGeNiGyfZw7jQUBZa00v6Iqshyc1Rn5KZ+y40tz
 j1Rs+j6UnzW7Zzsyh3++vZaK0fJxi/y48PaCWp36eIxjgF48X8NWfdOb0VRTuJk5T7Aa
 1kujp7a/617FwFsHJcF3sOHcljjzmQE2ahedJzKGcH1SOA4pxpJky9CW1ou3o5FkrZ5Y
 9ZFQqGjJrhAvTWTi2bLaXwwmgjyRDForjP+E05q3eMdKfcTqy+UdyFpFdIHXJAd7UTh/
 VZyLeS/hrnnWAvM5LFr+WfBuFcHQufSBAnG4g+b0Uk5Fk+tfLJb1apcyyPVUwdJtwh4d
 0EhQ==
X-Gm-Message-State: AOAM5334UTm48/+YsC2Nqa7xd30+tOuj7Wnbm4U3RQcrHUo9FbTaM3rs
 Jk9LW2GJmJgMREr6yrvlIM/gwViy/KUqgt/Ovu+7KQ==
X-Google-Smtp-Source: ABdhPJwQWq7g3pbfRLlsBldqcPKCNqfsD6uIgx4dvwMxt34ha1piFGj/+K9PbUzDlY0eA+DsqMIrdPacVDbKGWcQq7M=
X-Received: by 2002:a05:6122:8c8:b0:32a:7010:c581 with SMTP id
 8-20020a05612208c800b0032a7010c581mr3855979vkg.32.1646970798523; Thu, 10 Mar
 2022 19:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20220301041037.2271718-1-dvander@google.com>
 <Yh2sc2TOmyBdV3b7@B-P7TQMD6M-0146.local>
 <CA+FmFJB0iDzcPLqAtZsqQFj+j-pvhqs9YXmhjkmCYyqPgHpxnA@mail.gmail.com>
 <Yh25yvTzxt0aK62a@B-P7TQMD6M-0146.local>
In-Reply-To: <Yh25yvTzxt0aK62a@B-P7TQMD6M-0146.local>
Date: Thu, 10 Mar 2022 19:53:07 -0800
Message-ID: <CA+FmFJB39G3vDSJQW+pbC+EQVe3u51uKoASF28asHAkp0WPXSw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: Use extended inodes when ctime is set
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
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
From: David Anderson via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: David Anderson <dvander@google.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Feb 28, 2022 at 10:14 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
>
> (Or maybe just "--preserve-mtime" if it's supposed to be used frequently in
>  specific use cases...)

Looking at this again - is a new flag needed?

If -T is specified, the build will be reproducible. All timestamps
will be equal, and we'll never force an extended inode due to
mismatching timestamps. The patch has no effect in this case.

If -T is *not* specified, inode mtime *could* be reproducible
(depending on how the user creates the files), but sbi.build_time
isn't. Any of these inodes that gets the compact layout will use the
unreproducible build time instead. So, switching to extended inodes
here strictly improves reproducibility and determinism.

That said, it is a change in behavior, so maybe that warrants a flag anyway.

For what it's worth, in AOSP, "-T" is specified for production builds.
Non-production builds have "mtime" preserved for pushing incremental
changes.

Best,

-David
