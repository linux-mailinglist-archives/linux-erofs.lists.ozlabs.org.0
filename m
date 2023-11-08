Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0EC7E5218
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Nov 2023 09:45:09 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=E6R6g3Fd;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SQJYt1m7Cz3cCv
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Nov 2023 19:45:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=E6R6g3Fd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SQJYm5xnXz2yV3
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Nov 2023 19:44:59 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso60036975ad.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Nov 2023 00:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699433094; x=1700037894; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8npbOELwwAaBg+fld3/JBKofkedP3ykw7h6Uj4Yzpw8=;
        b=E6R6g3FdWdteZczV56dhQKsQNEbrZjqzT5i/+DiEy8SFfc8wx06o5+9q8ghar8zhRD
         VEJAgafRpOYvsJtuYlTYegHBvNdRtAsYVpvzAF5PsqQIovtII5TeP7F12w+iDz8jPCJH
         CRAXvVj+tzlEw9FogGHsb4VywZsPKOe+M2U7Th45gw/6hkJASxMGfcoIuSoJqa0TjGyY
         wUuUgFRoJnJdflBEiAAe7oweOr03aNCkRJ2CPNBOakBoHVxz2xtv5nwzoVFtKencqExs
         r4yhgV8AWPaQcST8zbTUlbjEGn7UJP7ldeqDe0NOdelfL8gDy3o4OHviKJHbZQjW2KWa
         cpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699433094; x=1700037894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8npbOELwwAaBg+fld3/JBKofkedP3ykw7h6Uj4Yzpw8=;
        b=kaiIrHfPUtPoHTSG1N15uCE0N7yIPFZrM7bcRDjDkF/KANzHuS+zPFzpAAh6F8xOqL
         SaCJnTPfYnDXzEjpgh1txeMlL3rolMaH9ATlQIFFnW9AgHSP3DaVyXEIAlYJuGcEt0Wo
         fwunvYVuE0OvR899eZsZNZeIuObXNZVrO1FWxc1PbTtknNZYXqPuQuDuro6WWLj6h0pW
         rKzIgFrjMaRoledVJjwlJf3F/O7gtxyLlmXDmeMp4p2U12rzpNaHpHsKvkgRK1X7wFZc
         /3iOeGcoAtf/NxMx89x59lUps4qJWr89q8PwNxw5bSz3mnJ+oTgLgvyCBXzRnbhlkD8R
         KLgA==
X-Gm-Message-State: AOJu0YxESbyAbUQNQd2AeFrlU1h0Cs4bjU9Krsi20kBOe1X4F0QzHTTG
	iGc/KOTbGrY9kn1+3pd3ftQ=
X-Google-Smtp-Source: AGHT+IGIbPZOe0q/NSPxZUXpxvQxFBOTBlTTVnQMpzk5L6uEu5N+LiM5I2pS887MrlloA7R/0mqCXQ==
X-Received: by 2002:a17:902:e995:b0:1cc:68a5:f388 with SMTP id f21-20020a170902e99500b001cc68a5f388mr1364248plb.33.1699433093882;
        Wed, 08 Nov 2023 00:44:53 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902d58400b001c5fd2a28d3sm1190069plh.28.2023.11.08.00.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 00:44:53 -0800 (PST)
Date: Wed, 8 Nov 2023 16:44:47 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Ferry Meng <mengferry@linux.alibaba.com>
Subject: Re: [PATCH] erofs: simplify erofs_read_inode()
Message-ID: <20231108164447.000016be.zbestahu@gmail.com>
In-Reply-To: <20231106110141.94103-1-mengferry@linux.alibaba.com>
References: <20231106110141.94103-1-mengferry@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon,  6 Nov 2023 19:01:41 +0800
Ferry Meng <mengferry@linux.alibaba.com> wrote:

