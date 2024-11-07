Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B99BFCDC
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 04:10:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1730949004;
	bh=qC58THW97K1QqlGvbF0BMTIvQfNGpPrBioIlRavBgxY=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=IvND+Un82p0jxBhkTtGUsGiRJBYdG94bOsrw7DghtFhZlMY9rLiNvHhybnUGcoMED
	 9myH9a816QrBEonrX9pQR6mCA2k8ReJYswJnux5XWI3hO7NPeuXGCpBdClb+vSuZ0K
	 j/8kmwY9eU6t1DSHELtmTgPXvOa/IDciyXNlvFONWJbYgmOCPGafyH334PTr2Rzugv
	 fYKufGyuRRr1HqxBW85SKYgfj35l0gr/6h0A+dTOK/GEYeMkK3j0hrAYqLbc99MI5f
	 0lfCxqZDyFapDiSRm+C7WxOudWObfv1g0ZKIBi+/QgMpdsG5kKgtEujYYsKHbTov/R
	 ZLSrEL36Gep8g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkRrr3pRbz3bjt
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 14:10:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730949003;
	cv=none; b=aJLqqkT5qU9rsmvG64LWp5yIAmb01uJOlTVCGn6uQj/F2W+3SK11iLG2s4zCFnBE4LZFkwvAQe+DJ0j/m+NXt+cK5wAzVbRFXwn4h93Lgu7Vk6w8MTpd/HxOQbZIZX0pZDGRyTlwpxdEWvi/MsXGNruZqkxWtBJN01TvsTIFSjk/OQ42Mo1tdsRezYSdncNwRqj00d3RJ3gjkNAhqH6T18ejz1LKAMaohgT6uYHAS1xHmKxKE2TzJNlsdN/Ye4FFHHizynV4hQyDPUl2EV4D5PwEukAIo6vHo+cwUjWiybcXv7aWcd2J5sA6onX6yo3sdI8kY44+l1p28ziZpeJGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730949003; c=relaxed/relaxed;
	bh=qC58THW97K1QqlGvbF0BMTIvQfNGpPrBioIlRavBgxY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=espWj9GbS3nspXGhKnztgR7yLxHNQ4QW2V3/SOmiWarmKe8MxqtpxEUF8WVrFg7ItIHzZ2hsXjDlqedreRObhcf1ir+C4mp9jczxgtL8x18zc7lFyWkRbvFDjUtZ1q0uaAZ2TiJqEfNsWQHEOJ9g/+iIJ6yo5uayEfvqCb38jjHV8ooFEgrkNL1wTDC4UsFZqS252dhrDLZoWvMhBDSMJDPPvABGl3FIgIUMiJCTFBibF73iXZhaCLIpwMJSTKF3gsLStNMrBUubKNbp55hrX2IfVFF155R9oD9APlYM7BQ0KBl1EFKceoZpTdAbwGNQjrw+qy78a0BdLaRK65K2/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Stla8fnf; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Stla8fnf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkRrp10Dsz2yM6
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2024 14:10:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 50DFD5C0374;
	Thu,  7 Nov 2024 03:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92749C4CECC;
	Thu,  7 Nov 2024 03:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730948996;
	bh=e0vKZNZg96eKyHN35H46M8rNrJ4JpDnQIfwWaNgFNSM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Stla8fnfAqeR3fYoNbhbmpleU2Jt6utTnRNG1KVi5Y7rjPe/F6Ruop7BfLrVVXqXU
	 qQ6E64Y+Heq5byXrKEempi6EwLt2RuIOpcE+qTIhGqbWSvRQ/l39L3avYFtkyMqeo9
	 uaHY9UOSLAidaDlY9Wx+r/3Ba+rckNwx1Vf6T31gUr81fm7pioFi6eRYDIVFofaKy7
	 D4dki02gdCA6AWf3iuEi/AwoNiXwGMO67CnqUccYuyFE4GLUTunqifS3e0xdDwt9zD
	 3Faac0kjlGjLubLOKgCcVd7WPl45LYVqNRm4zOOe9TOAJs9BYyYEJQftskqGvxLP55
	 xx4b+C+QuehrQ==
