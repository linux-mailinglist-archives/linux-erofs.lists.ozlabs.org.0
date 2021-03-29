Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E273234C3EA
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 08:36:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F82t96FF4z2xZ3
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 17:36:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C5DoALe8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C5DoALe8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=C5DoALe8; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=C5DoALe8; 
 dkim-atps=neutral
X-Greylist: delayed 159353 seconds by postgrey-1.36 at boromir;
 Mon, 29 Mar 2021 17:36:48 AEDT
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F82t82P15z2xYb
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Mar 2021 17:36:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616999802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9U3H6/jAz8O2em5ZXPRQTmJ1QVy9Gb3oXtroGsX95Ps=;
 b=C5DoALe8x7yoXbt9Kdl0wwIfXND/S3UZtsgkylrfKg1mWFYnkTl0WqCa6is8XwfojQh2Xn
 T/5kRxk8/qedyUtnACHiOsuMaE0nWscya9L9sRCeQauhoDRkmMnPKdrq5eVg2kDuz8Kw4a
 txyloikvzsJt354Ojo4mOwy3fJ+GrhY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616999802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9U3H6/jAz8O2em5ZXPRQTmJ1QVy9Gb3oXtroGsX95Ps=;
 b=C5DoALe8x7yoXbt9Kdl0wwIfXND/S3UZtsgkylrfKg1mWFYnkTl0WqCa6is8XwfojQh2Xn
 T/5kRxk8/qedyUtnACHiOsuMaE0nWscya9L9sRCeQauhoDRkmMnPKdrq5eVg2kDuz8Kw4a
 txyloikvzsJt354Ojo4mOwy3fJ+GrhY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-gD12GTSyOIOtrmtvu2K6Ag-1; Mon, 29 Mar 2021 02:36:37 -0400
X-MC-Unique: gD12GTSyOIOtrmtvu2K6Ag-1
Received: by mail-pf1-f197.google.com with SMTP id u16so2678533pfh.20
 for <linux-erofs@lists.ozlabs.org>; Sun, 28 Mar 2021 23:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9U3H6/jAz8O2em5ZXPRQTmJ1QVy9Gb3oXtroGsX95Ps=;
 b=NunyV2nTV8wjL3aRlYWS/YNkmkziPllS5Usr7fqPuETCz6Dtc5sMe1eXhC+qSqCYPS
 yFxS2QTg4UzNUAUazmdqhH05EXBQI9XVRmwsJvsp0098ytoRvZWKRt2CIW5zoSHh+2kJ
 iUfKZCIhXlALMOFm+7K9rSjgB0zj6it3KbVchbEphRePgEtvhEnfM+YIqn0OkYfePAw8
 SEzD5Fe8PwklG2RGy7W/6QfA7r5Sv1hm6vUNkrJDBtObOxWruFp8t6B1QaBMlkF2ECoS
 kQLATIzmKAvrS5aPfRDgrCW0y8gTb7IE2YQ1xUt9ub4a6zzonRK8m2n2glV1nk1P/i5O
 hPpw==
X-Gm-Message-State: AOAM5321TDNDQZ7eJoCOSD4CxatmbeiGj8a/4/qZgfCeyOvkImb45GXG
 KfwYS4WnmOhWwzS5aOXp2+ASYlW/XrgNbzvKMK1CZ+BI1iAcGBv2kDzc7gqYO4AYxvN4Xepkwql
 NoYMJuwFOuBXrKlJEG2HQEgjI
X-Received: by 2002:a17:90a:d3d1:: with SMTP id
 d17mr24572174pjw.21.1616999796748; 
 Sun, 28 Mar 2021 23:36:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo53EhIQ4WrpaWok0nTBh8a79hNyqcIjxwUXPwpNc4RWW6qCpRWGX4k24tCbk2sSFCqo37sw==
X-Received: by 2002:a17:90a:d3d1:: with SMTP id
 d17mr24572157pjw.21.1616999796452; 
 Sun, 28 Mar 2021 23:36:36 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d11sm14178817pjz.47.2021.03.28.23.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 23:36:35 -0700 (PDT)
