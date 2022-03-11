Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE3A4D5C12
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 08:14:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFHGt6D0Lz2yxW
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 18:13:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WYBrp34Z;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=WYBrp34Z; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFHGm3Gnqz2xVq
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 18:13:50 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id bx5so7403952pjb.3
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Mar 2022 23:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Xe/TObzCyIpMz+gsrdFN4FAYpTVbp6ttT/yAt6pqXM=;
 b=WYBrp34ZMpvN3EqOVtxjQPlFUSwiquPN+sa04OJ/pXjQBR65wj651cRBi1+ffL4KWV
 sJPiV/Be/MOEkOsZHVRF/OLpO0C/mQDVZ8REsfucG7lBIukeRY3P78OkjAvKkwuqgVhx
 pkMOcEwvpyNy5BS48CilZUN52WT97Cf9YERJPKaLydgzq5/Ar06Qni9Zl2kkbD1lnelX
 HgSmifYb9DQ27tCiq97eao3hMrpoawRtKAGMMyVr9Z5wfhjYbExF4ynn9IOmkKCfZJrF
 7T575iMvtSl0MUGAj8Nv7zEipoJgG8fjWSfMTDuWLQf1acpyVX2dL9I7b6udtnRlha5U
 3N5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Xe/TObzCyIpMz+gsrdFN4FAYpTVbp6ttT/yAt6pqXM=;
 b=TNjMWoBnYs8IS3cU389E2SU32J3K5NTv5FEBBNbUPy01s/OnIQm62QRv3AIqsxC1EU
 QaaAiTSA12kIRIFYVmdTshw3HVt4v7z6USf5IoaWYDIDCwg+liwtLQbbnHuBRFr7xX77
 LIUk+lM31wQzzV0yHxpVidI1xShpQAOh1Rr9j/c2+d4fzX0QuTksJI5en1gXsG1LuIWP
 FmHxujy61+2WzyfX3zIsvkcJrn9pPTPu2QrTy3WlZ3MtXO6wbqIxgwT0SPJ+OZF3VLqW
 R2KtCR1ld6mp0NgZy2aswb664lZkoQKMLQ3wK8bhbUnHTw0mLzWsWqLDq/yL+jcb1Uay
 4dhg==
X-Gm-Message-State: AOAM530Ymvz8q5TkQErqTE8yu1aLpC2BMCz4Jm1Q2yHbPP0c13FSWven
 tfApWd9cMrzaAGu2Ei609yU=
X-Google-Smtp-Source: ABdhPJzeqNVd2RpiWv8lFamefHdENq7LaJXmZHk/a7AlhSCshyhMDvRPfvchcD6409XA9sVL4cqPfg==
X-Received: by 2002:a17:90b:1811:b0:1bf:582e:443c with SMTP id
 lw17-20020a17090b181100b001bf582e443cmr20459312pjb.0.1646982827181; 
 Thu, 10 Mar 2022 23:13:47 -0800 (PST)
Received: from localhost ([103.220.76.197]) by smtp.gmail.com with ESMTPSA id
 o5-20020a655bc5000000b00372f7ecfcecsm7381854pgr.37.2022.03.10.23.13.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Mar 2022 23:13:46 -0800 (PST)
Date: Fri, 11 Mar 2022 15:12:32 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs: clean up z_erofs_extent_lookback
Message-ID: <20220311151232.00003619.zbestahu@gmail.com>
In-Reply-To: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
References: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 11 Mar 2022 02:27:42 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Avoid the unnecessary tail recursion since it can be converted into
> a loop directly in order to prevent potential stack overflow.
> 
> It's a pretty straightforward conversion.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zmap.c | 67 ++++++++++++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index b4059b9c3bac..572f0b8151ba 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -431,48 +431,47 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>  				   unsigned int lookback_distance)
>  {
>  	struct erofs_inode *const vi = EROFS_I(m->inode);
> -	struct erofs_map_blocks *const map = m->map;
>  	const unsigned int lclusterbits = vi->z_logical_clusterbits;
> -	unsigned long lcn = m->lcn;
> -	int err;
>  
> -	if (lcn < lookback_distance) {
> -		erofs_err(m->inode->i_sb,
> -			  "bogus lookback distance @ nid %llu", vi->nid);
> -		DBG_BUGON(1);
> -		return -EFSCORRUPTED;
> -	}
> +	while (m->lcn >= lookback_distance) {
> +		unsigned long lcn = m->lcn - lookback_distance;
> +		int err;

may better to declare variable 'lclusterbits' in loop just like 'err' usage?

>  
> -	/* load extent head logical cluster if needed */
> -	lcn -= lookback_distance;
> -	err = z_erofs_load_cluster_from_disk(m, lcn, false);
> -	if (err)
> -		return err;
> +		/* load extent head logical cluster if needed */
> +		err = z_erofs_load_cluster_from_disk(m, lcn, false);
> +		if (err)
> +			return err;
>  
> -	switch (m->type) {
> -	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
> -		if (!m->delta[0]) {
> +		switch (m->type) {
> +		case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
> +			if (!m->delta[0]) {
> +				erofs_err(m->inode->i_sb,
> +					  "invalid lookback distance 0 @ nid %llu",
> +					  vi->nid);
> +				DBG_BUGON(1);
> +				return -EFSCORRUPTED;
> +			}
> +			lookback_distance = m->delta[0];
> +			continue;
> +		case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> +		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> +		case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
> +			m->headtype = m->type;
> +			m->map->m_la = (lcn << lclusterbits) | m->clusterofs;
> +			return 0;
> +		default:
>  			erofs_err(m->inode->i_sb,
> -				  "invalid lookback distance 0 @ nid %llu",
> -				  vi->nid);
> +				  "unknown type %u @ lcn %lu of nid %llu",
> +				  m->type, lcn, vi->nid);
>  			DBG_BUGON(1);
> -			return -EFSCORRUPTED;
> +			return -EOPNOTSUPP;
>  		}
> -		return z_erofs_extent_lookback(m, m->delta[0]);
> -	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD1:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD2:
> -		m->headtype = m->type;
> -		map->m_la = (lcn << lclusterbits) | m->clusterofs;
> -		break;
> -	default:
> -		erofs_err(m->inode->i_sb,
> -			  "unknown type %u @ lcn %lu of nid %llu",
> -			  m->type, lcn, vi->nid);
> -		DBG_BUGON(1);
> -		return -EOPNOTSUPP;
>  	}
> -	return 0;
> +
> +	erofs_err(m->inode->i_sb, "bogus lookback distance @ nid %llu",
> +		  vi->nid);
> +	DBG_BUGON(1);
> +	return -EFSCORRUPTED;
>  }
>  
>  static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
