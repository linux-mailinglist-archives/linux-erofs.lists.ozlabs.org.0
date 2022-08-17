Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3A059677D
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Aug 2022 04:41:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M6sjN4fYgz3bkP
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Aug 2022 12:41:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M6sjD70wmz2yxF
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Aug 2022 12:41:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VMTZlVN_1660704088;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VMTZlVN_1660704088)
          by smtp.aliyun-inc.com;
          Wed, 17 Aug 2022 10:41:30 +0800
Date: Wed, 17 Aug 2022 10:41:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Sun Ke <sunke32@huawei.com>
Subject: Re: [PATCH] erofs: fix error return code in
 erofs_fscache_meta_read_folio and erofs_fscache_read_folio
Message-ID: <YvxVWP0njcgghe+r@B-P7TQMD6M-0146.local>
References: <20220815034829.3940803-1-sunke32@huawei.com>
 <YvsoIFzRlGpqNZKg@B-P7TQMD6M-0146.local>
 <d40a1e7e-d78c-1a99-0889-6fc4d2102e9d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d40a1e7e-d78c-1a99-0889-6fc4d2102e9d@huawei.com>
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Ke,

On Wed, Aug 17, 2022 at 09:44:46AM +0800, Sun Ke wrote:
> 
> 
> 在 2022/8/16 13:16, Gao Xiang 写道:
> > On Mon, Aug 15, 2022 at 11:48:29AM +0800, Sun Ke wrote:
> > > If erofs_fscache_alloc_request fail and then goto out, it will return 0.
> > > it should return a negative error code instead of 0.
> > > 
> > > Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache readpage/readahead")
> > > Signed-off-by: Sun Ke <sunke32@huawei.com>
> > 
> > Minor, I tried to apply this patch by updating the patch title into
> > "erofs: fix error return code in erofs_fscache_{meta_,}read_folio"
> > 
> > since the original patch title is too long.
> 
> Should I send a v2 patch to update the title?

I've already updated this by hand if you have no concern ;)
will push out to -next today...

Thanks,
Gao Xiang

> 
> Thanks,
> Sun Ke
> > 
> > Thanks,
> > Gao Xiang
> > .
> > 
