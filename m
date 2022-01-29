Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A0B4A2BAC
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 05:52:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jm24N0W2lz3bSq
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 15:52:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jm24J4jFwz30Mj
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jan 2022 15:52:16 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V35.TRS_1643431928; 
Received: from B-P7TQMD6M-0146(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V35.TRS_1643431928) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 29 Jan 2022 12:52:09 +0800
Date: Sat, 29 Jan 2022 12:52:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Igor Ostapenko <igoreisberg@gmail.com>
Subject: Re: [PATCH] erofs-utils: add missing errors and normalize errors to
 lower-case
Message-ID: <YfTH94pcETEpjN9m@B-P7TQMD6M-0146>
References: <20220128132218.26-1-igoreisberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128132218.26-1-igoreisberg@gmail.com>
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

Hi Igor,

On Fri, Jan 28, 2022 at 03:22:18PM +0200, Igor Ostapenko wrote:
> From: Igor Eisberg <igoreisberg@gmail.com>
> 
> * Added useful error messages.
> * Most errors start with lower-case, let's make all of them lower-case
>   for better consistency.
> 
> Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
> ---
>  dump/main.c |  4 +++-
>  fsck/main.c | 35 +++++++++++++++++++++++------------
>  mkfs/main.c | 32 +++++++++++++++++---------------
>  3 files changed, 43 insertions(+), 28 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index 0616113..664780b 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -162,8 +162,10 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
>  		}
>  	}
>  
> -	if (optind >= argc)
> +	if (optind >= argc) {
> +		erofs_err("missing argument: IMAGE");
>  		return -EINVAL;
> +	}
>  
>  	cfg.c_img_path = strdup(argv[optind++]);
>  	if (!cfg.c_img_path)
> diff --git a/fsck/main.c b/fsck/main.c
> index 6f17d0e..5667f2a 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -202,8 +202,10 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>  		}
>  	}
>  
> -	if (optind >= argc)
> +	if (optind >= argc) {
> +		erofs_err("missing argument: IMAGE");
>  		return -EINVAL;
> +	}
>  
>  	cfg.c_img_path = strdup(argv[optind++]);
>  	if (!cfg.c_img_path)
> @@ -230,8 +232,12 @@ static void erofsfsck_set_attributes(struct erofs_inode *inode, char *path)
>  
>  	if (utimensat(AT_FDCWD, path, times, AT_SYMLINK_NOFOLLOW) < 0)
>  #else
> -	if (utime(path, &((struct utimbuf){.actime = inode->i_ctime,
> -					   .modtime = inode->i_ctime})) < 0)
> +	const struct utimbuf time = {
> +		.actime = inode->i_ctime,
> +		.modtime = inode->i_ctime,
> +	};
> +
> +	if (utime(path, &time) < 0)

Can we drop this change since personally I don't want to introduce
unnecessary variables if possible?

