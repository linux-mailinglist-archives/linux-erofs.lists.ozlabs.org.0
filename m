Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 302AC967EF4
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 07:53:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wxybd1RYPz2yNt
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 15:53:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725256394;
	cv=none; b=Lz5YbwfAiuy0ycwLYklwt5Rtcm6b/UcvHfZW/JZdYvJwj60Q3LQeQVvm8hIScHU40uNg/rEu+EirOKLivdxhC3UiOzJe+8kLtFlHbHAbBR7wT7FO/JGYxTStsUpnTReGw+5NTM2I4wQF3Zf61i/xujGj2/e6tTPBTNIGQ4IXTA8oJelj5WykzdBNdI8SyiX1n40AQKxmjKWol0vT7pT8LHDGR50A2cjB6v/gpXO5Fh8pMzN+Azmm4FD+wLEmwZEWeED+5SfVla9eA8NtGuaVUzWZz91RRp6Vp+6G7wsiEnn6Hn8SFNMt7UTtoRhFpXs7qX9uV8t7MEh0EE65QVUjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725256394; c=relaxed/relaxed;
	bh=n9pbg9XS24r9wLN5q+b/cJg1TqhGcwRw4pEUuFObavk=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=V/wKDIGQdNOmGWYX2MEwg8xWFxIuLC0fpwTyNG4GQbcCQE8CPqsb7T8+rUE/T/7v9vbpEnWdaC39Y9tG8iTd9VgqujQV0KHWfVMKLGJK8t0+2QnMvh4GVnZ7FTqIs5Y7DkIPQgIVN1Opw3w5Kz/Hf/bUFfS6BnHFfJmZoL3f1kkWchgeG3QWbTHtoxkNze+pkMXYkAuh59KD8fIUY4O2KRpxA7UKpvNN7qkEEEJcQ5FWBJTMDW5BpS4cYNbacnEGlSZ40+g2qFOdn7U5x3MlL6pD1s4lVOzB+236hdeHgD0UZGdjs+SPxgkalCo3jes4tnUZbnLhLxB5B5WPKYL3oA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OhN0wmXZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OhN0wmXZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WxybV3cPfz2y66
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 15:53:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725256383; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=n9pbg9XS24r9wLN5q+b/cJg1TqhGcwRw4pEUuFObavk=;
	b=OhN0wmXZKzeULzBa9cOJ7o3iQ9qYOhUIaEeGERyochhvvISgTn2kHCC3YdeR/U4Pnzz14lacw4SJaooaxX1wzWuxNxDWrQ/ANTO1MHRQ3wYtpQlDmDyOBgWmzGPteshD9y380kaPXvksjSkZqwdAHnB4SpvppNc0gCg+VvAVq4g=
Received: from 30.244.151.91(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WE3kggo_1725256379)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 13:53:00 +0800
Message-ID: <eaeecdd2-9689-47e8-963b-f6aa9ef7d9cd@linux.alibaba.com>
Date: Mon, 2 Sep 2024 13:52:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs: refactor read_inode calling convention
To: Yiyang Wu <toolmanp@tlmp.cc>
References: <20240902045100.285477-1-toolmanp@tlmp.cc>
 <20240902045100.285477-2-toolmanp@tlmp.cc>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240902045100.285477-2-toolmanp@tlmp.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-erofs@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yiyang,

