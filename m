Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA88AA2BC4B
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 08:33:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1738913608;
	bh=bI4ftGEDXBFwjyBfswfrE892aOmSMst8jRZSW9tnPss=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ht9G3in9Sg/ts35GSLpXkfgtnHcyofIIk/AyG7llrf4Rh9x/vnozdZGE2vRB30StO
	 ywPoYLSraBmJxPFelZfuQhkr6NP3SpgahgWg7MYZU7jjN1TPjlLvGEhwc+HYo8im3P
	 EO6UADuR9ydoZGk111QXhkdcgWg4EsbYQARW2Q68S1mOBkJCWqpm8aM3HNsel5nmxS
	 Lx1pwA9TD0nKUmsYq6w3hv/wO3jYouVY3K7RstSMn3PJ65q67M5X5yDpj5eGhbm64f
	 1T5M2OZlhRCuKz1gpgdDMSZ/AtREJSqAI2jRBZ52n6P85pOuWqBLYzENVuD+kfeYgi
	 UPTjuSmMV8NZQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yq5LJ1gcWz30Tx
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Feb 2025 18:33:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738913607;
	cv=none; b=l6KUIbHeF4MktutwujhJ86kqQt0oI1HYxI65/2f8HDi6K0MuWtFCgij0LamlI5zl8fe3mwJxM4MUjenh3mTjP0cKAMzWlgYuULIhUUznMhW/4DeyFoIZbSiOgYTUrPo+0qajWgZ4ZYK7nqcpdDfkDQCbVwNVv+xXW8Z+t64JxlnyyWmsPHOFL80u0m+6Ygga3H0mDV2cupbU8zwqdpoGn+PEDzRGIOfuc2WtqFy1kyem+5gKd5GxgcYD7ToenrE62RLWMMISCNoAKgceFoBUUIfd7+/awusBVZt/laWsjFN1TgDqK4gU5Cccqzvbd7SvquimNLMIdeHRuoeWWlZ6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738913607; c=relaxed/relaxed;
	bh=bI4ftGEDXBFwjyBfswfrE892aOmSMst8jRZSW9tnPss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J1/FNyoq3JRu46+ZuW+S8nQwVj1dOZ/twbRQDUy8/T+Q2qipAHY10bo/BFq4YS3aElse0Vr2lBOLydk74eVOM9SOTN32z4EtTjVVTjZmCGTbFVqdqTFLkQBR3Cy7mDfFh/WY266d5e3H4GiQVj/3db0zn4FLNYvv65bUZ+z+2DkGaubOUNSjULZSrkivMud8iGPqnLgZEEIj3PnAPIeBrTebZC+1QoGZD/HFXXljKjnw9egzJK9CjIPBoi16tQ1TYBU9WNegQ49TAUIZJ4KzuAov9LQmAiENY01yDFAYPZA8oFOGhW3rRk6wyxMJOe751vk/JQZMiV8gC+n0nKvfgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yq5LF5Zylz2x9j
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Feb 2025 18:33:25 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Yq5Jf0Bk2z1JJcy;
	Fri,  7 Feb 2025 15:32:02 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 93855140257;
	Fri,  7 Feb 2025 15:33:19 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Feb 2025 15:33:19 +0800
Message-ID: <7a9a2ead-88e5-4b53-9322-c649c92e73c2@huawei.com>
Date: Fri, 7 Feb 2025 15:33:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20250207064135.2249529-1-hongzhen@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20250207064135.2249529-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/2/7 14:41, Hongzhen Luo wrote:
> There's no need to enumerate each type.  No logic changes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   fs/erofs/zmap.c | 59 ++++++++++++++++++-------------------------------
>   1 file changed, 22 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 689437e99a5a..0ee78413bfd5 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -265,24 +265,20 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>   		if (err)
>   			return err;
>   
> -		switch (m->type) {
> -		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
> +		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>   			lookback_distance = m->delta[0];
>   			if (!lookback_distance)
>   				goto err_bogus;
>   			continue;
> -		case Z_EROFS_LCLUSTER_TYPE_PLAIN:
> -		case Z_EROFS_LCLUSTER_TYPE_HEAD1:
> -		case Z_EROFS_LCLUSTER_TYPE_HEAD2:
> +		} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
>   			m->headtype = m->type;
>   			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
>   			return 0;
> -		default:
> -			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
> -				  m->type, lcn, vi->nid);
> -			DBG_BUGON(1);
> -			return -EOPNOTSUPP;
>   		}
> +		erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
> +			  m->type, lcn, vi->nid);
> +		DBG_BUGON(1);
> +		return -EOPNOTSUPP;

May be it would be easier to understand if you put the exception branch 
at the beginning. Such as:

if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
   // return -EOPNOTSUPP;
}

if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
   // do something
}

// do something for other cases..

This is also useful for other places. :)

Thanks,
Hongbo

>   	}
>   err_bogus:
>   	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
> @@ -329,35 +325,28 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>   	DBG_BUGON(lcn == initial_lcn &&
>   		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
>   
> -	switch (m->type) {
> -	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
> -	case Z_EROFS_LCLUSTER_TYPE_HEAD2:
> +	if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
> +		if (m->delta[0] != 1) {
> +			erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
> +			DBG_BUGON(1);
> +			return -EFSCORRUPTED;
> +		}
> +		if (m->compressedblks)
> +			goto out;
> +	} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
>   		/*
>   		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
>   		 * rather than CBLKCNT, it's a 1 block-sized pcluster.
>   		 */
>   		m->compressedblks = 1;
> -		break;
> -	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
> -		if (m->delta[0] != 1)
> -			goto err_bonus_cblkcnt;
> -		if (m->compressedblks)
> -			break;
> -		fallthrough;
> -	default:
> -		erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn,
> -			  vi->nid);
> -		DBG_BUGON(1);
> -		return -EFSCORRUPTED;
> +		goto out;
>   	}
> +	erofs_err(sb, "cannot found CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
> +	DBG_BUGON(1);
> +	return -EFSCORRUPTED;
>   out:
>   	m->map->m_plen = erofs_pos(sb, m->compressedblks);
>   	return 0;
> -err_bonus_cblkcnt:
> -	erofs_err(sb, "bogus CBLKCNT @ lcn %lu of nid %llu", lcn, vi->nid);
> -	DBG_BUGON(1);
> -	return -EFSCORRUPTED;
>   }
>   
>   static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
> @@ -386,9 +375,7 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
>   				m->delta[1] = 1;
>   				DBG_BUGON(1);
>   			}
> -		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
> -			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1 ||
> -			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
> +		} else if (m->type < Z_EROFS_LCLUSTER_TYPE_MAX) {
>   			if (lcn != headlcn)
>   				break;	/* ends at the next HEAD lcluster */
>   			m->delta[1] = 1;
> @@ -452,8 +439,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>   		}
>   		/* m.lcn should be >= 1 if endoff < m.clusterofs */
>   		if (!m.lcn) {
> -			erofs_err(inode->i_sb,
> -				  "invalid logical cluster 0 at nid %llu",
> +			erofs_err(inode->i_sb, "invalid logical cluster 0 at nid %llu",
>   				  vi->nid);
>   			err = -EFSCORRUPTED;
>   			goto unmap_out;
> @@ -469,8 +455,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
>   			goto unmap_out;
>   		break;
>   	default:
> -		erofs_err(inode->i_sb,
> -			  "unknown type %u @ offset %llu of nid %llu",
> +		erofs_err(inode->i_sb, "unknown type %u @ offset %llu of nid %llu",
>   			  m.type, ofs, vi->nid);
>   		err = -EOPNOTSUPP;
>   		goto unmap_out;
