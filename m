Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B5C47F9BE
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 03:22:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMhJP0Jp4z2yMs
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 13:22:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMhJF01gNz2yMs
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 13:21:58 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R911e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V.p-vQR_1640571707; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V.p-vQR_1640571707) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 27 Dec 2021 10:21:48 +0800
Date: Mon, 27 Dec 2021 10:21:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v3 1/5] erofs: tidy up z_erofs_lz4_decompress
Message-ID: <YckjO1lSbaB6Ixze@B-P7TQMD6M-0146.local>
References: <20211225070626.74080-1-hsiangkao@linux.alibaba.com>
 <20211225070626.74080-2-hsiangkao@linux.alibaba.com>
 <c3fd4833-2483-f77e-fb79-42871e2d4219@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3fd4833-2483-f77e-fb79-42871e2d4219@kernel.org>
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
Cc: Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Mon, Dec 27, 2021 at 10:08:54AM +0800, Chao Yu wrote:
> On 2021/12/25 15:06, Gao Xiang wrote:
> > To prepare for the upcoming ztailpacking feature and further
> > cleanups, introduce a unique z_erofs_lz4_decompress_ctx to keep
> > the context, including inpages, outpages and oend, which are
> > frequently used by the lz4 decompressor.
> > 
> > No logic changes.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >   fs/erofs/decompressor.c | 80 +++++++++++++++++++++--------------------
> >   1 file changed, 41 insertions(+), 39 deletions(-)
> > 
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index c373a199c407..d1282a8b709e 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -16,6 +16,11 @@
> >   #define LZ4_DECOMPRESS_INPLACE_MARGIN(srcsize)  (((srcsize) >> 8) + 32)
> >   #endif
> > +struct z_erofs_lz4_decompress_ctx {
> > +	struct z_erofs_decompress_req *rq;
> > +	unsigned int inpages, outpages, oend;
> > +};
> > +
> 
> Could you please comment a bit about fields of structure
> z_erofs_lz4_decompress_ctx?
> 

Many thanks for the comment! I will revise it in the next version.

Thanks,
Gao Xiang

> Otherwise, the patch looks good to me.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
