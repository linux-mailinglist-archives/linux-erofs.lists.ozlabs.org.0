Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BE95A0B66
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Aug 2022 10:26:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MCwzW0x4zz3bf5
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Aug 2022 18:26:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=i+mbtR5m;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=i+mbtR5m;
	dkim-atps=neutral
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MCwzN5M5Zz2xGt
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Aug 2022 18:26:23 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id c24so17242728pgg.11
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Aug 2022 01:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=insU4wk9QzLv3XuEg5ohlaO5trMh0Ju2twU+9zeB2ek=;
        b=i+mbtR5mlO8rKcETXrmqxyoPDaiSSBQBuDHMrR1eKKN46+337WYHa7tuAvcl6l+hkk
         jBB1mPw4UQSfrdYXB/6ir/bMiNSa8nMO6qMB52g+wqfYmPQEi40QvbJ4XErmK2/LAIop
         jXwO9cKAsGqDwD5axCruCLVra6Kd2VhA/0VuhSClGioeYEFf8UgDAVrNk8msG+tUqcjd
         UovM2RYEUl6loemPD2uzVjgKWLgAj07Ih3nAGod8sxm8+zxRnkrBD4UGWs1HQOY4VYAb
         F3SBV3tuAZyeZnBdijl0EVkUB2hkSC2ULMYCS74U37CsRfGkeV9bvnMptJkVO8SGTMyH
         aYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=insU4wk9QzLv3XuEg5ohlaO5trMh0Ju2twU+9zeB2ek=;
        b=j7r++7JL2+j4FZthOMAZ8rI1HrGB27lwcA6n+JoO3JZO9bC2QSb9rMvEaDwYZ+lpaF
         OdQGaAewq8gqZDN6uZ23qK7nddzJPrQMFTKLGhQv1+rvSlIrYu+gUhke+yKLEqYXIqYK
         wwT7W4nd5+rfg3Op2aG+unROCxKCtLUgaxiGJnnZBKQdaYann1b+Bt77tBllY119jiBp
         tLzsKZUmA/mnHhpd6fIekA7zqVWIrGwObtb2UgH2n68QYnYm1MYL8zWCYqhaStVnqjD4
         BSmkCIgpQyUHPDA+bGg/7fsNo8fmoXwQ0ugydfdvZmcqBRNZy5x87yTwm5W2XZWeT+Yk
         CDAA==
X-Gm-Message-State: ACgBeo0qmv2i5tk3foLgCre7oxQrYdRROQwUASngX8S3nr2ZQMDph9lR
	gGplY1HiMmiEabM2gPqVZUSag3eRTWE=
X-Google-Smtp-Source: AA6agR4TO/iZeKnHz/WUPlUyLPgs5g93WzsV89wMI73OkzUE/cigFA3CKu2UkSkx5ceIDpOjx99LEQ==
X-Received: by 2002:a63:e242:0:b0:421:9053:8923 with SMTP id y2-20020a63e242000000b0042190538923mr2322526pgj.283.1661415980398;
        Thu, 25 Aug 2022 01:26:20 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902f65100b0016f1319d2aasm13954053plg.171.2022.08.25.01.26.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Aug 2022 01:26:20 -0700 (PDT)
Date: Thu, 25 Aug 2022 16:28:31 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH 2/2] erofs: add on-disk compressed fragments support
Message-ID: <20220825162831.00000e05.zbestahu@gmail.com>
In-Reply-To: <YwbrQF315/Sh41/D@B-P7TQMD6M-0146.local>
References: <cover.1661146058.git.huyue2@coolpad.com>
	<b087322de2adfd8ce39a5d380191562b0b0e0086.1661146058.git.huyue2@coolpad.com>
	<YwbrQF315/Sh41/D@B-P7TQMD6M-0146.local>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 25 Aug 2022 11:23:44 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Mon, Aug 22, 2022 at 01:53:01PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > Introduce on-disk compressed fragments feature.