Message-ID: <36d1653d-249a-47b0-a87c-1216ed5bf1ca@kernel.org>
Date: Thu, 7 Nov 2024 11:09:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] erofs: get rid of erofs_{find,insert}_workgroup
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Chunhai Guo <guochunhai@vivo.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/10/21 11:53, Gao Xiang wrote:
> Just fold them into the only two callers since
> they are simple enough.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v1: https://lore.kernel.org/r/20241017115705.877515-1-hsiangkao@linux.alibaba.com
> change since v1:
>   - !grp case should be handled properly mentioned by Chunhai;
> 
>   fs/erofs/internal.h |  5 +----
>   fs/erofs/zdata.c    | 38 +++++++++++++++++++++++++---------
>   fs/erofs/zutil.c    | 50 +--------------------------------------------
>   3 files changed, 30 insertions(+), 63 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4efd578d7c62..8081ee43cd83 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -457,10 +457,7 @@ void erofs_release_pages(struct page **pagepool);
>   
>   #ifdef CONFIG_EROFS_FS_ZIP
>   void erofs_workgroup_put(struct erofs_workgroup *grp);
> -struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
> -					     pgoff_t index);
> -struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
> -					       struct erofs_workgroup *grp);
> +bool erofs_workgroup_get(struct erofs_workgroup *grp);
>   void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
>   void erofs_shrinker_register(struct super_block *sb);
>   void erofs_shrinker_unregister(struct super_block *sb);
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index a569ff9dfd04..bb1b73d99d07 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -714,9 +714,10 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>   {
>   	struct erofs_map_blocks *map = &fe->map;
>   	struct super_block *sb = fe->inode->i_sb;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   	bool ztailpacking = map->m_flags & EROFS_MAP_META;
>   	struct z_erofs_pcluster *pcl;
> -	struct erofs_workgroup *grp;
> +	struct erofs_workgroup *grp, *pre;
>   	int err;
>   
>   	if (!(map->m_flags & EROFS_MAP_ENCODED) ||
> @@ -752,15 +753,23 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>   		pcl->obj.index = 0;	/* which indicates ztailpacking */
>   	} else {
>   		pcl->obj.index = erofs_blknr(sb, map->m_pa);
> -
> -		grp = erofs_insert_workgroup(fe->inode->i_sb, &pcl->obj);
> -		if (IS_ERR(grp)) {
> -			err = PTR_ERR(grp);
> -			goto err_out;
> +		while (1) {
> +			xa_lock(&sbi->managed_pslots);
> +			pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
> +					   NULL, grp, GFP_KERNEL);
> +			if (!pre || xa_is_err(pre) || erofs_workgroup_get(pre)) {
> +				xa_unlock(&sbi->managed_pslots);
> +				break;
> +			}
> +			/* try to legitimize the current in-tree one */
> +			xa_unlock(&sbi->managed_pslots);
> +			cond_resched();
>   		}
> -
> -		if (grp != &pcl->obj) {

Do we need to keep this logic?

Thanks,

> -			fe->pcl = container_of(grp,
> +		if (xa_is_err(pre)) {
> +			err = xa_err(pre);
> +			goto err_out;
> +		} else if (pre) {
> +			fe->pcl = container_of(pre,
>   					struct z_erofs_pcluster, obj);
>   			err = -EEXIST;
>   			goto err_out;
> @@ -789,7 +798,16 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>   	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
>   
>   	if (!(map->m_flags & EROFS_MAP_META)) {
> -		grp = erofs_find_workgroup(sb, blknr);
> +		while (1) {
> +			rcu_read_lock();
> +			grp = xa_load(&EROFS_SB(sb)->managed_pslots, blknr);
> +			if (!grp || erofs_workgroup_get(grp)) {
> +				DBG_BUGON(grp && blknr != grp->index);
> +				rcu_read_unlock();
> +				break;
> +			}
> +			rcu_read_unlock();
> +		}
>   	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
>   		DBG_BUGON(1);
>   		return -EFSCORRUPTED;
> diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
> index 37afe2024840..218b0249a482 100644
> --- a/fs/erofs/zutil.c
> +++ b/fs/erofs/zutil.c
> @@ -214,7 +214,7 @@ void erofs_release_pages(struct page **pagepool)
>   	}
>   }
>   
> -static bool erofs_workgroup_get(struct erofs_workgroup *grp)
> +bool erofs_workgroup_get(struct erofs_workgroup *grp)
>   {
>   	if (lockref_get_not_zero(&grp->lockref))
>   		return true;
> @@ -231,54 +231,6 @@ static bool erofs_workgroup_get(struct erofs_workgroup *grp)
>   	return true;
>   }
>   
> -struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
> -					     pgoff_t index)
> -{
> -	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	struct erofs_workgroup *grp;
> -
> -repeat:
> -	rcu_read_lock();
> -	grp = xa_load(&sbi->managed_pslots, index);
> -	if (grp) {
> -		if (!erofs_workgroup_get(grp)) {
> -			/* prefer to relax rcu read side */
> -			rcu_read_unlock();
> -			goto repeat;
> -		}
> -
> -		DBG_BUGON(index != grp->index);
> -	}
> -	rcu_read_unlock();
> -	return grp;
> -}
> -
> -struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
> -					       struct erofs_workgroup *grp)
> -{
> -	struct erofs_sb_info *const sbi = EROFS_SB(sb);
> -	struct erofs_workgroup *pre;
> -
> -	DBG_BUGON(grp->lockref.count < 1);
> -repeat:
> -	xa_lock(&sbi->managed_pslots);
> -	pre = __xa_cmpxchg(&sbi->managed_pslots, grp->index,
> -			   NULL, grp, GFP_KERNEL);
> -	if (pre) {
> -		if (xa_is_err(pre)) {
> -			pre = ERR_PTR(xa_err(pre));
> -		} else if (!erofs_workgroup_get(pre)) {
> -			/* try to legitimize the current in-tree one */
> -			xa_unlock(&sbi->managed_pslots);
> -			cond_resched();
> -			goto repeat;
> -		}
> -		grp = pre;
> -	}
> -	xa_unlock(&sbi->managed_pslots);
> -	return grp;
> -}
> -
>   static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
>   {
>   	atomic_long_dec(&erofs_global_shrink_cnt);

