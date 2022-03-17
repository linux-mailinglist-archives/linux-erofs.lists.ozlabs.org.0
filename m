Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C594DBE83
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 06:36:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJwql4f2lz3085
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 16:36:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJwqg0nNWz2xXZ
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 16:36:29 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=17; SR=0; TI=SMTPD_---0V7Q-ubC_1647495378; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V7Q-ubC_1647495378) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 17 Mar 2022 13:36:20 +0800
Date: Thu, 17 Mar 2022 13:36:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [Linux-cachefs] [PATCH v5 10/22] erofs: add mode checking helper
Message-ID: <YjLI0cCcxtg/rEHj@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 gregkh@linuxfoundation.org, tao.peng@linux.alibaba.com,
 willy@infradead.org, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 eguan@linux.alibaba.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-11-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220316131723.111553-11-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, torvalds@linux-foundation.org,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Mar 16, 2022 at 09:17:11PM +0800, Jeffle Xu wrote:
> Until then erofs is exactly blockdev based filesystem. In other using
> scenarios (e.g. container image), erofs needs to run upon files.
> 
> This patch set is going to introduces a new nodev mode, in which erofs
> could be mounted from a bootstrap blob file containing complete erofs
> image.
> 
> Add a helper checking which mode erofs works in.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/internal.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index e424293f47a2..f66af9ebda43 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -161,6 +161,11 @@ struct erofs_sb_info {
>  #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
>  #define test_opt(opt, option)	((opt)->mount_opt & EROFS_MOUNT_##option)
>  
> +static inline bool erofs_bdev_mode(struct super_block *sb)

How about renaming it as erofs_is_nodev_mode()?

Thanks,
Gao Xiang

> +{
> +	return sb->s_bdev;
> +}
> +
>  enum {
>  	EROFS_ZIP_CACHE_DISABLED,
>  	EROFS_ZIP_CACHE_READAHEAD,
> -- 
> 2.27.0
> 
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
