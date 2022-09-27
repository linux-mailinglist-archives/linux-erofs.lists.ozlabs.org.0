Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0885EB978
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 07:14:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mc78h5Rc9z3bqW
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Sep 2022 15:14:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mc78c4L9tz30Kr
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Sep 2022 15:14:23 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQqJQ6N_1664255655;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VQqJQ6N_1664255655)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 13:14:17 +0800
Date: Tue, 27 Sep 2022 13:14:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs: fold in z_erofs_reload_indexes()
Message-ID: <YzKGpUJsVh/T1nVO@B-P7TQMD6M-0146.local>
References: <20220927032518.25266-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220927032518.25266-1-zbestahu@gmail.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Sep 27, 2022 at 11:25:18AM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The name of this function looks not very accurate compared to it's
> implementation and it's only a wrapper to erofs_read_metabuf(). So,
> let's fold it directly instead.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/zmap.c | 28 ++++++++--------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index ccdddb755be8..4cecd32b87c6 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -166,18 +166,6 @@ struct z_erofs_maprecorder {
>  	bool partialref;
>  };
>  
> -static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
> -				  erofs_blk_t eblk)
> -{
> -	struct super_block *const sb = m->inode->i_sb;
> -
> -	m->kaddr = erofs_read_metabuf(&m->map->buf, sb, eblk,
> -				      EROFS_KMAP_ATOMIC);
> -	if (IS_ERR(m->kaddr))
> -		return PTR_ERR(m->kaddr);
> -	return 0;
> -}
> -
>  static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  					 unsigned long lcn)
>  {
> @@ -190,11 +178,11 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  		lcn * sizeof(struct z_erofs_vle_decompressed_index);
>  	struct z_erofs_vle_decompressed_index *di;
>  	unsigned int advise, type;
> -	int err;
>  
> -	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
> -	if (err)
> -		return err;
> +	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
> +				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
> +	if (IS_ERR(m->kaddr))
> +		return PTR_ERR(m->kaddr);
>  
>  	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
>  	m->lcn = lcn;
> @@ -393,7 +381,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	unsigned int compacted_4b_initial, compacted_2b;
>  	unsigned int amortizedshift;
>  	erofs_off_t pos;
> -	int err;
>  
>  	if (lclusterbits != 12)
>  		return -EOPNOTSUPP;
> @@ -430,9 +417,10 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>  	amortizedshift = 2;
>  out:
>  	pos += lcn * (1 << amortizedshift);
> -	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
> -	if (err)
> -		return err;
> +	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
> +				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
> +	if (IS_ERR(m->kaddr))
> +		return PTR_ERR(m->kaddr);
>  	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
>  }
>  
> -- 
> 2.17.1
