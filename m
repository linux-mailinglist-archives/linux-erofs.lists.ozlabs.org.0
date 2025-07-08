Return-Path: <linux-erofs+bounces-550-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3FAAFC8E0
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 12:51:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbyZv2mQGz3bVW;
	Tue,  8 Jul 2025 20:51:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751971879;
	cv=none; b=nTS08khTbBNolVJJEQUePGYd4XK76HgJB1cAxxzqqyhmPwzTOb+r6cHzKkN+GfhV+MhrZs76P5fSELduqF7CJsjEj0SV9ZW3PEFYMKm4/OKjQwmJx68Lx9PFTcDMrg0mKMxoGn2cQHBud6PSNZBoCGxzYxDHSB8AhkGZgE9l+qZkjCKT+LvfXwoqShYKlrlGT+7ceHYNanvykaxgaTWPKE+9rEOUx03L6NgLu7CdRAlf1Y5g1ghdykOwFBiL76rO//BZC0E85ObrEY52mwlpzTDDJsZM8MHCB2HaVSfUHR1lMYP/wJEpWc3h44nj8LA4/McaDQqOIsagvAOVGLI3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751971879; c=relaxed/relaxed;
	bh=zxoFrioygDIVmu4X78093MkSV9t45GavcLxpuVWbCw4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MJYdnwBs2/NJ7aLr9KLJwXMt8cMAmS9BAMyWarJpzbkVXU9PLMShpGAl0UnXEtwMLbYanYayiIVAM1QSt/AmAJ/l8uaauOFYhWt0ie7fYvkEXSu6An15tzzxGtQbN53Hd7/vYaUOxLqgf8jPwMWRcVGp9XpOFF6JGNWo2ovGg982QRP/FYlPFT56RBpNztexcSnupBtcxYERLF60w+JZYKLnBZaQlBIGgk4zr/tQAyR8N3PGejOXeppcuKNbJAA9M6MnOZbYj4I3o0l6fa3fvEJKiwgVyPfu8R1+MlUnng7enzd5p3oghHrBVgziK/6zz3MY5tYctcxi55+qdgTspg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=A2nMeY4m; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=A2nMeY4m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbyZt2bRZz3bTf
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 20:51:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 313D746798;
	Tue,  8 Jul 2025 10:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ABEC4CEED;
	Tue,  8 Jul 2025 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751971876;
	bh=IWFwLdVjUFsiW9YXkXJxZjlcfthKmL+sH9ZCpSOBw4w=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=A2nMeY4mB10I8KbrIph0HGhFnahBmPKzxHl4RyuYtLWM/odPIBKxP3BaEOp4cKa49
	 uzUEx/wsRAQYvRU25GT1NU1TTaVK7LIMFt7KDWfGrrj4yIGOXs5zQ5BBwfNkLptH6G
	 /rPVvmNX35dPPR2AVgPjdkrlRPuHms83NA1LNxi8fwJcBmwTS9kHqSMv3fdhIn+l88
	 aohtGTgJtYjtc4jwIRS4K8USCTaKGcDhnwAEa22ClBDoalAjmrWWSMoh2i2hfshrQY
	 gIQtuR5XjlhgApC3Pn8QOlkHPR8AweA013F+iNarLhYyswyyZo5YfCLSUmF6/S+/lL
	 6C9yQe1bRFWwQ==
Message-ID: <a2431122-9b24-410c-92b4-53b9f0783e02@kernel.org>
Date: Tue, 8 Jul 2025 18:51:11 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH] erofs: do sanity check on m->type in
 z_erofs_load_compact_lcluster()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250707084723.2725437-1-chao@kernel.org>
 <e367f45a-b511-4f64-a528-807317004a2e@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <e367f45a-b511-4f64-a528-807317004a2e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 7/8/25 10:58, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/7/7 16:47, Chao Yu wrote:
>> All below functions will do sanity check on m->type, let's move sanity
>> check to z_erofs_load_compact_lcluster() for cleanup.
>> - z_erofs_map_blocks_fo
>> - z_erofs_get_extent_compressedlen
>> - z_erofs_get_extent_decompressedlen
>> - z_erofs_extent_lookback
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
> How about appending the following diff to tidy up the code
> a bit further (avoid `goto map_block` and `goto out`)?

Xiang,

Looks good to me, will append the diff in the patch.

Thanks,

> 
> 
>  fs/erofs/zmap.c | 67 +++++++++++++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index e530b152e14e..431199452542 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -327,21 +327,18 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>      DBG_BUGON(lcn == initial_lcn &&
>            m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
>  
> -    if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
> -        if (m->delta[0] != 1) {
> -            erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
> -            DBG_BUGON(1);
> -            return -EFSCORRUPTED;
> -        }
> -        if (m->compressedblks)
> -            goto out;
> +    if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD && m->delta[0] != 1) {
> +        erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
> +        DBG_BUGON(1);
> +        return -EFSCORRUPTED;
>      }
>  
>      /*
>       * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type rather
>       * than CBLKCNT, it's a 1 block-sized pcluster.
>       */
> -    m->compressedblks = 1;
> +    if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD || !m->compressedblks)
> +        m->compressedblks = 1;
>  out:
>      m->map->m_plen = erofs_pos(sb, m->compressedblks);
>      return 0;
> @@ -422,36 +419,34 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
>      map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
>      end = (m.lcn + 1ULL) << lclusterbits;
>  
> -    if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
> -        if (endoff >= m.clusterofs) {
> -            m.headtype = m.type;
> -            map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
> -            /*
> -             * For ztailpacking files, in order to inline data more
> -             * effectively, special EOF lclusters are now supported
> -             * which can have three parts at most.
> -             */
> -            if (ztailpacking && end > inode->i_size)
> -                end = inode->i_size;
> -            goto map_block;
> +    if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD && endoff >= m.clusterofs) {
> +        m.headtype = m.type;
> +        map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
> +        /*
> +         * For ztailpacking files, in order to inline data more
> +         * effectively, special EOF lclusters are now supported
> +         * which can have three parts at most.
> +         */
> +        if (ztailpacking && end > inode->i_size)
> +            end = inode->i_size;
> +    } else {
> +        if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
> +            /* m.lcn should be >= 1 if endoff < m.clusterofs */
> +            if (!m.lcn) {
> +                erofs_err(sb, "invalid logical cluster 0 at nid %llu",
> +                      vi->nid);
> +                err = -EFSCORRUPTED;
> +                goto unmap_out;
> +            }
> +            end = (m.lcn << lclusterbits) | m.clusterofs;
> +            map->m_flags |= EROFS_MAP_FULL_MAPPED;
> +            m.delta[0] = 1;
>          }
> -        /* m.lcn should be >= 1 if endoff < m.clusterofs */
> -        if (!m.lcn) {
> -            erofs_err(sb, "invalid logical cluster 0 at nid %llu",
> -                  vi->nid);
> -            err = -EFSCORRUPTED;
> +        /* get the corresponding first chunk */
> +        err = z_erofs_extent_lookback(&m, m.delta[0]);
> +        if (err)
>              goto unmap_out;
> -        }
> -        end = (m.lcn << lclusterbits) | m.clusterofs;
> -        map->m_flags |= EROFS_MAP_FULL_MAPPED;
> -        m.delta[0] = 1;
>      }
> -
> -    /* get the corresponding first chunk */
> -    err = z_erofs_extent_lookback(&m, m.delta[0]);
> -    if (err)
> -        goto unmap_out;
> -map_block:
>      if (m.partialref)
>          map->m_flags |= EROFS_MAP_PARTIAL_REF;
>      map->m_llen = end - map->m_la;


