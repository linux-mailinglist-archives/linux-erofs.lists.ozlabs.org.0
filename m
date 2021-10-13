Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C2C42BF51
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Oct 2021 13:58:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HTrf5650cz2ynd
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Oct 2021 22:58:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HTrf23x9hz2yWn
 for <linux-erofs@lists.ozlabs.org>; Wed, 13 Oct 2021 22:58:33 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UrhChj4_1634126307; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UrhChj4_1634126307) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 13 Oct 2021 19:58:28 +0800
Date: Wed, 13 Oct 2021 19:58:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs: fix the per-CPU buffer decompression for small
 output size
Message-ID: <YWbJ4r7Nj5C4XS9Q@B-P7TQMD6M-0146.local>
References: <20211013092906.1434-1-zbestahu@gmail.com>
 <YWbIWydks+wpuNij@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWbIWydks+wpuNij@B-P7TQMD6M-0146.local>
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
Cc: linux-kernel@vger.kernel.org, zbestahu@163.com, huyue2@yulong.com,
 linux-erofs@lists.ozlabs.org, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Oct 13, 2021 at 07:51:55PM +0800, Gao Xiang wrote:
> Hi Yue,
> 
> On Wed, Oct 13, 2021 at 05:29:05PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Note that z_erofs_lz4_decompress() will return a positive value if
> > decompression succeeds. However, we do not copy_from_pcpubuf() due
> > to !ret. Let's fix it.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> 
> Thanks for catching this. This is a valid issue, but it has no real
> impact to the current kernels since such pcluster in practice will be
> !inplace_io and trigger "if (nrpages_out == 1 && !rq->inplace_io) {"
> above for upstream strategies.
> 
> Our customized lz4 implementation will return 0 if success instead, so
> it has no issue to our previous products as well.
> 
> For such cases, how about updating z_erofs_lz4_decompress() to return
> 0 if success instead rather than outputsize. Since I'll return 0 if
> success for LZMA as well.

In addition, I'm fine to getting rid of such path as well, since it has
no real impact to our current upstream decompression strategy.

If it has some use cases due to decompression strategy change, we could
re-add it with some evaluation (some real numbers) later.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
