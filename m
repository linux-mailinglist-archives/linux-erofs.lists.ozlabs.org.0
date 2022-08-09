Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E5A58D281
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Aug 2022 05:58:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M1znw3V9Gz305d
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Aug 2022 13:58:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M1znq56Hsz2xGw
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Aug 2022 13:58:37 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VLoExwC_1660017510;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VLoExwC_1660017510)
          by smtp.aliyun-inc.com;
          Tue, 09 Aug 2022 11:58:32 +0800
Date: Tue, 9 Aug 2022 11:58:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Sheng Yong <shengyong@oppo.com>
Subject: Re: [RFC PATCH 2/3] erofs-utils: fuse: export erofs_xattr_foreach
Message-ID: <YvHbZrYUU7qDP0Jg@B-P7TQMD6M-0146.local>
References: <20220803142223.3962974-1-shengyong@oppo.com>
 <20220803142223.3962974-3-shengyong@oppo.com>
 <YurQkH7D/Ch/clT0@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YurQkH7D/Ch/clT0@debian>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yong,

On Thu, Aug 04, 2022 at 03:46:24AM +0800, Gao Xiang wrote:
> 
> On Wed, Aug 03, 2022 at 10:22:22PM +0800, Sheng Yong wrote:
> > This patch exports erofs_xattr_foreach() to iterate all xattrs.
> > Each xattr entry is handled by operations defined in `struct
> > xattr_iter_ops'.
> > 
> 
> Thanks for your hard effort! 
> 
> Could we import in-kernel xattr implementation with verify enabled
> (or unify these implementations) instead?
> 
> ( Jianan ported a kernel implementation before, could we enhance
>   it with verification?
>   https://lore.kernel.org/r/20220728120910.61636-1-jnhuang@linux.alibaba.com)
> 

We're about to fix FUSE extended attribute support... Would you mind
leaving your opinion about this?

Thanks,
Gao Xiang

> Thanks,
> Gao Xiang
