Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 908B843F2B8
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 00:26:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HgKsJ3CT2z30Hv
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 09:26:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=HPDjNeyD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::133;
 helo=mail-lf1-x133.google.com; envelope-from=daeho43@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=HPDjNeyD; dkim-atps=neutral
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HgKsC5ys6z2xtP
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 09:26:05 +1100 (AEDT)
Received: by mail-lf1-x133.google.com with SMTP id b32so13514070lfv.0
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 15:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=AYMmGJ5xwlG/N4LJKrU9THhgPJvL3GRJFH8dw6T9Uoc=;
 b=HPDjNeyDI6qCcvB/KgBtwIMCLxzMartJOpaI9VA8v4WHJsL2+wUwkM/O/ruUdAbSPz
 cpNcHjZ2XiYNdlRCDNB58OkChghL2JFx+fsfnDGMmlH0dwAgq53Edv8NtWN5os/gCMKj
 YZE/eP7xvHLj6Nn0pzQyDFpqWwnVGEhAfMWtDdLHgxVCuUxMP8AuMv0gXeVna6zuKpPH
 XJCDEaNoKKFXJiZS9ryGF7kn0tAyBuYIumhk/9kl+wOlY77rSvBoBm4eerK5TIrRRZo2
 52SSgQiBVNUBgqxlT8kBiq3Zy6eWuMy+5Knh5Sm1b7n00HugQgnRTNrHe1KE/4QK0ks+
 Dj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=AYMmGJ5xwlG/N4LJKrU9THhgPJvL3GRJFH8dw6T9Uoc=;
 b=KMJn8nXNbCNFBPeMqlEiEbIAqOcb7cGDrHdzf/ODu8Aaz1kveUHhIi7hUyd/tw1jKA
 ZLlhGFRK6LpEIFRiyL7+G3pC5+iJO2pN88h3eDs29y7CO57GqBJQus44ZO9gdctn8tyx
 PPzRK4fLyoBOO0tanp29sVIjbnc9CAY7plQd/MGBZXkaV8EvFNs0Racz/mmIEI2XFZal
 fxH36Cblaz/y5BbCduTLMJrPu2T7Pd5IpJY1ZegyMOw1NRk/rJTBhGXnq/uoAbu6Guy1
 9IyCa8C6DjB+fh9oIvtvKaFGwZc1Vc3bF6aESt1HNeZBmt74UhxtNxuAmalN5m7yy6Rj
 dGKg==
X-Gm-Message-State: AOAM5334aSDiOjifMxkqwsPGYcTvLP1/mBmoWtdNgcMzzVvKGSPr4xXf
 0jcLU9Rr16PFBZTnUvY5XHs3YlkZQSHZw4Kq1Rc=
X-Google-Smtp-Source: ABdhPJyBDP1OAbLM3giyqMDkq1xs261cmlTVppWVnueuPjoBZsOOQsXVQZJBQOMpI2HLbNTcpgAyoKTyYLMZuXPJOy4=
X-Received: by 2002:a05:6512:1056:: with SMTP id
 c22mr7055142lfb.26.1635459961258; 
 Thu, 28 Oct 2021 15:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211025194809.1118624-1-daeho43@gmail.com>
 <20211025232436.GB10537@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CACOAw_ymWoufFFHcF+RV5sA5G5Xq1nsWqJZiWtWS5_VGpYXQXA@mail.gmail.com>
 <YXjD7bnOHj8D/3/w@B-P7TQMD6M-0146.local>
 <CACOAw_xkPk29XroW58z5A+pA8rXi=JGOHW6EhEE2dScQJVDaCw@mail.gmail.com>
 <YXn2PE4XEqg60VzO@B-P7TQMD6M-0146.local>
 <CACOAw_y=-g-Lkk+wfd=fnQMdmAVQ22-jpKQo8kkB7D4o34uoSw@mail.gmail.com>
 <20211028221812.GA16132@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20211028221812.GA16132@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 28 Oct 2021 15:25:50 -0700
Message-ID: <CACOAw_w2MFLhy5poO9Otr_3sG8NuKXApu8uUnHih2hRzRHt75g@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: introduce fsck.erofs
To: Daeho Jeong <daeho43@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, 
 linux-erofs@lists.ozlabs.org, miaoxie@huawei.com, fangwei1@huawei.com, 
 xiang@kernel.org, Daeho Jeong <daehojeong@google.com>,
 GuoXuenan <guoxuenan@huawei.com>, 
 Wang Qi <mpiglet@outlook.com>, Jaegeuk Kim <jaegeuk@kernel.org>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Oct 28, 2021 at 3:20 PM Gao Xiang <xiang@kernel.org> wrote:
>
> On Thu, Oct 28, 2021 at 10:10:03AM -0700, Daeho Jeong wrote:
> > > > In fact, I wanted to decompress the whole data here. We can't check
> > > > the data integrity,
> > > > so I just wanted to check the layout of the file and that is the
> > > > reason why I used z_erofs_map_blocks_iter() directly.
> > >
> > > Yeah, z_erofs_map_blocks_iter() here is good, yet I think we could
> > > add a follow-up z_erofs_decompress() as well, at least it can verify
> > > obvious compressed data corruption.
> >
> > Could you enlighten me what is wrong with the below flow?
> > z_erofs_decompress fails with -EIO or -EUCLEAN.
> >
> >         raw = malloc(pchunk_len);
> >         BUG_ON(!raw);
> >         buffer = malloc(inode->i_size);
> >         BUG_ON(!buffer);
> >
> >         ret = dev_read(raw, 0, pchunk_len);
> >         if (ret < 0) {
> >                 erofs_err("an error occurred when reading compressed data "
> >                           "of nid(%llu): errno(%d)", inode->nid | 0ULL, ret);
> >                 goto out;
> >         }
> >
> >         ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
> >                                 .in = raw,
> >                                 .out = buffer,
> >                                 .decodedskip = 0,
> >                                 .inputsize = pchunk_len,
> >                                 .decodedlength = inode->i_size,
>
> I guess try to pass map.m_llen here? since we need to decode pcluster
> one-by-one....

Oh, I had to decompress them by cluster, not the whole file. Got it.

Thanks,

>
> Thanks,
> Gao Xiang
>
> >                                 .alg = algorithmformat,
> >                                 .partial_decoding = 0
> >                                  });
