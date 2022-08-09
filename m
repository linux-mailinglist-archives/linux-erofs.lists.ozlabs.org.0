Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E224B58D2EB
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Aug 2022 06:27:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M20RR5jsfz306K
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Aug 2022 14:27:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M20RM5Jj4z2xHY
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Aug 2022 14:27:42 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VLoLPOq_1660019256;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VLoLPOq_1660019256)
          by smtp.aliyun-inc.com;
          Tue, 09 Aug 2022 12:27:38 +0800
Date: Tue, 9 Aug 2022 12:27:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Sheng Yong <shengyong@oppo.com>
Subject: Re: [RFC PATCH 2/3] erofs-utils: fuse: export erofs_xattr_foreach
Message-ID: <YvHiOIIPO7iMgdlo@B-P7TQMD6M-0146.local>
References: <20220803142223.3962974-1-shengyong@oppo.com>
 <20220803142223.3962974-3-shengyong@oppo.com>
 <YurQkH7D/Ch/clT0@debian>
 <YvHbZrYUU7qDP0Jg@B-P7TQMD6M-0146.local>
 <76efd3fa-e760-8321-8bb7-c7cc1daa9fe1@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76efd3fa-e760-8321-8bb7-c7cc1daa9fe1@oppo.com>
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

On Tue, Aug 09, 2022 at 12:18:34PM +0800, Sheng Yong wrote:
> 
> 
> 在 2022/8/9 11:58, Gao Xiang 写道:
> > Hi Yong,
> > 
> > On Thu, Aug 04, 2022 at 03:46:24AM +0800, Gao Xiang wrote:
> > > 
> > > On Wed, Aug 03, 2022 at 10:22:22PM +0800, Sheng Yong wrote:
> > > > This patch exports erofs_xattr_foreach() to iterate all xattrs.
> > > > Each xattr entry is handled by operations defined in `struct
> > > > xattr_iter_ops'.
> > > > 
> > > 
> > > Thanks for your hard effort!
> > > 
> > > Could we import in-kernel xattr implementation with verify enabled
> > > (or unify these implementations) instead?
> > > 
> > > ( Jianan ported a kernel implementation before, could we enhance
> > >    it with verification?
> > >    https://lore.kernel.org/r/20220728120910.61636-1-jnhuang@linux.alibaba.com)
> > > 
> > 
> > We're about to fix FUSE extended attribute support... Would you mind
> > leaving your opinion about this?
> 
> Hi, Xiang
> 
> Sorry for late. At first glance, I though it would be too heavy to port
> in-kernel code when I tried to add xattr to fuse client. But if we want
> a more unified implementation and Jianan has already done it. I'd like
> to try Jianan's version :-)
> 

Okay, got it.  Also if kernel implementation has more chance to simplify
or clean up, let's do it now.  However, it's definitely better if we share
more code between kernel and erofs-utils in common, so we don't need to
maintain / test two different approaches and that could lead to more bugs
if we enhance them even further in the future...

Thanks,
Gao Xiang

> Thanks,
> Sheng Yong
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > Thanks,
> > > Gao Xiang
