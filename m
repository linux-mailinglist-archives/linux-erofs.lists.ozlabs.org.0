Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B0844B98F
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 01:16:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpllD19JNz2yZv
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 11:16:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=NUyXBNBB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22f;
 helo=mail-lj1-x22f.google.com; envelope-from=daeho43@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=NUyXBNBB; dkim-atps=neutral
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hpll53XkFz2yV5
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 11:16:31 +1100 (AEDT)
Received: by mail-lj1-x22f.google.com with SMTP id s24so1699996lji.12
 for <linux-erofs@lists.ozlabs.org>; Tue, 09 Nov 2021 16:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qIywBRLqGCo6ZO5p52eNr6z2PcSrohh2EMAY3XDCMP8=;
 b=NUyXBNBBkxCrKh0rQPUlAaw+Gjn8P7qMeQq7A8MLA9AFoO3OJl60q+mesKeLMdQum7
 1wV/1EqHcUg4c+pY5NQGQ3aWljD0RPHeJfuVoD7ib1Y/w+qoSzwJa0fNtCKN35yLkuLe
 a85Ey1w3KcZKrMJpF2xCzVD05T+Lc6vW1kqTR5wUE4WImfSy87ETz473bKvfuqqoH7J3
 gqIRm2Bbi1d55LtbvK/bQnJlZN4cqXXCEJAEQaGQpPqiwKhCxLamGvqoMDQTLoKixYW7
 6AVXykMG0LdK11unQbKyBTdRQFdrHPjWy1KoMKIyXeXjN6szLZjBAGuJYUuLmtgpAhgI
 vgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qIywBRLqGCo6ZO5p52eNr6z2PcSrohh2EMAY3XDCMP8=;
 b=sEUdq8lU9D7wC2ayBeNkGluYn+otnkOJqGiXD1KnawxLtwViKJotmD2r4MdqIt8AeS
 ttZ7ksvSaCYhYwDpAXf62Fn1DImcOtcAJ1Iulg1fyTlm7RttzaZwqdeUSDc/qFZ4YIl2
 CxJXUR6CJxnWKyxN1R7rCXGUfiG3ja5DyqydNuwSn7UFnrnaSIRhdu14/ojtFbZ3NPnG
 ezVIVNCgWDLUATPDIg1rDIxXeyc02ZtjzE9WGPrZ4Jr52IPQf0qi4TJE+2hrnsp2lcRP
 FN5Je/F8DAa7FN2m/WvRt6WgVn9qeSzfGeNHzUT4vFlLBMW3QZDWutqmz9mse0dl4E5j
 JtGA==
X-Gm-Message-State: AOAM530CP3M+ajcsvljfJd/izIlk2jHMT+pccilc3Xh/jfdTwIurF3Fw
 EXsuc0oqn8//0chbYVi+UMatVnVGBrv04vuGgaE=
X-Google-Smtp-Source: ABdhPJybHJ/EnCLvuZgY65m9Jl2nbjDU3KKJlzAWfe6Gv6tkqbW4yWpcyB9K+hKz57luEmYN+BmniWDA/Xkmb76U6qc=
X-Received: by 2002:a05:651c:612:: with SMTP id
 k18mr12652837lje.260.1636503383379; 
 Tue, 09 Nov 2021 16:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20211029171312.2189648-1-daeho43@gmail.com>
 <YYpaySr6vGEfwduR@B-P7TQMD6M-0146.local>
 <CACOAw_zJgxwQnQTgcU4DfsxN5gFCgAONU4B3A1dR79ccJSLBfA@mail.gmail.com>
In-Reply-To: <CACOAw_zJgxwQnQTgcU4DfsxN5gFCgAONU4B3A1dR79ccJSLBfA@mail.gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 9 Nov 2021 16:16:12 -0800
Message-ID: <CACOAw_wt+DX0D+Ps-K=oF+MgUxtVKbXpamShoZR7n4WwM+wODw@mail.gmail.com>
Subject: Re: [PATCH v3] erofs-utils: introduce fsck.erofs
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-erofs@lists.ozlabs.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

After merging all the latest patches, the build fails now, since we
don't have the lzma library on the build system now.

external/erofs-utils/lib/compressor_liblzma.c:8:10: fatal error:
'lzma.h' file not found
#include <lzma.h>
         ^~~~~~~~
1 error generated.
16:13:47 ninja failed with: exit status 1

Can you fix this to make it built without the lzma library?
