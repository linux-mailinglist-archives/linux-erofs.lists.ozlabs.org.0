Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA8950FE5F
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Apr 2022 15:10:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Knj1V5j1Fz2yw9
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Apr 2022 23:10:54 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Knj1M1BBVz2xnR
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 Apr 2022 23:10:41 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=21; SR=0; TI=SMTPD_---0VBMUIgL_1650977664; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VBMUIgL_1650977664) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 26 Apr 2022 20:54:27 +0800
Date: Tue, 26 Apr 2022 20:54:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com
Subject: Re: [PATCH v10 00/21] fscache,erofs: fscache-based on-demand read
 semantics
Message-ID: <YmfrgPkloTAgYe4Z@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
 fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com,
 zhujia.zj@bytedance.com
References: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Apr 25, 2022 at 08:21:22PM +0800, Jeffle Xu wrote:
> changes since v9:
> - rebase to 5.18-rc3
> - cachefiles: extract cachefiles_in_ondemand_mode() helper; add barrier
>   pair between enqueuing and flushing requests; make the xarray
>   structures non-conditionally defined in struct cachefiles_cache
>   (patch 2) (David Howells)
> - cacehfiles: use refcount_t for unbind_pincount; run "cachefiles_open = 0;"
>   cleanup only when unbind_pincount is decreased to 0 (patch 3)
>   (David Howells)
> - cachefiles: rename CACHEFILES_IOC_CREAD ioctl to
>   CACHEFILES_IOC_READ_COMPLETE (patch 5) (David Howells)
> - cachefiles: fix the error message when the argument to the 'bind'
>   command is invalid (patch 6) (David Howells)
> - cachefiles: update the documentation polished by David (patch 8)
> - erofs: tweak the code arrangement of erofs_fscache_meta_readpage()
>   (patch 17) (Gao Xiang)
> - erofs: add comment on error cases (patch 20) (Gao Xiang)
> - update Tested-by tags in the cover letter
> 
> 
> Kernel Patchset
> ---------------
> Git tree:
> 
>     https://github.com/lostjeffle/linux.git jingbo/dev-erofs-fscache-v10
> 

Come to an agreement with David on IRC, I will push out this series to
-next later for wider testing aiming for 5.19.

Thanks,
Gao Xiang
