Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9A749F271
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jan 2022 05:23:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JlPT63bp8z3bPW
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jan 2022 15:23:06 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JlPSz0Jl6z2ymt
 for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jan 2022 15:22:55 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R691e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V30Qac0_1643343766; 
Received: from B-P7TQMD6M-0146(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V30Qac0_1643343766) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 28 Jan 2022 12:22:47 +0800
Date: Fri, 28 Jan 2022 12:22:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Igor Ostapenko <igoreisberg@gmail.com>
Subject: Re: [PATCH] erofs-utils: fsck: fix issues related to --extract=X
Message-ID: <YfNvloN0RAX0mHRn@B-P7TQMD6M-0146>
References: <YfC7rIs7%2FaAVdcS9@B-P7TQMD6M-0146.local>
 <20220128040511.27-1-igoreisberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128040511.27-1-igoreisberg@gmail.com>
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

On Fri, Jan 28, 2022 at 06:05:11AM +0200, Igor Ostapenko wrote:
> From: Igor Eisberg <igoreisberg@gmail.com>
> 
> * Added tar-like default behaviors for --[no-]preserve options:
>   normal user - uses user's owner ID + umask on perms by default;
>   root user - preserve original owner IDs + perms by default;
>   and add appropriate error message when used without --extract=X.
> * "--[no-]same-owner" and "--[no-]same-permissions" were renamed
>   to "--[no-]preserve-owner" and "--[no-]preserve-perms" to
>   better represent what these options do, the word "same" is
>   ambiguous and tells nothing to the user ("same" to what?).
> * Added "--[no-]preserve" as shortcuts for both options in one.
> * Fixed option descriptions as they had typos and were too ambiguous
>   ("extract information" to where? separate file?).
> * Added --force option to allow extracting directly to root path.
> 
> Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
> ---
>  fsck/main.c | 104 ++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 77 insertions(+), 27 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 92e0c76..9080a66 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -18,15 +18,21 @@
>  static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
>  
>  struct erofsfsck_cfg {
> +	bool superuser;
> +	mode_t umask;
>  	bool corrupted;
> +	u64 physical_blocks;
> +	u64 logical_blocks;
>  	bool print_comp_ratio;
>  	bool check_decomp;
>  	char *extract_path;
>  	size_t extract_pos;
> -	bool overwrite, preserve_owner, preserve_perms;
> -	mode_t umask;
> -	u64 physical_blocks;
> -	u64 logical_blocks;
> +	bool force;
> +	bool overwrite;
> +	bool preserve_owner;
> +	bool preserve_perms;
> +	bool no_preserve_owner;
> +	bool no_preserve_perms;

Thanks for the patch, just a minor comment.

How about moving no_preserve_owner, no_preserve_perms to
erofsfsck_parse_options_cfg as local varibles instead?

Otherwise looks good to me.

Thanks,
Gao Xiang

>  };
>  static struct erofsfsck_cfg fsckcfg;
>  
> @@ -34,11 +40,14 @@ static struct option long_options[] = {
>  	{"help", no_argument, 0, 1},
>  	{"extract", optional_argument, 0, 2},
>  	{"device", required_argument, 0, 3},
> -	{"no-same-owner", no_argument, 0, 4},
> -	{"no-same-permissions", no_argument, 0, 5},
> -	{"same-owner", no_argument, 0, 6},
> -	{"same-permissions", no_argument, 0, 7},
> -	{"overwrite", no_argument, 0, 8},
> +	{"force", no_argument, 0, 4},
> +	{"overwrite", no_argument, 0, 5},
> +	{"preserve", no_argument, 0, 6},
> +	{"preserve-owner", no_argument, 0, 7},
> +	{"preserve-perms", no_argument, 0, 8},
> +	{"no-preserve", no_argument, 0, 9},
> +	{"no-preserve-owner", no_argument, 0, 10},
> +	{"no-preserve-perms", no_argument, 0, 11},
>  	{0, 0, 0, 0},
>  };
>  
> @@ -66,11 +75,16 @@ static void usage(void)
>  	      " --extract[=X]          check if all files are well encoded, optionally extract to X\n"
>  	      " --help                 display this help and exit\n"
>  	      "\nExtraction options (--extract=X is required):\n"
> -	      " --no-same-owner        extract files as yourself\n"
> -	      " --no-same-permissions  apply the user's umask when extracting permission\n"
> -	      " --same-permissions     extract information about file permissions\n"
> -	      " --same-owner           extract files about the file ownerships\n"
> -	      " --overwrite            if file already exists then overwrite\n"
> +	      " --force                allow extracting to root\n"
> +	      " --overwrite            overwrite files that already exist\n"
> +	      " --preserve             extract with the same ownership and permissions as on the filesystem\n"
> +	      "                        (default for superuser)\n"
> +	      " --preserve-owner       extract with the same ownership as on the filesystem\n"
> +	      " --preserve-perms       extract with the same permissions as on the filesystem\n"
> +	      " --no-preserve          extract as yourself and apply user's umask on permissions\n"
> +	      "                        (default for ordinary users)\n"
> +	      " --no-preserve-owner    extract as yourself\n"
> +	      " --no-preserve-perms    apply user's umask when extracting permissions\n"
>  	      "\nSupported algorithms are: ", stderr);
>  	print_available_decompressors(stderr, ", ");
>  }
> @@ -121,6 +135,9 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>  					return -ENOMEM;
>  				strncpy(fsckcfg.extract_path, optarg, len);
>  				fsckcfg.extract_path[len] = '\0';
> +				/* if path is root, start writing from position 0 */
> +				if (len == 1 && fsckcfg.extract_path[0] == '/')
> +					len = 0;
>  				fsckcfg.extract_pos = len;
>  			}
>  			break;
> @@ -131,33 +148,62 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>  			++sbi.extra_devices;
>  			break;
>  		case 4:
> -			fsckcfg.preserve_owner = false;
> +			fsckcfg.force = true;
>  			break;
>  		case 5:
> -			fsckcfg.preserve_perms = false;
> +			fsckcfg.overwrite = true;
>  			break;
>  		case 6:
>  			fsckcfg.preserve_owner = true;
> +			fsckcfg.preserve_perms = true;
> +			fsckcfg.no_preserve_owner = false;
> +			fsckcfg.no_preserve_perms = false;
>  			break;
>  		case 7:
> -			fsckcfg.preserve_perms = true;
> +			fsckcfg.preserve_owner = true;
> +			fsckcfg.no_preserve_owner = false;
>  			break;
>  		case 8:
> -			fsckcfg.overwrite = true;
> +			fsckcfg.preserve_perms = true;
> +			fsckcfg.no_preserve_perms = false;
> +			break;
> +		case 9:
> +			fsckcfg.no_preserve_owner = true;
> +			fsckcfg.no_preserve_perms = true;
> +			fsckcfg.preserve_owner = false;
> +			fsckcfg.preserve_perms = false;
> +			break;
> +		case 10:
> +			fsckcfg.no_preserve_owner = true;
> +			fsckcfg.preserve_owner = false;
> +			break;
> +		case 11:
> +			fsckcfg.no_preserve_perms = true;
> +			fsckcfg.preserve_perms = false;
>  			break;
>  		default:
>  			return -EINVAL;
>  		}
>  	}
>  
> +	if (fsckcfg.extract_path) {
> +		if (!fsckcfg.extract_pos && !fsckcfg.force) {
> +			erofs_err("--extract=/ must be used together with --force");
> +			return -EINVAL;
> +		}
> +	} else {
> +		if (fsckcfg.force)
> +			erofs_err("--force must be used together with --extract=X");
> +		if (fsckcfg.overwrite)
> +			erofs_err("--overwrite must be used together with --extract=X");
> +		if (fsckcfg.preserve_owner || fsckcfg.preserve_perms ||
> +			  fsckcfg.no_preserve_owner || fsckcfg.no_preserve_perms)
> +			erofs_err("--[no-]preserve[-owner/-perms] must be used together with --extract=X");
> +	}
> +
>  	if (optind >= argc)
>  		return -EINVAL;
>  
> -	if (!fsckcfg.extract_path)
> -		if (fsckcfg.overwrite || fsckcfg.preserve_owner ||
> -		    fsckcfg.preserve_perms)
> -			return -EINVAL;
> -
>  	cfg.c_img_path = strdup(argv[optind++]);
>  	if (!cfg.c_img_path)
>  		return -ENOMEM;
> @@ -680,13 +726,19 @@ int main(int argc, char **argv)
>  
>  	erofs_init_configure();
>  
> +	fsckcfg.superuser = geteuid() == 0;
> +	fsckcfg.umask = umask(0);
>  	fsckcfg.corrupted = false;
> +	fsckcfg.logical_blocks = 0;
> +	fsckcfg.physical_blocks = 0;
>  	fsckcfg.print_comp_ratio = false;
>  	fsckcfg.check_decomp = false;
>  	fsckcfg.extract_path = NULL;
>  	fsckcfg.extract_pos = 0;
> -	fsckcfg.logical_blocks = 0;
> -	fsckcfg.physical_blocks = 0;
> +	fsckcfg.force = false;
> +	fsckcfg.overwrite = false;
> +	fsckcfg.preserve_owner = fsckcfg.superuser;
> +	fsckcfg.preserve_perms = fsckcfg.superuser;
>  
>  	err = erofsfsck_parse_options_cfg(argc, argv);
>  	if (err) {
> @@ -695,8 +747,6 @@ int main(int argc, char **argv)
>  		goto exit;
>  	}
>  
> -	fsckcfg.umask = umask(0);
> -
>  	err = dev_open_ro(cfg.c_img_path);
>  	if (err) {
>  		erofs_err("failed to open image file");
> -- 
> 2.30.2
