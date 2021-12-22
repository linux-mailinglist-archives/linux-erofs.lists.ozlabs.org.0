Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D51447CBAC
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 04:21:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJds70BFkz2yph
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 14:21:31 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJds15KY3z2xtv
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Dec 2021 14:21:23 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V.NrnyB_1640143272; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V.NrnyB_1640143272) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 22 Dec 2021 11:21:14 +0800
Date: Wed, 22 Dec 2021 11:21:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v1] erofs-utils: lib: Fix 8MB bug on uncompressed extent
 size
Message-ID: <YcKZqAwRVMZ7+c5J@B-P7TQMD6M-0146.local>
References: <20211222020307.273150-1-zhangkelvin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211222020307.273150-1-zhangkelvin@google.com>
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

On Tue, Dec 21, 2021 at 06:03:07PM -0800, Kelvin Zhang wrote:
> Previously, uncompressed extent can be at most 8MB before mkfs.erofs
> crashes on some error condition. This is due to a minor bug in how
> compressed indices are encoded. This patch fixes the issue.
> 
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>

I have to hold this for a while and look into (evaluate) that when I
get a full free time... (maybe a week later.) I understand it's not
quite urgent for all of us currently..

I still stuck into ztailpacking inline feature for now... 

Thanks,
Gao Xiang

> ---
>  include/erofs_fs.h |  2 +-
>  lib/compress.c     | 21 ++++++++++++++++++++-
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index 9a91877..13eaf24 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -353,7 +353,7 @@ enum {
>   * compressed block count of a compressed extent (in logical clusters, aka.
>   * block count of a pcluster).
>   */
> -#define Z_EROFS_VLE_DI_D0_CBLKCNT		(1 << 11)
> +#define Z_EROFS_VLE_DI_D0_CBLKCNT		(1U << 11)
>  
>  struct z_erofs_vle_decompressed_index {
>  	__le16 di_advise;
> diff --git a/lib/compress.c b/lib/compress.c
> index 98be7a2..23e571c 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -97,7 +97,26 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
>  		} else if (d0) {
>  			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
>  
> -			di.di_u.delta[0] = cpu_to_le16(d0);
> +			/* If the |Z_EROFS_VLE_DI_D0_CBLKCNT| bit is set, parser
> +			 * will interpret |delta[0]| as size of pcluster, rather
> +			 * than distance to last head cluster. Normally this
> +			 * isn't a problem, because uncompressed extent size are
> +			 * below Z_EROFS_VLE_DI_D0_CBLKCNT * BLOCK_SIZE = 8MB.
> +			 * But with large pcluster it's possible to go over this
> +			 * number, resulting in corrupted compressed indices.
> +			 * To solve this, we use Z_EROFS_VLE_DI_D0_CBLKCNT-1 if
> +			 * the uncompressed extent size goes above 8MB. This is
> +			 * OK because if kernel sees another non-head cluster
> +			 * after going back by |delta[0]| blocks, kernel will
> +			 * just keep looking back.
> +			 */
> +			if (d0 & Z_EROFS_VLE_DI_D0_CBLKCNT) {
> +				di.di_u.delta[0] = max(
> +					d0 & (~Z_EROFS_VLE_DI_D0_CBLKCNT),
> +					Z_EROFS_VLE_DI_D0_CBLKCNT-1);
> +			} else {
> +				di.di_u.delta[0] = cpu_to_le16(d0);
> +			}
>  			di.di_u.delta[1] = cpu_to_le16(d1);
>  		} else {
>  			type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
> -- 
> 2.34.1.448.ga2b2bfdf31-goog
