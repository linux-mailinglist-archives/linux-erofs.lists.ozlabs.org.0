Return-Path: <linux-erofs+bounces-64-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39BBA6335C
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 03:36:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFj0x12hqz2ydj;
	Sun, 16 Mar 2025 13:36:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742092609;
	cv=none; b=HZUL0oc4W9jKytrXVcDqbFxcv5VIMifU+qgg9rwTe69mcru8ZKGxXNVpT5RqvbTHlg5CGEfWTyxXW0KvSBuexUq26wnvGruRcBPlyx0uhDOnLg8vgz+QYhZ5CvXBQKK9wpmOiMfqg5QdeAVNbxbN1LBHwYld4+WnyB7jaCOmL/c6gubMQAhYxNm+MIPazdojGlaM2x6JffGHxFkAVo10CvcndpO+dpmAdtScYF61RPFBI/xETAS9FesDRa6hqplwYfDtDadqk+vg3zBIhPcYXK9FZP7fvr0thMsVbtIRbzTqwcZh63jFDjtLFcpVxI8IZohw6TyFTt/729OzLJ+f9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742092609; c=relaxed/relaxed;
	bh=CJVZpI3xK+CLN4IbO+Tu6a+ZSx1WA5/3lnEXwKPYKco=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YGO1s29Tn1xGXF/RBIhfhwjw1epZtP9yg03g00qvILNETe3H6hnF1sArMPV49RHjjS25sLFdTqNVDGQfc7uHe9g7JPgFUI48BDPuMqXD01lokQ3S0oejjsbeWHR6a/R6UF6l0cwOZ+zh9xgBR6RT5ZZttxbsbf8HQDicuieZlApgeWvgUf+uutN0i2atpVJR3+ESQUBrD796+IGExpQXiV0dpaoy+cXH/NYXyMTYSJPxLLwa9JGlS28YhnBaM6Y4nXAST+QWjJT4XKn0Sy7Sg2TCmh/dK8EkA42naHaTvfIXrKKymWloKNnn/6GMQTxf+/lOvz7Th+DMuSyuK8L2IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EGSuo9jL; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EGSuo9jL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFj0w1n0vz2ybQ
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 13:36:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2B78B5C4813;
	Sun, 16 Mar 2025 02:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EA4C4CEE5;
	Sun, 16 Mar 2025 02:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742092605;
	bh=rgsohwfd76T3iZ6/taL0SEHla+2AjE/cv/Q5/d2KtRg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EGSuo9jLl8CKjvcyN6/wLezqmR2YfvsbvYWCqZQ0IWtOxDczGQjQP3BMOUo/C7UgL
	 dJEowcCVYoNuDvPWSN/8Xjx/0uYKpa8zQKIUl4WXs9/kOybnCISHH3KUzdemv8XUjm
	 YHM1w4Jw2aisBJRewkLN01F3+iTZx+6+kIQ140/hGy0sVAmj48iC392d+h4BMHlkjL
	 wIA/1NyatH0OdJSfMMkSH26t3abiQ7Bp229MCxPz8DHagihNw0xDFfFd4KhcG4QN03
	 wgtFLMXDSgP2rc5N23TgJoqrCLeFt8d/HJn9J/QmSXNgGb5j6+JnDA0b5HPDwxGde8
	 3ClILjaLY5bxg==
Message-ID: <511c5fd9-307e-4c56-9d20-796dd06f775c@kernel.org>
Date: Sun, 16 Mar 2025 10:36:44 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/2/10 11:29, Hongzhen Luo wrote:
> There's no need to enumerate each type.  No logic changes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Looks good to me, feel free to add:

Reviewed-by: Chao Yu <chao@kernel.org>

And one minor comment below.

> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 689437e99a5a..d278ebd60281 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -265,26 +265,22 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>   		if (err)
>   			return err;
>   
> -		switch (m->type) {
> -		case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
> +		if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
> +			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
> +				  m->type, lcn, vi->nid);
> +			DBG_BUGON(1);
> +			return -EOPNOTSUPP;
 > +		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {>   			lookback_distance = m->delta[0];
>   			if (!lookback_distance)
> -				goto err_bogus;
> +				break;
>   			continue;
> -		case Z_EROFS_LCLUSTER_TYPE_PLAIN:
> -		case Z_EROFS_LCLUSTER_TYPE_HEAD1:
> -		case Z_EROFS_LCLUSTER_TYPE_HEAD2:
> +		} else {
>   			m->headtype = m->type;
>   			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
>   			return 0;
> -		default:
> -			erofs_err(sb, "unknown type %u @ lcn %lu of nid %llu",
> -				  m->type, lcn, vi->nid);
> -			DBG_BUGON(1);
> -			return -EOPNOTSUPP;

Should return EFSCORRUPTED here? is m->type >= Z_EROFS_LCLUSTER_TYPE_MAX a possible
case?

Btw, we'd better to do sanity check for m->type in z_erofs_load_full_lcluster(),
then we can treat m->type as reliable variable later.

	advise = le16_to_cpu(di->di_advise);
	m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
		...
		DBG_BUGON(1);
		return -EFSCORRUPTED;
	}

Thanks,

>   		}
>   	}
> -err_bogus:
>   	erofs_err(sb, "bogus lookback distance %u @ lcn %lu of nid %llu",
>   		  lookback_distance, m->lcn, vi->nid);
>   	DBG_BUGON(1);
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


