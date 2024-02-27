Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5425868A08
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 08:41:22 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hf61yBQv;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TkTv15BbYz3vXw
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 18:41:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hf61yBQv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TkTtq1mnLz3dDq
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Feb 2024 18:41:06 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d918008b99so30849385ad.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 26 Feb 2024 23:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709019665; x=1709624465; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92+2TageH+FXGPhCUqujdzhw6qx31aFaK8t168mlTs0=;
        b=hf61yBQvTvflDpTkewThsxTMa7Px4Z+IKlAkuNzzIzPrh0t2Z9oMLHlW4w9rhbcn4z
         Dt8uA0X5ygItvpKQYWED9rWuZRi60Jq0/9cDPX78W+F+6YgQ6iWa3Lb3+u05c+yxMUnb
         jsVBN6u6o2zwUkZN9JLABQbHzzuo5n2p8I4S8YO4d93EzgPysPTUjRqet/3GTlF7tumr
         kGm9Tb5LLM+slLzxGfsIDpsdZk773zCd6HG88lZDKTPNAj5VJZiM258nQDOD5c8mHzPx
         XmGKnn+0kz+ZMZ8CI8C7ldAEqb606Nw3F+5AQj41mhfqckFt5uOtqGatd3ymFgxs5Hgg
         IRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709019665; x=1709624465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92+2TageH+FXGPhCUqujdzhw6qx31aFaK8t168mlTs0=;
        b=R98GMWGcbzBrPj2Ti1DJxPAiGmLfC9Vcply7+hEEOu11/1ecu3pxAV4CViPPLRNINB
         xEKUqfqutmzeDpy1espRLMrJz2Z4jtG/7lZ07GZudO3/rPgzZmA6yPQVhWJAv87KQ1Gr
         8ecnR3M/b44KQBgyG4kPQLRFlVVL9CWX8fpjd7DXI6f7n68o1s77DtvkO6rorC6ic+Vi
         XBh/HkIVbaFpAaU4UE8CtZBgpMzlLDSzAGxPedOD/E4pfZg/WrFWXnpIrdgf47wkndDB
         yRIMJgC9EuRPGlRQ1l2rUS4mO6/eWRbbx+UyK6dzCjy9h56CG4MtTu2z23eMUbfW2LRA
         Vxew==
X-Forwarded-Encrypted: i=1; AJvYcCV+k1PANEPnuqv6GTq6G0i1rR59MIO/0w29UTDcEYL2M/4mENvaZxNuXu7Urpd/bs+hpRk93Rczl4Qm0n9AzirA1jblS+pbYnEzOGRG
X-Gm-Message-State: AOJu0YwZZtVj/8X0HFfz3OK63o6IDxpC5Z7QHi6daiGVsZoCeeSb9KtT
	IbUrGwlr50pDu5Mhj+bWguR1J7gWHWB3ljb6VBnKjSo27lrk5S/G
X-Google-Smtp-Source: AGHT+IGf9sMePHBxGTwQUOjRzd4Is4ynyjVANJdI0djeLhvJxopu5kQmD6jpIJ0tB7YYiUVeOn4UbQ==
X-Received: by 2002:a17:903:2281:b0:1d9:ce46:6ebd with SMTP id b1-20020a170903228100b001d9ce466ebdmr10851750plh.16.1709019664319;
        Mon, 26 Feb 2024 23:41:04 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090270cb00b001dcc0d35018sm181197plt.112.2024.02.26.23.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:41:04 -0800 (PST)
Date: Tue, 27 Feb 2024 15:40:57 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 6.1.y 1/2] erofs: simplify compression configuration
 parser
Message-ID: <20240227153951.00000e5e.zbestahu@gmail.com>
In-Reply-To: <80740042-8b16-40f6-b0a2-4e53670d6513@linux.alibaba.com>
References: <5216b503054dbbb9fccf8faa280647c728e82726.1709000322.git.huyue2@coolpad.com>
	<80740042-8b16-40f6-b0a2-4e53670d6513@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, stable@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 27 Feb 2024 11:00:01 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On 2024/2/27 10:22, Yue Hu wrote:
