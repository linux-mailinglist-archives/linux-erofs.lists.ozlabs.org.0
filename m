Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DABF3968057
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 09:19:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy0Vd4KLFz2yP8
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 17:19:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725261543;
	cv=none; b=JhPsSgmMC4Rox+svXXpJRobfznzLYY5Ys2L6Q9FxjirIY556cw5vqDE04F0xdOIN7XR1edaivVOv6/ZJGf8pzrEtyOmP5AfVnr5Tx4mQ5zjXaBIyqAjU5UOx7aHQeeL/qK2R+PPQMWDWaIwnjyUZ0YWhy9TIO54lw1piRvSPbDlA4A7RwsLTyJyDSfsd9eG7WVxPmov1n2NNvUGqdVJF5FupEzlONbY0R1MGMBJV/9oIm6knGhmIlR8MIW6jvJ7HtTbATQxkGoJgQ3P5pNYYCV8SKor6h8lXgMfsGOm9doYZZqdQRc6EXN99VzXI27vf2saxZOQE/Xiiq8BD8ekTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725261543; c=relaxed/relaxed;
	bh=o3KY1048xX8iTaUzpS3u10C/iYTS8rXb7+01vfWalWc=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=a4ZeGYNv8FmLirmzU3ibpHWn4USoeYmpiEyPWUEaRaR8NvP19hmjY8OmWc/DaK2yQF/BFFOpJ5+K9CfZwiM/h+wGQr1VlVEclYCVo8R85eKL+bO+pClrknXMBe223lW0UWyV6JmrIrZMQJaHs8ZOVBBHDSZ39ltBuSwS+54/p5rTVJUcm0/5xi+mURZBakZUDlHtN0FPrcLPSHoDw303AK5OnbdyHNPeV8STP4BbqJgQ9OXtIrT6vGnWD24v98aryWr4v47p76gynA3Fah/OQHI7+ryiRpXOUq1MwbobEp+nawEL/5H275pb4REGOvQFNS6FBt6PGTlGRKFlMonNXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JelYicfc; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JelYicfc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy0VZ56Gnz2xg3
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 17:19:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725261537; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=o3KY1048xX8iTaUzpS3u10C/iYTS8rXb7+01vfWalWc=;
	b=JelYicfcxGYGo7eAdw/SLHCY+OiSYZlMQzn1rCUXeOKsVHPVno5WmjwdbYyU3760HA7K5WHgb34S6SPImp84W72peEeF/tUkOuJyWAlrNWAF32S6IC0KnXbq6Gsdp0kw31NicrDlI7XKFPVsVefRJZDW7ZXN0CpDPWPaVD30TVU=
Received: from 30.244.151.91(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WE5DaGW_1725261535)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 15:18:56 +0800
Message-ID: <1067fd19-495e-40d7-9acf-bf2735ca89fb@linux.alibaba.com>
Date: Mon, 2 Sep 2024 15:18:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] erofs: refactor read_inode calling convention
To: Yiyang Wu <toolmanp@tlmp.cc>
References: <20240902070047.384952-1-toolmanp@tlmp.cc>
 <20240902070047.384952-3-toolmanp@tlmp.cc>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240902070047.384952-3-toolmanp@tlmp.cc>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/2 15:00, Yiyang Wu via Linux-erofs wrote:
> Refactor out the iop binding behavior out of the erofs_fill_symlink
> and move erofs_buf into the erofs_read_inode, so that erofs_fill_inode
> can only deal with inode operation bindings and can be decoupled from
> metabuf operations. This results in better calling conventions.
> 
> Note that after this patch, we do not need erofs_buf and ofs as
> parameters any more when calling erofs_read_inode as
> all the data operations are now included in itself.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/
> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> ---
>   fs/erofs/inode.c | 126 ++++++++++++++++++++++++-----------------------
>   1 file changed, 65 insertions(+), 61 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index d051afe39670..d854509bb082 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -8,8 +8,39 @@
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
> +	m_pofs += vi->xattr_isize;
> +	/* inline symlink data shouldn't cross block boundary */
> +	if (m_pofs + inode->i_size > bsz) {
> +		erofs_err(inode->i_sb,
> +			  "inline data cross block boundary @ nid %llu",
> +			  vi->nid);

Since you move the code block of erofs_fill_symlink,

I think it'd be better to update this statement to
		erofs_err(inode->i_sb, "inline data cross block boundary @ nid %llu",
			  vi->nid);

As I mentioned, the print message doesn't have line limitation.

> +		DBG_BUGON(1);
> +		return -EFSCORRUPTED;
> +	}
> +
> +	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> +
> +	if (!lnk)
> +		return -ENOMEM;

