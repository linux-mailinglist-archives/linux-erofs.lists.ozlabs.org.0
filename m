Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93E855B7E6
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Jun 2022 08:15:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LWcsz0Tm0z3blh
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Jun 2022 16:15:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LWcsq25Kjz2y8Q
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Jun 2022 16:15:40 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VHTNMzH_1656310531;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VHTNMzH_1656310531)
          by smtp.aliyun-inc.com;
          Mon, 27 Jun 2022 14:15:33 +0800
Date: Mon, 27 Jun 2022 14:15:31 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>, Yuwen Chen <chenyuwen1@meizu.com>
Subject: Re: [PATCH] erofs: Wake up all waiters after z_erofs_lzma_head ready.
Message-ID: <YrlLA5kDpprL0klA@B-P7TQMD6M-0146.local>
References: <20220625145000.2720-1-chenyuwen1@meizu.com>
 <20220627135754.00000999.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627135754.00000999.zbestahu@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jun 27, 2022 at 01:57:54PM +0800, Yue Hu wrote:
> On Sat, 25 Jun 2022 22:50:00 +0800
> Yuwen Chen <chenyuwen1@meizu.com> wrote:
> 

...

> > 
> > Signed-off-by: Yuwen Chen <chenyuwen1@meizu.com>
> > ---
> >  fs/erofs/decompressor_lzma.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> > index 05a3063cf2bc..5e59b3f523eb 100644
> > --- a/fs/erofs/decompressor_lzma.c
> > +++ b/fs/erofs/decompressor_lzma.c
> > @@ -143,6 +143,7 @@ int z_erofs_load_lzma_config(struct super_block *sb,
> >  	DBG_BUGON(z_erofs_lzma_head);
> >  	z_erofs_lzma_head = head;
> >  	spin_unlock(&z_erofs_lzma_lock);
> > +	wake_up_all(&z_erofs_lzma_wq);
> >  
> >  	z_erofs_lzma_max_dictsize = dict_size;
> >  	mutex_unlock(&lzma_resize_mutex);
> 
> Please do not end the summary line(title) with a period.

Okay, that is a good point, also it'd be better to de-capitalize the 'W'
in "Wake" since they are common practices for kernel patches.

If it's convenient to you to send another version, please go with my
r-v-b tag.

Thanks,
Gao Xiang
