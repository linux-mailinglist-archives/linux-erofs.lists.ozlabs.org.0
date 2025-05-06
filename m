Return-Path: <linux-erofs+bounces-281-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE2FAAC923
	for <lists+linux-erofs@lfdr.de>; Tue,  6 May 2025 17:11:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsMKb4M9bz2yrF;
	Wed,  7 May 2025 01:10:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746544259;
	cv=none; b=ceMaivVMqBh8dspj+zoIuiwAeiKNz/SpRHeJRCRdBslq1ZdKT47NCBLXyn2+f9WlX/D3gdltnvxIn4Vxn/SZ+4kKGkw7V54Mda+8Zk0XPjGtgQZhMATFqY3Q7Tmaqo6LNS6RMSns2hw4qaG56P6eCisX/0jPIaDV7gdv7jkvrX9z9XFk1Cjl99sLseNZTFdg7DrD0+YtAHEp8XEex4EUKn1jPykU+eS2Q1c1xgoDOSlYWIUh9Rj3X1/e6FCgPr4Hp6bHauTm6ASDO2z+3kduJT2zH1jwo/brsbrvt0BDTRCx8mM3UholG9g65EaoNDqgHm4p9m+LRtpLNt3eq5gs0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746544259; c=relaxed/relaxed;
	bh=GeNymH+klft7mdhfQZi/jBImRDyPtAkJHpdNSIxr5aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdfaLaCypA46I5zpekvpDPLi6dw3d+HRKecr/A5TozMbebPG1s+Y0eA7xRaCXhuLDFVAfKovBYwHv2gpOdKP2YlQAsg2mTRPzbhFNEDB3bGK77LLdVfsKggUrZMdgIlkJUeNydbTWtId28CWqOiaeR7PXHHhRuBKF57ggySXVpWckLvZ1V5wBrFd4Q87CP0Aa/Y2tNMAxHNpWIwqMJ+ha7FHZdPKA4o6f6FACMJkmitn2984EUaJumkw5Uq/28yHCZFZWoiSAHqVc4ZjQtK00jdajNSejzQJaNbSzOC7rN5iMaXhtcgC3ly6S6fGCDAAh+tSNbLR8zAR3zGoCtlqIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=chzdt8Y3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=chzdt8Y3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsMKY40dcz2ydw
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 01:10:56 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746544251; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GeNymH+klft7mdhfQZi/jBImRDyPtAkJHpdNSIxr5aI=;
	b=chzdt8Y3m/huHV5Hg/f4PpidhYZedOJXHphd76Ju4YRrAheeSp5nuXMEBp49fs7dy+2r2PxEFnzpuFQyRIQOc9iIQsHSVzDB9atT4grU+9HXWD9j0AOS941dqML6KAsDGUxl1feshGVR9Zux7PopmEgUsHAijk5HHPe0Wi9lHGk=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WZYPgkD_1746544248 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 06 May 2025 23:10:49 +0800
Message-ID: <18d272ce-6a80-4fdc-b67b-ddc2ffa522d4@linux.alibaba.com>
Date: Tue, 6 May 2025 23:10:46 +0800
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
Subject: Re: [PATCH v3] erofs: fix file handle encoding for 64-bit NIDs
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com
Cc: dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250429134257.690176-1-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250429134257.690176-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Hongbo,

On 2025/4/29 21:42, Hongbo Li wrote:
> In erofs, the inode number has the location information of
> files. The default encode_fh uses the ino32, this will lack
> of some information when the file is too big. So we need
> the internal helpers to encode filehandle.

EROFS uses NID to indicate the on-disk inode offset, which can
exceed 32 bits. However, the default encode_fh uses the ino32,
thus it doesn't work if the image is large than 128GiB.

Let's introduce our own helpers to encode file handles.

> 
> It is easy to reproduce test:

It's easy to reproduce:

>    1. prepare an erofs image with nid bigger than UINT_MAX

      1. Prepare an EROFS image with NIDs larger than U32_MAX

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
> v2: https://lore.kernel.org/all/20250429074109.689075-1-lihongbo22@huawei.com/
>    - Assign parent nid with correct value.
> 
> v1: https://lore.kernel.org/all/20250429011139.686847-1-lihongbo22@huawei.com/
>     - Encode generation into file handle and minor clean code.
>     - Update the commiti's title.
> ---
>   fs/erofs/super.c | 54 +++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index cadec6b1b554..28b3701165cc 100644
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

Just `erofs_nid_t nid = EROFS_I(inode)->nid;`?

I think the compiler will optimize out `if (*max_len < len)`.

> +	u32 generation;

It seems it's unnecessary to introduce `generation` variable here?

> +
> +	if (*max_len < len) {
> +		*max_len = len;
> +		return FILEID_INVALID;
> +	}
> +
> +	nid = EROFS_I(inode)->nid;
> +	generation = inode->i_generation;

So drop these two lines.

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

		fh[5] = parent->i_generation;

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

Unnecessary nid variable.

> +	return d_obtain_alias(erofs_iget(sb, nid));

	return d_obtain_alias(erofs_iget(sb,
			((u64)fid->raw[0] << 32) | fid->raw[1]));

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
> +	nid = (u64) fid->raw[3] << 32;
> +	nid |= (u64) fid->raw[4];

Same here.

Thanks,
Gao Xiang