> > 
> > This approach adds a new field called `h_fragmentoff' in the per-file
> > compression header to indicate the fragment offset of each tail pcluster
> > or the whole file in the special packed inode.
> > 
> > Like ztailpacking, it will also find and record the 'headlcn' of the
> > tail pcluster when initializing per-inode zmap for making follow-on
> > requests more easy.
> > 
> > Moreover, enable the offset for shifted decompression since we are
> > writing from 'pageofs_ofs' when compressing if this feature is used.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> >  fs/erofs/decompressor.c |  4 +--
> >  fs/erofs/erofs_fs.h     | 26 ++++++++++++++-----
> >  fs/erofs/internal.h     | 16 +++++++++---
> >  fs/erofs/super.c        |  6 +++++
> >  fs/erofs/sysfs.c        |  2 ++
> >  fs/erofs/zdata.c        | 55 ++++++++++++++++++++++++++++++++++++++++-
> >  fs/erofs/zmap.c         | 40 +++++++++++++++++++++++++++---
> >  7 files changed, 133 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index dc02d95b52d7..fe4a34ac2de7 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -338,8 +338,8 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
> >  		return 0;
> >  	}
> >  
> > -	/* set it to pageofs_out if fragments feature is used */
> > -	headofs_in = 0;
> > +	headofs_in = !erofs_sb_has_fragments(EROFS_SB(rq->sb)) ? 0 :  
> 
> Same as I pointed out in the erofs-utils series.

I will update in v2.

> 
> > +		     rq->pageofs_out;
> >  
> >  	src = kmap_atomic(*rq->in) + rq->pageofs_in;
> >  	if (rq->out[0]) {
> > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> > index 2b48373f690b..3306cca5f03b 100644
> > --- a/fs/erofs/erofs_fs.h
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -25,6 +25,7 @@
> >  #define EROFS_FEATURE_INCOMPAT_DEVICE_TABLE	0x00000008
> >  #define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
> >  #define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
> > +#define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
> >  #define EROFS_ALL_FEATURE_INCOMPAT		\
> >  	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
> >  	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
> > @@ -32,7 +33,8 @@
> >  	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
> >  	 EROFS_FEATURE_INCOMPAT_DEVICE_TABLE | \
> >  	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2 | \
> > -	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING)
> > +	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
> > +	 EROFS_FEATURE_INCOMPAT_FRAGMENTS)
> >  
> >  #define EROFS_SB_EXTSLOT_SIZE	16
> >  
> > @@ -71,7 +73,9 @@ struct erofs_super_block {
> >  	} __packed u1;
> >  	__le16 extra_devices;	/* # of devices besides the primary device */
> >  	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
> > -	__u8 reserved2[38];
> > +	__u8 reserved[6];
> > +	__le64 packed_nid;	/* nid of the special packed inode */
> > +	__u8 reserved2[24];
> >  };
> >  
> >  /*
> > @@ -295,16 +299,25 @@ struct z_erofs_lzma_cfgs {
> >   * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
> >   * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
> >   * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
> > + * bit 4 : fragment pcluster (0 - off; 1 - on)
> >   */
> >  #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
> >  #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
> >  #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
> >  #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
> > +#define Z_EROFS_ADVISE_FRAGMENT_PCLUSTER	0x0010
> >  
> > +#define Z_EROFS_FRAGMENT_INODE_BIT              7
> >  struct z_erofs_map_header {
> > -	__le16	h_reserved1;
> > -	/* indicates the encoded size of tailpacking data */
> > -	__le16  h_idata_size;
> > +	union {
> > +		/* direct addressing for fragment offset */
> > +		__le32  h_fragmentoff;
> > +		struct {
> > +			__le16  h_reserved1;
> > +			/* indicates the encoded size of tailpacking data */
> > +			__le16  h_idata_size;
> > +		};
> > +	};
> >  	__le16	h_advise;
> >  	/*
> >  	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
> > @@ -313,7 +326,8 @@ struct z_erofs_map_header {
> >  	__u8	h_algorithmtype;
> >  	/*
> >  	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
> > -	 * bit 3-7 : reserved.
> > +	 * bit 3-6 : reserved;
> > +	 * bit 7   : move the whole file into packed inode or not.
> >  	 */
> >  	__u8	h_clusterbits;
> >  };
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index cfee49d33b95..7b9d31bab928 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -120,6 +120,7 @@ struct erofs_sb_info {
> >  	struct inode *managed_cache;
> >  
> >  	struct erofs_sb_lz4_info lz4;
> > +	struct inode *packed_inode;
> >  #endif	/* CONFIG_EROFS_FS_ZIP */
> >  	struct erofs_dev_context *devs;
> >  	struct dax_device *dax_dev;
> > @@ -306,6 +307,7 @@ EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
> >  EROFS_FEATURE_FUNCS(device_table, incompat, INCOMPAT_DEVICE_TABLE)
> >  EROFS_FEATURE_FUNCS(compr_head2, incompat, INCOMPAT_COMPR_HEAD2)
> >  EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
> > +EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
> >  EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
> >  
> >  /* atomic flag definitions */
> > @@ -341,8 +343,13 @@ struct erofs_inode {
> >  			unsigned char  z_algorithmtype[2];
> >  			unsigned char  z_logical_clusterbits;
> >  			unsigned long  z_tailextent_headlcn;
> > -			erofs_off_t    z_idataoff;
> > -			unsigned short z_idata_size;
> > +			union {
> > +				struct {
> > +					erofs_off_t    z_idataoff;
> > +					unsigned short z_idata_size;
> > +				};
> > +				erofs_off_t z_fragmentoff;
> > +			};
> >  		};
> >  #endif	/* CONFIG_EROFS_FS_ZIP */
> >  	};
> > @@ -400,6 +407,7 @@ extern const struct address_space_operations z_erofs_aops;
> >  enum {
> >  	BH_Encoded = BH_PrivateStart,
> >  	BH_FullMapped,
> > +	BH_Fragment,
> >  };
> >  
> >  /* Has a disk mapping */
> > @@ -410,6 +418,8 @@ enum {
> >  #define EROFS_MAP_ENCODED	(1 << BH_Encoded)
> >  /* The length of extent is full */
> >  #define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
> > +/* Located in the special packed inode */
> > +#define EROFS_MAP_FRAGMENT	(1 << BH_Fragment)
> >  
> >  struct erofs_map_blocks {
> >  	struct erofs_buf buf;
> > @@ -431,7 +441,7 @@ struct erofs_map_blocks {
> >  #define EROFS_GET_BLOCKS_FIEMAP	0x0002
> >  /* Used to map the whole extent if non-negligible data is requested for LZMA */
> >  #define EROFS_GET_BLOCKS_READMORE	0x0004
> > -/* Used to map tail extent for tailpacking inline pcluster */
> > +/* Used to map tail extent for tailpacking inline or fragment pcluster */
> >  #define EROFS_GET_BLOCKS_FINDTAIL	0x0008
> >  
> >  enum {
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index 3173debeaa5a..fde5ece36b2c 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -381,6 +381,8 @@ static int erofs_read_superblock(struct super_block *sb)
> >  #endif
> >  	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
> >  	sbi->root_nid = le16_to_cpu(dsb->root_nid);
> > +	sbi->packed_inode = erofs_sb_has_fragments(sbi) ?
> > +		erofs_iget(sb, le64_to_cpu(dsb->packed_nid), false) : NULL;  
> 
> iget could fail, what will we do next in such case?

I will fix it in v2.

> 
> >  	sbi->inos = le64_to_cpu(dsb->inos);
> >  
> >  	sbi->build_time = le64_to_cpu(dsb->build_time);
> > @@ -411,6 +413,8 @@ static int erofs_read_superblock(struct super_block *sb)
> >  		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
> >  	if (erofs_is_fscache_mode(sb))
> >  		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
> > +	if (erofs_sb_has_fragments(sbi))
> > +		erofs_info(sb, "EXPERIMENTAL compressed fragments feature in use. Use at your own risk!");
> >  out:
> >  	erofs_put_metabuf(&buf);
> >  	return ret;
> > @@ -908,6 +912,8 @@ static void erofs_put_super(struct super_block *sb)
> >  #ifdef CONFIG_EROFS_FS_ZIP
> >  	iput(sbi->managed_cache);
> >  	sbi->managed_cache = NULL;
> > +	iput(sbi->packed_inode);
> > +	sbi->packed_inode = NULL;
> >  #endif
> >  	erofs_fscache_unregister_cookie(&sbi->s_fscache);
> >  }
> > diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> > index c1383e508bbe..1b52395be82a 100644
> > --- a/fs/erofs/sysfs.c
> > +++ b/fs/erofs/sysfs.c
> > @@ -76,6 +76,7 @@ EROFS_ATTR_FEATURE(device_table);
> >  EROFS_ATTR_FEATURE(compr_head2);
> >  EROFS_ATTR_FEATURE(sb_chksum);
> >  EROFS_ATTR_FEATURE(ztailpacking);
> > +EROFS_ATTR_FEATURE(fragments);
> >  
> >  static struct attribute *erofs_feat_attrs[] = {
> >  	ATTR_LIST(zero_padding),
> > @@ -86,6 +87,7 @@ static struct attribute *erofs_feat_attrs[] = {
> >  	ATTR_LIST(compr_head2),
> >  	ATTR_LIST(sb_chksum),
> >  	ATTR_LIST(ztailpacking),
> > +	ATTR_LIST(fragments),
> >  	NULL,
> >  };
> >  ATTRIBUTE_GROUPS(erofs_feat);
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 5792ca9e0d5e..3dd3b829766f 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -650,6 +650,33 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
> >  		la < fe->headoffset;
> >  }
> >  
> > +static int z_erofs_read_fragment_data(struct page *page, unsigned int pageofs,
> > +				      loff_t start, unsigned int len)
> > +{
> > +	struct inode *const inode = page->mapping->host;
> > +	erofs_off_t offset = EROFS_I(inode)->z_fragmentoff + start;
> > +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> > +	u8 *src, *dst;
> > +	unsigned int i, cnt;
> > +
> > +	for (i = 0; i < len; i += cnt) {
> > +		cnt = min(EROFS_BLKSIZ - (unsigned int)erofs_blkoff(offset),
> > +			  len - i);
> > +		src = erofs_bread(&buf, EROFS_I_SB(inode)->packed_inode,
> > +				  erofs_blknr(offset), EROFS_KMAP);
> > +		if (IS_ERR(src))
> > +			return PTR_ERR(src);
> > +
> > +		dst = kmap_atomic(page);
> > +		memcpy(dst + pageofs + i, src + erofs_blkoff(offset), cnt);
> > +		kunmap_atomic(dst);  
> 
> Use kmap_local_page instead.

Got it.

> 
> > +
> > +		offset += cnt;
> > +	}
> > +	erofs_put_metabuf(&buf);
> > +	return 0;
> > +}
> > +
> >  static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> >  				struct page *page, struct page **pagepool)
> >  {
> > @@ -688,7 +715,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> >  		/* didn't get a valid pcluster previously (very rare) */
> >  	}
> >  
> > -	if (!(map->m_flags & EROFS_MAP_MAPPED))
> > +	if (!(map->m_flags & EROFS_MAP_MAPPED) ||
> > +	    map->m_flags & EROFS_MAP_FRAGMENT)
> >  		goto hitted;
> >  
> >  	err = z_erofs_collector_begin(fe);
> > @@ -735,6 +763,31 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> >  		zero_user_segment(page, cur, end);
> >  		goto next_part;
> >  	}
> > +	if (map->m_flags & EROFS_MAP_FRAGMENT) {
> > +		unsigned int pageofs, skip, len;
> > +
> > +		if (!map->m_la) {
> > +			len = (offset + cur + 1 == inode->i_size) ? (cur + 1) :
> > +			      end;
> > +			err = z_erofs_read_fragment_data(page, 0, offset, len);
> > +			goto out;
> > +		}
> > +		if (map->m_la < offset) {
> > +			pageofs = 0;
> > +			skip = offset - map->m_la;
> > +		} else {
> > +			pageofs = map->m_la & ~PAGE_MASK;
> > +			skip = 0;
> > +		}
> > +		DBG_BUGON(map->m_llen - skip > PAGE_SIZE);  
> 
> 		len = min(map->m_llen - skip, end - cur)?

Nice, let me try.

Thanks.

> 
> > +		err = z_erofs_read_fragment_data(page, pageofs, skip,
> > +						 map->m_llen - skip);  
> 
> 						 len); ?
> 
> Thanks,
> Gao Xiang

