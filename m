Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C12FD485227
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jan 2022 12:58:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JTSgD4zQ7z2yfd
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jan 2022 22:58:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JTSg35Nz3z2xth
 for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jan 2022 22:58:20 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0V11Cvwq_1641383877; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V11Cvwq_1641383877) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 05 Jan 2022 19:57:58 +0800
Date: Wed, 5 Jan 2022 19:57:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v2 0/3] fs/erofs: new filesystem
Message-ID: <YdWHxPMyojsdcg9v@B-P7TQMD6M-0146.local>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
 <20210823123646.9765-1-jnhuang95@gmail.com>
 <20210825224042.GF858@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210825224042.GF858@bill-the-cat>
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
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Wed, Aug 25, 2021 at 06:40:42PM -0400, Tom Rini wrote:
> On Mon, Aug 23, 2021 at 08:36:43PM +0800, Huang Jianan wrote:
> 
> > From: Huang Jianan <huangjianan@oppo.com>
> > 
> > Add erofs filesystem support.
> > 
> > The code is adapted from erofs-utils in order to reduce maintenance
> > burden and keep with the latest feature.
> > 
> > Changes since v1:
> >  - fix the inconsistency between From and SoB (Bin Meng);
> >  - add missing license header;
> > 
> > Huang Jianan (3):
> >   fs/erofs: add erofs filesystem support
> >   fs/erofs: add lz4 1.8.3 decompressor
> >   fs/erofs: add lz4 decompression support
> 
> Aside from what I've just now sent, can you please extend the existing
> py/tests/ to cover basic functionality here, ensure they run on sandbox
> and in CI?  Thanks.

Any further progress on this work? At least sync it up with erofs-utils
1.4?

Thanks,
Gao Xiang

> 
> -- 
> Tom


