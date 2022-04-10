Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ACD4FADF8
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Apr 2022 14:52:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KbsMK1mbwz3071
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Apr 2022 22:52:13 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KbsM84VPgz2xfC
 for <linux-erofs@lists.ozlabs.org>; Sun, 10 Apr 2022 22:52:00 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=19; SR=0; TI=SMTPD_---0V9eO7PR_1649595108; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V9eO7PR_1649595108) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 10 Apr 2022 20:51:50 +0800
Date: Sun, 10 Apr 2022 20:51:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 00/20] fscache,erofs: fscache-based on-demand read
 semantics
Message-ID: <YlLS47A9TpHyZJQi@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
 fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
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
Cc: tianzichen@kuaishou.com, linux-erofs@lists.ozlabs.org, fannaihao@baidu.com,
 willy@infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 06, 2022 at 03:55:52PM +0800, Jeffle Xu wrote:
> changes since v7:
> - rebased to 5.18-rc1
> - include "cachefiles: unmark inode in use in error path" patch into
>   this patchset to avoid warning from test robot (patch 1)
> - cachefiles: rename [cookie|volume]_key_len field of struct
>   cachefiles_open to [cookie|volume]_key_size to avoid potential
>   misunderstanding. Also add more documentation to
>   include/uapi/linux/cachefiles.h. (patch 3)
> - cachefiles: valid check for error code returned from user daemon
>   (patch 3)
> - cachefiles: change WARN_ON_ONCE() to pr_info_once() when user daemon
>   closes anon_fd prematurely (patch 4/5)
> - ready for complete review
> 
> 
> Kernel Patchset
> ---------------
> Git tree:
> 
>     https://github.com/lostjeffle/linux.git jingbo/dev-erofs-fscache-v8
> 
> Gitweb:
> 
>     https://github.com/lostjeffle/linux/commits/jingbo/dev-erofs-fscache-v8
> 
> 
> User Daemon for Quick Test
> --------------------------
> Git tree:
> 
>     https://github.com/lostjeffle/demand-read-cachefilesd.git main
> 
> Gitweb:
> 
>     https://github.com/lostjeffle/demand-read-cachefilesd
> 

Btw, we've also finished a preliminary end-to-end on-demand download
daemon in order to test the fscache on-demand kernel code as a real
end-to-end workload for container use cases:

User guide: https://github.com/dragonflyoss/image-service/blob/fscache/docs/nydus-fscache.md
Video: https://youtu.be/F4IF2_DENXo

Thanks,
Gao Xiang
