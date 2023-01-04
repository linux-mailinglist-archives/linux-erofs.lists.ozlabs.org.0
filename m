Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9354665CBFF
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 03:48:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NmvF21HW3z3bTq
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 13:48:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.8; helo=out30-8.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-8.freemail.mail.aliyun.com (out30-8.freemail.mail.aliyun.com [115.124.30.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NmvDw3S6Zz2xZB
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Jan 2023 13:48:46 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VYpZBrj_1672800520;
Received: from 30.97.49.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VYpZBrj_1672800520)
          by smtp.aliyun-inc.com;
          Wed, 04 Jan 2023 10:48:41 +0800
Message-ID: <fa1df3e5-9158-4381-5315-d243f77542a6@linux.alibaba.com>
Date: Wed, 4 Jan 2023 10:48:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH] erofs-utils: fsck: support fragments
To: Yue Hu <zbestahu@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20221224094319.10317-1-zbestahu@gmail.com>
From: Xiang Gao <hsiangkao@linux.alibaba.com>
In-Reply-To: <20221224094319.10317-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

在 2022/12/24 17:43, Yue Hu 写道:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Add compressed fragments support for fsck.erofs.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>   fsck/main.c | 41 +++++++++++++++++++++++++++++++++++++++--
>   lib/zmap.c  |  1 +
>   2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 2a9c501..9babc61 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -421,6 +421,31 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>   		if (!(map.m_flags & EROFS_MAP_MAPPED) || !fsckcfg.check_decomp)
>   			continue;
>   
> +		if (map.m_flags & EROFS_MAP_FRAGMENT) {
> +			struct erofs_inode packed_inode = {
> +				.nid = sbi.packed_nid,
> +			};

Sorry for late response.

a question... why don't we just rely on z_erofs_read_data()?


Thanks,
Gao Xiang

> +
> +			ret = erofs_read_inode_from_disk(&packed_inode);
> +			if (ret) {
> +				erofs_err("failed to read packed inode from disk");
> +				goto out;
> +			}
> +
> +			if (!buffer || map.m_llen > buffer_size) {
> +				buffer_size = map.m_llen;
> +				buffer = realloc(buffer, map.m_llen);
> +				BUG_ON(!buffer);
> +			}
> +			ret = erofs_pread(&packed_inode, buffer, map.m_llen,
> +					  inode->fragmentoff);
> +			if (ret)
> +				goto out;
> +
> +			compressed = true;	/* force using buffer */
> +			goto write_outfd;
> +		}
> +
>   		if (map.m_plen > raw_size) {
>   			raw_size = map.m_plen;
>   			raw = realloc(raw, raw_size);
> @@ -476,6 +501,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>   			}
>   		}
>   
> +write_outfd:
>   		if (outfd >= 0 && write(outfd, compressed ? buffer : raw,
>   					map.m_llen) < 0) {
>   			erofs_err("I/O error occurred when verifying data chunk @ nid %llu",
> @@ -486,8 +512,9 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>   	}
>   
>   	if (fsckcfg.print_comp_ratio) {
> -		fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
>   		fsckcfg.physical_blocks += BLK_ROUND_UP(pchunk_len);
> +		if (!erofs_is_packed_inode(inode))
> +			fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
>   	}
>   out:
>   	if (raw)
> @@ -732,6 +759,8 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
>   			ret = erofs_extract_dir(&inode);
>   			break;
>   		case S_IFREG:
> +			if (erofs_is_packed_inode(&inode))
> +				goto verify;
>   			ret = erofs_extract_file(&inode);
>   			break;
>   		case S_IFLNK:
> @@ -767,7 +796,7 @@ verify:
>   		ret = erofs_iterate_dir(&ctx, true);
>   	}
>   
> -	if (!ret)
> +	if (!ret && !erofs_is_packed_inode(&inode))
>   		erofsfsck_set_attributes(&inode, fsckcfg.extract_path);
>   
>   	if (ret == -ECANCELED)
> @@ -822,6 +851,14 @@ int main(int argc, char **argv)
>   		goto exit_put_super;
>   	}
>   
> +	if (erofs_sb_has_fragments()) {
> +		err = erofsfsck_check_inode(sbi.packed_nid, sbi.packed_nid);
> +		if (err) {
> +			erofs_err("failed to verify packed file");
> +			goto exit_put_super;
> +		}
> +	}
> +
>   	err = erofsfsck_check_inode(sbi.root_nid, sbi.root_nid);
>   	if (fsckcfg.corrupted) {
>   		if (!fsckcfg.extract_path)
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 41e0713..ca65038 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -639,6 +639,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
>   		map->m_plen = vi->z_idata_size;
>   	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
>   		map->m_flags |= EROFS_MAP_FRAGMENT;
> +		map->m_plen = 0;
>   	} else {
>   		map->m_pa = blknr_to_addr(m.pblk);
>   		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
