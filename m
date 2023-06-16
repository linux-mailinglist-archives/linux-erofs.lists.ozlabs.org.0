Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8757324A2
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jun 2023 03:25:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qj1g873lvz3bTS
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jun 2023 11:25:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.23; helo=frasgout11.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qj1g26JSKz30XT
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jun 2023 11:24:59 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qj1Qg4qhpz9xrt0
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jun 2023 09:14:19 +0800 (CST)
Received: from [10.174.177.238] (unknown [10.174.177.238])
	by APP2 (Coremail) with SMTP id BqC_BwD3GnXduYtkF6vbCA--.30496S2;
	Fri, 16 Jun 2023 01:24:49 +0000 (GMT)
Message-ID: <3f963aa8-42bb-5953-eacb-5b7ae88e66a8@huaweicloud.com>
Date: Fri, 16 Jun 2023 09:24:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] erofs: clean up zmap.c
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230615063219.87466-1-hsiangkao@linux.alibaba.com>
 <20230615064421.103178-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Guo Xuenan <guoxuenan@huaweicloud.com>
In-Reply-To: <20230615064421.103178-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: BqC_BwD3GnXduYtkF6vbCA--.30496S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XryxAFy7tr47urW7Kw4kJFb_yoWxAr18pr
	sFk3WrJ3yUtryjkr1fZws5ZryakrZ7JF48Kw12g34ftas5GF4UXrZ5JF9avrs0grn5ArZ2
	va12vr15u3yDGrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: xjxr53hhqd0q5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2023/6/15 14:44, Gao Xiang wrote:
