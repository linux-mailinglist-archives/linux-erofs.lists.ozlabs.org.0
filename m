Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E9243E6DD
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 19:10:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HgBs32KqBz2ynX
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 04:10:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ccWyGLH/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::136;
 helo=mail-lf1-x136.google.com; envelope-from=daeho43@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=ccWyGLH/; dkim-atps=neutral
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HgBrw5HSdz2yQ9
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 04:10:22 +1100 (AEDT)
Received: by mail-lf1-x136.google.com with SMTP id l13so15039061lfg.6
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iOJftuIooiY6MWzc3S+lZTXSWKEPUbnrQG6HFMNtHLE=;
 b=ccWyGLH/45gthNQvLrEsIk8RxH3LTZNbcD+pYBsnv/Si6aXyDx2bnbdSIwTUMHUZeP
 n5SwJI+NJrB4NW2xwFFBh0FscLQc9kvaXlzCqOBM72RI5i0iHK1cXT8KhJbg5WTRmsDU
 rmG8OuEUW2zKgoxlKDzKwIAAEu3dxyq1bQAe+9B4MlkCYqk3uIIoo79FqJT/yW9UDW/B
 aDGOcwJR841W2tBRK5sug/Kunun15rW4UaT8iTeY7beSGtIPPFeuOGWEADlNFho8SP0e
 y/TG1kRWdRU6MVN77viJkFY3YCqscpAyKuAJKtW+0Rj3cBxTItQI1khNwfGqcb6OZdJP
 9L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iOJftuIooiY6MWzc3S+lZTXSWKEPUbnrQG6HFMNtHLE=;
 b=ZD1LceI4NhG7Qq8nPktAKga5+6Z87OJ5d4elbI/qf6W6b83B/funObmHkcomXHC3Z6
 3qPmfm+5IgLelZ/YLjcOYEJlQs8L9GSssAlCs83DLpmvMmtd6Z1NQ3Goh28h/SNPB67D
 fDsjzxboI4Q9LRj6+ARbNLxDH+/YN6ETQtL595i/OWOPh+xdf8TlSJIORTiMbcjZIM8j
 gpJa2GraGKjFPBWXghsr14WO/Pa8PnGCi+h1cJJvVvPwhFO11qPPSrZtlCH+dDUXO7PJ
 89wyrpfPvaIw76FBha/2FoGA9E9Tlq179Hw8Vy+Ces+8zJnaw6zOGDgrc2Dp0eVBYkK3
 KKlw==
X-Gm-Message-State: AOAM532NajRaScnrs9dTowiNlOYtNWa+VbXzLuFwCaz/b+80GbViNeHK
 0mEuxUlKyXxCuV7is+yaY/ElZTzq9LCIQNYUHiM=
X-Google-Smtp-Source: ABdhPJxBu5cmF1M9qYUDTd0J4+7oxFoYxsnoDppn65hclCZLNzd0xSq6NjLUEUlxSQqAvTr0ltBRTKFEEUFC/M4DAME=
X-Received: by 2002:a05:6512:b8b:: with SMTP id
 b11mr5399581lfv.99.1635441015401; 
 Thu, 28 Oct 2021 10:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211025194809.1118624-1-daeho43@gmail.com>
 <20211025232436.GB10537@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CACOAw_ymWoufFFHcF+RV5sA5G5Xq1nsWqJZiWtWS5_VGpYXQXA@mail.gmail.com>
 <YXjD7bnOHj8D/3/w@B-P7TQMD6M-0146.local>
 <CACOAw_xkPk29XroW58z5A+pA8rXi=JGOHW6EhEE2dScQJVDaCw@mail.gmail.com>
 <YXn2PE4XEqg60VzO@B-P7TQMD6M-0146.local>
In-Reply-To: <YXn2PE4XEqg60VzO@B-P7TQMD6M-0146.local>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 28 Oct 2021 10:10:03 -0700
Message-ID: <CACOAw_y=-g-Lkk+wfd=fnQMdmAVQ22-jpKQo8kkB7D4o34uoSw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: introduce fsck.erofs
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
 Jaegeuk Kim <jaegeuk@kernel.org>, miaoxie@huawei.com,
 Wang Qi <mpiglet@outlook.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> > In fact, I wanted to decompress the whole data here. We can't check
> > the data integrity,
> > so I just wanted to check the layout of the file and that is the
> > reason why I used z_erofs_map_blocks_iter() directly.
>
> Yeah, z_erofs_map_blocks_iter() here is good, yet I think we could
> add a follow-up z_erofs_decompress() as well, at least it can verify
> obvious compressed data corruption.

Could you enlighten me what is wrong with the below flow?
z_erofs_decompress fails with -EIO or -EUCLEAN.

        raw = malloc(pchunk_len);
        BUG_ON(!raw);
        buffer = malloc(inode->i_size);
        BUG_ON(!buffer);

        ret = dev_read(raw, 0, pchunk_len);
        if (ret < 0) {
                erofs_err("an error occurred when reading compressed data "
                          "of nid(%llu): errno(%d)", inode->nid | 0ULL, ret);
                goto out;
        }

        ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
                                .in = raw,
                                .out = buffer,
                                .decodedskip = 0,
                                .inputsize = pchunk_len,
                                .decodedlength = inode->i_size,
                                .alg = algorithmformat,
                                .partial_decoding = 0
                                 });
