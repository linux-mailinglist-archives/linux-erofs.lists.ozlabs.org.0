Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967A043F29F
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 00:20:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HgKkt3fpFz30Pj
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Oct 2021 09:20:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hrQfBF82;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hrQfBF82; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HgKkq04w6z2yL7
 for <linux-erofs@lists.ozlabs.org>; Fri, 29 Oct 2021 09:20:34 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 083C060F21;
 Thu, 28 Oct 2021 22:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635459631;
 bh=dir1ZFnzFiLche/onzYwyuYo85qNRcFbqp14rhgWKqg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hrQfBF82UhUT93EGhlO31+WUfVzzFWmdXMJn11GK7jhMasqs03KMQkU7LDMnhlSyz
 s5rvtSq1fx5jwQsxfjsVjLzoi5IrfbzoBFf6CnWl7l4jUXhKy4Cd+YnU6O+uaug0T4
 ARUXGWi1XWyjYCjVLTSrS1ofoLmzdsQGqIOKnEK3HPmRYC7O14Ggdhj5rLpzRzVUQS
 veLfXX+srB+gsr8sglZafRjXf8enNFu+QTtDsMRTAX2r+SL4ajN64Pm9T2APplwZH3
 dxO1+cAAq6NUqzInx0zpF4MVzSMDcGF2dsqWJmXlNAHCiLSiVVhkgM4GKKtX7kIstp
 gZ2QPVCVSxAVQ==
Date: Fri, 29 Oct 2021 06:20:20 +0800
From: Gao Xiang <xiang@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Subject: Re: [PATCH] erofs-utils: introduce fsck.erofs
Message-ID: <20211028221812.GA16132@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Daeho Jeong <daeho43@gmail.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org, miaoxie@huawei.com,
 fangwei1@huawei.com, xiang@kernel.org,
 Daeho Jeong <daehojeong@google.com>,
 GuoXuenan <guoxuenan@huawei.com>, Wang Qi <mpiglet@outlook.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20211025194809.1118624-1-daeho43@gmail.com>
 <20211025232436.GB10537@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CACOAw_ymWoufFFHcF+RV5sA5G5Xq1nsWqJZiWtWS5_VGpYXQXA@mail.gmail.com>
 <YXjD7bnOHj8D/3/w@B-P7TQMD6M-0146.local>
 <CACOAw_xkPk29XroW58z5A+pA8rXi=JGOHW6EhEE2dScQJVDaCw@mail.gmail.com>
 <YXn2PE4XEqg60VzO@B-P7TQMD6M-0146.local>
 <CACOAw_y=-g-Lkk+wfd=fnQMdmAVQ22-jpKQo8kkB7D4o34uoSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACOAw_y=-g-Lkk+wfd=fnQMdmAVQ22-jpKQo8kkB7D4o34uoSw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
 Jaegeuk Kim <jaegeuk@kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 miaoxie@huawei.com, Wang Qi <mpiglet@outlook.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Oct 28, 2021 at 10:10:03AM -0700, Daeho Jeong wrote:
> > > In fact, I wanted to decompress the whole data here. We can't check
> > > the data integrity,
> > > so I just wanted to check the layout of the file and that is the
> > > reason why I used z_erofs_map_blocks_iter() directly.
> >
> > Yeah, z_erofs_map_blocks_iter() here is good, yet I think we could
> > add a follow-up z_erofs_decompress() as well, at least it can verify
> > obvious compressed data corruption.
> 
> Could you enlighten me what is wrong with the below flow?
> z_erofs_decompress fails with -EIO or -EUCLEAN.
> 
>         raw = malloc(pchunk_len);
>         BUG_ON(!raw);
>         buffer = malloc(inode->i_size);
>         BUG_ON(!buffer);
> 
>         ret = dev_read(raw, 0, pchunk_len);
>         if (ret < 0) {
>                 erofs_err("an error occurred when reading compressed data "
>                           "of nid(%llu): errno(%d)", inode->nid | 0ULL, ret);
>                 goto out;
>         }
> 
>         ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
>                                 .in = raw,
>                                 .out = buffer,
>                                 .decodedskip = 0,
>                                 .inputsize = pchunk_len,
>                                 .decodedlength = inode->i_size,

I guess try to pass map.m_llen here? since we need to decode pcluster
one-by-one....

Thanks,
Gao Xiang

>                                 .alg = algorithmformat,
>                                 .partial_decoding = 0
>                                  });
