Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C234B612
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 11:22:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6vz15FpLz30Bk
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 21:22:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KX45BgEi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KX45BgEi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=KX45BgEi; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KX45BgEi; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6vz012c5z309j
 for <linux-erofs@lists.ozlabs.org>; Sat, 27 Mar 2021 21:22:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616840520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iohr6m49kXpruLbyu6Jjrq1tJB8EijNtO1XFnYRAYkA=;
 b=KX45BgEiV5MxQjVsB0/9J4B7MD8or9wq/NDBISlqcfLuTWN7VL8jb2cPdQxhZEo/pEghYn
 9/X6O3XPrjIMA+orovvomn3UHiC7HFR1d8Y8Pxf38NbisvOjL6Qu15+iL1xQbQneshtVxO
 0O16QxtF5AJZoQZwiPTWzHDkG9p9wv8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616840520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iohr6m49kXpruLbyu6Jjrq1tJB8EijNtO1XFnYRAYkA=;
 b=KX45BgEiV5MxQjVsB0/9J4B7MD8or9wq/NDBISlqcfLuTWN7VL8jb2cPdQxhZEo/pEghYn
 9/X6O3XPrjIMA+orovvomn3UHiC7HFR1d8Y8Pxf38NbisvOjL6Qu15+iL1xQbQneshtVxO
 0O16QxtF5AJZoQZwiPTWzHDkG9p9wv8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-9iZDYcxCODiLtnC1ss_qnA-1; Sat, 27 Mar 2021 06:20:47 -0400
X-MC-Unique: 9iZDYcxCODiLtnC1ss_qnA-1
Received: by mail-pl1-f198.google.com with SMTP id w11so2481092plg.20
 for <linux-erofs@lists.ozlabs.org>; Sat, 27 Mar 2021 03:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Iohr6m49kXpruLbyu6Jjrq1tJB8EijNtO1XFnYRAYkA=;
 b=rz2+Ct5qxd2I8RKA31X5fZyopRKosaJsag2TVxD+Ke6+2HEVvjSo77XSXmj3nTtbST
 2qtVk/KuZlSO4naodiLbSDRTZloKB0aNH8S4QMyFJ2e0cB3u/MD3LfGYBXtRJdhXn0/v
 4kl2U2XIfnFoF3072NoJqP8rsxdfJHgCFEe8Bsc7OZjboyMn5XEK7DODkIrtIKZmd6nm
 hDfdvtXtwVJfxTuUP7UNSEwBIEVaKsOgHDvY6wqchDAvqk06hZ7LguQBqfqRoPm0ggoq
 Y+Pg/4G35r7LF/0R/kcWaneYJvdj9P3uWu8yWkg9TOtN1V1xyIqQEktD131FiDzbs4WQ
 KRyw==
X-Gm-Message-State: AOAM532avk2NwT8rWEygAVfhW6BFJeDNLwYfv9FGThXJOyjPGbNsjogy
 d9JQHVU8qC0qwyxBosU3oV1hm2yN4Ue/LgPtppknurW/52CdzUQr//hEyADl5nnD72/K1Qg1b3Z
 088O+ZhR0D1dH5url43Gpf1h7
X-Received: by 2002:a17:90a:5d10:: with SMTP id
 s16mr17940384pji.126.1616840446513; 
 Sat, 27 Mar 2021 03:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylMuo26yauvlRzltRPYVWiF63PKE/EzgtsMieWbTzfxUNaiOYW3vspNONHDCz0l5pdB9TZ9Q==
X-Received: by 2002:a17:90a:5d10:: with SMTP id
 s16mr17940369pji.126.1616840446262; 
 Sat, 27 Mar 2021 03:20:46 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z1sm11802846pfn.127.2021.03.27.03.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Mar 2021 03:20:46 -0700 (PDT)
Date: Sat, 27 Mar 2021 18:20:35 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 4/4] erofs: add on-disk compression configurations
Message-ID: <20210327102035.GC2995728@xiangao.remote.csb>
References: <20210327034936.12537-1-hsiangkao@aol.com>
 <20210327034936.12537-5-hsiangkao@aol.com>
 <7a2b76ff-f86f-79ce-d6e9-f8c359f90ae4@huawei.com>
MIME-Version: 1.0
In-Reply-To: <7a2b76ff-f86f-79ce-d6e9-f8c359f90ae4@huawei.com>
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

On Sat, Mar 27, 2021 at 05:46:44PM +0800, Chao Yu wrote:
> On 2021/3/27 11:49, Gao Xiang wrote:
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
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> > ---
> >   fs/erofs/decompressor.c |   2 +-
> >   fs/erofs/erofs_fs.h     |  16 +++--
> >   fs/erofs/internal.h     |   5 +-
> >   fs/erofs/super.c        | 145 +++++++++++++++++++++++++++++++++++++++-
> >   4 files changed, 161 insertions(+), 7 deletions(-)
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
> > index 1322ae63944b..ef3f8a99aa5f 100644
> > --- a/fs/erofs/erofs_fs.h
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -18,15 +18,18 @@
> >    * be incompatible with this kernel version.
> >    */
> >   #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
> > -#define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> > +#define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
> > +#define EROFS_ALL_FEATURE_INCOMPAT		\
> > +	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
> > +	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS)
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
> > @@ -39,7 +42,11 @@ struct erofs_super_block {
> >   	__u8 uuid[16];          /* 128-bit uuid for volume */
> >   	__u8 volume_name[16];   /* volume name */
> >   	__le32 feature_incompat;
> > -	__le16 lz4_max_distance;
> > +	union {
> > +		/* bitmap for available compression algorithms */
> > +		__le16 available_compr_algs;
> > +		__le16 lz4_max_distance;
> > +	} __packed u1;
> >   	__u8 reserved2[42];
> >   };
> > @@ -195,6 +202,7 @@ enum {
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
> > index 1ca8da3f2125..c5e3039f51bf 100644
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
> 
> Caller expects valid page w/o kmapped or a NULL page, right? it needs
> to call kunmap() here? or out label can be relocated above kunmap()?

Yeah, I misplaced it by mistake, thanks for pointing out!

Thanks,
Gao Xiang

> 
> Thanks,
>

