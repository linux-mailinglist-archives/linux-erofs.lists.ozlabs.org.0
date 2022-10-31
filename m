Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFD661324E
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Oct 2022 10:12:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N16qY5xbRz3c3V
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Oct 2022 20:12:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N16qR1LtTz2xnM
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Oct 2022 20:12:17 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VTTcWV5_1667207530;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VTTcWV5_1667207530)
          by smtp.aliyun-inc.com;
          Mon, 31 Oct 2022 17:12:11 +0800
Date: Mon, 31 Oct 2022 17:12:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH v2] erofs-utils: avoid the potentially wrong m_plen for
 big pcluster
Message-ID: <Y1+RaSe7kmFg12/3@B-P7TQMD6M-0146.local>
References: <20221031022653.14981-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221031022653.14981-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Oct 31, 2022 at 10:26:53AM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Keep in sync with the kernel commit 0d53d2e882f9 ("erofs: avoid the
> potentially wrong m_plen for big pcluster").
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
> v2: rebase on latest dev branch
> 
>  lib/zmap.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 1c6706a..89e9da1 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -115,7 +115,7 @@ struct z_erofs_maprecorder {
>  	u8  type, headtype;
>  	u16 clusterofs;
>  	u16 delta[2];
> -	erofs_blk_t pblk, compressedlcs;
> +	erofs_blk_t pblk, compressedblks;
>  	erofs_off_t nextpackoff;
>  	bool partialref;
>  };
> @@ -172,7 +172,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  				DBG_BUGON(1);
>  				return -EFSCORRUPTED;
>  			}
> -			m->compressedlcs = m->delta[0] &
> +			m->compressedblks = m->delta[0] &
>  				~Z_EROFS_VLE_DI_D0_CBLKCNT;
>  			m->delta[0] = 1;
>  		}
> @@ -274,7 +274,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>  				DBG_BUGON(1);
>  				return -EFSCORRUPTED;
>  			}
> -			m->compressedlcs = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
> +			m->compressedblks = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
>  			m->delta[0] = 1;
>  			return 0;
>  		} else if (i + 1 != (int)vcnt) {
> @@ -471,7 +471,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  	}
>  
>  	lcn = m->lcn + 1;
> -	if (m->compressedlcs)
> +	if (m->compressedblks)
>  		goto out;
>  
>  	err = z_erofs_load_cluster_from_disk(m, lcn, false);
> @@ -480,7 +480,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  
>  	/*
>  	 * If the 1st NONHEAD lcluster has already been handled initially w/o
> -	 * valid compressedlcs, which means at least it mustn't be CBLKCNT, or
> +	 * valid compressedblks, which means at least it mustn't be CBLKCNT, or
>  	 * an internal implemenatation error is detected.
>  	 *
>  	 * The following code can also handle it properly anyway, but let's
> @@ -496,12 +496,12 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
>  		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
>  		 */
> -		m->compressedlcs = 1;
> +		m->compressedblks = 1 << (lclusterbits - LOG_BLOCK_SIZE);
>  		break;
>  	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
>  		if (m->delta[0] != 1)
>  			goto err_bonus_cblkcnt;
> -		if (m->compressedlcs)
> +		if (m->compressedblks)
>  			break;
>  		/* fallthrough */
>  	default:
> @@ -511,7 +511,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  		return -EFSCORRUPTED;
>  	}
>  out:
> -	map->m_plen = m->compressedlcs << lclusterbits;
> +	map->m_plen = m->compressedblks << LOG_BLOCK_SIZE;
>  	return 0;
>  err_bonus_cblkcnt:
>  	erofs_err("bogus CBLKCNT @ lcn %lu of nid %llu",
> -- 
> 2.17.1
