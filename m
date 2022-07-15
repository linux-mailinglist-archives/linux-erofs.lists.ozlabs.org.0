Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64EF575C35
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 09:20:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LkjRl4cVrz3c4m
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 17:20:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.13; helo=out199-13.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LkjRf354wz3blD
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Jul 2022 17:19:55 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VJODXgh_1657869587;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJODXgh_1657869587)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 15:19:48 +0800
Date: Fri, 15 Jul 2022 15:19:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH 05/16] erofs: drop the old pagevec approach
Message-ID: <YtEVEtTOD2peFXum@B-P7TQMD6M-0146.local>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
 <20220714132051.46012-6-hsiangkao@linux.alibaba.com>
 <20220715150737.00006764.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220715150737.00006764.zbestahu@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jul 15, 2022 at 03:07:37PM +0800, Yue Hu wrote:
> On Thu, 14 Jul 2022 21:20:40 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > Remove the old pagevec approach but keep z_erofs_page_type for now.
> > It will be reworked in the following commits as well.
> > 
> > Also rename Z_EROFS_NR_INLINE_PAGEVECS as Z_EROFS_INLINE_BVECS with
> > the new value 2 since it's actually enough to bootstrap.
> 
> I notice there are 2 comments as below which still use pagevec, should we
> update it as well?
> 
> [1] 
> * pagevec) since it can be directly decoded without I/O submission.
> [2]
> * for inplace I/O or pagevec (should be processed in strict order.)

Yeah, thanks for reminder... I will update it in this patch in the next
version.

> 
> BTW, utils.c includes needles <pagevec.h>, we can remove it along with the patchset
> or remove it later.

That is a completely different stuff, would you mind submitting a patch
to remove it if needed?

Thanks,
Gao Xiang
