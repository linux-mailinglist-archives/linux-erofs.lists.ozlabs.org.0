Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD222432E21
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Oct 2021 08:24:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HYNxT43rQz2yMq
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Oct 2021 17:24:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HYNxL4wZBz2xYV
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Oct 2021 17:24:04 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0UssDq4D_1634624635; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UssDq4D_1634624635) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 19 Oct 2021 14:23:56 +0800
Date: Tue, 19 Oct 2021 14:23:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: nl6720 <nl6720@gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: introduce --quiet option
Message-ID: <YW5keh6YqhO2NvgG@B-P7TQMD6M-0146.local>
References: <YW1luAmReW8HpbHn@B-P7TQMD6M-0146.local>
 <11045556.rbnRpsbqeb@walnut>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11045556.rbnRpsbqeb@walnut>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On Mon, Oct 18, 2021 at 03:48:16PM +0300, nl6720 wrote:
> On Monday, 18 October 2021 15:16:56 EEST Gao Xiang wrote:
> > Add a preliminary quiet mode as described in
> > https://gitlab.archlinux.org/archlinux/archiso/-/issues/148
> > 
> > Suggested-by: nl6720 <nl6720@gmail.com>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  lib/config.c |  4 +++-
> >  mkfs/main.c  | 25 ++++++++++++++++++++-----
> >  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> I tried it on top of the experimental branch and it seems to work as intended.
> Thanks for working on this!

Yeah, thanks for your confirmation! This patch might not be quite
clean, I'll revise it later as well...

Thanks,
Gao Xiang

> 
> -- 
> nl6720
> 