As I mentioned in the previous patch, so it could become
	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
	return inode->i_link ? 0 : -ENOMEM;

> +
> +	inode->i_link = lnk;
> +	return 0;
> +}
> +
> +static int erofs_read_inode(struct inode *inode)
>   {
>   	struct super_block *sb = inode->i_sb;
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> @@ -20,20 +51,21 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   	struct erofs_inode_compact *dic;
>   	struct erofs_inode_extended *die, *copied = NULL;
>   	union erofs_inode_i_u iu;
> -	unsigned int ifmt;
> +	struct erofs_buf buf;
> +	unsigned int ifmt, ofs;
>   	int err;
>   
>   	blkaddr = erofs_blknr(sb, inode_loc);
> -	*ofs = erofs_blkoff(sb, inode_loc);
> +	ofs = erofs_blkoff(sb, inode_loc);
>   
> -	kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr), EROFS_KMAP);
> +	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), EROFS_KMAP);
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
>   		erofs_err(sb, "unsupported i_format %u of nid %llu",
> @@ -54,11 +86,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
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
> @@ -66,16 +98,16 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   				goto err_out;
>   			}
>   			memcpy(copied, dic, gotten);
> -			kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr + 1),
> +			kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr + 1),
>   						   EROFS_KMAP);
>   			if (IS_ERR(kaddr)) {
>   				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
>   					  vi->nid, PTR_ERR(kaddr));
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
> @@ -95,7 +127,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   		break;
>   	case EROFS_INODE_LAYOUT_COMPACT:
>   		vi->inode_isize = sizeof(struct erofs_inode_compact);
> -		*ofs += vi->inode_isize;
> +		ofs += vi->inode_isize;
>   		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
>   
>   		inode->i_mode = le16_to_cpu(dic->i_mode);
> @@ -119,6 +151,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   	case S_IFREG:
>   	case S_IFDIR:
>   	case S_IFLNK:
> +		if(S_ISLNK(inode->i_mode)) {
> +			err = erofs_fill_symlink(inode, kaddr, ofs);
> +			if(err)

missing a blank:
			if (err)


> +				goto err_out;
> +		}
>   		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
>   		break;
>   	case S_IFCHR:
> @@ -165,63 +202,29 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>   		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
>   	else
>   		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
> -	return kaddr;
> +
> +	erofs_put_metabuf(&buf);
> +	return 0;
>   
>   err_out:

I wonder this can be unified too as:

err_out:
	DBG_BUGON(err);
	kfree(copied);			I'm not sure if it's really needed now.
	erofs_put_metabuf(&buf);
	return err;

>   	DBG_BUGON(1);
>   	kfree(copied);
> -	erofs_put_metabuf(buf);
> -	return ERR_PTR(err);
> +	erofs_put_metabuf(&buf);
> +	return err;
>   }
>   
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
> -	m_pofs += vi->xattr_isize;
> -	/* inline symlink data shouldn't cross block boundary */
> -	if (m_pofs + inode->i_size > bsz) {
> -		erofs_err(inode->i_sb,
> -			  "inline data cross block boundary @ nid %llu",
> -			  vi->nid);
> -		DBG_BUGON(1);
> -		return -EFSCORRUPTED;
> -	}
> -
> -	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
> -
> -	if (!lnk)
> -		return -ENOMEM;
> -
> -	inode->i_link = lnk;
> -	inode->i_op = &erofs_fast_symlink_iops;
> -	return 0;
> -}
>   
>   static int erofs_fill_inode(struct inode *inode)
>   {
>   	struct erofs_inode *vi = EROFS_I(inode);
> -	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> -	void *kaddr;
> -	unsigned int ofs;
>   	int err = 0;
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

out_unlock can be avoided too, just
		return err;

>   
>   	/* setup the new inode */
>   	switch (inode->i_mode & S_IFMT) {
> @@ -238,9 +241,11 @@ static int erofs_fill_inode(struct inode *inode)
>   		inode_nohighmem(inode);
>   		break;
>   	case S_IFLNK:
> -		err = erofs_fill_symlink(inode, kaddr, ofs);
> -		if (err)
> -			goto out_unlock;
> +		if (inode->i_link)
> +			inode->i_op = &erofs_fast_symlink_iops;
> +		else
> +			inode->i_op = &erofs_symlink_iops;
> +
>   		inode_nohighmem(inode);
>   		break;
>   	case S_IFCHR:
> @@ -273,7 +278,6 @@ static int erofs_fill_inode(struct inode *inode)
>   #endif
>   	}
>   out_unlock:

Remove this.

Thanks,
Gao Xiang