>  #endif
>  		erofs_warn("failed to set times: %s", path);
>  
> @@ -512,7 +518,7 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
>  		struct stat st;
>  
>  		if (errno != EEXIST) {
> -			erofs_err("failed to create directory %s: %s",
> +			erofs_err("failed to create directory: %s (%s)",
>  				  fsckcfg.extract_path, strerror(errno));
>  			return -errno;
>  		}
> @@ -528,8 +534,11 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
>  		 * Try to change permissions of existing directory so
>  		 * that we can write to it
>  		 */
> -		if (chmod(fsckcfg.extract_path, 0700) < 0)
> +		if (chmod(fsckcfg.extract_path, 0700) < 0) {
> +			erofs_err("failed to set permissions: %s (%s)",
> +				  fsckcfg.extract_path, strerror(errno));
>  			return -errno;
> +		}
>  	}
>  	return 0;
>  }
> @@ -551,18 +560,20 @@ again:
>  				erofs_warn("try to forcely remove directory %s",
>  					   fsckcfg.extract_path);
>  				if (rmdir(fsckcfg.extract_path) < 0) {
> -					erofs_err("failed to remove: %s",
> -						  fsckcfg.extract_path);
> +					erofs_err("failed to remove: %s (%s)",
> +						  fsckcfg.extract_path, strerror(errno));
>  					return -EISDIR;
>  				}
>  			} else if (errno == EACCES &&
>  				   chmod(fsckcfg.extract_path, 0700) < 0) {
> +				erofs_err("failed to set permissions: %s (%s)",
> +					  fsckcfg.extract_path, strerror(errno));
>  				return -errno;
>  			}
>  			tryagain = false;
>  			goto again;
>  		}
> -		erofs_err("failed to open %s: %s", fsckcfg.extract_path,
> +		erofs_err("failed to open: %s (%s)", fsckcfg.extract_path,
>  			  strerror(errno));
>  		return -errno;
>  	}
> @@ -768,15 +779,15 @@ int main(int argc, char **argv)
>  	err = erofsfsck_check_inode(sbi.root_nid, sbi.root_nid);
>  	if (fsckcfg.corrupted) {
>  		if (!fsckcfg.extract_path)
> -			erofs_err("Found some filesystem corruption");
> +			erofs_err("found some filesystem corruption");

IMO, how about leaving these conclusive messages starting with
upper cases?

>  		else
> -			erofs_err("Failed to extract filesystem");
> +			erofs_err("failed to extract filesystem");

ditto.

>  		err = -EFSCORRUPTED;
>  	} else if (!err) {
>  		if (!fsckcfg.extract_path)
> -			erofs_info("No error found");
> +			erofs_info("no errors found");

ditto.

>  		else
> -			erofs_info("Extract data successfully");
> +			erofs_info("extracted filesystem successfully");

ditto.

Thanks,
Gao Xiang

>  
>  		if (fsckcfg.print_comp_ratio) {
>  			double comp_ratio =
> diff --git a/mkfs/main.c b/mkfs/main.c
> index c755da1..dd698ff 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -381,9 +381,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  		}
>  	}
>  
> -	if (optind >= argc)
> -		return -EINVAL;
> -
>  	if (cfg.c_blobdev_path && cfg.c_chunkbits < LOG_BLOCK_SIZE) {
>  		erofs_err("--blobdev must be used together with --chunksize");
>  		return -EINVAL;
> @@ -396,24 +393,29 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  		return -EINVAL;
>  	}
>  
> +	if (optind >= argc) {
> +		erofs_err("missing argument: FILE");
> +		return -EINVAL;
> +	}
> +
>  	cfg.c_img_path = strdup(argv[optind++]);
>  	if (!cfg.c_img_path)
>  		return -ENOMEM;
>  
>  	if (optind >= argc) {
> -		erofs_err("Source directory is missing");
> +		erofs_err("missing argument: DIRECTORY");
>  		return -EINVAL;
>  	}
>  
>  	cfg.c_src_path = realpath(argv[optind++], NULL);
>  	if (!cfg.c_src_path) {
> -		erofs_err("Failed to parse source directory: %s",
> +		erofs_err("failed to parse source directory: %s",
>  			  erofs_strerror(-errno));
>  		return -ENOENT;
>  	}
>  
>  	if (optind < argc) {
> -		erofs_err("Unexpected argument: %s\n", argv[optind]);
> +		erofs_err("unexpected argument: %s\n", argv[optind]);
>  		return -EINVAL;
>  	}
>  	if (quiet)
> @@ -456,7 +458,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  
>  	buf = calloc(sb_blksize, 1);
>  	if (!buf) {
> -		erofs_err("Failed to allocate memory for sb: %s",
> +		erofs_err("failed to allocate memory for sb: %s",
>  			  erofs_strerror(-errno));
>  		return -ENOMEM;
>  	}
> @@ -538,7 +540,7 @@ int parse_source_date_epoch(void)
>  
>  	epoch = strtoull(source_date_epoch, &endptr, 10);
>  	if (epoch == -1ULL || *endptr != '\0') {
> -		erofs_err("Environment variable $SOURCE_DATE_EPOCH %s is invalid",
> +		erofs_err("environment variable $SOURCE_DATE_EPOCH %s is invalid",
>  			  source_date_epoch);
>  		return -EINVAL;
>  	}
> @@ -641,34 +643,34 @@ int main(int argc, char **argv)
>  	sb_bh = erofs_buffer_init();
>  	if (IS_ERR(sb_bh)) {
>  		err = PTR_ERR(sb_bh);
> -		erofs_err("Failed to initialize buffers: %s",
> +		erofs_err("failed to initialize buffers: %s",
>  			  erofs_strerror(err));
>  		goto exit;
>  	}
>  	err = erofs_bh_balloon(sb_bh, EROFS_SUPER_END);
>  	if (err < 0) {
> -		erofs_err("Failed to balloon erofs_super_block: %s",
> +		erofs_err("failed to balloon erofs_super_block: %s",
>  			  erofs_strerror(err));
>  		goto exit;
>  	}
>  
>  	err = erofs_load_compress_hints();
>  	if (err) {
> -		erofs_err("Failed to load compress hints %s",
> +		erofs_err("failed to load compress hints %s",
>  			  cfg.c_compress_hints_file);
>  		goto exit;
>  	}
>  
>  	err = z_erofs_compress_init(sb_bh);
>  	if (err) {
> -		erofs_err("Failed to initialize compressor: %s",
> +		erofs_err("failed to initialize compressor: %s",
>  			  erofs_strerror(err));
>  		goto exit;
>  	}
>  
>  	err = erofs_generate_devtable();
>  	if (err) {
> -		erofs_err("Failed to generate device table: %s",
> +		erofs_err("failed to generate device table: %s",
>  			  erofs_strerror(err));
>  		goto exit;
>  	}
> @@ -681,7 +683,7 @@ int main(int argc, char **argv)
>  
>  	err = erofs_build_shared_xattrs_from_path(cfg.c_src_path);
>  	if (err) {
> -		erofs_err("Failed to build shared xattrs: %s",
> +		erofs_err("failed to build shared xattrs: %s",
>  			  erofs_strerror(err));
>  		goto exit;
>  	}
> @@ -727,7 +729,7 @@ exit:
>  	erofs_exit_configure();
>  
>  	if (err) {
> -		erofs_err("\tCould not format the device : %s\n",
> +		erofs_err("\tcould not format the device : %s\n",
>  			  erofs_strerror(err));
>  		return 1;
>  	}
> -- 
> 2.30.2
