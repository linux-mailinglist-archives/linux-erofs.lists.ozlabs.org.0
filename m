Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132FD4528B6
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 04:50:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HtXBp19BJz2xsZ
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 14:50:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HtXBd1Pyyz2xCN
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Nov 2021 14:49:57 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R321e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0UwoA1Sy_1637034576; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UwoA1Sy_1637034576) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 16 Nov 2021 11:49:38 +0800
Date: Tue, 16 Nov 2021 11:49:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v6 1/3] erofs: rename lz4_0pading to zero_padding
Message-ID: <YZMqUNy1f4ji9ZbI@B-P7TQMD6M-0146.local>
References: <20211112160935.19394-1-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211112160935.19394-1-jnhuang95@gmail.com>
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
Cc: yh@oppo.com, guanyuwei@oppo.com, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, zhangshiming@oppo.co
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Sat, Nov 13, 2021 at 12:09:33AM +0800, Huang Jianan wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> Renaming lz4_0padding to zero_padding globally since LZMA and later
> algorithms also need that.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

I'm fine with renaming the original on-disk feature from lz4_0padding
to zero_padding... but could we leave `support_0padding' as-is?

My own concern is
 1) it seems 'support_zero_padding' is not much better than
    'support_0padding' but it causes somewhat longer lines...

 2) it causes somewhat backporting overhead but with no real
    benefits...

Otherwise it looks good to me. If you agree on this, I could
update this patch manually at the time when I apply this (maybe
about this weekend).

Thanks,
Gao Xiang

