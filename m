Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE4768FE28
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 04:58:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC34t3DPKz3cgx
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 14:58:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=alC9C1/5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=alC9C1/5;
	dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC34k4H7Qz3bVr
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 14:58:29 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id j1so993228pjd.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Feb 2023 19:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxAQGzrgLbEKwQLTtSgWWT/soA7h5zx9Of2z6uUxhpo=;
        b=alC9C1/54qBtm60InbmYrT1IuXDDtew6Mqg8QMXjlYPN0F+oQji1Aw762ZssCSPatD
         swp3F/VVLKdU2fJvSlnPndW1kYvkFiFQNGJQXQSPkxVrpU7kvTc6Om+1eLpf45QrJ3BR
         0FVLr+DC0Am0upSuHJ7z242L1WlDnEkN5gBUe6r1fIRX3S0JIkCzCVUdbgQXDJ6bMFWj
         3znlvBNm9Zwp/T43esqBr2/asXe3bKCRdaPH57xm/gri0AbT8Ib3Uit0eazui+/H8WDU
         OtwlPuURbiVmgNq/KNT7vts9NQqFPH9GhlYu/nloO7K/tEMAELeRgmfdal6KfYYh42em
         OQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxAQGzrgLbEKwQLTtSgWWT/soA7h5zx9Of2z6uUxhpo=;
        b=CE7UKok8FQcOjvtk8IbnyFWYHKDvauxxO9EApi6p1porh4hvdgUxtLRC8UdnpsbrsS
         Q/sa1BOL0LNksNzn6Aoybscvq9Qr3v0XjR2r5kvuM6ycCKMlf9g6HPg9hT6194buObMf
         Xdy941YDrkvCEQ2Wn1sbN3dpWEEHI6GE9128TLGyGVvXz0KcJxCreRJHkkSA7ve8C+jS
         SflDE+FALqa2im6SVNDf8p6yHiMOGDoaoT3MWPoc/IFJ/q/oy6K2W2Ulp3XPA0HVY1wM
         1Ir3eJ0n9yT3OsVcFoTxyG55Nv9C9zY7yRMBMipKsbvXPsGdNNKsDH2rt1o2o5app0xB
         JpnA==
X-Gm-Message-State: AO0yUKXCfVabcwJkhMln+It5JZeqRJtHmjykOmJ3wYTK8XWTvXbuzPob
	k6UBtkITv+URKSq5+ZtL6kM=
X-Google-Smtp-Source: AK7set+VRpB1T34o6oZU9KXK251nTXoKwlJ+1XmNMO0jf14olBYGzwci8pt33LwAUSSRf7+/5JavxA==
X-Received: by 2002:a17:90b:3903:b0:22c:7ed4:6bf9 with SMTP id ob3-20020a17090b390300b0022c7ed46bf9mr11099836pjb.28.1675915104781;
        Wed, 08 Feb 2023 19:58:24 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090ad3cf00b00229962d07bcsm300105pjw.6.2023.02.08.19.58.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Feb 2023 19:58:24 -0800 (PST)
Date: Thu, 9 Feb 2023 12:04:09 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 2/2] erofs: remove unused EROFS_GET_BLOCKS_RAW flag
Message-ID: <20230209120409.000030a0.zbestahu@gmail.com>
In-Reply-To: <20230209024825.17335-2-jefflexu@linux.alibaba.com>
References: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
	<20230209024825.17335-2-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu,  9 Feb 2023 10:48:25 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> For erofs_map_blocks() and erofs_map_blocks_flatmode(), the flags
