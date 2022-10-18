Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 867656034F4
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Oct 2022 23:29:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MsRp95sPGz3bwQ
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 08:29:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MsRp22sX1z2xZV
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Oct 2022 08:29:28 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VSXOP2U_1666128562;
Received: from B-P7TQMD6M-0146.lan(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSXOP2U_1666128562)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 05:29:24 +0800
Date: Wed, 19 Oct 2022 05:29:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v2] erofs: use kmap_local_page() only for erofs_bread()
Message-ID: <Y08asdeoz5yOAefN@B-P7TQMD6M-0146.lan>
References: <20221018105313.4940-1-hsiangkao@linux.alibaba.com>
 <9108233.CDJkKcVGEf@mypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9108233.CDJkKcVGEf@mypc>
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
Cc: ira.weiny@intel.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Fabio,

On Tue, Oct 18, 2022 at 09:18:49PM +0200, Fabio M. De Francesco wrote:
> On Tuesday, October 18, 2022 12:53:13 PM CEST Gao Xiang wrote:
> > Convert all mapped erofs_bread() users to use kmap_local_page()
> > instead of kmap() or kmap_atomic().
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  fs/erofs/data.c     | 8 ++------
> >  fs/erofs/internal.h | 3 +--
> >  fs/erofs/xattr.c    | 8 ++++----
> >  fs/erofs/zmap.c     | 4 ++--
> >  4 files changed, 9 insertions(+), 14 deletions(-)
> > 
> 
> I just realized that you know the code of fs/erofs very well. I saw a Gao 
> Xiang in MAINTAINERS, although having a different email address.
> 
> Therefore, I'm sure that everybody can trust that you checked everything is 
> needed to assure the safety of the conversions.
> 
> However, an extended commit message would have prevented me to send you the 
> previous email with all those questions / objections.

Thanks for your suggestion.  Yeah, this conversion looks trivial [since most
paths for erofs_bread() don't have more restriction in principle so we can
just disable migration.  One of what I need to care is nested kmap() usage,
some unmap/remap order cannot be simply converted to kmap_local() but I think
it's not the case for erofs_bread().  Actually EROFS has one of such nested
kmap() usage, but I don't really care its performance on HIGHMEM platforms,
so I think kmap() is still somewhat useful compared to kmap_local() from this
point of view], but in order to make it all work properly, I will try to do
stress test with 32-bit platform later.  Since it targets for the next cycle
6.2, I will do a full stress test in the next following weeks.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> Fabio
> 
