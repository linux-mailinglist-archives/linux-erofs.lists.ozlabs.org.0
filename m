Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 631653C1D80
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jul 2021 04:28:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GLcY32gD2z3bXk
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jul 2021 12:28:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GLcXw19c5z303t
 for <linux-erofs@lists.ozlabs.org>; Fri,  9 Jul 2021 12:28:45 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0Uf9kTmr_1625797708; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uf9kTmr_1625797708) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 09 Jul 2021 10:28:30 +0800
Date: Fri, 9 Jul 2021 10:28:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH v1.1 2/2] erofs: dax support for non-tailpacking
 regular file
Message-ID: <YOe0S+NKUrBi5YZC@B-P7TQMD6M-0146.local>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, nvdimm@lists.linux.dev,
 Liu Bo <bo.liu@linux.alibaba.com>,
 Joseqh Qi <joseph.qi@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
References: <20210704135056.42723-3-hsiangkao@linux.alibaba.com>
 <20210705132153.223839-1-hsiangkao@linux.alibaba.com>
 <20210709014719.GD11634@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210709014719.GD11634@locust>
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
Cc: nvdimm@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Joseqh Qi <joseph.qi@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 linux-fsdevel@vger.kernel.org, Liu Jiang <gerry@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Darrick,

On Thu, Jul 08, 2021 at 06:47:19PM -0700, Darrick J. Wong wrote:
> On Mon, Jul 05, 2021 at 09:21:53PM +0800, Gao Xiang wrote:

...

> >  	Opt_cache_strategy,
> > +	Opt_dax,
> >  	Opt_err
> >  };
> >  
> > @@ -370,6 +372,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
> >  	fsparam_flag_no("acl",		Opt_acl),
> >  	fsparam_enum("cache_strategy",	Opt_cache_strategy,
> >  		     erofs_param_cache_strategy),
> > +	fsparam_flag("dax",             Opt_dax),
> >  	{}
> >  };
> >  
> > @@ -410,6 +413,14 @@ static int erofs_fc_parse_param(struct fs_context *fc,
> >  		ctx->cache_strategy = result.uint_32;
> >  #else
> >  		errorfc(fc, "compression not supported, cache_strategy ignored");
> > +#endif
> > +		break;
> > +	case Opt_dax:
> > +#ifdef CONFIG_FS_DAX
> > +		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> > +		set_opt(ctx, DAX);
> 
> You might want to allow 'dax=always' and 'dax=never' to maintain parity
> with xfs/ext4's mount options...

Yeah, thanks for your suggestion. Will revise in the next version..

(Also, more use case details and development status about this scenario
 will be shown in the following months...)

Thanks,
Gao Xiang


> 
> --D
> 
> > +#else
> > +		errorfc(fc, "dax options not supported");
> >  #endif
> >  		break;
> >  	default:
> > @@ -496,10 +507,17 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
> >  		return -ENOMEM;
> >  
> >  	sb->s_fs_info = sbi;
> > +	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
> >  	err = erofs_read_superblock(sb);
> >  	if (err)
> >  		return err;
> >  
> > +	if (test_opt(ctx, DAX) &&
> > +	    !bdev_dax_supported(sb->s_bdev, EROFS_BLKSIZ)) {
> > +		errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
> > +		clear_opt(ctx, DAX);
> > +	}
> > +
> >  	sb->s_flags |= SB_RDONLY | SB_NOATIME;
> >  	sb->s_maxbytes = MAX_LFS_FILESIZE;
> >  	sb->s_time_gran = 1;
> > @@ -609,6 +627,8 @@ static void erofs_kill_sb(struct super_block *sb)
> >  	sbi = EROFS_SB(sb);
> >  	if (!sbi)
> >  		return;
> > +	if (sbi->dax_dev)
> > +		fs_put_dax(sbi->dax_dev);
> >  	kfree(sbi);
> >  	sb->s_fs_info = NULL;
> >  }
> > @@ -711,8 +731,8 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >  
> >  static int erofs_show_options(struct seq_file *seq, struct dentry *root)
> >  {
> > -	struct erofs_sb_info *sbi __maybe_unused = EROFS_SB(root->d_sb);
> > -	struct erofs_fs_context *ctx __maybe_unused = &sbi->ctx;
> > +	struct erofs_sb_info *sbi = EROFS_SB(root->d_sb);
> > +	struct erofs_fs_context *ctx = &sbi->ctx;
> >  
> >  #ifdef CONFIG_EROFS_FS_XATTR
> >  	if (test_opt(ctx, XATTR_USER))
> > @@ -734,6 +754,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
> >  	else if (ctx->cache_strategy == EROFS_ZIP_CACHE_READAROUND)
> >  		seq_puts(seq, ",cache_strategy=readaround");
> >  #endif
> > +	if (test_opt(ctx, DAX))
> > +		seq_puts(seq, ",dax");
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.24.4
> > 