> Several trivial cleanups which aren't quite necessary to split:
>
>   - Rename lcluster load functions as well as justify full indexes
>     since they are typically used for global deduplication for
>     compressed data;
>
>   - Avoid unnecessary lines, comments for simplicity.
>
> No logic changes.
>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> changes since v1:
>   - fix a build error of `lcn` in z_erofs_extent_lookback().
>
>   fs/erofs/zmap.c | 69 +++++++++++++++++++++----------------------------
>   1 file changed, 29 insertions(+), 40 deletions(-)
>
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 920fb4dbc731..1909ddafd9c7 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -22,8 +22,8 @@ struct z_erofs_maprecorder {
>   	bool partialref;
>   };
>   
> -static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> -					 unsigned long lcn)
> +static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
> +				      unsigned long lcn)
>   {
>   	struct inode *const inode = m->inode;
>   	struct erofs_inode *const vi = EROFS_I(inode);
> @@ -226,8 +226,8 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>   	return 0;
>   }
>   
> -static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> -					    unsigned long lcn, bool lookahead)
> +static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
> +					 unsigned long lcn, bool lookahead)
>   {
>   	struct inode *const inode = m->inode;
>   	struct erofs_inode *const vi = EROFS_I(inode);
> @@ -277,23 +277,23 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>   	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
>   }
>   
> -static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> -					  unsigned int lcn, bool lookahead)
> +static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
> +					   unsigned int lcn, bool lookahead)
>   {
> -	const unsigned int datamode = EROFS_I(m->inode)->datalayout;
> -
> -	if (datamode == EROFS_INODE_COMPRESSED_FULL)
> -		return legacy_load_cluster_from_disk(m, lcn);
> -
> -	if (datamode == EROFS_INODE_COMPRESSED_COMPACT)
> -		return compacted_load_cluster_from_disk(m, lcn, lookahead);
> -
> -	return -EINVAL;
> +	switch (EROFS_I(m->inode)->datalayout) {
> +	case EROFS_INODE_COMPRESSED_FULL:
> +		return z_erofs_load_full_lcluster(m, lcn);
> +	case EROFS_INODE_COMPRESSED_COMPACT:
> +		return z_erofs_load_compact_lcluster(m, lcn, lookahead);
> +	default:
> +		return -EINVAL;
> +	}
>   }
>   
>   static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>   				   unsigned int lookback_distance)
>   {
> +	struct super_block *sb = m->inode->i_sb;
>   	struct erofs_inode *const vi = EROFS_I(m->inode);
>   	const unsigned int lclusterbits = vi->z_logical_clusterbits;
>   
> @@ -301,21 +301,15 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>   		unsigned long lcn = m->lcn - lookback_distance;
>   		int err;
>   
> -		/* load extent head logical cluster if needed */
> -		err = z_erofs_load_cluster_from_disk(m, lcn, false);
> +		err = z_erofs_load_lcluster_from_disk(m, lcn, false);
>   		if (err)
>   			return err;
>   
>   		switch (m->type) {
>   		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
> -			if (!m->delta[0]) {
> -				erofs_err(m->inode->i_sb,
> -					  "invalid lookback distance 0 @ nid %llu",
> -					  vi->nid);
> -				DBG_BUGON(1);
> -				return -EFSCORRUPTED;
> -			}
>   			lookback_distance = m->delta[0];
> +			if (!lookback_distance)
> +				goto err_bogus;
>   			continue;
>   		case Z_EROFS_LCLUSTER_TYPE_PLAIN:
>   		case Z_EROFS_LCLUSTER_TYPE_HEAD1:
> @@ -324,16 +318,15 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>   			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
>   			return 0;
>   		default:
> -			erofs_err(m->inode->i_sb,
> -				  "unknown type %u @ lcn %lu of nid %llu",
> +			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
>   				  m->type, lcn, vi->nid);
>   			DBG_BUGON(1);
>   			return -EOPNOTSUPP;
>   		}
>   	}
> -
> -	erofs_err(m->inode->i_sb, "bogus lookback distance @ nid %llu",
> -		  vi->nid);
> +err_bogus:
> +	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
> +		  lookback_distance, m->lcn, vi->nid);
>   	DBG_BUGON(1);
>   	return -EFSCORRUPTED;
>   }
> @@ -365,7 +358,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>   	if (m->compressedblks)
>   		goto out;
>   
> -	err = z_erofs_load_cluster_from_disk(m, lcn, false);
> +	err = z_erofs_load_lcluster_from_disk(m, lcn, false);
>   	if (err)
>   		return err;
>   
> @@ -397,9 +390,8 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>   			break;
>   		fallthrough;
>   	default:
> -		erofs_err(m->inode->i_sb,
> -			  "cannot found CBLKCNT @ lcn %lu of nid %llu",
> -			  lcn, vi->nid);
> +		erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn,
> +			  vi->nid);
>   		DBG_BUGON(1);
>   		return -EFSCORRUPTED;
>   	}
> @@ -407,9 +399,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>   	map->m_plen = erofs_pos(sb, m->compressedblks);
>   	return 0;
>   err_bonus_cblkcnt:
> -	erofs_err(m->inode->i_sb,
> -		  "bogus CBLKCNT @ lcn %lu of nid %llu",
> -		  lcn, vi->nid);
> +	erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
>   	DBG_BUGON(1);
>   	return -EFSCORRUPTED;
>   }
> @@ -430,7 +420,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
>   			return 0;
>   		}
>   
> -		err = z_erofs_load_cluster_from_disk(m, lcn, true);
> +		err = z_erofs_load_lcluster_from_disk(m, lcn, true);
>   		if (err)
>   			return err;
>   
> @@ -477,7 +467,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>   	initial_lcn = ofs >> lclusterbits;
>   	endoff = ofs & ((1 << lclusterbits) - 1);
>   
> -	err = z_erofs_load_cluster_from_disk(&m, initial_lcn, false);
> +	err = z_erofs_load_lcluster_from_disk(&m, initial_lcn, false);
>   	if (err)
>   		goto unmap_out;
>   
> @@ -535,8 +525,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>   	if (flags & EROFS_GET_BLOCKS_FINDTAIL) {
>   		vi->z_tailextent_headlcn = m.lcn;
>   		/* for non-compact indexes, fragmentoff is 64 bits */
> -		if (fragment &&
> -		    vi->datalayout == EROFS_INODE_COMPRESSED_FULL)
> +		if (fragment && vi->datalayout == EROFS_INODE_COMPRESSED_FULL)
>   			vi->z_fragmentoff |= (u64)m.pblk << 32;
>   	}
>   	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
Reviewed-by: Guo Xuenan <guoxuenan@huaweicloud.com>

-- 
Best regards
Guo Xuenan

