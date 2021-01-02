Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A14912E864B
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Jan 2021 06:15:23 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D797s0D0MzDr6w
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Jan 2021 16:15:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=MAwIUaCy; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MAwIUaCy; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D797m3B0TzDqJc
 for <linux-erofs@lists.ozlabs.org>; Sat,  2 Jan 2021 16:15:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609564513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jx3AkUVlvJgVoCz2NtcUf/aqR0PBah/0E+uySw4dtGM=;
 b=MAwIUaCy28iszEtrY6NT2xC1rOe2TKAo2h71N2D7kL/4IuLtJki+tuwZztn9DkR4cIgF0M
 Vpeepq8g4NpLKF3oOawpJaOrHVNALdWLLpKeBST50+1FYquaPbz8VDS+82I0h+bkjCXgOs
 boP0uBa+IlQ5cZuJccZO5d3S3Gg3eDo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609564513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jx3AkUVlvJgVoCz2NtcUf/aqR0PBah/0E+uySw4dtGM=;
 b=MAwIUaCy28iszEtrY6NT2xC1rOe2TKAo2h71N2D7kL/4IuLtJki+tuwZztn9DkR4cIgF0M
 Vpeepq8g4NpLKF3oOawpJaOrHVNALdWLLpKeBST50+1FYquaPbz8VDS+82I0h+bkjCXgOs
 boP0uBa+IlQ5cZuJccZO5d3S3Gg3eDo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-VrTXPcNUNpihp0XSTX3kEg-1; Sat, 02 Jan 2021 00:15:11 -0500
X-MC-Unique: VrTXPcNUNpihp0XSTX3kEg-1
Received: by mail-pj1-f70.google.com with SMTP id q10so9431684pjg.1
 for <linux-erofs@lists.ozlabs.org>; Fri, 01 Jan 2021 21:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Jx3AkUVlvJgVoCz2NtcUf/aqR0PBah/0E+uySw4dtGM=;
 b=lM+wCcDfJBbGeCD9aBGYub/pM+4/HEK8BYpkNW61j+09l7huvxb8H2LygqTQQaSu6q
 k7l2P9MJRQorNp2TBuPzYPGwIc6XwngimWBlIu15t5f/jDbf9LftMgTZdDhGhA7h6Xf3
 KLkxveb8xPVya7N6Iasc1K1X7p1H+4iq/FovC1NaCEPDnxFFG7K7XpkOhEZolZiQLgFE
 vNPZMiL1LoFhI8fy8ir0NX9XYFV9OPAYKXiwoAi/11hF0YQ11SQZ7hLHYlgBxYQkRHHL
 dNAOid8e247j4tmoqKgDRfaIUl5dj3vIuCi9HQEuBSZPmicg/qhykeVQyQotPy3zc6Nd
 HaIQ==
X-Gm-Message-State: AOAM53229E5vJSn6Nhwl7N+tKUMWqupoHUJpM5HfEUkmZCxmFCmQKxjW
 X0IVEbT+7WNctN3CGsFxEdj2gDFFz22L7oScsfkrvd03K7lmqxymRp8zoUlvICRPRSqvS3n0N2H
 lWrk08PHjG4MQUAoP8/n0qhQI
X-Received: by 2002:a17:90a:301:: with SMTP id 1mr20982635pje.86.1609564510667; 
 Fri, 01 Jan 2021 21:15:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOsUJRVyXPWkf5D9i07Y18wsNG0sjqPeNcgVOYWR5Z/vuXWEJODovJpdkhj5Dq36JqqJGSAA==
X-Received: by 2002:a17:90a:301:: with SMTP id 1mr20982626pje.86.1609564510462; 
 Fri, 01 Jan 2021 21:15:10 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c5sm47878669pgt.73.2021.01.01.21.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Jan 2021 21:15:10 -0800 (PST)
Date: Sat, 2 Jan 2021 13:14:59 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOh546u5paH?= <huww98@outlook.com>
Subject: Re: [PATCH 2/2] erofs-utils: refactor: remove end argument from
 erofs_mapbh
Message-ID: <20210102051459.GB3732199@xiangao.remote.csb>
References: <20210101091158.13896-1-huww98@outlook.com>
 <ME3P282MB19387A6D70997B82DE981954C0D50@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
In-Reply-To: <ME3P282MB19387A6D70997B82DE981954C0D50@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <gaoxiang25@huawei.com>, linux-erofs@lists.ozlabs.org,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Weiwen,

On Fri, Jan 01, 2021 at 05:11:58PM +0800, 胡玮文 wrote:
> Signed-off-by: Hu Weiwen <huww98@outlook.com>

