Return-Path: <linux-erofs+bounces-268-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E901AA0DB2
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 15:45:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zn1mN0Bllz30Vs;
	Tue, 29 Apr 2025 23:45:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745934339;
	cv=none; b=gdGd/TjJ2MelP3aqLBmxfN8CJnD4SCV/nb+piPmMXlb4iUH0BxoNoUcNQQOZb7jk1QyevXzGmN44DI14S1rEMWupKT2ExIOuwCzyeIA2sWkhxcoUgDXPIwVd6LA9np4vOaXfEzq1O0P6ArCsx8bzWweXLdOdTVJDVxBUWFypxyCU7amxVOXKpqMlRtSwAR7pF891r0gz4LoGNWDfhBteRwivBi1hoUaT933xZz+2Vztifq0YGi9dR/GJOCacEEZ09Lq3cU3T6n+q8/FTVgyWOyYlIZ+1XpLATntELA6hiLNYrEq2EtrdmzDXJ1AB8S27sVfDG93u222/VTUS7Vk1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745934339; c=relaxed/relaxed;
	bh=qm94qmWrMYnQkPthq7mKpdmpUQzoGGqSR6xiR4FKQco=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jipycwuMWvs5e+SkHHV2JzVzgBXpPEKAlUEP7bWQfTNS0iq4CxjsZLkeRiLjjExpVDlWale0ewmZ2Be11b9sYDPjOu9ANdbf1W+ueSKKvUG1vJ8dTXPue4o9GYqjX78k3i7cVpe75C2WHdSSYcQsdL5mNs+6pn97G3UDUmYEGbtu85X10jOaQDDKW3u2/KCVAYD92cptRKIJzgVOrjfqHAtYs2QrD8eiuF7MzlzDQgQy4htUJT37dmjTaJOeO2wtbQzdDROS+0POLImvO5CDOQv6T8G4AtN5YMCht/BuSPcwU1Omt+hnieWYzHoH1JMs4ga6+871IPphPhAtI1ITmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zn1mF6Zsdz2xHp
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 23:45:31 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zn1gG5PbCzvWx6
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 21:41:14 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id A7F3A1401E0
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 21:45:26 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Apr 2025 21:45:26 +0800
Message-ID: <eceecf11-2d2e-452d-9b60-27805ac18188@huawei.com>
Date: Tue, 29 Apr 2025 21:45:25 +0800
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
Subject: Re: [PATCH v2] erofs: fix file handle encoding for 64-bit NIDs
To: <linux-erofs@lists.ozlabs.org>
References: <20250429074109.689075-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250429074109.689075-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/29 15:41, Hongbo Li wrote:
> In erofs, the inode number has the location information of
> files. The default encode_fh uses the ino32, this will lack
> of some information when the file is too big. So we need
> the internal helpers to encode filehandle.
> 
> It is easy to reproduce test:
>    1. prepare an erofs image with nid bigger than UINT_MAX
>    2. mount -t erofs foo.img /mnt/erofs
>    3. set exportfs with configuration: /mnt/erofs *(rw,sync,
>       no_root_squash)
>    4. mount -t nfs $IP:/mnt/erofs /mnt/nfs
>    5. md5sum /mnt/nfs/foo # foo is the file which nid bigger
>       than UINT_MAX.
> For overlayfs case, the under filesystem's file handle is
> encoded in ovl_fb.fid, it is same as NFS's case.
> 
> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
> v1: https://lore.kernel.org/all/20250429011139.686847-1-lihongbo22@huawei.com/
>    - Encode generation into file handle and minor clean code.
>    - Update the commiti's title.
> ---
>   fs/erofs/super.c | 54 +++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index cadec6b1b554..aef5d0ca1695 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -511,24 +511,62 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   	return 0;
>   }
>   
> -static struct inode *erofs_nfs_get_inode(struct super_block *sb,
> -					 u64 ino, u32 generation)
> +static int erofs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> +			   struct inode *parent)
>   {
> -	return erofs_iget(sb, ino);
> +	int len = parent ? 6 : 3;
> +	erofs_nid_t nid;
> +	u32 generation;
> +
> +	if (*max_len < len) {
> +		*max_len = len;
> +		return FILEID_INVALID;
> +	}
> +
> +	nid = EROFS_I(inode)->nid;
> +	generation = inode->i_generation;
> +	fh[0] = (u32)(nid >> 32);
> +	fh[1] = (u32)(nid & 0xffffffff);
> +	fh[2] = generation;
> +
> +	if (parent) {
> +		nid = EROFS_I(parent)->nid;
> +		generation = parent->i_generation;
> +
> +		fh[3] = (u32)(nid >> 32);
> +		fh[4] = (u32)(nid & 0xffffffff);
> +		fh[5] = generation;
> +	}
> +
> +	*max_len = len;
> +	return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
>   }
>   
>   static struct dentry *erofs_fh_to_dentry(struct super_block *sb,
>   		struct fid *fid, int fh_len, int fh_type)
>   {
> -	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
> -				    erofs_nfs_get_inode);
> +	erofs_nid_t nid;
> +
> +	if ((fh_type != FILEID_INO64_GEN &&
> +	     fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 3)
> +		return NULL;
> +
> +	nid = (u64) fid->raw[0] << 32;
> +	nid |= (u64) fid->raw[1];
> +	return d_obtain_alias(erofs_iget(sb, nid));
>   }
>   
>   static struct dentry *erofs_fh_to_parent(struct super_block *sb,
>   		struct fid *fid, int fh_len, int fh_type)
>   {
> -	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
> -				    erofs_nfs_get_inode);
> +	erofs_nid_t nid;
> +
> +	if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 6)
> +		return NULL;
> +
> +	nid = (u64) fid->raw[2] << 32;
> +	nid |= (u64) fid->raw[3];
Sorry, I forget change here, I will send the next version.
> +	return d_obtain_alias(erofs_iget(sb, nid));
>   }
>   
>   static struct dentry *erofs_get_parent(struct dentry *child)
> @@ -544,7 +582,7 @@ static struct dentry *erofs_get_parent(struct dentry *child)
>   }
>   
>   static const struct export_operations erofs_export_ops = {
> -	.encode_fh = generic_encode_ino32_fh,
> +	.encode_fh = erofs_encode_fh,
>   	.fh_to_dentry = erofs_fh_to_dentry,
>   	.fh_to_parent = erofs_fh_to_parent,
>   	.get_parent = erofs_get_parent,

