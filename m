Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5494E8C6C
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Mar 2022 05:05:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KRcxt2MrMz3c1b
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Mar 2022 14:05:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KRcxk6cpHz2ymw
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Mar 2022 14:04:52 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=19; SR=0; TI=SMTPD_---0V8KicJN_1648436681; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V8KicJN_1648436681) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 28 Mar 2022 11:04:44 +0800
Date: Mon, 28 Mar 2022 11:04:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v6 15/22] erofs: register cookie context for bootstrap blob
Message-ID: <YkElyeMDdt3hQKGi@B-P7TQMD6M-0146.local>
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
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
 <20220325122223.102958-16-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325122223.102958-16-jefflexu@linux.alibaba.com>
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

On Fri, Mar 25, 2022 at 08:22:16PM +0800, Jeffle Xu wrote:
> Registers fscache_cookie for the bootstrap blob file. The bootstrap blob
> file can be specified by a new mount option, which is going to be
> introduced by a following patch.
> 
> Something worth mentioning about the cleanup routine.
> 
> 1. The init routine is prior to when the root inode gets initialized,
> and thus the corresponding cleanup routine shall be placed inside
> .kill_sb() callback.
> 
> 2. The init routine will instantiate anonymous inodes under the
> super_block, and thus .put_super() callback shall also contain the
> cleanup routine. Or we'll get "VFS: Busy inodes after unmount." warning.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/internal.h |  3 +++
>  fs/erofs/super.c    | 17 +++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 459f31803c3b..d8c886a7491e 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -73,6 +73,7 @@ struct erofs_mount_opts {
>  	/* threshold for decompression synchronously */
>  	unsigned int max_sync_decompress_pages;
>  #endif
> +	char *tag;
>  	unsigned int mount_opt;
>  };
>  
> @@ -151,6 +152,8 @@ struct erofs_sb_info {
>  	/* sysfs support */
>  	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
>  	struct completion s_kobj_unregister;
> +
> +	struct erofs_fscache *bootstrap;

the concept of bootstrap is nydus-specific. Actually here we need
a fscache context of the primary device.

So I prefer struct erofs_fscache *s_fscache;

Also please help revise the subject and commit message about
bootstrap.

Thanks,
Gao Xiang

