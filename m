Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F055C5BA8FA
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 11:09:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MTStN4p0Rz3blQ
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Sep 2022 19:09:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54; helo=out30-54.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MTStK6Fpgz2xH9
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Sep 2022 19:08:57 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VPwhIS5_1663319332;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VPwhIS5_1663319332)
          by smtp.aliyun-inc.com;
          Fri, 16 Sep 2022 17:08:54 +0800
Date: Fri, 16 Sep 2022 17:08:51 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [RFC PATCH v4 2/2] erofs: support on-disk compressed fragments
 data
Message-ID: <YyQ9I5aJh/acVbjD@B-P7TQMD6M-0146.local>
References: <cover.1663066966.git.huyue2@coolpad.com>
 <6ded0c212d7da65b70c853fd04f21da229cdefb1.1663066966.git.huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ded0c212d7da65b70c853fd04f21da229cdefb1.1663066966.git.huyue2@coolpad.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Sep 13, 2022 at 07:05:52PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Introduce on-disk compressed fragments data feature.
> 
> This approach adds a new field called `h_fragmentoff' in the per-file
> compression header to indicate the fragment offset of each tail pcluster
> or the whole file in the special packed inode.
> 
> Similar to ztailpacking, it will also find and record the 'headlcn'
> of the tail pcluster when initializing per-inode zmap for making
> follow-on requests more easy.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>  fs/erofs/erofs_fs.h | 29 +++++++++++++++++++++------
>  fs/erofs/internal.h | 16 ++++++++++++---
>  fs/erofs/super.c    | 15 ++++++++++++++
>  fs/erofs/sysfs.c    |  2 ++
>  fs/erofs/zdata.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++-
>  fs/erofs/zmap.c     | 48 +++++++++++++++++++++++++++++++++++++++++++--
>  6 files changed, 146 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 5c1de6d7ad71..aa976757328b 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -25,6 +25,7 @@
>  #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
>  #define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
>  #define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
> +#define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
>  #define EROFS_ALL_FEATURE_INCOMPAT		\
>  	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
>  	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
> @@ -32,7 +33,8 @@
>  	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
>  	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
>  	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2 | \
> -	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
> +	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
> +	 EROFS_FEATURE_INCOMPAT_FRAGMENTS)
>  
>  #define EROFS_SB_EXTSLOT_SIZE	16
>  
> @@ -71,7 +73,9 @@ struct erofs_super_block {
>  	} __packed u1;
>  	__le16 extra_devices;	/* # of devices besides the primary device */
>  	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
> -	__u8 reserved2[38];
> +	__u8 reserved[6];
> +	__le64 packed_nid;	/* nid of the special packed inode */
> +	__u8 reserved2[24];
>  };
>  
>  /*
> @@ -296,17 +300,26 @@ struct z_erofs_lzma_cfgs {
>   * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
>   * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
>   * bit 4 : interlaced plain pcluster (0 - off; 1 - on)
> + * bit 5 : fragment pcluster (0 - off; 1 - on)
>   */
>  #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
>  #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
>  #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
>  #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
>  #define Z_EROFS_ADVISE_INTERLACED_PCLUSTER	0x0010
> +#define Z_EROFS_ADVISE_FRAGMENT_PCLUSTER	0x0020
>  
> +#define Z_EROFS_FRAGMENT_INODE_BIT              7
>  struct z_erofs_map_header {
> -	__le16	h_reserved1;
> -	/* indicates the encoded size of tailpacking data */
> -	__le16  h_idata_size;
> +	union {
> +		/* fragment data offset in the packed inode */
> +		__le32  h_fragmentoff;
> +		struct {
> +			__le16  h_reserved1;
> +			/* indicates the encoded size of tailpacking data */
> +			__le16  h_idata_size;
> +		};
> +	};
>  	__le16	h_advise;
>  	/*
>  	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
> @@ -315,7 +328,8 @@ struct z_erofs_map_header {
>  	__u8	h_algorithmtype;
>  	/*
>  	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
> -	 * bit 3-7 : reserved.
> +	 * bit 3-6 : reserved;
> +	 * bit 7   : move the whole file into packed inode or not.
>  	 */
>  	__u8	h_clusterbits;
>  };
> @@ -421,6 +435,9 @@ static inline void erofs_check_ondisk_layout_definitions(void)
>  
>  	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
>  		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
> +	WARN_ON(*(__le64 *)&(struct z_erofs_map_header) {
> +			.h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT
> +		} != cpu_to_le64(1ULL << 63));

why not BUILD_BUG_ON here?

>  }
>  
>  #endif
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index f3ed36445d73..b133664b4ad2 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -120,6 +120,7 @@ struct erofs_sb_info {
>  	struct inode *managed_cache;
>  
>  	struct erofs_sb_lz4_info lz4;
> +	struct inode *packed_inode;
>  #endif	/* CONFIG_EROFS_FS_ZIP */
>  	struct erofs_dev_context *devs;
>  	struct dax_device *dax_dev;
> @@ -306,6 +307,7 @@ EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
>  EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
>  EROFS_FEATURE_FUNCS(compr_head2, incompat, INCOMPAT_COMPR_HEAD2)
>  EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
> +EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
>  EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
>  
>  /* atomic flag definitions */
> @@ -341,8 +343,13 @@ struct erofs_inode {
>  			unsigned char  z_algorithmtype[2];
>  			unsigned char  z_logical_clusterbits;
>  			unsigned long  z_tailextent_headlcn;
> -			erofs_off_t    z_idataoff;
> -			unsigned short z_idata_size;
> +			union {
> +				struct {
> +					erofs_off_t    z_idataoff;
> +					unsigned short z_idata_size;
> +				};
> +				erofs_off_t z_fragmentoff;
> +			};
>  		};
>  #endif	/* CONFIG_EROFS_FS_ZIP */
>  	};
> @@ -400,6 +407,7 @@ extern const struct address_space_operations z_erofs_aops;
>  enum {
>  	BH_Encoded = BH_PrivateStart,
>  	BH_FullMapped,
> +	BH_Fragment,
>  };
>  
>  /* Has a disk mapping */
> @@ -410,6 +418,8 @@ enum {
>  #define EROFS_MAP_ENCODED	(1 << BH_Encoded)
>  /* The length of extent is full */
>  #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
> +/* Located in the special packed inode */
> +#define EROFS_MAP_FRAGMENT	(1 << BH_Fragment)
>  
>  struct erofs_map_blocks {
>  	struct erofs_buf buf;
> @@ -431,7 +441,7 @@ struct erofs_map_blocks {
>  #define EROFS_GET_BLOCKS_FIEMAP	0x0002
>  /* Used to map the whole extent if non-negligible data is requested for LZMA */
>  #define EROFS_GET_BLOCKS_READMORE	0x0004
> -/* Used to map tail extent for tailpacking inline pcluster */
> +/* Used to map tail extent for tailpacking inline or fragment pcluster */
>  #define EROFS_GET_BLOCKS_FINDTAIL	0x0008
>  
>  enum {
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 3173debeaa5a..8170c0d8ab92 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -381,6 +381,17 @@ static int erofs_read_superblock(struct super_block *sb)
>  #endif
>  	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
>  	sbi->root_nid = le16_to_cpu(dsb->root_nid);
> +#ifdef CONFIG_EROFS_FS_ZIP
> +	sbi->packed_inode = NULL;
> +	if (erofs_sb_has_fragments(sbi)) {
> +		sbi->packed_inode =
> +			erofs_iget(sb, le64_to_cpu(dsb->packed_nid), false);
> +		if (IS_ERR(sbi->packed_inode)) {
> +			ret = PTR_ERR(sbi->packed_inode);
> +			goto out;
> +		}
> +	}
> +#endif
>  	sbi->inos = le64_to_cpu(dsb->inos);
>  
>  	sbi->build_time = le64_to_cpu(dsb->build_time);
> @@ -411,6 +422,8 @@ static int erofs_read_superblock(struct super_block *sb)
>  		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
>  	if (erofs_is_fscache_mode(sb))
>  		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
> +	if (erofs_sb_has_fragments(sbi))
> +		erofs_info(sb, "EXPERIMENTAL compressed fragments feature in use. Use at your own risk!");
>  out:
>  	erofs_put_metabuf(&buf);
>  	return ret;
> @@ -908,6 +921,8 @@ static void erofs_put_super(struct super_block *sb)
>  #ifdef CONFIG_EROFS_FS_ZIP
>  	iput(sbi->managed_cache);
>  	sbi->managed_cache = NULL;
> +	iput(sbi->packed_inode);
> +	sbi->packed_inode = NULL;
>  #endif
>  	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>  }
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index c1383e508bbe..1b52395be82a 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -76,6 +76,7 @@ EROFS_ATTR_FEATURE(device_table);
>  EROFS_ATTR_FEATURE(compr_head2);
>  EROFS_ATTR_FEATURE(sb_chksum);
>  EROFS_ATTR_FEATURE(ztailpacking);
> +EROFS_ATTR_FEATURE(fragments);
>  
>  static struct attribute *erofs_feat_attrs[] = {
>  	ATTR_LIST(zero_padding),
> @@ -86,6 +87,7 @@ static struct attribute *erofs_feat_attrs[] = {
>  	ATTR_LIST(compr_head2),
>  	ATTR_LIST(sb_chksum),
>  	ATTR_LIST(ztailpacking),
> +	ATTR_LIST(fragments),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(erofs_feat);
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 5792ca9e0d5e..aa2a3cdeea57 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -650,6 +650,33 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
>  		la < fe->headoffset;
>  }
>  
> +static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
> +				 struct page *page, unsigned int pageofs,
> +				 unsigned int len)
> +{
> +	struct inode *packed_inode = EROFS_I_SB(inode)->packed_inode;
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> +	u8 *src, *dst;
> +	unsigned int i, cnt;
> +
> +	pos += EROFS_I(inode)->z_fragmentoff;
> +	for (i = 0; i < len; i += cnt) {
> +		cnt = min_t(unsigned int, len - i,
> +			    EROFS_BLKSIZ - erofs_blkoff(pos));
> +		src = erofs_bread(&buf, packed_inode,
> +				  erofs_blknr(pos), EROFS_KMAP);
> +		if (IS_ERR(src))

			^
			need to erofs_put_metabuf() here anyway?

> +			return PTR_ERR(src);
> +
> +		dst = kmap_local_page(page);
> +		memcpy(dst + pageofs + i, src + erofs_blkoff(pos), cnt);
> +		kunmap_local(dst);
> +		pos += cnt;
> +	}
> +	erofs_put_metabuf(&buf);
> +	return 0;
> +}

Thanks,
Gao Xiang
