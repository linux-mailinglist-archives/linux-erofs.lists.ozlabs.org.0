Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35AE4ACBAB
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Feb 2022 22:52:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jt0HX4T85z30L4
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Feb 2022 08:52:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jt0HT4Sl7z2xYQ
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Feb 2022 08:52:37 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R401e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=1; SR=0; TI=SMTPD_---0V3t4YjT_1644270749; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V3t4YjT_1644270749) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Feb 2022 05:52:30 +0800
Date: Tue, 8 Feb 2022 05:52:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 2/2] erofs-utils: lib: refine tailpcluster compression
 approach
Message-ID: <YgGUnH/aKYxYcPuP@B-P7TQMD6M-0146.local>
References: <20220204160944.120151-1-hsiangkao@linux.alibaba.com>
 <20220204160944.120151-3-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204160944.120151-3-hsiangkao@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Feb 05, 2022 at 12:09:44AM +0800, Gao Xiang wrote:
> As my previous comment [1] mentioned, currently, in order to inline
> a tail pcluster right after its inode metadata, tail data is split,
> compressed with many 4KiB pclusters and then the last pcluster is
> chosen.
> 
> However, it can have some impacts to overall compression ratios if big
> pclusters are enabled. So instead, let's implement another approach:
> compressing with two pclusters by trying recompressing.
> 
> It also enables EOF lcluster inlining for small compressed data, so
> please make sure the kernel is already fixed up [2].
> 
> [1] https://lore.kernel.org/r/YXkBIpcCG12Y8qMN@B-P7TQMD6M-0146.local
> [2] https://lore.kernel.org/r/20220203190203.30794-1-xiang@kernel.org
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Yue Hu reported a buffer overflow case with some specific file due to
this patch. So don't use it immediately. I will investigate soon.

Thanks,
Gao Xiang
