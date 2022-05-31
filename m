Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4DF538B92
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 08:51:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LC2x24XWFz3bfr
	for <lists+linux-erofs@lfdr.de>; Tue, 31 May 2022 16:51:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LC2wt4hKvz2yyQ
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 May 2022 16:50:52 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VEu7moQ_1653979844;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VEu7moQ_1653979844)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 May 2022 14:50:46 +0800
Date: Tue, 31 May 2022 14:50:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 0/3] erofs: random decompression cleanups
Message-ID: <YpW6xNPXHig7Djee@B-P7TQMD6M-0146.local>
References: <20220529055425.226363-1-xiang@kernel.org>
 <903a5a66-be1c-6371-708e-ac7f491b9585@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <903a5a66-be1c-6371-708e-ac7f491b9585@kernel.org>
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

On Tue, May 31, 2022 at 02:45:38PM +0800, Chao Yu wrote:
> Acked-by: Chao Yu <chao@kernel.org>

Thanks Chao! It'd be much helpful for me if we apply these cleanups
so I can have a new folio rework+cleanup+rolling hash 5.20 cycle.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> On 2022/5/29 13:54, Gao Xiang wrote:
> > From: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > Hi folks,
> > 
> > Now I'm working on cleanuping decompression code and doing some
> > folio adaption for the next 5.20 cycle, see:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/folios
> > 
> > This cleanup work completely gets rid of PageError usage finally
> > and tries to prepare for introducing rolling hashing for EROFS
> > since EROFS supports compressing variable-sized data instead of
> > fixed-sized clusters.
> > 
> > Therefore, EROFS can support rolling hash easily and our mechanism
> > can make full use of filesystem interfaces (byte-addressed) naturally.
> > 
> > Before that, I'd like to submit some trivial cleanups in advance for
> > the 5.19 cycle. All patches are without any logical change, so I can
> > have a more recent codebase for the next rework cycle.
> > 
> > Thanks,
> > Gao Xiang
> > 
> > Gao Xiang (3):
> >    erofs: get rid of `struct z_erofs_collection'
> >    erofs: get rid of label `restart_now'
> >    erofs: simplify z_erofs_pcluster_readmore()
> > 
> >   fs/erofs/zdata.c | 165 +++++++++++++++++++----------------------------
> >   fs/erofs/zdata.h |  50 +++++++-------
> >   2 files changed, 88 insertions(+), 127 deletions(-)
> > 
