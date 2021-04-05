Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E82035418F
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Apr 2021 13:35:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDT9s4VJmz30Cs
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Apr 2021 21:35:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=as6Q6M4g;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=as6Q6M4g;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=as6Q6M4g; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=as6Q6M4g; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FDT9p3BLsz30B4
 for <linux-erofs@lists.ozlabs.org>; Mon,  5 Apr 2021 21:35:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617622538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0DagDAI+w2ULU0ar/n+RJ75q45VMtmoTIa32JtACPJU=;
 b=as6Q6M4gxe5mntUZlle8D8+rjDW34039pgSW3+N/mZ0RzhFSESsPcAtWMOhx2EBKXeKal8
 XDk1mEvEt3Ei4sjeHLSV8xr6tlifU6xlAG2lWqkY5wY6xnibbdnjVUyi9iEqbbdvJ8U4w/
 6eVdLSP3B4r1C+bfJhRhQrINMdcYtOc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617622538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0DagDAI+w2ULU0ar/n+RJ75q45VMtmoTIa32JtACPJU=;
 b=as6Q6M4gxe5mntUZlle8D8+rjDW34039pgSW3+N/mZ0RzhFSESsPcAtWMOhx2EBKXeKal8
 XDk1mEvEt3Ei4sjeHLSV8xr6tlifU6xlAG2lWqkY5wY6xnibbdnjVUyi9iEqbbdvJ8U4w/
 6eVdLSP3B4r1C+bfJhRhQrINMdcYtOc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-PeTlwL_NNUG61E2-qB35Cg-1; Mon, 05 Apr 2021 07:35:37 -0400
X-MC-Unique: PeTlwL_NNUG61E2-qB35Cg-1
Received: by mail-pl1-f198.google.com with SMTP id n12so5863102plf.12
 for <linux-erofs@lists.ozlabs.org>; Mon, 05 Apr 2021 04:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0DagDAI+w2ULU0ar/n+RJ75q45VMtmoTIa32JtACPJU=;
 b=iys1J4gZN0Hz2vlDjp4CEzC4mvQmYhKTsYvcSR5p5J67wajV524kgQ/rzpyYTPP5uI
 Vs4490DsblxTKqijDvhe0C35gtCZ710KTuA+UYf7NiisK1iWCqFVTNgBxxkqrxEE1llK
 IJXqgS1bW+6z4CPBqTq1AArGkCMyT5yDM0+XkFabFvX0kk2yqu+vW3G61MSTLn3y3xI3
 My8Cc3hjLCkmF7FbGMwPM6pp7ZCt0tNL0Rql3LxKwupsham2CRtubf60ih+JYM16/Y9A
 YmAtZ1uObR61dKDPTxIUjkEIIgFOeRohBsk85gDEgLAc9UEmvfgYQwaRVoLy8u00viKm
 zqBg==
X-Gm-Message-State: AOAM530RozNN7WX/0sCC1/cRuSZRd/umgNr7NB3yRyA++xLI4ibQivc6
 Bou5ato0n21F57KyNG0wtQCVjc1kWsqYlLbh6FJI/87g+9AD6cKzL/vOe8mULrrRioz5VvbqaAS
 yo6lRL76AdJDqFx5LGvgDJOAP
X-Received: by 2002:a17:90b:f8f:: with SMTP id
 ft15mr6784165pjb.105.1617622535813; 
 Mon, 05 Apr 2021 04:35:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXOFurRKgtxHn1MtNHAQXvBdFBc2QWSF+YzSeEs40LAEWLvHibefcv/EiLS7EMY0IJLU2FNA==
X-Received: by 2002:a17:90b:f8f:: with SMTP id
 ft15mr6784139pjb.105.1617622535404; 
 Mon, 05 Apr 2021 04:35:35 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l20sm16005365pfd.82.2021.04.05.04.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Apr 2021 04:35:34 -0700 (PDT)
Date: Mon, 5 Apr 2021 19:35:25 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: get rid of inode->i_srcpath
Message-ID: <20210405113525.GB378859@xiangao.remote.csb>
References: <20210405094950.150983-1-sehuww@mail.scut.edu.cn>
MIME-Version: 1.0
In-Reply-To: <20210405094950.150983-1-sehuww@mail.scut.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Weiwen,

On Mon, Apr 05, 2021 at 05:49:50PM +0800, Hu Weiwen wrote:
> This cut the memory usage by half.
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> ---

I have to hold on this patch for now, 3 main reasons here:
 1) I'd like to apply big pcluster first, which is a main new feature
    for erofs-utils 1.3;
 2) even though it saves memory usage (and not sure how much memory
    you need to save), I think srcpath is more useful for debugging
    and file tracing; Also, I think we could flush inode in advance to
    save memory usage (e.g. by using bflush()) as well.
 3) if src_path is too large, how about malloc() it as the first step,
    even that, I'd like to apply it after erofs-utils 1.3 is out...

Thanks,
Gao Xiang