On 2024/9/2 12:50, Yiyang Wu wrote:
> Refactor out the iop binding behavior out of the erofs_fill_symlink
> and move erofs_buf into the erofs_read_inode, so that erofs_fill_inode
> can only deal with inode operation bindings and can be decoupled from
> metabuf operations. This results in better calling conventions.
> 
> Note that after the patch, we do not need erofs_buf and ofs as
> parameters when calling erofs_read_inode as all the data operations are
> self included inside itself.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> ---
>   fs/erofs/inode.c | 164 +++++++++++++++++++++++++----------------------
>   1 file changed, 86 insertions(+), 78 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 419432be3223..90f1235dc404 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -8,36 +8,71 @@
>   
>   #include <trace/events/erofs.h>
>   
> -static void *erofs_read_inode(struct erofs_buf *buf,
> -			      struct inode *inode, unsigned int *ofs)
> +static int erofs_fill_symlink(struct inode *inode, void *kaddr,
> +			      unsigned int m_pofs)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	unsigned int bsz = i_blocksize(inode);
> +	char *lnk;
> +
> +	/* if it cannot be handled with fast symlink scheme */
> +	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
> +	    inode->i_size >= bsz || inode->i_size < 0) {
> +		return 0;
> +	}
> +
> +	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
> +	if (!lnk)
> +		return -ENOMEM;
> +
> +	m_pofs += vi->xattr_isize;
> +	/* inline symlink data shouldn't cross block boundary */
> +	if (m_pofs + inode->i_size > bsz) {
> +		kfree(lnk);
> +		erofs_err(inode->i_sb,
> +			  "inline data cross block boundary @ nid %llu",
> +			  vi->nid);
> +		DBG_BUGON(1);
> +		return -EFSCORRUPTED;
> +	}
> +	memcpy(lnk, kaddr + m_pofs, inode->i_size);
> +	lnk[inode->i_size] = '\0';
> +
> +	inode->i_link = lnk;
> +	return 0;
> +}
> +
> +static int erofs_read_inode(struct inode *inode)
>   {
>   	struct super_block *sb = inode->i_sb;
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   	struct erofs_inode *vi = EROFS_I(inode);
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>   	const erofs_off_t inode_loc = erofs_iloc(inode);
>   	erofs_blk_t blkaddr, nblks = 0;
>   	void *kaddr;
>   	struct erofs_inode_compact *dic;
>   	struct erofs_inode_extended *die, *copied = NULL;
>   	union erofs_inode_i_u iu;
> -	unsigned int ifmt;
> +	unsigned int ifmt, ofs;
>   	int err;
>   
>   	blkaddr = erofs_blknr(sb, inode_loc);
> -	*ofs = erofs_blkoff(sb, inode_loc);
> +	ofs = erofs_blkoff(sb, inode_loc);
>   
> -	kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr), EROFS_KMAP);
> +	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr),
> +				   EROFS_KMAP);
>   	if (IS_ERR(kaddr)) {
>   		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
>   			  vi->nid, PTR_ERR(kaddr));
> -		return kaddr;
> +		return PTR_ERR(kaddr);
>   	}
>   
> -	dic = kaddr + *ofs;
> +	dic = kaddr + ofs;
>   	ifmt = le16_to_cpu(dic->i_format);
>   	if (ifmt & ~EROFS_I_ALL) {
> -		erofs_err(sb, "unsupported i_format %u of nid %llu",
> -			  ifmt, vi->nid);
> +		erofs_err(sb, "unsupported i_format %u of nid %llu", ifmt,
> +			  vi->nid);
>   		err = -EOPNOTSUPP;
>   		goto err_out;
>   	}
> @@ -54,11 +89,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   	case EROFS_INODE_LAYOUT_EXTENDED:
>   		vi->inode_isize = sizeof(struct erofs_inode_extended);
>   		/* check if the extended inode acrosses block boundary */
> -		if (*ofs + vi->inode_isize <= sb->s_blocksize) {
> -			*ofs += vi->inode_isize;
> +		if (ofs + vi->inode_isize <= sb->s_blocksize) {
> +			ofs += vi->inode_isize;
>   			die = (struct erofs_inode_extended *)dic;
>   		} else {
> -			const unsigned int gotten = sb->s_blocksize - *ofs;
> +			const unsigned int gotten = sb->s_blocksize - ofs;
>   
>   			copied = kmalloc(vi->inode_isize, GFP_KERNEL);
>   			if (!copied) {
> @@ -66,16 +101,19 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   				goto err_out;
>   			}
>   			memcpy(copied, dic, gotten);
> -			kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr + 1),
> +			kaddr = erofs_read_metabuf(&buf, sb,
> +						   erofs_pos(sb, blkaddr + 1),
>   						   EROFS_KMAP);
>   			if (IS_ERR(kaddr)) {
> -				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
> -					  vi->nid, PTR_ERR(kaddr));
> +				erofs_err(
> +					sb,
> +					"failed to get inode payload block (nid: %llu), err %ld",
> +					vi->nid, PTR_ERR(kaddr));

Unnecessary change, please don't touch this, and
the style is weird, usually, print statements don't
follow linechar limitation.


>   				kfree(copied);
> -				return kaddr;
> +				return PTR_ERR(kaddr);
>   			}
> -			*ofs = vi->inode_isize - gotten;
> -			memcpy((u8 *)copied + gotten, kaddr, *ofs);
> +			ofs = vi->inode_isize - gotten;
> +			memcpy((u8 *)copied + gotten, kaddr, ofs);
>   			die = copied;
>   		}
>   		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
> @@ -95,7 +133,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   		break;
>   	case EROFS_INODE_LAYOUT_COMPACT:
>   		vi->inode_isize = sizeof(struct erofs_inode_compact);
> -		*ofs += vi->inode_isize;
> +		ofs += vi->inode_isize;
>   		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
>   
>   		inode->i_mode = le16_to_cpu(dic->i_mode);
> @@ -109,16 +147,22 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   		inode->i_size = le32_to_cpu(dic->i_size);
>   		break;
>   	default:
> -		erofs_err(sb, "unsupported on-disk inode version %u of nid %llu",
> +		erofs_err(sb,
> +			  "unsupported on-disk inode version %u of nid %llu",
>   			  erofs_inode_version(ifmt), vi->nid);
>   		err = -EOPNOTSUPP;
>   		goto err_out;
>   	}
>   
>   	switch (inode->i_mode & S_IFMT) {
> +	case S_IFLNK:
> +		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
> +		err = erofs_fill_symlink(inode, kaddr, ofs);
> +		if (err)
> +			goto err_out;
> +		break;
>   	case S_IFREG:
>   	case S_IFDIR:
> -	case S_IFLNK:

How about not changing this, but add another if for this.
	if (S_ISLNK(inode->i_mode)) {
		err = erofs_fill_symlink(inode, kaddr, ofs);
		if (err)
			goto err_out;
	}

>   		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
>   		break;
>   	case S_IFCHR:
> @@ -148,11 +192,12 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   			err = -EOPNOTSUPP;
>   			goto err_out;
>   		}
> -		vi->chunkbits = sb->s_blocksize_bits +
> +		vi->chunkbits =
> +			sb->s_blocksize_bits +
>   			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);

