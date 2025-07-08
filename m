Return-Path: <linux-erofs+bounces-544-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB02AFC0D5
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 04:30:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bblSg1YxYz3064;
	Tue,  8 Jul 2025 12:30:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751941811;
	cv=none; b=RjPp7sLqQ2sS5yH5pK7/f7XgyURkWi15Z8QS0dDpcivdIRn60ZK+JT1JwZ/Iq67KCnJIJtG7H7cj75NinJVLXp4j/wHjemJerj88Of+eNLX3A50sUrFlbWsKGT69qKOmmRIrZ6aWd+epRCYYOAhc2/oAFbVf11mHFsB5wfUwy5Q6V3wyh00KdlKNLr95p9dfa5vjrI1U7UFiYGLGAyx1S4OLdSGkWmz2ZyDibeH51opN70OXakcri/1Q9p5rDCfW3qrRo438PyF7F0f222+LVDMvWiVZJ/5SKRbgi1W59r3HrXbIYfT/aDMe00vMEa7RghCuiSba/Wmrvl80HhvaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751941811; c=relaxed/relaxed;
	bh=AlA+bnxO+iwJ/mBIUEIMVl4OWSt9hgzOerlGznbd6VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FLz71VG84dkd1QD52OizB6bqsOD2iD5zb825iksOdQnePYhlFtUU5WSM0PfQHqX3QkIgpW20yHnWTqNegWMVbjpnXYZRx/HxtxolnD+2sPnDZ87n1l+oII9fh/BykqxQVmrfJhfJtmdho1GwxxO8pyCWJYnNUV0Z+PHp6WX0tBjKbnoKmj5wk8yrO8GWYPWFMRlaqxLbRjjqrHOWxcAYRHAqHF+wsQIX6Yc+Q9LnAuBf7ItvFxO6pjX2jBrHOrS9OVP4yq1PxK8qoMOuaVOgPn6wtsDUUw6gzJw0EUDYmnI4XxV3/y/EdXN4ysQBv7I0BqnCQFY3rIPXYeU1+56dsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bblSd6m3Bz2yFP
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 12:30:08 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bblQK6JZpz2SSkl;
	Tue,  8 Jul 2025 10:28:09 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F35614011B;
	Tue,  8 Jul 2025 10:30:03 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 10:30:02 +0800
Message-ID: <3d04116f-5cee-4d41-9150-abbeb18f80be@huawei.com>
Date: Tue, 8 Jul 2025 10:30:02 +0800
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
Subject: Re: [PATCH] erofs: do sanity check on m->type in
 z_erofs_load_compact_lcluster()
To: Chao Yu <chao@kernel.org>, <xiang@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Yue Hu
	<zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
	<dhavale@google.com>
References: <20250707084723.2725437-1-chao@kernel.org>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250707084723.2725437-1-chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/7 16:47, Chao Yu wrote:
> All below functions will do sanity check on m->type, let's move sanity
> check to z_erofs_load_compact_lcluster() for cleanup.
> - z_erofs_map_blocks_fo
> - z_erofs_get_extent_compressedlen
> - z_erofs_get_extent_decompressedlen
> - z_erofs_extent_lookback
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/erofs/zmap.c | 60 ++++++++++++++++++-------------------------------
>   1 file changed, 22 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 0bebc6e3a4d7..e530b152e14e 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -240,6 +240,13 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
>   static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
>   					   unsigned int lcn, bool lookahead)
>   {
> +	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
> +		erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
> +				m->type, lcn, EROFS_I(m->inode)->nid);
> +		DBG_BUGON(1);
> +		return -EOPNOTSUPP;
> +	}
> +

Hi, Chao,

After moving the condition in here, there is no need to check in 
z_erofs_extent_lookback, z_erofs_get_extent_compressedlen and 
z_erofs_get_extent_decompressedlen. Because in z_erofs_map_blocks_fo, 
the condition has been checked in before. Right?

Thanks,
Hongbo

>   	switch (EROFS_I(m->inode)->datalayout) {
>   	case EROFS_INODE_COMPRESSED_FULL:
>   		return z_erofs_load_full_lcluster(m, lcn);
> @@ -265,12 +272,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>   		if (err)
>   			return err;
>   
> -		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
> -			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
> -				  m->type, lcn, vi->nid);
> -			DBG_BUGON(1);
> -			return -EOPNOTSUPP;
> -		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
> +		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>   			lookback_distance = m->delta[0];
>   			if (!lookback_distance)
>   				break;
> @@ -333,17 +335,13 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>   		}
>   		if (m->compressedblks)
>   			goto out;
> -	} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
> -		/*
> -		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
> -		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
> -		 */
> -		m->compressedblks = 1;
> -		goto out;
>   	}
> -	erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
> -	DBG_BUGON(1);
> -	return -EFSCORRUPTED;
> +
> +	/*
> +	 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type rather
> +	 * than CBLKCNT, it's a 1 block-sized pcluster.
> +	 */
> +	m->compressedblks = 1;
>   out:
>   	m->map->m_plen = erofs_pos(sb, m->compressedblks);
>   	return 0;
> @@ -379,11 +377,6 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
>   			if (lcn != headlcn)
>   				break;	/* ends at the next HEAD lcluster */
>   			m->delta[1] = 1;
> -		} else {
> -			erofs_err(inode->i_sb, "unknown type %u @ lcn %llu of nid %llu",
> -				  m->type, lcn, vi->nid);
> -			DBG_BUGON(1);
> -			return -EOPNOTSUPP;
>   		}
>   		lcn += m->delta[1];
>   	}
> @@ -429,10 +422,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
>   	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
>   	end = (m.lcn + 1ULL) << lclusterbits;
>   
> -	switch (m.type) {
> -	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
> -	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
> +	if (m.type != Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>   		if (endoff >= m.clusterofs) {
>   			m.headtype = m.type;
>   			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
> @@ -443,7 +433,7 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
>   			 */
>   			if (ztailpacking && end > inode->i_size)
>   				end = inode->i_size;
> -			break;
> +			goto map_block;
>   		}
>   		/* m.lcn should be >= 1 if endoff < m.clusterofs */
>   		if (!m.lcn) {
> @@ -455,19 +445,13 @@ static int z_erofs_map_blocks_fo(struct inode *inode,
>   		end = (m.lcn << lclusterbits) | m.clusterofs;
>   		map->m_flags |= EROFS_MAP_FULL_MAPPED;
>   		m.delta[0] = 1;
> -		fallthrough;
> -	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
> -		/* get the corresponding first chunk */
> -		err = z_erofs_extent_lookback(&m, m.delta[0]);
> -		if (err)
> -			goto unmap_out;
> -		break;
> -	default:
> -		erofs_err(sb, "unknown type %u @ offset %llu of nid %llu",
> -			  m.type, ofs, vi->nid);
> -		err = -EOPNOTSUPP;
> -		goto unmap_out;
>   	}
> +
> +	/* get the corresponding first chunk */
> +	err = z_erofs_extent_lookback(&m, m.delta[0]);
> +	if (err)
> +		goto unmap_out;
> +map_block:
>   	if (m.partialref)
>   		map->m_flags |= EROFS_MAP_PARTIAL_REF;
>   	map->m_llen = end - map->m_la;