Date: Mon, 29 Mar 2021 14:36:25 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2 4/4] erofs: add on-disk compression configurations
Message-ID: <20210329063625.GA3293200@xiangao.remote.csb>
References: <20210329012308.28743-1-hsiangkao@aol.com>
 <20210329012308.28743-5-hsiangkao@aol.com>
 <f24bd7dc-54c3-1c19-a461-97ddca778c06@huawei.com>
MIME-Version: 1.0
In-Reply-To: <f24bd7dc-54c3-1c19-a461-97ddca778c06@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Mon, Mar 29, 2021 at 02:26:05PM +0800, Chao Yu wrote:
> On 2021/3/29 9:23, Gao Xiang wrote:
> > From: Gao Xiang <hsiangkao@redhat.com>
> > 
> > Add a bitmap for available compression algorithms and a variable-sized
> > on-disk table for compression options in preparation for upcoming big
> > pcluster and LZMA algorithm, which follows the end of super block.
> > 
> > To parse the compression options, the bitmap is scanned one by one.
> > For each available algorithm, there is data followed by 2-byte `length'
> > correspondingly (it's enough for most cases, or entire fs blocks should
> > be used.)
> > 
> > With such available algorithm bitmap, kernel itself can also refuse to
> > mount such filesystem if any unsupported compression algorithm exists.
> > 
> > Note that COMPR_CFGS feature will be enabled with BIG_PCLUSTER.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> > ---
> >   fs/erofs/decompressor.c |   2 +-
> >   fs/erofs/erofs_fs.h     |  14 ++--
> >   fs/erofs/internal.h     |   5 +-
> >   fs/erofs/super.c        | 143 +++++++++++++++++++++++++++++++++++++++-
> >   4 files changed, 157 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index 97538ff24a19..27aa6a99b371 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -41,7 +41,7 @@ int z_erofs_load_lz4_config(struct super_block *sb,
> >   		}
> >   		distance = le16_to_cpu(lz4->max_distance);
> >   	} else {
> > -		distance = le16_to_cpu(dsb->lz4_max_distance);
> > +		distance = le16_to_cpu(dsb->u1.lz4_max_distance);
> >   	}
> >   	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
> > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> > index e0f3c0db1f82..5a126493d4d9 100644
> > --- a/fs/erofs/erofs_fs.h
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -18,15 +18,16 @@
> >    * be incompatible with this kernel version.
> >    */
> >   #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
> > +#define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
> >   #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> > -/* 128-byte erofs on-disk super block */
> > +/* erofs on-disk super block (currently 128 bytes) */
> >   struct erofs_super_block {
> >   	__le32 magic;           /* file system magic number */
> >   	__le32 checksum;        /* crc32c(super_block) */
> >   	__le32 feature_compat;
> >   	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
> > -	__u8 reserved;
> > +	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
> >   	__le16 root_nid;	/* nid of root directory */
> >   	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
> > @@ -39,8 +40,12 @@ struct erofs_super_block {
> >   	__u8 uuid[16];          /* 128-bit uuid for volume */
> >   	__u8 volume_name[16];   /* volume name */
> >   	__le32 feature_incompat;
> > -	/* customized lz4 sliding window size instead of 64k by default */
> > -	__le16 lz4_max_distance;
> > +	union {
> > +		/* bitmap for available compression algorithms */
> > +		__le16 available_compr_algs;
> > +		/* customized sliding window size instead of 64k by default */
> > +		__le16 lz4_max_distance;
> > +	} __packed u1;
> >   	__u8 reserved2[42];
> >   };
> > @@ -196,6 +201,7 @@ enum {
> >   	Z_EROFS_COMPRESSION_LZ4	= 0,
> >   	Z_EROFS_COMPRESSION_MAX
> >   };
> > +#define Z_EROFS_ALL_COMPR_ALGS		(1 << (Z_EROFS_COMPRESSION_MAX - 1))
> >   /* 14 bytes (+ length field = 16 bytes) */
> >   struct z_erofs_lz4_cfgs {
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index 46b977f348eb..f3fa895d809f 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -75,6 +75,7 @@ struct erofs_sb_info {
> >   	struct xarray managed_pslots;
> >   	unsigned int shrinker_run_no;
> > +	u16 available_compr_algs;
> >   	/* pseudo inode to manage cached pages */
> >   	struct inode *managed_cache;
> > @@ -90,6 +91,7 @@ struct erofs_sb_info {
> >   	/* inode slot unit size in bit shift */
> >   	unsigned char islotbits;
> > +	u32 sb_size;			/* total superblock size */
> >   	u32 build_time_nsec;
> >   	u64 build_time;
> > @@ -233,6 +235,7 @@ static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
> >   }
> >   EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
> > +EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
> >   EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
> >   /* atomic flag definitions */
> > @@ -454,7 +457,7 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
> >   				  struct erofs_super_block *dsb,
> >   				  struct z_erofs_lz4_cfgs *lz4, int len)
> >   {
> > -	if (lz4 || dsb->lz4_max_distance) {
> > +	if (lz4 || dsb->u1.lz4_max_distance) {
> >   		erofs_err(sb, "lz4 algorithm isn't enabled");
> >   		return -EINVAL;
> >   	}
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index 1ca8da3f2125..628c751634fe 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -122,6 +122,138 @@ static bool check_layout_compatibility(struct super_block *sb,
> >   	return true;
> >   }
> > +#ifdef CONFIG_EROFS_FS_ZIP
> > +/* read variable-sized metadata, offset will be aligned by 4-byte */
> > +static void *erofs_read_metadata(struct super_block *sb, struct page **pagep,
> > +				 erofs_off_t *offset, int *lengthp)
> > +{
> > +	struct page *page = *pagep;
> > +	u8 *buffer, *ptr;
> > +	int len, i, cnt;
> > +	erofs_blk_t blk;
> > +
> > +	*offset = round_up(*offset, 4);
> > +	blk = erofs_blknr(*offset);
> > +
> > +	if (!page || page->index != blk) {
> > +		if (page) {
> > +			unlock_page(page);
> > +			put_page(page);
> > +		}
> > +		page = erofs_get_meta_page(sb, blk);
> > +		if (IS_ERR(page))
> > +			goto err_nullpage;
> > +	}
> > +
> > +	ptr = kmap(page);
> > +	len = le16_to_cpu(*(__le16 *)&ptr[erofs_blkoff(*offset)]);
> > +	if (!len)
> > +		len = U16_MAX + 1;
> > +	buffer = kmalloc(len, GFP_KERNEL);
> > +	if (!buffer) {
> > +		buffer = ERR_PTR(-ENOMEM);
> > +		goto out;
> > +	}
> > +	*offset += sizeof(__le16);
> > +	*lengthp = len;
> > +
> > +	for (i = 0; i < len; i += cnt) {
> > +		cnt = min(EROFS_BLKSIZ - (int)erofs_blkoff(*offset), len - i);
> > +		blk = erofs_blknr(*offset);
> > +
> > +		if (!page || page->index != blk) {
> > +			if (page) {
> > +				kunmap(page);
> > +				unlock_page(page);
> > +				put_page(page);
> > +			}
> > +			page = erofs_get_meta_page(sb, blk);
> > +			if (IS_ERR(page)) {
> > +				kfree(buffer);
> > +				goto err_nullpage;
> > +			}
> > +			ptr = kmap(page);
> > +		}
> > +		memcpy(buffer + i, ptr + erofs_blkoff(*offset), cnt);
> > +		*offset += cnt;
> > +	}
> > +out:
> > +	kunmap(page);
> > +	*pagep = page;
> > +	return buffer;
> > +err_nullpage:
> > +	*pagep = NULL;
> > +	return page;
> > +}
> > +
> > +static int erofs_load_compr_cfgs(struct super_block *sb,
> > +				 struct erofs_super_block *dsb)
> > +{
> > +	struct erofs_sb_info *sbi;
> > +	struct page *page;
> > +	unsigned int algs, alg;
> > +	erofs_off_t offset;
> > +	int size, ret;
> > +
> > +	sbi = EROFS_SB(sb);
> > +	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
> > +
> > +	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
> > +		erofs_err(sb,
> > +"try to load compressed image with unsupported algorithms %x",
> 
> Minor style issue:
> 
> 			"try to load compressed image with unsupported "
> 			"algorithms %x",
> 			sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);

If I remembered correctly, kernel code style suggests "don't break the print
message, it'd more easy to grep". Actually such style above is from XFS, and
can pass checkpatch.pl check, see:

(fs/xfs/xfs_log_recover.c) xlog_recover():
		/*
		 * Version 5 superblock log feature mask validation. We know the
		 * log is dirty so check if there are any unknown log features
		 * in what we need to recover. If there are unknown features
		 * (e.g. unsupported transactions, then simply reject the
		 * attempt at recovery before touching anything.
		 */
		if (XFS_SB_VERSION_NUM(&log->l_mp->m_sb) == XFS_SB_VERSION_5 &&
		    xfs_sb_has_incompat_log_feature(&log->l_mp->m_sb,
					XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN)) {
			xfs_warn(log->l_mp,
"Superblock has unknown incompatible log features (0x%x) enabled.",
				(log->l_mp->m_sb.sb_features_log_incompat &
					XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN));
			xfs_warn(log->l_mp,
"The log can not be fully and/or safely recovered by this kernel.");
			xfs_warn(log->l_mp,
"Please recover the log on a kernel that supports the unknown features.");
			return -EINVAL;
		}

If that does't look ok for us, I could use > 80 line for this instead,
but I tend to not break the message ..

> 
> > +			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
> > +		return -EINVAL;
> > +	}
> > +
> > +	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
> > +	page = NULL;
> > +	alg = 0;
> > +	ret = 0;
> > +
> > +	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
> > +		void *data;
> > +
> > +		if (!(algs & 1))
> > +			continue;
> > +
> > +		data = erofs_read_metadata(sb, &page, &offset, &size);
> > +		if (IS_ERR(data)) {
> > +			ret = PTR_ERR(data);
> > +			goto err;
> > +		}
> > +
> > +		switch (alg) {
> > +		case Z_EROFS_COMPRESSION_LZ4:
> > +			ret = z_erofs_load_lz4_config(sb, dsb, data, size);
> > +			break;
> > +		default:
> > +			DBG_BUGON(1);
> > +			ret = -EFAULT;
> > +		}
> > +		kfree(data);
> > +		if (ret)
> > +			goto err;
> > +	}
> > +err:
> > +	if (page) {
> > +		unlock_page(page);
> > +		put_page(page);
> > +	}
> > +	return ret;
> > +}
> > +#else
> > +static int erofs_load_compr_cfgs(struct super_block *sb,
> > +				 struct erofs_super_block *dsb)
> > +{
> > +	if (dsb->u1.available_compr_algs) {
> > +		erofs_err(sb,
> > +"try to load compressed image when compression is disabled");
> 
> Ditto,
> 		erofs_err(sb, "try to load compressed image when "
> 			  "compression is disabled");
> 

The same above....

> 
> > +		return -EINVAL;
> > +	}
> > +	return 0;
> > +}
> > +#endif
> > +
> >   static int erofs_read_superblock(struct super_block *sb)
> >   {
> >   	struct erofs_sb_info *sbi;
> > @@ -166,6 +298,12 @@ static int erofs_read_superblock(struct super_block *sb)
> >   	if (!check_layout_compatibility(sb, dsb))
> >   		goto out;
> > +	sbi->sb_size = 128 + dsb->sb_extslots * 16;
> 
> 	sbi->sb_size = sizeof(struct erofs_super_block) +
> 			dsb->sb_extslots * EROFS_EXTSLOT_SIZE;
> 
> Otherwise it looks good to me,
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks for the review!

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > +	if (sbi->sb_size > EROFS_BLKSIZ) {
> > +		erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
> > +			  sbi->sb_size);
> > +		goto out;
> > +	}
> >   	sbi->blocks = le32_to_cpu(dsb->blocks);
> >   	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
> >   #ifdef CONFIG_EROFS_FS_XATTR
> > @@ -189,7 +327,10 @@ static int erofs_read_superblock(struct super_block *sb)
> >   	}
> >   	/* parse on-disk compression configurations */
> > -	ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
> > +	if (erofs_sb_has_compr_cfgs(sbi))
> > +		ret = erofs_load_compr_cfgs(sb, dsb);
> > +	else
> > +		ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
> >   out:
> >   	kunmap(page);
> >   	put_page(page);
> > 
> 