Unnecessary change, please don't touch this.

>   	}
> -	inode_set_mtime_to_ts(inode,
> -			      inode_set_atime_to_ts(inode, inode_get_ctime(inode)));
> +	inode_set_mtime_to_ts(
> +		inode, inode_set_atime_to_ts(inode, inode_get_ctime(inode)));

Unnecessary change.

>   
>   	inode->i_flags &= ~S_DAX;
>   	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
> @@ -165,65 +210,29 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
>   	else
>   		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
> -	return kaddr;
> +
> +	erofs_put_metabuf(&buf);
> +	return 0;
>   
>   err_out:
>   	DBG_BUGON(1);
>   	kfree(copied);
> -	erofs_put_metabuf(buf);
> -	return ERR_PTR(err);
> -}
> -
> -static int erofs_fill_symlink(struct inode *inode, void *kaddr,
> -			      unsigned int m_pofs)
> -{
> -	struct erofs_inode *vi = EROFS_I(inode);
> -	unsigned int bsz = i_blocksize(inode);
> -	char *lnk;
> -
> -	/* if it cannot be handled with fast symlink scheme */
> -	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
> -	    inode->i_size >= bsz || inode->i_size < 0) {
> -		inode->i_op = &erofs_symlink_iops;
> -		return 0;
> -	}
> -
> -	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
> -	if (!lnk)
> -		return -ENOMEM;
> -
> -	m_pofs += vi->xattr_isize;
> -	/* inline symlink data shouldn't cross block boundary */
> -	if (m_pofs + inode->i_size > bsz) {
> -		kfree(lnk);
> -		erofs_err(inode->i_sb,
> -			  "inline data cross block boundary @ nid %llu",
> -			  vi->nid);
> -		DBG_BUGON(1);
> -		return -EFSCORRUPTED;
> -	}
> -	memcpy(lnk, kaddr + m_pofs, inode->i_size);
> -	lnk[inode->i_size] = '\0';
> -
> -	inode->i_link = lnk;
> -	inode->i_op = &erofs_fast_symlink_iops;
> +	erofs_put_metabuf(&buf);
>   	return 0;
>   }
>   
>   static int erofs_fill_inode(struct inode *inode)
>   {
>   	struct erofs_inode *vi = EROFS_I(inode);
> -	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> -	void *kaddr;
> -	unsigned int ofs;
> -	int err = 0;
> +
> +	int err;
>   
>   	trace_erofs_fill_inode(inode);
>   
>   	/* read inode base data from disk */
> -	kaddr = erofs_read_inode(&buf, inode, &ofs);
> -	if (IS_ERR(kaddr))
> -		return PTR_ERR(kaddr);
> +	err = erofs_read_inode(inode);
> +	if (err)
> +		goto out_unlock;
>   
>   	/* setup the new inode */
>   	switch (inode->i_mode & S_IFMT) {
> @@ -240,9 +249,10 @@ static int erofs_fill_inode(struct inode *inode)
>   		inode_nohighmem(inode);
>   		break;
>   	case S_IFLNK:
> -		err = erofs_fill_symlink(inode, kaddr, ofs);
> -		if (err)
> -			goto out_unlock;
> +		if (inode->i_link != NULL)

		if (inode->i_link)

I'm not sure if `scripts/checkpatch.pl` still has the rule,
but EROFS codebase don't compare against NULL.

> +			inode->i_op = &erofs_fast_symlink_iops;
> +		else
> +			inode->i_op = &erofs_symlink_iops;
>   		inode_nohighmem(inode);
>   		break;
>   	case S_IFCHR:
> @@ -260,9 +270,9 @@ static int erofs_fill_inode(struct inode *inode)
>   	mapping_set_large_folios(inode->i_mapping);
>   	if (erofs_inode_is_data_compressed(vi->datalayout)) {
>   #ifdef CONFIG_EROFS_FS_ZIP
> -		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
> -			  erofs_info, inode->i_sb,
> -			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
> +		DO_ONCE_LITE_IF(
> +			inode->i_blkbits != PAGE_SHIFT, erofs_info, inode->i_sb,
> +			"EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");

Unnecessary change.

>   		inode->i_mapping->a_ops = &z_erofs_aops;
>   #else
>   		err = -EOPNOTSUPP;
> @@ -275,7 +285,6 @@ static int erofs_fill_inode(struct inode *inode)
>   #endif
>   	}
>   out_unlock:
> -	erofs_put_metabuf(&buf);
>   	return err;
>   }
>   
> @@ -338,8 +347,7 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>   	if (compressed)
>   		stat->attributes |= STATX_ATTR_COMPRESSED;
>   	stat->attributes |= STATX_ATTR_IMMUTABLE;
> -	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
> -				  STATX_ATTR_IMMUTABLE);
> +	stat->attributes_mask |= (STATX_ATTR_COMPRESSED | STATX_ATTR_IMMUTABLE);

Unnecessary change.

Thanks,
Gao Xiang

>   
>   	/*
>   	 * Return the DIO alignment restrictions if requested.