>  include/erofs/compress.h |  2 +-
>  include/erofs/internal.h |  2 --
>  include/erofs/xattr.h    |  2 +-
>  lib/compress.c           | 24 +++++++--------------
>  lib/inode.c              | 45 ++++++++++++++++++++--------------------
>  lib/xattr.c              |  4 ++--
>  6 files changed, 33 insertions(+), 46 deletions(-)
> 
> diff --git a/include/erofs/compress.h b/include/erofs/compress.h
> index 952f287..a1dd55f 100644
> --- a/include/erofs/compress.h
> +++ b/include/erofs/compress.h
> @@ -16,7 +16,7 @@
>  #define EROFS_CONFIG_COMPR_MAX_SZ           (900  * 1024)
>  #define EROFS_CONFIG_COMPR_MIN_SZ           (32   * 1024)
>  
> -int erofs_write_compressed_file(struct erofs_inode *inode);
> +int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
>  
>  int z_erofs_compress_init(void);
>  int z_erofs_compress_exit(void);
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index ac5b270..d99d4ac 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -137,8 +137,6 @@ struct erofs_inode {
>  		u32 i_rdev;
>  	} u;
>  
> -	char i_srcpath[PATH_MAX + 1];
> -
>  	unsigned char datalayout;
>  	unsigned char inode_isize;
>  	/* inline tail-end packing size */
> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
> index 197fe25..e22342d 100644
> --- a/include/erofs/xattr.h
> +++ b/include/erofs/xattr.h
> @@ -42,7 +42,7 @@
>  #define XATTR_NAME_POSIX_ACL_DEFAULT "system.posix_acl_default"
>  #endif
>  
> -int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
> +int erofs_prepare_xattr_ibody(struct erofs_inode *inode, const char *path);
>  char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
>  int erofs_build_shared_xattrs_from_path(const char *path);
>  
> diff --git a/lib/compress.c b/lib/compress.c
> index 4b685cd..ea2310e 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -170,8 +170,7 @@ static int vle_compress_one(struct erofs_inode *inode,
>  					      &count, dst, EROFS_BLKSIZ);
>  		if (ret <= 0) {
>  			if (ret != -EAGAIN) {
> -				erofs_err("failed to compress %s: %s",
> -					  inode->i_srcpath,
> +				erofs_err("failed to compress: %s",
>  					  erofs_strerror(ret));
>  			}
>  nocompression:
> @@ -388,30 +387,24 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
>  	return 0;
>  }
>  
> -int erofs_write_compressed_file(struct erofs_inode *inode)
> +int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>  {
>  	struct erofs_buffer_head *bh;
>  	struct z_erofs_vle_compress_ctx ctx;
>  	erofs_off_t remaining;
>  	erofs_blk_t blkaddr, compressed_blocks;
>  	unsigned int legacymetasize;
> -	int ret, fd;
> +	int ret;
>  
>  	u8 *compressmeta = malloc(vle_compressmeta_capacity(inode->i_size));
>  	if (!compressmeta)
>  		return -ENOMEM;
>  
> -	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
> -	if (fd < 0) {
> -		ret = -errno;
> -		goto err_free;
> -	}
> -
>  	/* allocate main data buffer */
>  	bh = erofs_balloc(DATA, 0, 0, 0);
>  	if (IS_ERR(bh)) {
>  		ret = PTR_ERR(bh);
> -		goto err_close;
> +		goto err;
>  	}
>  
>  	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
> @@ -455,13 +448,12 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
>  
>  	vle_write_indexes_final(&ctx);
>  
> -	close(fd);
>  	DBG_BUGON(!compressed_blocks);
>  	ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
>  	DBG_BUGON(ret != EROFS_BLKSIZ);
>  
> -	erofs_info("compressed %s (%llu bytes) into %u blocks",
> -		   inode->i_srcpath, (unsigned long long)inode->i_size,
> +	erofs_info("compressed %llu bytes into %u blocks",
> +		   (unsigned long long)inode->i_size,
>  		   compressed_blocks);
>  
>  	/*
> @@ -486,9 +478,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
>  
>  err_bdrop:
>  	erofs_bdrop(bh, true);	/* revoke buffer */
> -err_close:
> -	close(fd);
> -err_free:
> +err:
>  	free(compressmeta);
>  	return ret;
>  }
> diff --git a/lib/inode.c b/lib/inode.c
> index d52facf..44ed6f6 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -362,9 +362,9 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
>  	return 0;
>  }
>  
> -int erofs_write_file(struct erofs_inode *inode)
> +int erofs_write_file(struct erofs_inode *inode, int fd)
>  {
> -	int ret, fd;
> +	int ret;
>  
>  	if (!inode->i_size) {
>  		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> @@ -372,17 +372,15 @@ int erofs_write_file(struct erofs_inode *inode)
>  	}
>  
>  	if (cfg.c_compr_alg_master && erofs_file_is_compressible(inode)) {
> -		ret = erofs_write_compressed_file(inode);
> +		ret = erofs_write_compressed_file(inode, fd);
>  
> -		if (!ret || ret != -ENOSPC)
> +		if (!ret || ret != -ENOSPC) {
> +			close(fd);
>  			return ret;
> +		}
>  	}
>  
>  	/* fallback to all data uncompressed */
> -	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
> -	if (fd < 0)
> -		return -errno;
> -
>  	ret = write_uncompressed_file_from_fd(inode, fd);
>  	close(fd);
>  	return ret;
> @@ -786,16 +784,12 @@ int erofs_fill_inode(struct erofs_inode *inode,
>  		return -EINVAL;
>  	}
>  
> -	strncpy(inode->i_srcpath, path, sizeof(inode->i_srcpath) - 1);
> -	inode->i_srcpath[sizeof(inode->i_srcpath) - 1] = '\0';
> -
>  	inode->dev = st->st_dev;
>  	inode->i_ino[1] = st->st_ino;
>  
>  	if (erofs_should_use_inode_extended(inode)) {
>  		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
> -			erofs_err("file %s cannot be in compact form",
> -				  inode->i_srcpath);
> +			erofs_err("file %s cannot be in compact form", path);
>  			return -EINVAL;
>  		}
>  		inode->inode_isize = sizeof(struct erofs_inode_extended);
> @@ -916,14 +910,15 @@ void erofs_d_invalidate(struct erofs_dentry *d)
>  	erofs_iput(inode);
>  }
>  
> -struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
> +struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir,
> +		const char *src_path)
>  {
>  	int ret;
>  	DIR *_dir;
>  	struct dirent *dp;
>  	struct erofs_dentry *d;
>  
> -	ret = erofs_prepare_xattr_ibody(dir);
> +	ret = erofs_prepare_xattr_ibody(dir, src_path);
>  	if (ret < 0)
>  		return ERR_PTR(ret);
>  
> @@ -933,7 +928,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  
>  			if (!symlink)
>  				return ERR_PTR(-ENOMEM);
> -			ret = readlink(dir->i_srcpath, symlink, dir->i_size);
> +			ret = readlink(src_path, symlink, dir->i_size);
>  			if (ret < 0) {
>  				free(symlink);
>  				return ERR_PTR(-errno);
> @@ -944,7 +939,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  			if (ret)
>  				return ERR_PTR(ret);
>  		} else {
> -			ret = erofs_write_file(dir);
> +			int fd = open(src_path, O_RDONLY | O_BINARY);
> +
> +			if (fd < 0)
> +				return ERR_PTR(-errno);
> +			ret = erofs_write_file(dir, fd);
>  			if (ret)
>  				return ERR_PTR(ret);
>  		}
> @@ -954,10 +953,10 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  		return dir;
>  	}
>  
> -	_dir = opendir(dir->i_srcpath);
> +	_dir = opendir(src_path);
>  	if (!_dir) {
>  		erofs_err("%s, failed to opendir at %s: %s",
> -			  __func__, dir->i_srcpath, erofs_strerror(errno));
> +			  __func__, src_path, erofs_strerror(errno));
>  		return ERR_PTR(-errno);
>  	}
>  
> @@ -976,7 +975,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  			continue;
>  
>  		/* skip if it's a exclude file */
> -		if (erofs_is_exclude_path(dir->i_srcpath, dp->d_name))
> +		if (erofs_is_exclude_path(src_path, dp->d_name))
>  			continue;
>  
>  		d = erofs_d_alloc(dir, dp->d_name);
> @@ -1017,7 +1016,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  		}
>  
>  		ret = snprintf(buf, PATH_MAX, "%s/%s",
> -			       dir->i_srcpath, d->name);
> +			       src_path, d->name);
>  		if (ret < 0 || ret >= PATH_MAX) {
>  			/* ignore the too long path */
>  			goto fail;
> @@ -1038,7 +1037,7 @@ fail:
>  
>  		erofs_d_invalidate(d);
>  		erofs_info("add file %s/%s (nid %llu, type %d)",
> -			   dir->i_srcpath, d->name, (unsigned long long)d->nid,
> +			   src_path, d->name, (unsigned long long)d->nid,
>  			   d->type);
>  	}
>  	erofs_write_dir_file(dir);
> @@ -1071,6 +1070,6 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
>  	else
>  		inode->i_parent = inode;	/* rootdir mark */
>  
> -	return erofs_mkfs_build_tree(inode);
> +	return erofs_mkfs_build_tree(inode, path);
>  }
>  
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 8b7bcb1..e128f3d 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -401,7 +401,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
>  }
>  #endif
>  
> -int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
> +int erofs_prepare_xattr_ibody(struct erofs_inode *inode, const char *path)
>  {
>  	int ret;
>  	struct inode_xattr_node *node;
> @@ -411,7 +411,7 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
>  	if (cfg.c_inline_xattr_tolerance < 0)
>  		return 0;
>  
> -	ret = read_xattrs_from_file(inode->i_srcpath, inode->i_mode, ixattrs);
> +	ret = read_xattrs_from_file(path, inode->i_mode, ixattrs);
>  	if (ret < 0)
>  		return ret;
>  
> -- 
> 2.25.1
> 

