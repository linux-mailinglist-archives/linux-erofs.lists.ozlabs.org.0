Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A47575B6F
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 08:20:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lkh7H5BGxz3c4c
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 16:20:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mwJkMnLw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=mwJkMnLw;
	dkim-atps=neutral
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lkh7F0cYlz3bnH
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Jul 2022 16:20:40 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so5195851pjf.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 14 Jul 2022 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Nj+Clt9ZkEOhilN6GICXjikzzBZghfnwZ/Dm9+HmTo=;
        b=mwJkMnLwTVy3fOxc9CUwVdBQ+JVYJgWfg0AJjJUXUuEwFZoFT56M7qE9Ww1IVf0IyQ
         GdbkY3+dIVefF6zQA/TzE2Cw15nEBQD6doXBwd1cC4+vxM9AU2jfL+dwzW3j5bJvMsBQ
         /7OsVK1hwO0XV7qXRFKabM9eoeY/7wW6ByTi1SyxdtgrPEwLLyu8Gk/dc7Nai7A//Fjf
         Lv1NWrXfgHkrwgSZsxnvIpmGd5c5s6evfbPlDJEAWj7Xb6vtPjL7Iau7Zoj1KR7jxgW+
         kEwM8+//HF0pf/OScF5XwMEbyLIesJVF/6nPHDN16+L3Y28HK3RKTlXC6Gb+ZZZy7z1P
         O7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Nj+Clt9ZkEOhilN6GICXjikzzBZghfnwZ/Dm9+HmTo=;
        b=d31a+AuvDuBrUNK+eua74L7OE3cRwYtGhK0ikNckxpMq2L8AqkWqmAjAdDa/g89ibR
         pYGnWmAfovzMvN4ScTvkWNBQuhPq3HvsIark32ViXECL8H5Y9UnzgVkh8vYopdJFFCun
         2jtratNVhhyruGdKD3SoKntebqjMRsu9iiROzX8R7eGHUIYKLsryf85T79VDDkwhCDDg
         SGq/7FQwPsPw4a/PqbpnWa9JUgoqmCXJEoZcKaWOg6QCjPZS1nM3D6Rc8IJ2byjMjaEm
         iDqkPIecVJCfaTXM6OrY2ahW+hrsN/mfK73eCXBlNLJF3jRPaKYAEHlVSOGv/gFBdqz+
         z6Vg==
X-Gm-Message-State: AJIora/0mVWU719AFm3AyltGbD/KJnny8QtsN50ST6bMyOp6IgdszcyF
	lLHYV3TgxeaKLpzqKZU1AE4=
X-Google-Smtp-Source: AGRyM1sq1O/dROKcgW/RFJ8xEucSHXKkPva4WFF14qX+E+GPx5HaHZIGGrLmCeCSd00CPR8xFfXSdA==
X-Received: by 2002:a17:902:c40a:b0:16c:408:57d6 with SMTP id k10-20020a170902c40a00b0016c040857d6mr12190575plk.157.1657866037951;
        Thu, 14 Jul 2022 23:20:37 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b0016bdeb58611sm2578624plk.112.2022.07.14.23.20.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jul 2022 23:20:37 -0700 (PDT)
Date: Fri, 15 Jul 2022 14:22:01 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 02/16] erofs: clean up z_erofs_collector_begin()
Message-ID: <20220715142201.000030f1.zbestahu@gmail.com>
In-Reply-To: <20220714132051.46012-3-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
	<20220714132051.46012-3-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 14 Jul 2022 21:20:37 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Rearrange the code and get rid of all gotos.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 1b6816dd235f..c7be447ac64d 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -521,7 +521,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>  static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
>  {
>  	struct erofs_map_blocks *map = &fe->map;
> -	struct erofs_workgroup *grp;
> +	struct erofs_workgroup *grp = NULL;
>  	int ret;
>  
>  	DBG_BUGON(fe->pcl);
> @@ -530,33 +530,31 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
>  	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
>  	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
>  
> -	if (map->m_flags & EROFS_MAP_META) {
> -		if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
> -			DBG_BUGON(1);
> -			return -EFSCORRUPTED;
> -		}
> -		goto tailpacking;
> +	if (!(map->m_flags & EROFS_MAP_META)) {
> +		grp = erofs_find_workgroup(fe->inode->i_sb,
> +					   map->m_pa >> PAGE_SHIFT);
> +	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
> +		DBG_BUGON(1);
> +		return -EFSCORRUPTED;
>  	}
>  
> -	grp = erofs_find_workgroup(fe->inode->i_sb, map->m_pa >> PAGE_SHIFT);
>  	if (grp) {
>  		fe->pcl = container_of(grp, struct z_erofs_pcluster, obj);
> +		ret = -EEXIST;
>  	} else {
> -tailpacking:
>  		ret = z_erofs_register_pcluster(fe);
> -		if (!ret)
> -			goto out;
> -		if (ret != -EEXIST)
> -			return ret;
>  	}
>  
> -	ret = z_erofs_lookup_pcluster(fe);
> -	if (ret) {
> -		erofs_workgroup_put(&fe->pcl->obj);
> +	if (ret == -EEXIST) {
> +		ret = z_erofs_lookup_pcluster(fe);
> +		if (ret) {
> +			erofs_workgroup_put(&fe->pcl->obj);
> +			return ret;
> +		}
> +	} else if (ret) {
>  		return ret;
>  	}
>  
> -out:
>  	z_erofs_pagevec_ctor_init(&fe->vector, Z_EROFS_NR_INLINE_PAGEVECS,
>  				  fe->pcl->pagevec, fe->pcl->vcnt);
>  	/* since file-backed online pages are traversed in reverse order */

Reviewed-by: Yue Hu <huyue2@coolpad.com>
