Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F207974E528
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 05:13:30 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=Y2hDC11F;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0Qtc6GwXz3bNs
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 13:13:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=Y2hDC11F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::12e; helo=mail-il1-x12e.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0QtV0W8pz2yD6
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jul 2023 13:13:21 +1000 (AEST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3465bd756afso11856365ab.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 20:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689045197; x=1691637197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLFtQx412F7E9WAUd0wX2NX/NE9fV1NBRGG+n2UWA+o=;
        b=Y2hDC11FY+0PTthrVVaBQgQv10THeUqIdqrmiBg7h0HtNcvJeMt1ecR8vjcuokLq2j
         Vz7hNZe54MKWNW/Tdog10nDCUNFs6JCBmZXyDusD2KJhDpPY7BNQgzsU7/uyKsG38p+j
         mc5N0OCJbkI6ZKuYIkUf5ngK1vdoMgwys19ucngFBjbyhvmMNYxjQPOuSIAnW44CvYiK
         5N2EUpIoyBZL03kTkt6AoB+cidD+5463258kmyfy2hg5m5sY5ymAWcUphvseYxHNbVT4
         OGpa+mCruV/gmfO/vrX9xAjaVR6VCsF+BspEBiJtMuc/JjgR7Iu5hJ6BpehJ+5BzUsWe
         wx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689045197; x=1691637197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QLFtQx412F7E9WAUd0wX2NX/NE9fV1NBRGG+n2UWA+o=;
        b=Gv+8FN9MdzQigQ5gyCeD/GCRWKjmrcXUwUQjhXMMQh82S7dV8gpflN1tyv8vtnE8SI
         gkg7qwKPiAUTs64ADmj900AXsMNwt1OMNLq+KX7ioTDH0uwQbvUgHksTABXOnuuW75z3
         b/iQIgsJGF/P29liE8zyZ1twY0XsFL5hGzz3rsFHp5alFFcmj09u+0IAF04O1ixtxblV
         4UeUfaLo35hGaFhdX4YjUsgL3L4ix+Fm0q0abC4mSyypRQdjJgduz59enElGrxS3j4pW
         81Y5lzBlyFAME/hc4eFYfgg5MoNw5gNoOJ05TmKrDxxXPk6fp7iUwHPKW9IiZF+OqURQ
         jtMg==
X-Gm-Message-State: ABy/qLYbzJZL3O98jW/xDTv9bGtx8VGvKEq4IwoxFPCNhJ9mXXfI6sPW
	LT+kPcmp8uPtaCR66jUFMjU=
X-Google-Smtp-Source: APBJJlFg1L/2R0FoMlqe9F6cZdTzMBERqpmvMkbEI+H8vemVDvfh+/u6LT3lvRvSEotuvU+aZp1WHg==
X-Received: by 2002:a92:d14c:0:b0:345:b536:61f with SMTP id t12-20020a92d14c000000b00345b536061fmr10397939ilg.31.1689045196282;
        Mon, 10 Jul 2023 20:13:16 -0700 (PDT)
Received: from [127.0.0.1] (awork111158.netvigator.com. [203.198.94.158])
        by smtp.gmail.com with ESMTPSA id x8-20020a056a00270800b006829ef1e179sm529124pfv.99.2023.07.10.20.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 20:13:15 -0700 (PDT)
Message-ID: <67ac9967-f7c2-4918-3952-5ab035ce3e44@gmail.com>
Date: Tue, 11 Jul 2023 11:12:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fs/erofs: Introduce new features including ztailpacking,
 fragments and dedupe
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, u-boot@lists.denx.de
References: <20230707155212.159914-1-zhaoyifan@sjtu.edu.cn>
From: Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <20230707155212.159914-1-zhaoyifan@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2023/7/7 23:52, Yifan Zhao 写道:
> This patch updates erofs driver code to catch up with the latest code of
> erofs_utils (commit e4939f9eaa177e05d697ace85d8dc283e25dc2ed).
> 
> LZMA will be supported in the separate patch later.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Looks good to me.

Reviewed-by: Huang Jianan <jnhuang95@gmail.com>

Thanks,
Jianan
> ---
> CI result here:
> https://github.com/u-boot/u-boot/pull/344
> 
>   fs/erofs/data.c       | 165 ++++++++++++++---------
>   fs/erofs/decompress.c |  32 ++++-
>   fs/erofs/decompress.h |   3 +
>   fs/erofs/erofs_fs.h   | 301 +++++++++++++++++++++++-------------------
>   fs/erofs/fs.c         |  12 +-
>   fs/erofs/internal.h   | 119 ++++++++++++++---
>   fs/erofs/namei.c      |  44 +++---
>   fs/erofs/super.c      |  33 ++---
>   fs/erofs/zmap.c       | 277 +++++++++++++++++++++++++-------------
>   9 files changed, 642 insertions(+), 344 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 761896054c..f4b21d7917 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -12,23 +12,23 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
>   	struct erofs_inode *vi = inode;
>   	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
>   
> -	nblocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
> +	nblocks = BLK_ROUND_UP(inode->i_size);
>   	lastblk = nblocks - tailendpacking;
>   
>   	/* there is no hole in flatmode */
>   	map->m_flags = EROFS_MAP_MAPPED;
>   
> -	if (offset < blknr_to_addr(lastblk)) {
> -		map->m_pa = blknr_to_addr(vi->u.i_blkaddr) + map->m_la;
> -		map->m_plen = blknr_to_addr(lastblk) - offset;
> +	if (offset < erofs_pos(lastblk)) {
> +		map->m_pa = erofs_pos(vi->u.i_blkaddr) + map->m_la;
> +		map->m_plen = erofs_pos(lastblk) - offset;
>   	} else if (tailendpacking) {
>   		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
>   		map->m_pa = iloc(vi->nid) + vi->inode_isize +
>   			vi->xattr_isize + erofs_blkoff(map->m_la);
>   		map->m_plen = inode->i_size - offset;
>   
> -		/* inline data should be located in one meta block */
> -		if (erofs_blkoff(map->m_pa) + map->m_plen > PAGE_SIZE) {
> +		/* inline data should be located in the same meta block */
> +		if (erofs_blkoff(map->m_pa) + map->m_plen > erofs_blksiz()) {
>   			erofs_err("inline data cross block boundary @ nid %" PRIu64,
>   				  vi->nid);
>   			DBG_BUGON(1);
> @@ -55,7 +55,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
>   {
>   	struct erofs_inode *vi = inode;
>   	struct erofs_inode_chunk_index *idx;
> -	u8 buf[EROFS_BLKSIZ];
> +	u8 buf[EROFS_MAX_BLOCK_SIZE];
>   	u64 chunknr;
>   	unsigned int unit;
>   	erofs_off_t pos;
> @@ -87,7 +87,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
>   
>   	map->m_la = chunknr << vi->u.chunkbits;
>   	map->m_plen = min_t(erofs_off_t, 1UL << vi->u.chunkbits,
> -			    roundup(inode->i_size - map->m_la, EROFS_BLKSIZ));
> +			    roundup(inode->i_size - map->m_la, erofs_blksiz()));
>   
>   	/* handle block map */
>   	if (!(vi->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
> @@ -96,7 +96,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
>   		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
>   			map->m_flags = 0;
>   		} else {
> -			map->m_pa = blknr_to_addr(le32_to_cpu(*blkaddr));
> +			map->m_pa = erofs_pos(le32_to_cpu(*blkaddr));
>   			map->m_flags = EROFS_MAP_MAPPED;
>   		}
>   		goto out;
> @@ -110,7 +110,7 @@ int erofs_map_blocks(struct erofs_inode *inode,
>   	default:
>   		map->m_deviceid = le16_to_cpu(idx->device_id) &
>   			sbi.device_id_mask;
> -		map->m_pa = blknr_to_addr(le32_to_cpu(idx->blkaddr));
> +		map->m_pa = erofs_pos(le32_to_cpu(idx->blkaddr));
>   		map->m_flags = EROFS_MAP_MAPPED;
>   		break;
>   	}
> @@ -119,23 +119,23 @@ out:
>   	return err;
>   }
>   
> -int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
> +int erofs_map_dev(struct erofs_map_dev *map)
>   {
>   	struct erofs_device_info *dif;
>   	int id;
>   
>   	if (map->m_deviceid) {
> -		if (sbi->extra_devices < map->m_deviceid)
> +		if (sbi.extra_devices < map->m_deviceid)
>   			return -ENODEV;
> -	} else if (sbi->extra_devices) {
> -		for (id = 0; id < sbi->extra_devices; ++id) {
> +	} else if (sbi.extra_devices) {
> +		for (id = 0; id < sbi.extra_devices; ++id) {
>   			erofs_off_t startoff, length;
>   
> -			dif = sbi->devs + id;
> +			dif = sbi.devs + id;
>   			if (!dif->mapped_blkaddr)
>   				continue;
> -			startoff = blknr_to_addr(dif->mapped_blkaddr);
> -			length = blknr_to_addr(dif->blocks);
> +			startoff = erofs_pos(dif->mapped_blkaddr);
> +			length = erofs_pos(dif->blocks);
>   
>   			if (map->m_pa >= startoff &&
>   			    map->m_pa < startoff + length) {
> @@ -147,19 +147,38 @@ int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
>   	return 0;
>   }
>   
> +int erofs_read_one_data(struct erofs_map_blocks *map, char *buffer, u64 offset,
> +			size_t len)
> +{
> +	struct erofs_map_dev mdev;
> +	int ret;
> +
> +	mdev = (struct erofs_map_dev) {
> +		.m_deviceid = map->m_deviceid,
> +		.m_pa = map->m_pa,
> +	};
> +	ret = erofs_map_dev(&mdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = erofs_dev_read(mdev.m_deviceid, buffer, mdev.m_pa + offset, len);
> +	if (ret < 0)
> +		return -EIO;
> +	return 0;
> +}
> +
>   static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
>   			       erofs_off_t size, erofs_off_t offset)
>   {
>   	struct erofs_map_blocks map = {
>   		.index = UINT_MAX,
>   	};
> -	struct erofs_map_dev mdev;
>   	int ret;
>   	erofs_off_t ptr = offset;
>   
>   	while (ptr < offset + size) {
>   		char *const estart = buffer + ptr - offset;
> -		erofs_off_t eend;
> +		erofs_off_t eend, moff = 0;
>   
>   		map.m_la = ptr;
>   		ret = erofs_map_blocks(inode, &map, 0);
> @@ -168,14 +187,6 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
>   
>   		DBG_BUGON(map.m_plen != map.m_llen);
>   
> -		mdev = (struct erofs_map_dev) {
> -			.m_deviceid = map.m_deviceid,
> -			.m_pa = map.m_pa,
> -		};
> -		ret = erofs_map_dev(&sbi, &mdev);
> -		if (ret)
> -			return ret;
> -
>   		/* trim extent */
>   		eend = min(offset + size, map.m_la + map.m_llen);
>   		DBG_BUGON(ptr < map.m_la);
> @@ -193,19 +204,73 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
>   		}
>   
>   		if (ptr > map.m_la) {
> -			mdev.m_pa += ptr - map.m_la;
> +			moff = ptr - map.m_la;
>   			map.m_la = ptr;
>   		}
>   
> -		ret = erofs_dev_read(mdev.m_deviceid, estart, mdev.m_pa,
> -				     eend - map.m_la);
> -		if (ret < 0)
> -			return -EIO;
> +		ret = erofs_read_one_data(&map, estart, moff, eend - map.m_la);
> +		if (ret)
> +			return ret;
>   		ptr = eend;
>   	}
>   	return 0;
>   }
>   
> +int z_erofs_read_one_data(struct erofs_inode *inode,
> +			  struct erofs_map_blocks *map, char *raw, char *buffer,
> +			  erofs_off_t skip, erofs_off_t length, bool trimmed)
> +{
> +	struct erofs_map_dev mdev;
> +	int ret = 0;
> +
> +	if (map->m_flags & EROFS_MAP_FRAGMENT) {
> +		struct erofs_inode packed_inode = {
> +			.nid = sbi.packed_nid,
> +		};
> +
> +		ret = erofs_read_inode_from_disk(&packed_inode);
> +		if (ret) {
> +			erofs_err("failed to read packed inode from disk");
> +			return ret;
> +		}
> +
> +		return erofs_pread(&packed_inode, buffer, length - skip,
> +				   inode->fragmentoff + skip);
> +	}
> +
> +	/* no device id here, thus it will always succeed */
> +	mdev = (struct erofs_map_dev) {
> +		.m_pa = map->m_pa,
> +	};
> +	ret = erofs_map_dev(&mdev);
> +	if (ret) {
> +		DBG_BUGON(1);
> +		return ret;
> +	}
> +
> +	ret = erofs_dev_read(mdev.m_deviceid, raw, mdev.m_pa, map->m_plen);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
> +			.in = raw,
> +			.out = buffer,
> +			.decodedskip = skip,
> +			.interlaced_offset =
> +				map->m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED ?
> +					erofs_blkoff(map->m_la) : 0,
> +			.inputsize = map->m_plen,
> +			.decodedlength = length,
> +			.alg = map->m_algorithmformat,
> +			.partial_decoding = trimmed ? true :
> +				!(map->m_flags & EROFS_MAP_FULL_MAPPED) ||
> +					(map->m_flags & EROFS_MAP_PARTIAL_REF),
> +			 });
> +	if (ret < 0)
> +		return ret;
> +	return 0;
> +}
> +
>   static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>   			     erofs_off_t size, erofs_off_t offset)
>   {
> @@ -213,8 +278,7 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>   	struct erofs_map_blocks map = {
>   		.index = UINT_MAX,
>   	};
> -	struct erofs_map_dev mdev;
> -	bool partial;
> +	bool trimmed;
>   	unsigned int bufsize = 0;
>   	char *raw = NULL;
>   	int ret = 0;
> @@ -227,27 +291,17 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>   		if (ret)
>   			break;
>   
> -		/* no device id here, thus it will always succeed */
> -		mdev = (struct erofs_map_dev) {
> -			.m_pa = map.m_pa,
> -		};
> -		ret = erofs_map_dev(&sbi, &mdev);
> -		if (ret) {
> -			DBG_BUGON(1);
> -			break;
> -		}
> -
>   		/*
>   		 * trim to the needed size if the returned extent is quite
>   		 * larger than requested, and set up partial flag as well.
>   		 */
>   		if (end < map.m_la + map.m_llen) {
>   			length = end - map.m_la;
> -			partial = true;
> +			trimmed = true;
>   		} else {
>   			DBG_BUGON(end != map.m_la + map.m_llen);
>   			length = map.m_llen;
> -			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
> +			trimmed = false;
>   		}
>   
>   		if (map.m_la < offset) {
> @@ -272,19 +326,10 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
>   				break;
>   			}
>   		}
> -		ret = erofs_dev_read(mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
> -		if (ret < 0)
> -			break;
>   
> -		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
> -					.in = raw,
> -					.out = buffer + end - offset,
> -					.decodedskip = skip,
> -					.inputsize = map.m_plen,
> -					.decodedlength = length,
> -					.alg = map.m_algorithmformat,
> -					.partial_decoding = partial
> -					 });
> +		ret = z_erofs_read_one_data(inode, &map, raw,
> +					    buffer + end - offset, skip, length,
> +					    trimmed);
>   		if (ret < 0)
>   			break;
>   	}
> @@ -301,8 +346,8 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
>   	case EROFS_INODE_FLAT_INLINE:
>   	case EROFS_INODE_CHUNK_BASED:
>   		return erofs_read_raw_data(inode, buf, count, offset);
> -	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
> -	case EROFS_INODE_FLAT_COMPRESSION:
> +	case EROFS_INODE_COMPRESSED_FULL:
> +	case EROFS_INODE_COMPRESSED_COMPACT:
>   		return z_erofs_read_data(inode, buf, count, offset);
>   	default:
>   		break;
> diff --git a/fs/erofs/decompress.c b/fs/erofs/decompress.c
> index 2be3b844cf..e04e5c34a8 100644
> --- a/fs/erofs/decompress.c
> +++ b/fs/erofs/decompress.c
> @@ -15,8 +15,8 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
>   	if (erofs_sb_has_lz4_0padding()) {
>   		support_0padding = true;
>   
> -		while (!src[inputmargin & ~PAGE_MASK])
> -			if (!(++inputmargin & ~PAGE_MASK))
> +		while (!src[inputmargin & (erofs_blksiz() - 1)])
> +			if (!(++inputmargin & (erofs_blksiz() - 1)))
>   				break;
>   
>   		if (inputmargin >= rq->inputsize)
> @@ -40,6 +40,9 @@ static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
>   					  rq->decodedlength);
>   
>   	if (ret != (int)rq->decodedlength) {
> +		erofs_err("failed to %s decompress %d in[%u, %u] out[%u]",
> +			  rq->partial_decoding ? "partial" : "full",
> +			  ret, rq->inputsize, inputmargin, rq->decodedlength);
>   		ret = -EIO;
>   		goto out;
>   	}
> @@ -58,13 +61,30 @@ out:
>   
>   int z_erofs_decompress(struct z_erofs_decompress_req *rq)
>   {
> -	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
> -		if (rq->inputsize != EROFS_BLKSIZ)
> +	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
> +		unsigned int count, rightpart, skip;
> +
> +		/* XXX: should support inputsize >= erofs_blksiz() later */
> +		if (rq->inputsize > erofs_blksiz())
>   			return -EFSCORRUPTED;
>   
> -		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
> -		DBG_BUGON(rq->decodedlength < rq->decodedskip);
> +		if (rq->decodedlength > erofs_blksiz())
> +			return -EFSCORRUPTED;
> +
> +		if (rq->decodedlength < rq->decodedskip)
> +			return -EFSCORRUPTED;
>   
> +		count = rq->decodedlength - rq->decodedskip;
> +		skip = erofs_blkoff(rq->interlaced_offset + rq->decodedskip);
> +		rightpart = min(erofs_blksiz() - skip, count);
> +		memcpy(rq->out, rq->in + skip, rightpart);
> +		memcpy(rq->out + rightpart, rq->in, count - rightpart);
> +		return 0;
> +	} else if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
> +		if (rq->decodedlength > rq->inputsize)
> +			return -EFSCORRUPTED;
> +
> +		DBG_BUGON(rq->decodedlength < rq->decodedskip);
>   		memcpy(rq->out, rq->in + rq->decodedskip,
>   		       rq->decodedlength - rq->decodedskip);
>   		return 0;
> diff --git a/fs/erofs/decompress.h b/fs/erofs/decompress.h
> index 81d5fb84f6..4752f77950 100644
> --- a/fs/erofs/decompress.h
> +++ b/fs/erofs/decompress.h
> @@ -14,6 +14,9 @@ struct z_erofs_decompress_req {
>   	unsigned int decodedskip;
>   	unsigned int inputsize, decodedlength;
>   
> +	/* cut point of interlaced uncompressed data */
> +	unsigned int interlaced_offset;
> +
>   	/* indicate the algorithm will be used for decompression */
>   	unsigned int alg;
>   	bool partial_decoding;
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 6b62c7a4f5..158e2c68a1 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -3,7 +3,7 @@
>    * EROFS (Enhanced ROM File System) on-disk format definition
>    *
>    * Copyright (C) 2017-2018 HUAWEI, Inc.
> - *             http://www.huawei.com/
> + *             https://www.huawei.com/
>    * Copyright (C) 2021, Alibaba Cloud
>    */
>   #ifndef __EROFS_FS_H
> @@ -18,33 +18,41 @@
>   #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
>   #define EROFS_SUPER_OFFSET      1024
>   
> -#define EROFS_FEATURE_COMPAT_SB_CHKSUM		0x00000001
> +#define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
> +#define EROFS_FEATURE_COMPAT_MTIME              0x00000002
>   
>   /*
>    * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
>    * be incompatible with this kernel version.
>    */
> -#define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
> +#define EROFS_FEATURE_INCOMPAT_ZERO_PADDING	0x00000001
>   #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
>   #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
>   #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
>   #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
> +#define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
> +#define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
> +#define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
> +#define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
> +#define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
>   #define EROFS_ALL_FEATURE_INCOMPAT		\
> -	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
> +	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
>   	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
>   	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
>   	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
> -	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE)
> +	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
> +	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2 | \
> +	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
> +	 EROFS_FEATURE_INCOMPAT_FRAGMENTS | \
> +	 EROFS_FEATURE_INCOMPAT_DEDUPE | \
> +	 EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES)
>   
>   #define EROFS_SB_EXTSLOT_SIZE	16
>   
>   struct erofs_deviceslot {
> -	union {
> -		u8 uuid[16];		/* used for device manager later */
> -		u8 userdata[64];	/* digest(sha256), etc. */
> -	} u;
> -	__le32 blocks;			/* total fs blocks of this device */
> -	__le32 mapped_blkaddr;		/* map starting at mapped_blkaddr */
> +	u8 tag[64];		/* digest(sha256), etc. */
> +	__le32 blocks;		/* total fs blocks of this device */
> +	__le32 mapped_blkaddr;	/* map starting at mapped_blkaddr */
>   	u8 reserved[56];
>   };
>   
> @@ -55,14 +63,14 @@ struct erofs_super_block {
>   	__le32 magic;           /* file system magic number */
>   	__le32 checksum;        /* crc32c(super_block) */
>   	__le32 feature_compat;
> -	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
> +	__u8 blkszbits;         /* filesystem block size in bit shift */
>   	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
>   
>   	__le16 root_nid;	/* nid of root directory */
>   	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
>   
> -	__le64 build_time;      /* inode v1 time derivation */
> -	__le32 build_time_nsec;	/* inode v1 time derivation in nano scale */
> +	__le64 build_time;      /* compact inode time derivation */
> +	__le32 build_time_nsec;	/* compact inode time derivation in ns scale */
>   	__le32 blocks;          /* used for statfs */
>   	__le32 meta_blkaddr;	/* start block address of metadata area */
>   	__le32 xattr_blkaddr;	/* start block address of shared xattr area */
> @@ -77,39 +85,38 @@ struct erofs_super_block {
>   	} __packed u1;
>   	__le16 extra_devices;	/* # of devices besides the primary device */
>   	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
> -	__u8 reserved2[38];
> +	__u8 dirblkbits;	/* directory block size in bit shift */
> +	__u8 xattr_prefix_count;	/* # of long xattr name prefixes */
> +	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
> +	__le64 packed_nid;	/* nid of the special packed inode */
> +	__u8 reserved2[24];
>   };
>   
>   /*
> - * erofs inode datalayout (i_format in on-disk inode):
> - * 0 - inode plain without inline data A:
> - * inode, [xattrs], ... | ... | no-holed data
> - * 1 - inode VLE compression B (legacy):
> - * inode, [xattrs], extents ... | ...
> - * 2 - inode plain with inline data C:
> - * inode, [xattrs], last_inline_data, ... | ... | no-holed data
> - * 3 - inode compression D:
> - * inode, [xattrs], map_header, extents ... | ...
> - * 4 - inode chunk-based E:
> - * inode, [xattrs], chunk indexes ... | ...
> + * EROFS inode datalayout (i_format in on-disk inode):
> + * 0 - uncompressed flat inode without tail-packing inline data:
> + * 1 - compressed inode with non-compact indexes:
> + * 2 - uncompressed flat inode with tail-packing inline data:
> + * 3 - compressed inode with compact indexes:
> + * 4 - chunk-based inode with (optional) multi-device support:
>    * 5~7 - reserved
>    */
>   enum {
>   	EROFS_INODE_FLAT_PLAIN			= 0,
> -	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
> +	EROFS_INODE_COMPRESSED_FULL		= 1,
>   	EROFS_INODE_FLAT_INLINE			= 2,
> -	EROFS_INODE_FLAT_COMPRESSION		= 3,
> +	EROFS_INODE_COMPRESSED_COMPACT		= 3,
>   	EROFS_INODE_CHUNK_BASED			= 4,
>   	EROFS_INODE_DATALAYOUT_MAX
>   };
>   
>   static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
>   {
> -	return datamode == EROFS_INODE_FLAT_COMPRESSION ||
> -		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
> +	return datamode == EROFS_INODE_COMPRESSED_COMPACT ||
> +		datamode == EROFS_INODE_COMPRESSED_FULL;
>   }
>   
> -/* bit definitions of inode i_advise */
> +/* bit definitions of inode i_format */
>   #define EROFS_I_VERSION_BITS            1
>   #define EROFS_I_DATALAYOUT_BITS         3
>   
> @@ -127,11 +134,30 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
>   #define EROFS_CHUNK_FORMAT_ALL	\
>   	(EROFS_CHUNK_FORMAT_BLKBITS_MASK | EROFS_CHUNK_FORMAT_INDEXES)
>   
> +/* 32-byte on-disk inode */
> +#define EROFS_INODE_LAYOUT_COMPACT	0
> +/* 64-byte on-disk inode */
> +#define EROFS_INODE_LAYOUT_EXTENDED	1
> +
>   struct erofs_inode_chunk_info {
>   	__le16 format;		/* chunk blkbits, etc. */
>   	__le16 reserved;
>   };
>   
> +union erofs_inode_i_u {
> +	/* total compressed blocks for compressed inodes */
> +	__le32 compressed_blocks;
> +
> +	/* block address for uncompressed flat inodes */
> +	__le32 raw_blkaddr;
> +
> +	/* for device files, used to indicate old/new device # */
> +	__le32 rdev;
> +
> +	/* for chunk-based files, it contains the summary info */
> +	struct erofs_inode_chunk_info c;
> +};
> +
>   /* 32-byte reduced form of an ondisk inode */
>   struct erofs_inode_compact {
>   	__le16 i_format;	/* inode format hints */
> @@ -142,28 +168,14 @@ struct erofs_inode_compact {
>   	__le16 i_nlink;
>   	__le32 i_size;
>   	__le32 i_reserved;
> -	union {
> -		/* file total compressed blocks for data mapping 1 */
> -		__le32 compressed_blocks;
> -		__le32 raw_blkaddr;
> +	union erofs_inode_i_u i_u;
>   
> -		/* for device files, used to indicate old/new device # */
> -		__le32 rdev;
> -
> -		/* for chunk-based files, it contains the summary info */
> -		struct erofs_inode_chunk_info c;
> -	} i_u;
> -	__le32 i_ino;           /* only used for 32-bit stat compatibility */
> +	__le32 i_ino;		/* only used for 32-bit stat compatibility */
>   	__le16 i_uid;
>   	__le16 i_gid;
>   	__le32 i_reserved2;
>   };
>   
> -/* 32 bytes on-disk inode */
> -#define EROFS_INODE_LAYOUT_COMPACT	0
> -/* 64 bytes on-disk inode */
> -#define EROFS_INODE_LAYOUT_EXTENDED	1
> -
>   /* 64-byte complete form of an ondisk inode */
>   struct erofs_inode_extended {
>   	__le16 i_format;	/* inode format hints */
> @@ -173,33 +185,17 @@ struct erofs_inode_extended {
>   	__le16 i_mode;
>   	__le16 i_reserved;
>   	__le64 i_size;
> -	union {
> -		/* file total compressed blocks for data mapping 1 */
> -		__le32 compressed_blocks;
> -		__le32 raw_blkaddr;
> -
> -		/* for device files, used to indicate old/new device # */
> -		__le32 rdev;
> -
> -		/* for chunk-based files, it contains the summary info */
> -		struct erofs_inode_chunk_info c;
> -	} i_u;
> -
> -	/* only used for 32-bit stat compatibility */
> -	__le32 i_ino;
> +	union erofs_inode_i_u i_u;
>   
> +	__le32 i_ino;		/* only used for 32-bit stat compatibility */
>   	__le32 i_uid;
>   	__le32 i_gid;
> -	__le64 i_ctime;
> -	__le32 i_ctime_nsec;
> +	__le64 i_mtime;
> +	__le32 i_mtime_nsec;
>   	__le32 i_nlink;
>   	__u8   i_reserved2[16];
>   };
>   
> -#define EROFS_MAX_SHARED_XATTRS         (128)
> -/* h_shared_count between 129 ... 255 are special # */
> -#define EROFS_SHARED_XATTR_EXTENT       (255)
> -
>   /*
>    * inline xattrs (n == i_xattr_icount):
>    * erofs_xattr_ibody_header(1) + (n - 1) * 4 bytes
> @@ -226,6 +222,13 @@ struct erofs_xattr_ibody_header {
>   #define EROFS_XATTR_INDEX_LUSTRE            5
>   #define EROFS_XATTR_INDEX_SECURITY          6
>   
> +/*
> + * bit 7 of e_name_index is set when it refers to a long xattr name prefix,
> + * while the remained lower bits represent the index of the prefix.
> + */
> +#define EROFS_XATTR_LONG_PREFIX		0x80
> +#define EROFS_XATTR_LONG_PREFIX_MASK	0x7f
> +
>   /* xattr entry (for both inline & shared xattrs) */
>   struct erofs_xattr_entry {
>   	__u8   e_name_len;      /* length of name */
> @@ -235,6 +238,12 @@ struct erofs_xattr_entry {
>   	char   e_name[0];       /* attribute name */
>   };
>   
> +/* long xattr name prefix */
> +struct erofs_xattr_long_prefix {
> +	__u8   base_index;	/* short xattr name prefix index */
> +	char   infix[0];	/* infix apart from short prefix */
> +};
> +
>   static inline unsigned int erofs_xattr_ibody_size(__le16 i_xattr_icount)
>   {
>   	if (!i_xattr_icount)
> @@ -265,6 +274,29 @@ struct erofs_inode_chunk_index {
>   	__le32 blkaddr;		/* start block address of this inode chunk */
>   };
>   
> +/* dirent sorts in alphabet order, thus we can do binary search */
> +struct erofs_dirent {
> +	__le64 nid;     /* node number */
> +	__le16 nameoff; /* start offset of file name */
> +	__u8 file_type; /* file type */
> +	__u8 reserved;  /* reserved */
> +} __packed;
> +
> +/* file types used in inode_info->flags */
> +enum {
> +	EROFS_FT_UNKNOWN,
> +	EROFS_FT_REG_FILE,
> +	EROFS_FT_DIR,
> +	EROFS_FT_CHRDEV,
> +	EROFS_FT_BLKDEV,
> +	EROFS_FT_FIFO,
> +	EROFS_FT_SOCK,
> +	EROFS_FT_SYMLINK,
> +	EROFS_FT_MAX
> +};
> +
> +#define EROFS_NAME_LEN      255
> +
>   /* maximum supported size of a physical compression cluster */
>   #define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
>   
> @@ -275,7 +307,7 @@ enum {
>   	Z_EROFS_COMPRESSION_MAX
>   };
>   
> -#define Z_EROFS_ALL_COMPR_ALGS		(1 << (Z_EROFS_COMPRESSION_MAX - 1))
> +#define Z_EROFS_ALL_COMPR_ALGS		((1 << Z_EROFS_COMPRESSION_MAX) - 1)
>   
>   /* 14 bytes (+ length field = 16 bytes) */
>   struct z_erofs_lz4_cfgs {
> @@ -290,6 +322,7 @@ struct z_erofs_lzma_cfgs {
>   	__le16 format;
>   	u8 reserved[8];
>   } __packed;
> +
>   #define Z_EROFS_LZMA_MAX_DICT_SIZE	(8 * Z_EROFS_PCLUSTER_MAX_SIZE)
>   
>   /*
> @@ -298,13 +331,28 @@ struct z_erofs_lzma_cfgs {
>    *                                  (4B) + 2B + (4B) if compacted 2B is on.
>    * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
>    * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
> + * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
> + * bit 4 : interlaced plain pcluster (0 - off; 1 - on)
> + * bit 5 : fragment pcluster (0 - off; 1 - on)
>    */
>   #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
>   #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
>   #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
> +#define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
> +#define Z_EROFS_ADVISE_INTERLACED_PCLUSTER	0x0010
> +#define Z_EROFS_ADVISE_FRAGMENT_PCLUSTER	0x0020
>   
> +#define Z_EROFS_FRAGMENT_INODE_BIT              7
>   struct z_erofs_map_header {
> -	__le32	h_reserved1;
> +	union {
> +		/* fragment data offset in the packed inode */
> +		__le32  h_fragmentoff;
> +		struct {
> +			__le16  h_reserved1;
> +			/* indicates the encoded size of tailpacking data */
> +			__le16  h_idata_size;
> +		};
> +	};
>   	__le16	h_advise;
>   	/*
>   	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
> @@ -313,107 +361,85 @@ struct z_erofs_map_header {
>   	__u8	h_algorithmtype;
>   	/*
>   	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
> -	 * bit 3-7 : reserved.
> +	 * bit 3-6 : reserved;
> +	 * bit 7   : move the whole file into packed inode or not.
>   	 */
>   	__u8	h_clusterbits;
>   };
>   
> -#define Z_EROFS_VLE_LEGACY_HEADER_PADDING       8
> -
>   /*
> - * Fixed-sized output compression ondisk Logical Extent cluster type:
> - *    0 - literal (uncompressed) cluster
> - *    1 - compressed cluster (for the head logical cluster)
> - *    2 - compressed cluster (for the other logical clusters)
> + * On-disk logical cluster type:
> + *    0   - literal (uncompressed) lcluster
> + *    1,3 - compressed lcluster (for HEAD lclusters)
> + *    2   - compressed lcluster (for NONHEAD lclusters)
>    *
>    * In detail,
> - *    0 - literal (uncompressed) cluster,
> + *    0 - literal (uncompressed) lcluster,
>    *        di_advise = 0
> - *        di_clusterofs = the literal data offset of the cluster
> - *        di_blkaddr = the blkaddr of the literal cluster
> + *        di_clusterofs = the literal data offset of the lcluster
> + *        di_blkaddr = the blkaddr of the literal pcluster
>    *
> - *    1 - compressed cluster (for the head logical cluster)
> - *        di_advise = 1
> - *        di_clusterofs = the decompressed data offset of the cluster
> - *        di_blkaddr = the blkaddr of the compressed cluster
> + *    1,3 - compressed lcluster (for HEAD lclusters)
> + *        di_advise = 1 or 3
> + *        di_clusterofs = the decompressed data offset of the lcluster
> + *        di_blkaddr = the blkaddr of the compressed pcluster
>    *
> - *    2 - compressed cluster (for the other logical clusters)
> + *    2 - compressed lcluster (for NONHEAD lclusters)
>    *        di_advise = 2
>    *        di_clusterofs =
> - *           the decompressed data offset in its own head cluster
> - *        di_u.delta[0] = distance to its corresponding head cluster
> - *        di_u.delta[1] = distance to its corresponding tail cluster
> - *                (di_advise could be 0, 1 or 2)
> + *           the decompressed data offset in its own HEAD lcluster
> + *        di_u.delta[0] = distance to this HEAD lcluster
> + *        di_u.delta[1] = distance to the next HEAD lcluster
>    */
>   enum {
> -	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
> -	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
> -	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
> -	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
> -	Z_EROFS_VLE_CLUSTER_TYPE_MAX
> +	Z_EROFS_LCLUSTER_TYPE_PLAIN	= 0,
> +	Z_EROFS_LCLUSTER_TYPE_HEAD1	= 1,
> +	Z_EROFS_LCLUSTER_TYPE_NONHEAD	= 2,
> +	Z_EROFS_LCLUSTER_TYPE_HEAD2	= 3,
> +	Z_EROFS_LCLUSTER_TYPE_MAX
>   };
>   
> -#define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
> -#define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
> +#define Z_EROFS_LI_LCLUSTER_TYPE_BITS        2
> +#define Z_EROFS_LI_LCLUSTER_TYPE_BIT         0
> +
> +/* (noncompact only, HEAD) This pcluster refers to partial decompressed data */
> +#define Z_EROFS_LI_PARTIAL_REF		(1 << 15)
>   
>   /*
>    * D0_CBLKCNT will be marked _only_ at the 1st non-head lcluster to store the
>    * compressed block count of a compressed extent (in logical clusters, aka.
>    * block count of a pcluster).
>    */
> -#define Z_EROFS_VLE_DI_D0_CBLKCNT		(1 << 11)
> +#define Z_EROFS_LI_D0_CBLKCNT		(1 << 11)
>   
> -struct z_erofs_vle_decompressed_index {
> +struct z_erofs_lcluster_index {
>   	__le16 di_advise;
> -	/* where to decompress in the head cluster */
> +	/* where to decompress in the head lcluster */
>   	__le16 di_clusterofs;
>   
>   	union {
> -		/* for the head cluster */
> +		/* for the HEAD lclusters */
>   		__le32 blkaddr;
>   		/*
> -		 * for the rest clusters
> -		 * eg. for 4k page-sized cluster, maximum 4K*64k = 256M)
> -		 * [0] - pointing to the head cluster
> -		 * [1] - pointing to the tail cluster
> +		 * for the NONHEAD lclusters
> +		 * [0] - distance to its HEAD lcluster
> +		 * [1] - distance to the next HEAD lcluster
>   		 */
>   		__le16 delta[2];
>   	} di_u;
>   };
>   
> -#define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
> -	(round_up(size, sizeof(struct z_erofs_vle_decompressed_index)) + \
> -	 sizeof(struct z_erofs_map_header) + Z_EROFS_VLE_LEGACY_HEADER_PADDING)
> -
> -#define Z_EROFS_VLE_EXTENT_ALIGN(size) round_up(size, \
> -	sizeof(struct z_erofs_vle_decompressed_index))
> -
> -/* dirent sorts in alphabet order, thus we can do binary search */
> -struct erofs_dirent {
> -	__le64 nid;     /* node number */
> -	__le16 nameoff; /* start offset of file name */
> -	__u8 file_type; /* file type */
> -	__u8 reserved;  /* reserved */
> -} __packed;
> -
> -/* file types used in inode_info->flags */
> -enum {
> -	EROFS_FT_UNKNOWN,
> -	EROFS_FT_REG_FILE,
> -	EROFS_FT_DIR,
> -	EROFS_FT_CHRDEV,
> -	EROFS_FT_BLKDEV,
> -	EROFS_FT_FIFO,
> -	EROFS_FT_SOCK,
> -	EROFS_FT_SYMLINK,
> -	EROFS_FT_MAX
> -};
> -
> -#define EROFS_NAME_LEN      255
> +#define Z_EROFS_FULL_INDEX_ALIGN(end)	\
> +	(round_up(end, 8) + sizeof(struct z_erofs_map_header) + 8)
>   
>   /* check the EROFS on-disk layout strictly at compile time */
>   static inline void erofs_check_ondisk_layout_definitions(void)
>   {
> +	const __le64 fmh __maybe_unused =
> +		*(__le64 *)&(struct z_erofs_map_header) {
> +			.h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT
> +		};
> +
>   	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
>   	BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);
>   	BUILD_BUG_ON(sizeof(struct erofs_inode_extended) != 64);
> @@ -422,15 +448,18 @@ static inline void erofs_check_ondisk_layout_definitions(void)
>   	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_info) != 4);
>   	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) != 8);
>   	BUILD_BUG_ON(sizeof(struct z_erofs_map_header) != 8);
> -	BUILD_BUG_ON(sizeof(struct z_erofs_vle_decompressed_index) != 8);
> +	BUILD_BUG_ON(sizeof(struct z_erofs_lcluster_index) != 8);
>   	BUILD_BUG_ON(sizeof(struct erofs_dirent) != 12);
>   	/* keep in sync between 2 index structures for better extendibility */
>   	BUILD_BUG_ON(sizeof(struct erofs_inode_chunk_index) !=
> -		     sizeof(struct z_erofs_vle_decompressed_index));
> +		     sizeof(struct z_erofs_lcluster_index));
>   	BUILD_BUG_ON(sizeof(struct erofs_deviceslot) != 128);
>   
> -	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
> -		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
> +	BUILD_BUG_ON(BIT(Z_EROFS_LI_LCLUSTER_TYPE_BITS) <
> +		     Z_EROFS_LCLUSTER_TYPE_MAX - 1);
> +	/* exclude old compiler versions like gcc 7.5.0 */
> +	BUILD_BUG_ON(__builtin_constant_p(fmh) ?
> +		     fmh != cpu_to_le64(1ULL << 63) : 0);
>   }
>   
>   #endif
> diff --git a/fs/erofs/fs.c b/fs/erofs/fs.c
> index 89269750f8..7bd2e8fcfc 100644
> --- a/fs/erofs/fs.c
> +++ b/fs/erofs/fs.c
> @@ -25,8 +25,8 @@ int erofs_dev_read(int device_id, void *buf, u64 offset, size_t len)
>   
>   int erofs_blk_read(void *buf, erofs_blk_t start, u32 nblocks)
>   {
> -	return erofs_dev_read(0, buf, blknr_to_addr(start),
> -			 blknr_to_addr(nblocks));
> +	return erofs_dev_read(0, buf, erofs_pos(start),
> +			 erofs_pos(nblocks));
>   }
>   
>   int erofs_probe(struct blk_desc *fs_dev_desc,
> @@ -52,7 +52,7 @@ struct erofs_dir_stream {
>   	struct fs_dirent dirent;
>   
>   	struct erofs_inode inode;
> -	char dblk[EROFS_BLKSIZ];
> +	char dblk[EROFS_MAX_BLOCK_SIZE];
>   	unsigned int maxsize, de_end;
>   	erofs_off_t pos;
>   };
> @@ -125,7 +125,7 @@ int erofs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
>   		return 1;
>   
>   	if (!dirs->maxsize) {
> -		dirs->maxsize = min_t(unsigned int, EROFS_BLKSIZ,
> +		dirs->maxsize = min_t(unsigned int, EROFS_MAX_BLOCK_SIZE,
>   				      dirs->inode.i_size - pos);
>   
>   		err = erofs_pread(&dirs->inode, dirs->dblk,
> @@ -136,7 +136,7 @@ int erofs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
>   		de = (struct erofs_dirent *)dirs->dblk;
>   		dirs->de_end = le16_to_cpu(de->nameoff);
>   		if (dirs->de_end < sizeof(struct erofs_dirent) ||
> -		    dirs->de_end >= EROFS_BLKSIZ) {
> +		    dirs->de_end >= EROFS_MAX_BLOCK_SIZE) {
>   			erofs_err("invalid de[0].nameoff %u @ nid %llu",
>   				  dirs->de_end, de->nid | 0ULL);
>   			return -EFSCORRUPTED;
> @@ -183,7 +183,7 @@ int erofs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
>   
>   	pos += sizeof(*de);
>   	if (erofs_blkoff(pos) >= dirs->de_end) {
> -		pos = blknr_to_addr(erofs_blknr(pos) + 1);
> +		pos = erofs_pos(erofs_blknr(pos) + 1);
>   		dirs->maxsize = 0;
>   	}
>   	dirs->pos = pos;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4af7c91560..433a3c6c1e 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -2,6 +2,7 @@
>   #ifndef __EROFS_INTERNAL_H
>   #define __EROFS_INTERNAL_H
>   
> +#include "linux/compat.h"
>   #define __packed __attribute__((__packed__))
>   
>   #include <linux/stat.h>
> @@ -30,8 +31,9 @@
>   
>   #define PAGE_MASK		(~(PAGE_SIZE - 1))
>   
> -#define LOG_BLOCK_SIZE          (12)
> -#define EROFS_BLKSIZ            (1U << LOG_BLOCK_SIZE)
> +#ifndef EROFS_MAX_BLOCK_SIZE
> +#define EROFS_MAX_BLOCK_SIZE	PAGE_SIZE
> +#endif
>   
>   #define EROFS_ISLOTBITS		5
>   #define EROFS_SLOTSIZE		(1U << EROFS_ISLOTBITS)
> @@ -44,11 +46,15 @@ typedef u32 erofs_blk_t;
>   #define NULL_ADDR	((unsigned int)-1)
>   #define NULL_ADDR_UL	((unsigned long)-1)
>   
> -#define erofs_blknr(addr)       ((addr) / EROFS_BLKSIZ)
> -#define erofs_blkoff(addr)      ((addr) % EROFS_BLKSIZ)
> -#define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
> +/* global sbi */
> +extern struct erofs_sb_info sbi;
> +
> +#define erofs_blksiz()		(1u << sbi.blkszbits)
> +#define erofs_blknr(addr)       ((addr) >> sbi.blkszbits)
> +#define erofs_blkoff(addr)      ((addr) & (erofs_blksiz() - 1))
> +#define erofs_pos(nr)           ((erofs_off_t)(nr) << sbi.blkszbits)
>   
> -#define BLK_ROUND_UP(addr)	DIV_ROUND_UP(addr, EROFS_BLKSIZ)
> +#define BLK_ROUND_UP(addr)	DIV_ROUND_UP(addr, 1u << sbi.blkszbits)
>   
>   struct erofs_buffer_head;
>   
> @@ -57,6 +63,8 @@ struct erofs_device_info {
>   	u32 mapped_blkaddr;
>   };
>   
> +#define EROFS_PACKED_NID_UNALLOCATED	-1
> +
>   struct erofs_sb_info {
>   	struct erofs_device_info *devs;
>   
> @@ -72,6 +80,7 @@ struct erofs_sb_info {
>   	u32 build_time_nsec;
>   
>   	unsigned char islotbits;
> +	unsigned char blkszbits;
>   
>   	/* what we really care is nid, rather than ino.. */
>   	erofs_nid_t root_nid;
> @@ -79,23 +88,29 @@ struct erofs_sb_info {
>   	u64 inos;
>   
>   	u8 uuid[16];
> +	char volume_name[16];
>   
>   	u16 available_compr_algs;
>   	u16 lz4_max_distance;
> +
>   	u32 checksum;
>   	u16 extra_devices;
>   	union {
>   		u16 devt_slotoff;		/* used for mkfs */
>   		u16 device_id_mask;		/* used for others */
>   	};
> +	erofs_nid_t packed_nid;
> +
> +	u32 xattr_prefix_start;
> +	u8 xattr_prefix_count;
>   };
>   
> -/* global sbi */
> -extern struct erofs_sb_info sbi;
> +/* make sure that any user of the erofs headers has at least 64bit off_t type */
> +extern int erofs_assert_largefile[sizeof(off_t) - 8];
>   
>   static inline erofs_off_t iloc(erofs_nid_t nid)
>   {
> -	return blknr_to_addr(sbi.meta_blkaddr) + (nid << sbi.islotbits);
> +	return erofs_pos(sbi.meta_blkaddr) + (nid << sbi.islotbits);
>   }
>   
>   #define EROFS_FEATURE_FUNCS(name, compat, feature) \
> @@ -112,11 +127,15 @@ static inline void erofs_sb_clear_##name(void) \
>   	sbi.feature_##compat &= ~EROFS_FEATURE_##feature; \
>   }
>   
> -EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
> +EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_ZERO_PADDING)
>   EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
>   EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
>   EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
>   EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
> +EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
> +EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
> +EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
> +EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
>   EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>   
>   #define EROFS_I_EA_INITED	(1 << 0)
> @@ -130,6 +149,8 @@ struct erofs_inode {
>   		unsigned int flags;
>   		/* (mkfs.erofs) device ID containing source file */
>   		u32 dev;
> +		/* (mkfs.erofs) queued sub-directories blocking dump */
> +		u32 subdirs_queued;
>   	};
>   	unsigned int i_count;
>   	struct erofs_inode *i_parent;
> @@ -140,8 +161,8 @@ struct erofs_inode {
>   	u64 i_ino[2];
>   	u32 i_uid;
>   	u32 i_gid;
> -	u64 i_ctime;
> -	u32 i_ctime_nsec;
> +	u64 i_mtime;
> +	u32 i_mtime_nsec;
>   	u32 i_nlink;
>   
>   	union {
> @@ -154,20 +175,31 @@ struct erofs_inode {
>   		};
>   	} u;
>   
> +	char *i_srcpath;
> +
>   	unsigned char datalayout;
>   	unsigned char inode_isize;
>   	/* inline tail-end packing size */
>   	unsigned short idata_size;
> +	bool compressed_idata;
> +	bool lazy_tailblock;
>   
>   	unsigned int xattr_isize;
>   	unsigned int extent_isize;
>   
> +	unsigned int xattr_shared_count;
> +	unsigned int *xattr_shared_xattrs;
> +
>   	erofs_nid_t nid;
>   	struct erofs_buffer_head *bh;
>   	struct erofs_buffer_head *bh_inline, *bh_data;
>   
>   	void *idata;
>   
> +	/* (ztailpacking) in order to recover uncompressed EOF data */
> +	void *eof_tailraw;
> +	unsigned int eof_tailrawsize;
> +
>   	union {
>   		void *compressmeta;
>   		void *chunkindexes;
> @@ -176,8 +208,14 @@ struct erofs_inode {
>   			uint8_t  z_algorithmtype[2];
>   			uint8_t  z_logical_clusterbits;
>   			uint8_t  z_physical_clusterblks;
> +			uint64_t z_tailextent_headlcn;
> +			unsigned int    z_idataoff;
> +#define z_idata_size	idata_size
>   		};
>   	};
> +	uint64_t capabilities;
> +	erofs_off_t fragmentoff;
> +	unsigned int fragment_size;
>   };
>   
>   static inline bool is_inode_layout_compression(struct erofs_inode *inode)
> @@ -216,6 +254,14 @@ struct erofs_dentry {
>   	};
>   };
>   
> +static inline bool is_dot_dotdot_len(const char *name, unsigned int len)
> +{
> +	if (len >= 1 && name[0] != '.')
> +		return false;
> +
> +	return len == 1 || (len == 2 && name[1] == '.');
> +}
> +
>   static inline bool is_dot_dotdot(const char *name)
>   {
>   	if (name[0] != '.')
> @@ -229,6 +275,8 @@ enum {
>   	BH_Mapped,
>   	BH_Encoded,
>   	BH_FullMapped,
> +	BH_Fragment,
> +	BH_Partialref,
>   };
>   
>   /* Has a disk mapping */
> @@ -239,9 +287,13 @@ enum {
>   #define EROFS_MAP_ENCODED	(1 << BH_Encoded)
>   /* The length of extent is full */
>   #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
> +/* Located in the special packed inode */
> +#define EROFS_MAP_FRAGMENT	(1 << BH_Fragment)
> +/* The extent refers to partial decompressed data */
> +#define EROFS_MAP_PARTIAL_REF	(1 << BH_Partialref)
>   
>   struct erofs_map_blocks {
> -	char mpage[EROFS_BLKSIZ];
> +	char mpage[EROFS_MAX_BLOCK_SIZE];
>   
>   	erofs_off_t m_pa, m_la;
>   	u64 m_plen, m_llen;
> @@ -257,9 +309,12 @@ struct erofs_map_blocks {
>    * approach instead if possible since it's more metadata lightweight.)
>    */
>   #define EROFS_GET_BLOCKS_FIEMAP	0x0002
> +/* Used to map tail extent for tailpacking inline or fragment pcluster */
> +#define EROFS_GET_BLOCKS_FINDTAIL	0x0008
>   
>   enum {
>   	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
> +	Z_EROFS_COMPRESSION_INTERLACED,
>   	Z_EROFS_COMPRESSION_RUNTIME_MAX
>   };
>   
> @@ -274,6 +329,7 @@ int erofs_dev_read(int device_id, void *buf, u64 offset, size_t len);
>   
>   /* super.c */
>   int erofs_read_superblock(void);
> +void erofs_put_super(void);
>   
>   /* namei.c */
>   int erofs_read_inode_from_disk(struct erofs_inode *vi);
> @@ -283,9 +339,40 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi);
>   /* data.c */
>   int erofs_pread(struct erofs_inode *inode, char *buf,
>   		erofs_off_t count, erofs_off_t offset);
> -int erofs_map_blocks(struct erofs_inode *inode,
> -		     struct erofs_map_blocks *map, int flags);
> -int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
> +int erofs_map_blocks(struct erofs_inode *inode, struct erofs_map_blocks *map,
> +		     int flags);
> +int erofs_map_dev(struct erofs_map_dev *map);
> +int erofs_read_one_data(struct erofs_map_blocks *map, char *buffer, u64 offset,
> +			size_t len);
> +int z_erofs_read_one_data(struct erofs_inode *inode,
> +			  struct erofs_map_blocks *map, char *raw, char *buffer,
> +			  erofs_off_t skip, erofs_off_t length, bool trimmed);
> +
> +static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
> +					  erofs_off_t *size)
> +{
> +	*size = 0;
> +	switch (inode->datalayout) {
> +	case EROFS_INODE_FLAT_INLINE:
> +	case EROFS_INODE_FLAT_PLAIN:
> +	case EROFS_INODE_CHUNK_BASED:
> +		*size = inode->i_size;
> +		break;
> +	case EROFS_INODE_COMPRESSED_FULL:
> +	case EROFS_INODE_COMPRESSED_COMPACT:
> +		*size = inode->u.i_blocks * erofs_blksiz();
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +/* data.c */
> +int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
> +		   size_t buffer_size);
> +int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size);
> +
>   /* zmap.c */
>   int z_erofs_fill_inode(struct erofs_inode *vi);
>   int z_erofs_map_blocks_iter(struct erofs_inode *vi,
> diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
> index d1d4757c50..bde995f1bf 100644
> --- a/fs/erofs/namei.c
> +++ b/fs/erofs/namei.c
> @@ -1,6 +1,15 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   #include "internal.h"
>   
> +#define makedev(major, minor) ((dev_t)((((major) & 0xfff) << 8) | ((minor) & 0xff)))
> +static dev_t erofs_new_decode_dev(u32 dev)
> +{
> +	const unsigned int major = (dev & 0xfff00) >> 8;
> +	const unsigned int minor = (dev & 0xff) | ((dev >> 12) & 0xfff00);
> +
> +	return makedev(major, minor);
> +}
> +
>   int erofs_read_inode_from_disk(struct erofs_inode *vi)
>   {
>   	int ret, ifmt;
> @@ -26,7 +35,8 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
>   	case EROFS_INODE_LAYOUT_EXTENDED:
>   		vi->inode_isize = sizeof(struct erofs_inode_extended);
>   
> -		ret = erofs_dev_read(0, buf + sizeof(*dic), inode_loc + sizeof(*dic),
> +		ret = erofs_dev_read(0, buf + sizeof(*dic),
> +				     inode_loc + sizeof(*dic),
>   				     sizeof(*die) - sizeof(*dic));
>   		if (ret < 0)
>   			return -EIO;
> @@ -43,7 +53,8 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
>   			break;
>   		case S_IFCHR:
>   		case S_IFBLK:
> -			vi->u.i_rdev = 0;
> +			vi->u.i_rdev =
> +				erofs_new_decode_dev(le32_to_cpu(die->i_u.rdev));
>   			break;
>   		case S_IFIFO:
>   		case S_IFSOCK:
> @@ -57,8 +68,8 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
>   		vi->i_gid = le32_to_cpu(die->i_gid);
>   		vi->i_nlink = le32_to_cpu(die->i_nlink);
>   
> -		vi->i_ctime = le64_to_cpu(die->i_ctime);
> -		vi->i_ctime_nsec = le64_to_cpu(die->i_ctime_nsec);
> +		vi->i_mtime = le64_to_cpu(die->i_mtime);
> +		vi->i_mtime_nsec = le64_to_cpu(die->i_mtime_nsec);
>   		vi->i_size = le64_to_cpu(die->i_size);
>   		if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
>   			/* fill chunked inode summary info */
> @@ -77,7 +88,8 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
>   			break;
>   		case S_IFCHR:
>   		case S_IFBLK:
> -			vi->u.i_rdev = 0;
> +			vi->u.i_rdev =
> +				erofs_new_decode_dev(le32_to_cpu(dic->i_u.rdev));
>   			break;
>   		case S_IFIFO:
>   		case S_IFSOCK:
> @@ -91,8 +103,8 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
>   		vi->i_gid = le16_to_cpu(dic->i_gid);
>   		vi->i_nlink = le16_to_cpu(dic->i_nlink);
>   
> -		vi->i_ctime = sbi.build_time;
> -		vi->i_ctime_nsec = sbi.build_time_nsec;
> +		vi->i_mtime = sbi.build_time;
> +		vi->i_mtime_nsec = sbi.build_time_nsec;
>   
>   		vi->i_size = le32_to_cpu(dic->i_size);
>   		if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
> @@ -111,10 +123,13 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
>   				  vi->u.chunkformat, vi->nid | 0ULL);
>   			return -EOPNOTSUPP;
>   		}
> -		vi->u.chunkbits = LOG_BLOCK_SIZE +
> +		vi->u.chunkbits = sbi.blkszbits +
>   			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
> -	} else if (erofs_inode_is_data_compressed(vi->datalayout))
> -		z_erofs_fill_inode(vi);
> +	} else if (erofs_inode_is_data_compressed(vi->datalayout)) {
> +		if (erofs_blksiz() != EROFS_MAX_BLOCK_SIZE)
> +			return -EOPNOTSUPP;
> +		return z_erofs_fill_inode(vi);
> +	}
>   	return 0;
>   bogusimode:
>   	erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode, vi->nid | 0ULL);
> @@ -163,12 +178,11 @@ struct nameidata {
>   	unsigned int	ftype;
>   };
>   
> -int erofs_namei(struct nameidata *nd,
> -		const char *name, unsigned int len)
> +int erofs_namei(struct nameidata *nd, const char *name, unsigned int len)
>   {
>   	erofs_nid_t nid = nd->nid;
>   	int ret;
> -	char buf[EROFS_BLKSIZ];
> +	char buf[EROFS_MAX_BLOCK_SIZE];
>   	struct erofs_inode vi = { .nid = nid };
>   	erofs_off_t offset;
>   
> @@ -179,7 +193,7 @@ int erofs_namei(struct nameidata *nd,
>   	offset = 0;
>   	while (offset < vi.i_size) {
>   		erofs_off_t maxsize = min_t(erofs_off_t,
> -					    vi.i_size - offset, EROFS_BLKSIZ);
> +					    vi.i_size - offset, erofs_blksiz());
>   		struct erofs_dirent *de = (void *)buf;
>   		unsigned int nameoff;
>   
> @@ -189,7 +203,7 @@ int erofs_namei(struct nameidata *nd,
>   
>   		nameoff = le16_to_cpu(de->nameoff);
>   		if (nameoff < sizeof(struct erofs_dirent) ||
> -		    nameoff >= PAGE_SIZE) {
> +		    nameoff >= erofs_blksiz()) {
>   			erofs_err("invalid de[0].nameoff %u @ nid %llu",
>   				  nameoff, nid | 0ULL);
>   			return -EFSCORRUPTED;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 8277d9b53f..d33926281b 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -9,7 +9,7 @@ static bool check_layout_compatibility(struct erofs_sb_info *sbi,
>   	sbi->feature_incompat = feature;
>   
>   	/* check if current kernel meets all mandatory requirements */
> -	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
> +	if (feature & ~EROFS_ALL_FEATURE_INCOMPAT) {
>   		erofs_err("unidentified incompatible feature %x, please upgrade kernel version",
>   			  feature & ~EROFS_ALL_FEATURE_INCOMPAT);
>   		return false;
> @@ -40,14 +40,18 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
>   
>   	sbi->device_id_mask = roundup_pow_of_two(ondisk_extradevs + 1) - 1;
>   	sbi->devs = calloc(ondisk_extradevs, sizeof(*sbi->devs));
> +	if (!sbi->devs)
> +		return -ENOMEM;
>   	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
>   	for (i = 0; i < ondisk_extradevs; ++i) {
>   		struct erofs_deviceslot dis;
>   		int ret;
>   
>   		ret = erofs_dev_read(0, &dis, pos, sizeof(dis));
> -		if (ret < 0)
> +		if (ret < 0) {
> +			free(sbi->devs);
>   			return ret;
> +		}
>   
>   		sbi->devs[i].mapped_blkaddr = dis.mapped_blkaddr;
>   		sbi->total_blocks += dis.blocks;
> @@ -58,42 +62,41 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
>   
>   int erofs_read_superblock(void)
>   {
> -	char data[EROFS_BLKSIZ];
> +	u8 data[EROFS_MAX_BLOCK_SIZE];
>   	struct erofs_super_block *dsb;
> -	unsigned int blkszbits;
>   	int ret;
>   
> -	ret = erofs_blk_read(data, 0, 1);
> +	ret = erofs_blk_read(data, 0, erofs_blknr(sizeof(data)));
>   	if (ret < 0) {
> -		erofs_dbg("cannot read erofs superblock: %d", ret);
> +		erofs_err("cannot read erofs superblock: %d", ret);
>   		return -EIO;
>   	}
>   	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
>   
>   	ret = -EINVAL;
>   	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
> -		erofs_dbg("cannot find valid erofs superblock");
> +		erofs_err("cannot find valid erofs superblock");
>   		return ret;
>   	}
>   
>   	sbi.feature_compat = le32_to_cpu(dsb->feature_compat);
>   
> -	blkszbits = dsb->blkszbits;
> -	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
> -	if (blkszbits != LOG_BLOCK_SIZE) {
> -		erofs_err("blksize %u isn't supported on this platform",
> -			  1 << blkszbits);
> +	sbi.blkszbits = dsb->blkszbits;
> +	if (sbi.blkszbits < 9 ||
> +	    sbi.blkszbits > ilog2(EROFS_MAX_BLOCK_SIZE)) {
> +		erofs_err("blksize %llu isn't supported on this platform",
> +			  erofs_blksiz() | 0ULL);
>   		return ret;
> -	}
> -
> -	if (!check_layout_compatibility(&sbi, dsb))
> +	} else if (!check_layout_compatibility(&sbi, dsb)) {
>   		return ret;
> +	}
>   
>   	sbi.primarydevice_blocks = le32_to_cpu(dsb->blocks);
>   	sbi.meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
>   	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
>   	sbi.islotbits = EROFS_ISLOTBITS;
>   	sbi.root_nid = le16_to_cpu(dsb->root_nid);
> +	sbi.packed_nid = le64_to_cpu(dsb->packed_nid);
>   	sbi.inos = le64_to_cpu(dsb->inos);
>   	sbi.checksum = le32_to_cpu(dsb->checksum);
>   
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index be2599ac4f..4f64258b00 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -1,14 +1,19 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   #include "internal.h"
>   
> +static int z_erofs_do_map_blocks(struct erofs_inode *vi,
> +				 struct erofs_map_blocks *map,
> +				 int flags);
> +
>   int z_erofs_fill_inode(struct erofs_inode *vi)
>   {
>   	if (!erofs_sb_has_big_pcluster() &&
> -	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
> +	    !erofs_sb_has_ztailpacking() && !erofs_sb_has_fragments() &&
> +	    vi->datalayout == EROFS_INODE_COMPRESSED_FULL) {
>   		vi->z_advise = 0;
>   		vi->z_algorithmtype[0] = 0;
>   		vi->z_algorithmtype[1] = 0;
> -		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
> +		vi->z_logical_clusterbits = sbi.blkszbits;
>   
>   		vi->flags |= EROFS_I_Z_INITED;
>   	}
> @@ -25,15 +30,23 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
>   	if (vi->flags & EROFS_I_Z_INITED)
>   		return 0;
>   
> -	DBG_BUGON(!erofs_sb_has_big_pcluster() &&
> -		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
>   	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
> -
>   	ret = erofs_dev_read(0, buf, pos, sizeof(buf));
>   	if (ret < 0)
>   		return -EIO;
>   
>   	h = (struct z_erofs_map_header *)buf;
> +	/*
> +	 * if the highest bit of the 8-byte map header is set, the whole file
> +	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
> +	 */
> +	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
> +		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
> +		vi->fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
> +		vi->z_tailextent_headlcn = 0;
> +		goto out;
> +	}
> +
>   	vi->z_advise = le16_to_cpu(h->h_advise);
>   	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
>   	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
> @@ -44,14 +57,41 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
>   		return -EOPNOTSUPP;
>   	}
>   
> -	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
> -	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
> +	vi->z_logical_clusterbits = sbi.blkszbits + (h->h_clusterbits & 7);
> +	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
>   	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
>   	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
>   		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
>   			  vi->nid * 1ULL);
>   		return -EFSCORRUPTED;
>   	}
> +
> +	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
> +		struct erofs_map_blocks map = { .index = UINT_MAX };
> +
> +		vi->idata_size = le16_to_cpu(h->h_idata_size);
> +		ret = z_erofs_do_map_blocks(vi, &map,
> +					    EROFS_GET_BLOCKS_FINDTAIL);
> +		if (!map.m_plen ||
> +		    erofs_blkoff(map.m_pa) + map.m_plen > erofs_blksiz()) {
> +			erofs_err("invalid tail-packing pclustersize %llu",
> +				  map.m_plen | 0ULL);
> +			return -EFSCORRUPTED;
> +		}
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
> +	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
> +		struct erofs_map_blocks map = { .index = UINT_MAX };
> +
> +		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
> +		ret = z_erofs_do_map_blocks(vi, &map,
> +					    EROFS_GET_BLOCKS_FINDTAIL);
> +		if (ret < 0)
> +			return ret;
> +	}
> +out:
>   	vi->flags |= EROFS_I_Z_INITED;
>   	return 0;
>   }
> @@ -66,7 +106,9 @@ struct z_erofs_maprecorder {
>   	u8  type, headtype;
>   	u16 clusterofs;
>   	u16 delta[2];
> -	erofs_blk_t pblk, compressedlcs;
> +	erofs_blk_t pblk, compressedblks;
> +	erofs_off_t nextpackoff;
> +	bool partialref;
>   };
>   
>   static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
> @@ -93,11 +135,10 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>   {
>   	struct erofs_inode *const vi = m->inode;
>   	const erofs_off_t ibase = iloc(vi->nid);
> -	const erofs_off_t pos =
> -		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
> -					       vi->xattr_isize) +
> -		lcn * sizeof(struct z_erofs_vle_decompressed_index);
> -	struct z_erofs_vle_decompressed_index *di;
> +	const erofs_off_t pos = Z_EROFS_FULL_INDEX_ALIGN(ibase +
> +			vi->inode_isize + vi->xattr_isize) +
> +		lcn * sizeof(struct z_erofs_lcluster_index);
> +	struct z_erofs_lcluster_index *di;
>   	unsigned int advise, type;
>   	int err;
>   
> @@ -105,29 +146,32 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>   	if (err)
>   		return err;
>   
> +	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
>   	m->lcn = lcn;
>   	di = m->kaddr + erofs_blkoff(pos);
>   
>   	advise = le16_to_cpu(di->di_advise);
> -	type = (advise >> Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT) &
> -		((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
> +	type = (advise >> Z_EROFS_LI_LCLUSTER_TYPE_BIT) &
> +		((1 << Z_EROFS_LI_LCLUSTER_TYPE_BITS) - 1);
>   	switch (type) {
> -	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
> +	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>   		m->clusterofs = 1 << vi->z_logical_clusterbits;
>   		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
> -		if (m->delta[0] & Z_EROFS_VLE_DI_D0_CBLKCNT) {
> +		if (m->delta[0] & Z_EROFS_LI_D0_CBLKCNT) {
>   			if (!(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
>   				DBG_BUGON(1);
>   				return -EFSCORRUPTED;
>   			}
> -			m->compressedlcs = m->delta[0] &
> -				~Z_EROFS_VLE_DI_D0_CBLKCNT;
> +			m->compressedblks = m->delta[0] &
> +				~Z_EROFS_LI_D0_CBLKCNT;
>   			m->delta[0] = 1;
>   		}
>   		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
>   		break;
> -	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
> +	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
> +		if (advise & Z_EROFS_LI_PARTIAL_REF)
> +			m->partialref = true;
>   		m->clusterofs = le16_to_cpu(di->di_clusterofs);
>   		m->pblk = le32_to_cpu(di->di_u.blkaddr);
>   		break;
> @@ -164,25 +208,25 @@ static int get_compacted_la_distance(unsigned int lclusterbits,
>   		lo = decode_compactedbits(lclusterbits, lomask,
>   					  in, encodebits * i, &type);
>   
> -		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
> +		if (type != Z_EROFS_LCLUSTER_TYPE_NONHEAD)
>   			return d1;
>   		++d1;
>   	} while (++i < vcnt);
>   
> -	/* vcnt - 1 (Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) item */
> -	if (!(lo & Z_EROFS_VLE_DI_D0_CBLKCNT))
> +	/* vcnt - 1 (Z_EROFS_LCLUSTER_TYPE_NONHEAD) item */
> +	if (!(lo & Z_EROFS_LI_D0_CBLKCNT))
>   		d1 += lo - 1;
>   	return d1;
>   }
>   
>   static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>   				  unsigned int amortizedshift,
> -				  unsigned int eofs, bool lookahead)
> +				  erofs_off_t pos, bool lookahead)
>   {
>   	struct erofs_inode *const vi = m->inode;
>   	const unsigned int lclusterbits = vi->z_logical_clusterbits;
>   	const unsigned int lomask = (1 << lclusterbits) - 1;
> -	unsigned int vcnt, base, lo, encodebits, nblk;
> +	unsigned int vcnt, base, lo, encodebits, nblk, eofs;
>   	int i;
>   	u8 *in, type;
>   	bool big_pcluster;
> @@ -194,8 +238,12 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>   	else
>   		return -EOPNOTSUPP;
>   
> +	/* it doesn't equal to round_up(..) */
> +	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
> +			 (vcnt << amortizedshift);
>   	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
>   	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
> +	eofs = erofs_blkoff(pos);
>   	base = round_down(eofs, vcnt << amortizedshift);
>   	in = m->kaddr + base;
>   
> @@ -204,20 +252,19 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>   	lo = decode_compactedbits(lclusterbits, lomask,
>   				  in, encodebits * i, &type);
>   	m->type = type;
> -	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
> +	if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>   		m->clusterofs = 1 << lclusterbits;
>   
>   		/* figure out lookahead_distance: delta[1] if needed */
>   		if (lookahead)
>   			m->delta[1] = get_compacted_la_distance(lclusterbits,
> -								encodebits,
> -								vcnt, in, i);
> -		if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
> +								encodebits, vcnt, in, i);
> +		if (lo & Z_EROFS_LI_D0_CBLKCNT) {
>   			if (!big_pcluster) {
>   				DBG_BUGON(1);
>   				return -EFSCORRUPTED;
>   			}
> -			m->compressedlcs = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
> +			m->compressedblks = lo & ~Z_EROFS_LI_D0_CBLKCNT;
>   			m->delta[0] = 1;
>   			return 0;
>   		} else if (i + 1 != (int)vcnt) {
> @@ -231,9 +278,9 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>   		 */
>   		lo = decode_compactedbits(lclusterbits, lomask,
>   					  in, encodebits * (i - 1), &type);
> -		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
> +		if (type != Z_EROFS_LCLUSTER_TYPE_NONHEAD)
>   			lo = 0;
> -		else if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT)
> +		else if (lo & Z_EROFS_LI_D0_CBLKCNT)
>   			lo = 1;
>   		m->delta[0] = lo + 1;
>   		return 0;
> @@ -247,7 +294,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>   			--i;
>   			lo = decode_compactedbits(lclusterbits, lomask,
>   						  in, encodebits * i, &type);
> -			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
> +			if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD)
>   				i -= lo;
>   
>   			if (i >= 0)
> @@ -259,13 +306,13 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
>   			--i;
>   			lo = decode_compactedbits(lclusterbits, lomask,
>   						  in, encodebits * i, &type);
> -			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
> -				if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
> +			if (type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
> +				if (lo & Z_EROFS_LI_D0_CBLKCNT) {
>   					--i;
> -					nblk += lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
> +					nblk += lo & ~Z_EROFS_LI_D0_CBLKCNT;
>   					continue;
>   				}
> -				if (lo == 1) {
> +				if (lo <= 1) {
>   					DBG_BUGON(1);
>   					/* --i; ++nblk;	continue; */
>   					return -EFSCORRUPTED;
> @@ -289,7 +336,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>   	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
>   					   vi->xattr_isize, 8) +
>   		sizeof(struct z_erofs_map_header);
> -	const unsigned int totalidx = DIV_ROUND_UP(vi->i_size, EROFS_BLKSIZ);
> +	const unsigned int totalidx = BLK_ROUND_UP(vi->i_size);
>   	unsigned int compacted_4b_initial, compacted_2b;
>   	unsigned int amortizedshift;
>   	erofs_off_t pos;
> @@ -307,7 +354,8 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>   	if (compacted_4b_initial == 32 / 4)
>   		compacted_4b_initial = 0;
>   
> -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> +	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
> +	    compacted_4b_initial < totalidx)
>   		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
>   	else
>   		compacted_2b = 0;
> @@ -332,8 +380,7 @@ out:
>   	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
>   	if (err)
>   		return err;
> -	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos),
> -				      lookahead);
> +	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
>   }
>   
>   static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> @@ -341,10 +388,10 @@ static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>   {
>   	const unsigned int datamode = m->inode->datalayout;
>   
> -	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
> +	if (datamode == EROFS_INODE_COMPRESSED_FULL)
>   		return legacy_load_cluster_from_disk(m, lcn);
>   
> -	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
> +	if (datamode == EROFS_INODE_COMPRESSED_COMPACT)
>   		return compacted_load_cluster_from_disk(m, lcn, lookahead);
>   
>   	return -EINVAL;
> @@ -373,7 +420,7 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>   		return err;
>   
>   	switch (m->type) {
> -	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
> +	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>   		if (!m->delta[0]) {
>   			erofs_err("invalid lookback distance 0 @ nid %llu",
>   				  (unsigned long long)vi->nid);
> @@ -381,8 +428,8 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
>   			return -EFSCORRUPTED;
>   		}
>   		return z_erofs_extent_lookback(m, m->delta[0]);
> -	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
> +	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
>   		m->headtype = m->type;
>   		map->m_la = (lcn << lclusterbits) | m->clusterofs;
>   		break;
> @@ -404,16 +451,17 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>   	unsigned long lcn;
>   	int err;
>   
> -	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
> -		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
> -	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
> +	DBG_BUGON(m->type != Z_EROFS_LCLUSTER_TYPE_PLAIN &&
> +		  m->type != Z_EROFS_LCLUSTER_TYPE_HEAD1);
> +
> +	if (m->headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
>   	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
>   		map->m_plen = 1 << lclusterbits;
>   		return 0;
>   	}
>   
>   	lcn = m->lcn + 1;
> -	if (m->compressedlcs)
> +	if (m->compressedblks)
>   		goto out;
>   
>   	err = z_erofs_load_cluster_from_disk(m, lcn, false);
> @@ -422,28 +470,28 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>   
>   	/*
>   	 * If the 1st NONHEAD lcluster has already been handled initially w/o
> -	 * valid compressedlcs, which means at least it mustn't be CBLKCNT, or
> +	 * valid compressedblks, which means at least it mustn't be CBLKCNT, or
>   	 * an internal implemenatation error is detected.
>   	 *
>   	 * The following code can also handle it properly anyway, but let's
>   	 * BUG_ON in the debugging mode only for developers to notice that.
>   	 */
>   	DBG_BUGON(lcn == initial_lcn &&
> -		  m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD);
> +		  m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD);
>   
>   	switch (m->type) {
> -	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
> +	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
>   		/*
>   		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
>   		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
>   		 */
> -		m->compressedlcs = 1;
> +		m->compressedblks = 1 << (lclusterbits - sbi.blkszbits);
>   		break;
> -	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
> +	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>   		if (m->delta[0] != 1)
>   			goto err_bonus_cblkcnt;
> -		if (m->compressedlcs)
> +		if (m->compressedblks)
>   			break;
>   		/* fallthrough */
>   	default:
> @@ -453,7 +501,7 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>   		return -EFSCORRUPTED;
>   	}
>   out:
> -	map->m_plen = m->compressedlcs << lclusterbits;
> +	map->m_plen = m->compressedblks << sbi.blkszbits;
>   	return 0;
>   err_bonus_cblkcnt:
>   	erofs_err("bogus CBLKCNT @ lcn %lu of nid %llu",
> @@ -481,11 +529,11 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
>   		if (err)
>   			return err;
>   
> -		if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
> +		if (m->type == Z_EROFS_LCLUSTER_TYPE_NONHEAD) {
>   			DBG_BUGON(!m->delta[1] &&
>   				  m->clusterofs != 1 << lclusterbits);
> -		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
> -			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD) {
> +		} else if (m->type == Z_EROFS_LCLUSTER_TYPE_PLAIN ||
> +			   m->type == Z_EROFS_LCLUSTER_TYPE_HEAD1) {
>   			/* go on until the next HEAD lcluster */
>   			if (lcn != headlcn)
>   				break;
> @@ -504,10 +552,12 @@ static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
>   	return 0;
>   }
>   
> -int z_erofs_map_blocks_iter(struct erofs_inode *vi,
> -			    struct erofs_map_blocks *map,
> -			    int flags)
> +static int z_erofs_do_map_blocks(struct erofs_inode *vi,
> +				 struct erofs_map_blocks *map,
> +				 int flags)
>   {
> +	bool ztailpacking = vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER;
> +	bool fragment = vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
>   	struct z_erofs_maprecorder m = {
>   		.inode = vi,
>   		.map = map,
> @@ -518,20 +568,8 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
>   	unsigned long initial_lcn;
>   	unsigned long long ofs, end;
>   
> -	/* when trying to read beyond EOF, leave it unmapped */
> -	if (map->m_la >= vi->i_size) {
> -		map->m_llen = map->m_la + 1 - vi->i_size;
> -		map->m_la = vi->i_size;
> -		map->m_flags = 0;
> -		goto out;
> -	}
> -
> -	err = z_erofs_fill_inode_lazy(vi);
> -	if (err)
> -		goto out;
> -
>   	lclusterbits = vi->z_logical_clusterbits;
> -	ofs = map->m_la;
> +	ofs = flags & EROFS_GET_BLOCKS_FINDTAIL ? vi->i_size - 1 : map->m_la;
>   	initial_lcn = ofs >> lclusterbits;
>   	endoff = ofs & ((1 << lclusterbits) - 1);
>   
> @@ -539,11 +577,14 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
>   	if (err)
>   		goto out;
>   
> +	if (ztailpacking && (flags & EROFS_GET_BLOCKS_FINDTAIL))
> +		vi->z_idataoff = m.nextpackoff;
> +
>   	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
>   	end = (m.lcn + 1ULL) << lclusterbits;
>   	switch (m.type) {
> -	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
> -	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
> +	case Z_EROFS_LCLUSTER_TYPE_PLAIN:
> +	case Z_EROFS_LCLUSTER_TYPE_HEAD1:
>   		if (endoff >= m.clusterofs) {
>   			m.headtype = m.type;
>   			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
> @@ -560,7 +601,7 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
>   		map->m_flags |= EROFS_MAP_FULL_MAPPED;
>   		m.delta[0] = 1;
>   		/* fallthrough */
> -	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
> +	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
>   		/* get the correspoinding first chunk */
>   		err = z_erofs_extent_lookback(&m, m.delta[0]);
>   		if (err)
> @@ -572,18 +613,43 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
>   		err = -EOPNOTSUPP;
>   		goto out;
>   	}
> -
> +	if (m.partialref)
> +		map->m_flags |= EROFS_MAP_PARTIAL_REF;
>   	map->m_llen = end - map->m_la;
> -	map->m_pa = blknr_to_addr(m.pblk);
> -
> -	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
> -	if (err)
> -		goto out;
> +	if (flags & EROFS_GET_BLOCKS_FINDTAIL) {
> +		vi->z_tailextent_headlcn = m.lcn;
> +		/* for non-compact indexes, fragmentoff is 64 bits */
> +		if (fragment && vi->datalayout == EROFS_INODE_COMPRESSED_FULL)
> +			vi->fragmentoff |= (u64)m.pblk << 32;
> +	}
> +	if (ztailpacking && m.lcn == vi->z_tailextent_headlcn) {
> +		map->m_flags |= EROFS_MAP_META;
> +		map->m_pa = vi->z_idataoff;
> +		map->m_plen = vi->z_idata_size;
> +	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
> +		map->m_flags |= EROFS_MAP_FRAGMENT;
> +	} else {
> +		map->m_pa = erofs_pos(m.pblk);
> +		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
> +		if (err)
> +			goto out;
> +	}
>   
> -	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
> -		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
> -	else
> +	if (m.headtype == Z_EROFS_LCLUSTER_TYPE_PLAIN) {
> +		if (map->m_llen > map->m_plen) {
> +			DBG_BUGON(1);
> +			err = -EFSCORRUPTED;
> +			goto out;
> +		}
> +		if (vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
> +			map->m_algorithmformat =
> +				Z_EROFS_COMPRESSION_INTERLACED;
> +		else
> +			map->m_algorithmformat =
> +				Z_EROFS_COMPRESSION_SHIFTED;
> +	} else {
>   		map->m_algorithmformat = vi->z_algorithmtype[0];
> +	}
>   
>   	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
>   		err = z_erofs_get_extent_decompressedlen(&m);
> @@ -595,7 +661,38 @@ out:
>   	erofs_dbg("m_la %" PRIu64 " m_pa %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64 " m_flags 0%o",
>   		  map->m_la, map->m_pa,
>   		  map->m_llen, map->m_plen, map->m_flags);
> +	return err;
> +}
>   
> +int z_erofs_map_blocks_iter(struct erofs_inode *vi,
> +			    struct erofs_map_blocks *map,
> +			    int flags)
> +{
> +	int err = 0;
> +
> +	/* when trying to read beyond EOF, leave it unmapped */
> +	if (map->m_la >= vi->i_size) {
> +		map->m_llen = map->m_la + 1 - vi->i_size;
> +		map->m_la = vi->i_size;
> +		map->m_flags = 0;
> +		goto out;
> +	}
> +
> +	err = z_erofs_fill_inode_lazy(vi);
> +	if (err)
> +		goto out;
> +
> +	if ((vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER) &&
> +	    !vi->z_tailextent_headlcn) {
> +		map->m_la = 0;
> +		map->m_llen = vi->i_size;
> +		map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_FULL_MAPPED |
> +				EROFS_MAP_FRAGMENT;
> +		goto out;
> +	}
> +
> +	err = z_erofs_do_map_blocks(vi, map, flags);
> +out:
>   	DBG_BUGON(err < 0 && err != -ENOMEM);
>   	return err;
>   }