> > From: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > [ Upstream commit efb4fb02cef3ab410b603c8f0e1c67f61d55f542 ]
> > 
> > Move erofs_load_compr_cfgs() into decompressor.c as well as introduce
> > a callback instead of a hard-coded switch for each algorithm for
> > simplicity.
> > 
> > Reviewed-by: Chao Yu <chao@kernel.org>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > Link: https://lore.kernel.org/r/20231022130957.11398-1-xiang@kernel.org
> > Stable-dep-of: 118a8cf504d7 ("erofs: fix inconsistent per-file compression format")
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>  
> 
> where is the real fix [patch 2/2]? It's needed to be posted
> here too.

Already sent.

> 
> Thanks,
> Gao Xiang
> 
> > ---
> >   fs/erofs/compress.h          |  4 ++
> >   fs/erofs/decompressor.c      | 60 ++++++++++++++++++++++++++++--
> >   fs/erofs/decompressor_lzma.c |  4 +-
> >   fs/erofs/internal.h          | 28 ++------------
> >   fs/erofs/super.c             | 72 +++++-------------------------------
> >   5 files changed, 76 insertions(+), 92 deletions(-)
> > 
> > diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> > index 26fa170090b8..c4a3187bdb8f 100644
> > --- a/fs/erofs/compress.h
> > +++ b/fs/erofs/compress.h
> > @@ -21,6 +21,8 @@ struct z_erofs_decompress_req {
> >   };
> >   
> >   struct z_erofs_decompressor {
> > +	int (*config)(struct super_block *sb, struct erofs_super_block *dsb,
> > +		      void *data, int size);
> >   	int (*decompress)(struct z_erofs_decompress_req *rq,
> >   			  struct page **pagepool);
> >   	char *name;
> > @@ -93,6 +95,8 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq,
> >   		       struct page **pagepool);
> >   
> >   /* prototypes for specific algorithms */
> > +int z_erofs_load_lzma_config(struct super_block *sb,
> > +			struct erofs_super_block *dsb, void *data, int size);
> >   int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
> >   			    struct page **pagepool);
> >   #endif
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index 0cfad74374ca..ae3cfd018d99 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -24,11 +24,11 @@ struct z_erofs_lz4_decompress_ctx {
> >   	unsigned int oend;
> >   };
> >   
> > -int z_erofs_load_lz4_config(struct super_block *sb,
> > -			    struct erofs_super_block *dsb,
> > -			    struct z_erofs_lz4_cfgs *lz4, int size)
> > +static int z_erofs_load_lz4_config(struct super_block *sb,
> > +			    struct erofs_super_block *dsb, void *data, int size)
> >   {
> >   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > +	struct z_erofs_lz4_cfgs *lz4 = data;
> >   	u16 distance;
> >   
> >   	if (lz4) {
> > @@ -374,17 +374,71 @@ static struct z_erofs_decompressor decompressors[] = {
> >   		.name = "interlaced"
> >   	},
> >   	[Z_EROFS_COMPRESSION_LZ4] = {
> > +		.config = z_erofs_load_lz4_config,
> >   		.decompress = z_erofs_lz4_decompress,
> >   		.name = "lz4"
> >   	},
> >   #ifdef CONFIG_EROFS_FS_ZIP_LZMA
> >   	[Z_EROFS_COMPRESSION_LZMA] = {
> > +		.config = z_erofs_load_lzma_config,
> >   		.decompress = z_erofs_lzma_decompress,
> >   		.name = "lzma"
> >   	},
> >   #endif
> >   };
> >   
> > +int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
> > +{
> > +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> > +	unsigned int algs, alg;
> > +	erofs_off_t offset;
> > +	int size, ret = 0;
> > +
> > +	if (!erofs_sb_has_compr_cfgs(sbi)) {
> > +		sbi->available_compr_algs = Z_EROFS_COMPRESSION_LZ4;
> > +		return z_erofs_load_lz4_config(sb, dsb, NULL, 0);
> > +	}
> > +
> > +	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
> > +	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
> > +		erofs_err(sb, "unidentified algorithms %x, please upgrade kernel",
> > +			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
> > +	alg = 0;
> > +	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
> > +		void *data;
> > +
> > +		if (!(algs & 1))
> > +			continue;
> > +
> > +		data = erofs_read_metadata(sb, &buf, &offset, &size);
> > +		if (IS_ERR(data)) {
> > +			ret = PTR_ERR(data);
> > +			break;
> > +		}
> > +
> > +		if (alg >= ARRAY_SIZE(decompressors) ||
> > +		    !decompressors[alg].config) {
> > +			erofs_err(sb, "algorithm %d isn't enabled on this kernel",
> > +				  alg);
> > +			ret = -EOPNOTSUPP;
> > +		} else {
> > +			ret = decompressors[alg].config(sb,
> > +					dsb, data, size);
> > +		}
> > +
> > +		kfree(data);
> > +		if (ret)
> > +			break;
> > +	}
> > +	erofs_put_metabuf(&buf);
> > +	return ret;
> > +}
> > +
> >   int z_erofs_decompress(struct z_erofs_decompress_req *rq,
> >   		       struct page **pagepool)
> >   {
> > diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> > index 49addc345aeb..970464c4b676 100644
> > --- a/fs/erofs/decompressor_lzma.c
> > +++ b/fs/erofs/decompressor_lzma.c
> > @@ -72,10 +72,10 @@ int z_erofs_lzma_init(void)
> >   }
> >   
> >   int z_erofs_load_lzma_config(struct super_block *sb,
> > -			     struct erofs_super_block *dsb,
> > -			     struct z_erofs_lzma_cfgs *lzma, int size)
> > +			struct erofs_super_block *dsb, void *data, int size)
> >   {
> >   	static DEFINE_MUTEX(lzma_resize_mutex);
> > +	struct z_erofs_lzma_cfgs *lzma = data;
> >   	unsigned int dict_size, i;
> >   	struct z_erofs_lzma *strm, *head = NULL;
> >   	int err;
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index d8d09fc3ed65..79a7a5815ea6 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -471,6 +471,8 @@ struct erofs_map_dev {
> >   
> >   /* data.c */
> >   extern const struct file_operations erofs_file_fops;
> > +void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
> > +			  erofs_off_t *offset, int *lengthp);
> >   void erofs_unmap_metabuf(struct erofs_buf *buf);
> >   void erofs_put_metabuf(struct erofs_buf *buf);
> >   void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
> > @@ -565,9 +567,7 @@ void z_erofs_exit_zip_subsystem(void);
> >   int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
> >   				       struct erofs_workgroup *egrp);
> >   int erofs_try_to_free_cached_page(struct page *page);
> > -int z_erofs_load_lz4_config(struct super_block *sb,
> > -			    struct erofs_super_block *dsb,
> > -			    struct z_erofs_lz4_cfgs *lz4, int len);
> > +int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
> >   #else
> >   static inline void erofs_shrinker_register(struct super_block *sb) {}
> >   static inline void erofs_shrinker_unregister(struct super_block *sb) {}
> > @@ -575,36 +575,14 @@ static inline int erofs_init_shrinker(void) { return 0; }
> >   static inline void erofs_exit_shrinker(void) {}
> >   static inline int z_erofs_init_zip_subsystem(void) { return 0; }
> >   static inline void z_erofs_exit_zip_subsystem(void) {}
> > -static inline int z_erofs_load_lz4_config(struct super_block *sb,
> > -				  struct erofs_super_block *dsb,
> > -				  struct z_erofs_lz4_cfgs *lz4, int len)
> > -{
> > -	if (lz4 || dsb->u1.lz4_max_distance) {
> > -		erofs_err(sb, "lz4 algorithm isn't enabled");
> > -		return -EINVAL;
> > -	}
> > -	return 0;
> > -}
> >   #endif	/* !CONFIG_EROFS_FS_ZIP */
> >   
> >   #ifdef CONFIG_EROFS_FS_ZIP_LZMA
> >   int z_erofs_lzma_init(void);
> >   void z_erofs_lzma_exit(void);
> > -int z_erofs_load_lzma_config(struct super_block *sb,
> > -			     struct erofs_super_block *dsb,
> > -			     struct z_erofs_lzma_cfgs *lzma, int size);
> >   #else
> >   static inline int z_erofs_lzma_init(void) { return 0; }
> >   static inline int z_erofs_lzma_exit(void) { return 0; }
> > -static inline int z_erofs_load_lzma_config(struct super_block *sb,
> > -			     struct erofs_super_block *dsb,
> > -			     struct z_erofs_lzma_cfgs *lzma, int size) {
> > -	if (lzma) {
> > -		erofs_err(sb, "lzma algorithm isn't enabled");
> > -		return -EINVAL;
> > -	}
> > -	return 0;
> > -}
> >   #endif	/* !CONFIG_EROFS_FS_ZIP */
> >   
> >   /* flags for erofs_fscache_register_cookie() */
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index bd8bf8fc2f5d..f2647126cb2f 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -126,8 +126,8 @@ static bool check_layout_compatibility(struct super_block *sb,
> >   
> >   #ifdef CONFIG_EROFS_FS_ZIP
> >   /* read variable-sized metadata, offset will be aligned by 4-byte */
> > -static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
> > -				 erofs_off_t *offset, int *lengthp)
> > +void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
> > +			  erofs_off_t *offset, int *lengthp)
> >   {
> >   	u8 *buffer, *ptr;
> >   	int len, i, cnt;
> > @@ -159,64 +159,15 @@ static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
> >   	}
> >   	return buffer;
> >   }
> > -
> > -static int erofs_load_compr_cfgs(struct super_block *sb,
> > -				 struct erofs_super_block *dsb)
> > -{
> > -	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > -	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> > -	unsigned int algs, alg;
> > -	erofs_off_t offset;
> > -	int size, ret = 0;
> > -
> > -	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
> > -	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
> > -		erofs_err(sb, "try to load compressed fs with unsupported algorithms %x",
> > -			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
> > -		return -EINVAL;
> > -	}
> > -
> > -	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
> > -	alg = 0;
> > -	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
> > -		void *data;
> > -
> > -		if (!(algs & 1))
> > -			continue;
> > -
> > -		data = erofs_read_metadata(sb, &buf, &offset, &size);
> > -		if (IS_ERR(data)) {
> > -			ret = PTR_ERR(data);
> > -			break;
> > -		}
> > -
> > -		switch (alg) {
> > -		case Z_EROFS_COMPRESSION_LZ4:
> > -			ret = z_erofs_load_lz4_config(sb, dsb, data, size);
> > -			break;
> > -		case Z_EROFS_COMPRESSION_LZMA:
> > -			ret = z_erofs_load_lzma_config(sb, dsb, data, size);
> > -			break;
> > -		default:
> > -			DBG_BUGON(1);
> > -			ret = -EFAULT;
> > -		}
> > -		kfree(data);
> > -		if (ret)
> > -			break;
> > -	}
> > -	erofs_put_metabuf(&buf);
> > -	return ret;
> > -}
> >   #else
> > -static int erofs_load_compr_cfgs(struct super_block *sb,
> > -				 struct erofs_super_block *dsb)
> > +static int z_erofs_parse_cfgs(struct super_block *sb,
> > +			      struct erofs_super_block *dsb)
> >   {
> > -	if (dsb->u1.available_compr_algs) {
> > -		erofs_err(sb, "try to load compressed fs when compression is disabled");
> > -		return -EINVAL;
> > -	}
> > -	return 0;
> > +	if (!dsb->u1.available_compr_algs)
> > +		return 0;
> > +
> > +	erofs_err(sb, "compression disabled, unable to mount compressed EROFS");
> > +	return -EOPNOTSUPP;
> >   }
> >   #endif
> >   
> > @@ -398,10 +349,7 @@ static int erofs_read_superblock(struct super_block *sb)
> >   	}
> >   
> >   	/* parse on-disk compression configurations */
> > -	if (erofs_sb_has_compr_cfgs(sbi))
> > -		ret = erofs_load_compr_cfgs(sb, dsb);
> > -	else
> > -		ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
> > +	ret = z_erofs_parse_cfgs(sb, dsb);
> >   	if (ret < 0)
> >   		goto out;
> >     

