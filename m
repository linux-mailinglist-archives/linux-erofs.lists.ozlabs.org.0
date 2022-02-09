Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 682CA4AE658
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 02:47:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JtjS41HgHz30hm
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 12:47:32 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JtjS00Jgkz2yNv
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 12:47:25 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R951e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V3yYS9m_1644371235; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V3yYS9m_1644371235) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 09:47:17 +0800
Date: Wed, 9 Feb 2022 09:47:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v3] erofs-utils: lib: Fix 8MB bug on uncompressed extent
 size
Message-ID: <YgMdIxaPzmGoni9p@B-P7TQMD6M-0146.local>
References: <YgGUL3aWmPmBvJ7z@B-P7TQMD6M-0146.local>
 <20220208184317.3639405-1-zhangkelvin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220208184317.3639405-1-zhangkelvin@google.com>
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
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 08, 2022 at 10:43:17AM -0800, Kelvin Zhang wrote:
> Previously, uncompressed extent can be at most 8MB before mkfs.erofs
> crashes on some error condition. This is due to a minor bug in how
> compressed indices are encoded. This patch fixes the issue.
> 
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> ---
>  lib/compress.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index 98be7a2..add95f5 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -97,7 +97,23 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
>  		} else if (d0) {
>  			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
>  
> -			di.di_u.delta[0] = cpu_to_le16(d0);
> +			/*
> +			 * If the |Z_EROFS_VLE_DI_D0_CBLKCNT| bit is set, parser
> +			 * will interpret |delta[0]| as size of pcluster, rather
> +			 * than distance to last head cluster. Normally this
> +			 * isn't a problem, because uncompressed extent size are
> +			 * below Z_EROFS_VLE_DI_D0_CBLKCNT * BLOCK_SIZE = 8MB.
> +			 * But with large pcluster it's possible to go over this
> +			 * number, resulting in corrupted compressed indices.
> +			 * To solve this, we replace d0 with
> +			 * Z_EROFS_VLE_DI_D0_CBLKCNT-1.
> +			 */
> +			if (d0 > Z_EROFS_VLE_DI_D0_CBLKCNT) {

Thanks for the new version.

I think this part would be "if (d0 >= Z_EROFS_VLE_DI_D0_CBLKCNT)",
and already applied with minor styling changes:

https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=789ac9b03c2c0d27c5be81cb8d026e2300ae822e

Thanks,
Gao Xiang

> +				di.di_u.delta[0] = cpu_to_le16(
> +					Z_EROFS_VLE_DI_D0_CBLKCNT-1);
> +			} else {
> +				di.di_u.delta[0] = cpu_to_le16(d0);
> +			}
>  			di.di_u.delta[1] = cpu_to_le16(d1);
>  		} else {
>  			type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
> -- 
> 2.35.0.263.gb82422642f-goog
