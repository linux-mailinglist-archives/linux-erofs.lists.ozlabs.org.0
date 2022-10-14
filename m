Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EFC5FEC07
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 11:47:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MphPL1z2wz3cB8
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Oct 2022 20:47:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MphPB09Rmz2xbK
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Oct 2022 20:46:49 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VS7NRQx_1665740799;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VS7NRQx_1665740799)
          by smtp.aliyun-inc.com;
          Fri, 14 Oct 2022 17:46:41 +0800
Date: Fri, 14 Oct 2022 17:46:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs-utils: avoid unnecessary insert behavior when not
 deduplicating
Message-ID: <Y0kv/rykPCQsvNmu@B-P7TQMD6M-0146.local>
References: <20221013040011.31944-1-zbestahu@gmail.com>
 <Y0fTbmoezlKid246@B-P7TQMD6M-0146.local>
 <20221014094846.00005bdb.zbestahu@gmail.com>
 <Y0jGP6gDnP+2WAry@B-P7TQMD6M-0146.local>
 <20221014164422.0000497a.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221014164422.0000497a.zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Oct 14, 2022 at 04:44:22PM +0800, Yue Hu wrote:
> Hi Xiang,
> 
> On Fri, 14 Oct 2022 10:15:27 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > On Fri, Oct 14, 2022 at 09:48:46AM +0800, Yue Hu wrote:
> > > On Thu, 13 Oct 2022 16:59:26 +0800
> > > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > >   
> > > > Hi Yue,
> > > > 
> > > > On Thu, Oct 13, 2022 at 12:00:11PM +0800, Yue Hu wrote:  
> > > > > From: Yue Hu <huyue2@coolpad.com>
> > > > > 
> > > > > We should do nothing in dedupe inserting when it's not configured.
> > > > > 
> > > > > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > > > > ---    
> > > > 
> > > > Thanks for the patch, do you observe some strange happening?   
> > > 
> > > I can see malloc/memcpy at runtime when dedupe is disabled. So, just skip.  
> > 
> > Would you mind confirming the numbers of e->length and window_size 
> > at that time?
> 
> The caller to insert function is just checking "!may_inline && !may_packing".
> 
> Check below (-zlz4hc foo.img foo/):
> 
> Processing .gitignore ...
> <E> erofs: z_erofs_dedupe_insert() Line[105] e->length 84, window_size 0
> Processing Kconfig.freezer ...
> <E> erofs: z_erofs_dedupe_insert() Line[105] e->length 92, window_size 0
> Processing Kconfig.hz ...
> <E> erofs: z_erofs_dedupe_insert() Line[105] e->length 1709, window_size 0
> 

Thanks for confirming!

Thanks,
Gao Xiang