> After commit 1c7f49a76773 ("erofs: tidy up EROFS on-disk naming"),
> there is a unique `union erofs_inode_i_u` so that we could parse
> the union directly.
> 
> Besides, it also replaces `inode->i_sb` with `sb` for simplicity.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
> ---
>  fs/erofs/inode.c | 98 +++++++++++++++++-------------------------------
>  1 file changed, 35 insertions(+), 63 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index edc8ec7581b8..99535c8c53b5 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -15,11 +15,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  	struct erofs_inode *vi = EROFS_I(inode);
>  	const erofs_off_t inode_loc = erofs_iloc(inode);
> -
>  	erofs_blk_t blkaddr, nblks = 0;
>  	void *kaddr;
>  	struct erofs_inode_compact *dic;
>  	struct erofs_inode_extended *die, *copied = NULL;
> +	union erofs_inode_i_u *iu;
>  	unsigned int ifmt;
>  	int err;
>  
> @@ -35,9 +35,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>  
>  	dic = kaddr + *ofs;
>  	ifmt = le16_to_cpu(dic->i_format);
> -
>  	if (ifmt & ~EROFS_I_ALL) {
> -		erofs_err(inode->i_sb, "unsupported i_format %u of nid %llu",
> +		erofs_err(sb, "unsupported i_format %u of nid %llu",
>  			  ifmt, vi->nid);
>  		err = -EOPNOTSUPP;
>  		goto err_out;
> @@ -45,7 +44,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>  
>  	vi->datalayout = erofs_inode_datalayout(ifmt);
>  	if (vi->datalayout >= EROFS_INODE_DATALAYOUT_MAX) {
> -		erofs_err(inode->i_sb, "unsupported datalayout %u of nid %llu",
> +		erofs_err(sb, "unsupported datalayout %u of nid %llu",
>  			  vi->datalayout, vi->nid);
>  		err = -EOPNOTSUPP;
>  		goto err_out;
> @@ -82,40 +81,15 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>  		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
>  
>  		inode->i_mode = le16_to_cpu(die->i_mode);
> -		switch (inode->i_mode & S_IFMT) {
> -		case S_IFREG:
> -		case S_IFDIR:
> -		case S_IFLNK:
> -			vi->raw_blkaddr = le32_to_cpu(die->i_u.raw_blkaddr);
> -			break;
> -		case S_IFCHR:
> -		case S_IFBLK:
> -			inode->i_rdev =
> -				new_decode_dev(le32_to_cpu(die->i_u.rdev));
> -			break;
> -		case S_IFIFO:
> -		case S_IFSOCK:
> -			inode->i_rdev = 0;
> -			break;
> -		default:
> -			goto bogusimode;
> -		}
> +		iu = &die->i_u;
>  		i_uid_write(inode, le32_to_cpu(die->i_uid));
>  		i_gid_write(inode, le32_to_cpu(die->i_gid));
>  		set_nlink(inode, le32_to_cpu(die->i_nlink));
> -
> -		/* extended inode has its own timestamp */
> +		/* each extended inode has its own timestamp */
>  		inode_set_ctime(inode, le64_to_cpu(die->i_mtime),
>  				le32_to_cpu(die->i_mtime_nsec));
>  
>  		inode->i_size = le64_to_cpu(die->i_size);
> -
> -		/* total blocks for compressed files */
> -		if (erofs_inode_is_data_compressed(vi->datalayout))
> -			nblks = le32_to_cpu(die->i_u.compressed_blocks);
> -		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
> -			/* fill chunked inode summary info */
> -			vi->chunkformat = le16_to_cpu(die->i_u.c.format);
>  		kfree(copied);
>  		copied = NULL;
>  		break;
> @@ -125,49 +99,51 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>  		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
>  
>  		inode->i_mode = le16_to_cpu(dic->i_mode);
> -		switch (inode->i_mode & S_IFMT) {
> -		case S_IFREG:
> -		case S_IFDIR:
> -		case S_IFLNK:
> -			vi->raw_blkaddr = le32_to_cpu(dic->i_u.raw_blkaddr);
> -			break;
> -		case S_IFCHR:
> -		case S_IFBLK:
> -			inode->i_rdev =
> -				new_decode_dev(le32_to_cpu(dic->i_u.rdev));
> -			break;
> -		case S_IFIFO:
> -		case S_IFSOCK:
> -			inode->i_rdev = 0;
> -			break;
> -		default:
> -			goto bogusimode;
> -		}
> +		iu = &dic->i_u;
>  		i_uid_write(inode, le16_to_cpu(dic->i_uid));
>  		i_gid_write(inode, le16_to_cpu(dic->i_gid));
>  		set_nlink(inode, le16_to_cpu(dic->i_nlink));
> -
>  		/* use build time for compact inodes */
>  		inode_set_ctime(inode, sbi->build_time, sbi->build_time_nsec);
>  
>  		inode->i_size = le32_to_cpu(dic->i_size);
> -		if (erofs_inode_is_data_compressed(vi->datalayout))
> -			nblks = le32_to_cpu(dic->i_u.compressed_blocks);
> -		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
> -			vi->chunkformat = le16_to_cpu(dic->i_u.c.format);
>  		break;
>  	default:
> -		erofs_err(inode->i_sb,
> -			  "unsupported on-disk inode version %u of nid %llu",
> +		erofs_err(sb, "unsupported on-disk inode version %u of nid %llu",
>  			  erofs_inode_version(ifmt), vi->nid);
>  		err = -EOPNOTSUPP;
>  		goto err_out;
>  	}
>  
> -	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
> +	switch (inode->i_mode & S_IFMT) {
> +	case S_IFREG:
> +	case S_IFDIR:
> +	case S_IFLNK:
> +		vi->raw_blkaddr = le32_to_cpu(iu->raw_blkaddr);

may cause use-after-free for acrossing block boundary case due to kfree(copied) before?

> +		break;
> +	case S_IFCHR:
> +	case S_IFBLK:
> +		inode->i_rdev = new_decode_dev(le32_to_cpu(iu->rdev));
> +		break;
> +	case S_IFIFO:
> +	case S_IFSOCK:
> +		inode->i_rdev = 0;
> +		break;
> +	default:
> +		erofs_err(sb, "bogus i_mode (%o) @ nid %llu", inode->i_mode,
> +			  vi->nid);
> +		err = -EFSCORRUPTED;
> +		goto err_out;
> +	}
> +
> +	/* total blocks for compressed files */
> +	if (erofs_inode_is_data_compressed(vi->datalayout)) {
> +		nblks = le32_to_cpu(iu->compressed_blocks);
> +	} else if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
> +		/* fill chunked inode summary info */
> +		vi->chunkformat = le16_to_cpu(iu->c.format);
>  		if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
> -			erofs_err(inode->i_sb,
> -				  "unsupported chunk format %x of nid %llu",
> +			erofs_err(sb, "unsupported chunk format %x of nid %llu",
>  				  vi->chunkformat, vi->nid);
>  			err = -EOPNOTSUPP;
>  			goto err_out;
> @@ -190,10 +166,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>  		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
>  	return kaddr;
>  
> -bogusimode:
> -	erofs_err(inode->i_sb, "bogus i_mode (%o) @ nid %llu",
> -		  inode->i_mode, vi->nid);
> -	err = -EFSCORRUPTED;
>  err_out:
>  	DBG_BUGON(1);
>  	kfree(copied);