> argument is always EROFS_GET_BLOCKS_RAW.  Thus remove the unused flags
> parameter for these two functions.
> 
> Besides EROFS_GET_BLOCKS_RAW is originally introduced for reading
> compressed (raw) data for compressed files.  However it's never used
> actually and let's remove it now.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/data.c              | 14 ++++++--------
>  fs/erofs/fscache.c           |  2 +-
>  fs/erofs/internal.h          | 10 ++++------
>  include/trace/events/erofs.h |  1 -
>  4 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 2713257ee718..032e12dccb84 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -74,8 +74,7 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
>  }
>  
>  static int erofs_map_blocks_flatmode(struct inode *inode,
> -				     struct erofs_map_blocks *map,
> -				     int flags)
> +				     struct erofs_map_blocks *map)
>  {
>  	erofs_blk_t nblocks, lastblk;
>  	u64 offset = map->m_la;
> @@ -114,8 +113,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  	return 0;
>  }
>  
> -int erofs_map_blocks(struct inode *inode,
> -		     struct erofs_map_blocks *map, int flags)
> +int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	struct erofs_inode *vi = EROFS_I(inode);
> @@ -127,7 +125,7 @@ int erofs_map_blocks(struct inode *inode,
>  	void *kaddr;
>  	int err = 0;
>  
> -	trace_erofs_map_blocks_enter(inode, map, flags);
> +	trace_erofs_map_blocks_enter(inode, map, 0);
>  	map->m_deviceid = 0;
>  	if (map->m_la >= inode->i_size) {
>  		/* leave out-of-bound access unmapped */
> @@ -137,7 +135,7 @@ int erofs_map_blocks(struct inode *inode,
>  	}
>  
>  	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
> -		err = erofs_map_blocks_flatmode(inode, map, flags);
> +		err = erofs_map_blocks_flatmode(inode, map);
>  		goto out;
>  	}
>  
> @@ -189,7 +187,7 @@ int erofs_map_blocks(struct inode *inode,
>  out:
>  	if (!err)
>  		map->m_llen = map->m_plen;
> -	trace_erofs_map_blocks_exit(inode, map, flags, 0);
> +	trace_erofs_map_blocks_exit(inode, map, 0, err);
>  	return err;
>  }
>  
> @@ -252,7 +250,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	map.m_la = offset;
>  	map.m_llen = length;
>  
> -	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	ret = erofs_map_blocks(inode, &map);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 03de4dc99302..9658cf8689d9 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -197,7 +197,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
>  	int ret;
>  
>  	map.m_la = pos;
> -	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	ret = erofs_map_blocks(inode, &map);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 48a2f33de15a..8a6ae820cd6d 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -401,16 +401,15 @@ struct erofs_map_blocks {
>  	unsigned int m_flags;
>  };
>  
> -#define EROFS_GET_BLOCKS_RAW    0x0001
>  /*
>   * Used to get the exact decompressed length, e.g. fiemap (consider lookback
>   * approach instead if possible since it's more metadata lightweight.)
>   */
> -#define EROFS_GET_BLOCKS_FIEMAP	0x0002
> +#define EROFS_GET_BLOCKS_FIEMAP		0x0001
>  /* Used to map the whole extent if non-negligible data is requested for LZMA */
> -#define EROFS_GET_BLOCKS_READMORE	0x0004
> +#define EROFS_GET_BLOCKS_READMORE	0x0002
>  /* Used to map tail extent for tailpacking inline or fragment pcluster */
> -#define EROFS_GET_BLOCKS_FINDTAIL	0x0008
> +#define EROFS_GET_BLOCKS_FINDTAIL	0x0004
>  
>  enum {
>  	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
> @@ -458,8 +457,7 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
>  int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
>  int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		 u64 start, u64 len);
> -int erofs_map_blocks(struct inode *inode,
> -		     struct erofs_map_blocks *map, int flags);
> +int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
>  struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
>  int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  		  struct kstat *stat, u32 request_mask,
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index f0e43e40a4a1..cf4a0d28b178 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -19,7 +19,6 @@ struct erofs_map_blocks;
>  		{ 1,		"DIR" })
>  
>  #define show_map_flags(flags) __print_flags(flags, "|",	\
> -	{ EROFS_GET_BLOCKS_RAW,		"RAW" },	\
>  	{ EROFS_GET_BLOCKS_FIEMAP,	"FIEMAP" },	\
>  	{ EROFS_GET_BLOCKS_READMORE,	"READMORE" },	\
>  	{ EROFS_GET_BLOCKS_FINDTAIL,	"FINDTAIL" })