It seems that it drops the needed argument `end'.

The original purpose of that is to get the beginning/end blkaddr of a buffer block
in preparation for later use, some specific reasons to get rid of it?
(also it only drops one extra line considering the diffstat....)

Thanks,
Gao Xiang

> ---
>  include/erofs/cache.h |  2 +-
>  lib/cache.c           |  3 +--
>  lib/compress.c        |  2 +-
>  lib/inode.c           | 10 +++++-----
>  lib/xattr.c           |  2 +-
>  mkfs/main.c           |  2 +-
>  6 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/include/erofs/cache.h b/include/erofs/cache.h
> index 8c171f5..f8dff67 100644
> --- a/include/erofs/cache.h
> +++ b/include/erofs/cache.h
> @@ -95,7 +95,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
>  struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
>  					int type, unsigned int size);
>  
> -erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end);
> +erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb);
>  bool erofs_bflush(struct erofs_buffer_block *bb);
>  
>  void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
> diff --git a/lib/cache.c b/lib/cache.c
> index 3412a0b..9765cfd 100644
> --- a/lib/cache.c
> +++ b/lib/cache.c
> @@ -329,9 +329,8 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
>  	return blkaddr;
>  }
>  
> -erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end)
> +erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb)
>  {
> -	DBG_BUGON(!end);
>  	struct erofs_buffer_block *t = last_mapped_block;
>  	while (1) {
>  		t = list_next_entry(t, list);
> diff --git a/lib/compress.c b/lib/compress.c
> index 86db940..2b1f93c 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -416,7 +416,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
>  
>  	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
>  
> -	blkaddr = erofs_mapbh(bh->block, true);	/* start_blkaddr */
> +	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
>  	ctx.blkaddr = blkaddr;
>  	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
>  	ctx.head = ctx.tail = 0;
> diff --git a/lib/inode.c b/lib/inode.c
> index 3d634fc..60666bb 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -150,7 +150,7 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
>  	inode->bh_data = bh;
>  
>  	/* get blkaddr of the bh */
> -	ret = erofs_mapbh(bh->block, true);
> +	ret = erofs_mapbh(bh->block);
>  	DBG_BUGON(ret < 0);
>  
>  	/* write blocks except for the tail-end block */
> @@ -524,7 +524,7 @@ int erofs_prepare_tail_block(struct erofs_inode *inode)
>  		bh->op = &erofs_skip_write_bhops;
>  
>  		/* get blkaddr of bh */
> -		ret = erofs_mapbh(bh->block, true);
> +		ret = erofs_mapbh(bh->block);
>  		DBG_BUGON(ret < 0);
>  		inode->u.i_blkaddr = bh->block->blkaddr;
>  
> @@ -634,7 +634,7 @@ int erofs_write_tail_end(struct erofs_inode *inode)
>  		int ret;
>  		erofs_off_t pos;
>  
> -		erofs_mapbh(bh->block, true);
> +		erofs_mapbh(bh->block);
>  		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
>  		ret = dev_write(inode->idata, pos, inode->idata_size);
>  		if (ret)
> @@ -871,7 +871,7 @@ void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
>  	struct erofs_buffer_head *const bh = rootdir->bh;
>  	erofs_off_t off, meta_offset;
>  
> -	erofs_mapbh(bh->block, true);
> +	erofs_mapbh(bh->block);
>  	off = erofs_btell(bh, false);
>  
>  	if (off > rootnid_maxoffset)
> @@ -890,7 +890,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
>  	if (!bh)
>  		return inode->nid;
>  
> -	erofs_mapbh(bh->block, true);
> +	erofs_mapbh(bh->block);
>  	off = erofs_btell(bh, false);
>  
>  	meta_offset = blknr_to_addr(sbi.meta_blkaddr);
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 49ebb9c..8b7bcb1 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -575,7 +575,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
>  	}
>  	bh->op = &erofs_skip_write_bhops;
>  
> -	erofs_mapbh(bh->block, true);
> +	erofs_mapbh(bh->block);
>  	off = erofs_btell(bh, false);
>  
>  	sbi.xattr_blkaddr = off / EROFS_BLKSIZ;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index c63b274..1c23560 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -304,7 +304,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
>  	char *buf;
>  
> -	*blocks         = erofs_mapbh(NULL, true);
> +	*blocks         = erofs_mapbh(NULL);
>  	sb.blocks       = cpu_to_le32(*blocks);
>  	sb.root_nid     = cpu_to_le16(root_nid);
>  	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
> -- 
> 2.30.0
> 

