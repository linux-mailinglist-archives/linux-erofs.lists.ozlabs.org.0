Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60A64957E7
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jan 2022 02:47:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jg2Lq3xzxz30NN
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jan 2022 12:47:31 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jg2Ll4Ywdz2xBL
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jan 2022 12:47:26 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V2Or0Xj_1642729637; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V2Or0Xj_1642729637) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 21 Jan 2022 09:47:18 +0800
Date: Fri, 21 Jan 2022 09:47:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Igor Ostapenko <igoreisberg@gmail.com>
Subject: Re: [PATCH] erofs-utils: fsck: fix issues related to --extract=X
Message-ID: <YeoQpMl+/dLfbpn+@B-P7TQMD6M-0146.local>
References: <20220121003116.135-1-igoreisberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220121003116.135-1-igoreisberg@gmail.com>
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

On Fri, Jan 21, 2022 at 02:31:16AM +0200, Igor Ostapenko wrote:
> From: Igor Eisberg <igoreisberg@gmail.com>
> 
> Have to disagree with some changes made to my original patch.

Thanks for the patch. If you had opinion with the original patch,
I'm very happy that if you could comment on the original patch
at that time in public. erofs-utils works for long-term plans, 
we need to consider more scenarios in advance (I admit I cannot
think carefully very well as well). Sorry about slight modification
your original patch.

> 1) Using tar options makes no sense here, since tar has default
>    behaviors set for normal user (uses user's owner ID + perms)
>    vs. root user (preserve original owner IDs + perms by default),

So we can have such behavior as well (it seems many extractors
have such behavior, such as tar and unsquashfs.)

>    and the options were there to override that preset behavior.
>    fsck doesn't have any default behavior set, and the default
>    values for preserve_owner and preserve_perms were left for
>    the compiler to decide. This change sets the default values
>    to false explicitly.
>    "--no-same-owner" and "--no-same-permissions" are completely
>    redundant in fsck's case, unlike tar.

No matter what default behaviors we use now, it should have both
options with opposite behaviors. Otherwise, if some user write
a script and the default behavior then changes, it will break
completely (because such users don't need to rely on the default
behavior actually.)

>    * "--same-owner" and "--same-permissions" were renamed to
>      "--preserve-owner" and "--preserve-perms" to better represent
>      what these options do, the word "same" is ambiguous and tells
>      nothing to the user ("same" to what?).

I'm either ok with "--preserve-owner" and "--preserve-perms"
words.

>    * Added "--preserve" as a shortcut for both options in one.

Ok, if you like, I'm fine with this.

>    * Fixed option descriptions as they had typos and were too
>      ambiguous ("extract information" to where? separate file?).
> 2) Errors for chmod 0700 were not logged, failures were silent.

Yeah, thanks! (but to make sure that each line (except for the print
message) is no more than 80 chars.)

> 3) --extract=/ should fail with a proper error due to it being
>    dangerous if used with sudo.

I tend to disagree such idea, since add (or overwrite) files
to / may be useful. Also, tar can do like this, why not
fsck.erofs? If you think that is great dangerous, we could add
another '--force' option together with this.

Thanks,
Gao Xiang

> 
> Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
> ---
>  fsck/main.c | 62 ++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 37 insertions(+), 25 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 14534b9..e2f4157 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -18,15 +18,17 @@
>  static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
>  
>  struct erofsfsck_cfg {
> -	bool corrupted;
>  	bool print_comp_ratio;
>  	bool check_decomp;
>  	char *extract_path;
>  	size_t extract_pos;
> -	bool overwrite, preserve_owner, preserve_perms;
> +	bool overwrite;
> +	bool preserve_owner;
> +	bool preserve_perms;
>  	mode_t umask;
>  	u64 physical_blocks;
>  	u64 logical_blocks;
> +	bool corrupted;
>  };
>  static struct erofsfsck_cfg fsckcfg;
>  
> @@ -34,11 +36,10 @@ static struct option long_options[] = {
>  	{"help", no_argument, 0, 1},
>  	{"extract", optional_argument, 0, 2},
>  	{"device", required_argument, 0, 3},
> -	{"no-same-owner", no_argument, 0, 4},
> -	{"no-same-permissions", no_argument, 0, 5},
> -	{"same-owner", no_argument, 0, 6},
> -	{"same-permissions", no_argument, 0, 7},
> -	{"overwrite", no_argument, 0, 8},
> +	{"overwrite", no_argument, 0, 4},
> +	{"preserve", no_argument, 0, 5},
> +	{"preserve-owner", no_argument, 0, 6},
> +	{"preserve-perms", no_argument, 0, 7},
>  	{0, 0, 0, 0},
>  };
>  
> @@ -66,11 +67,10 @@ static void usage(void)
>  	      " --extract[=X]          check if all files are well encoded, optionally extract to X\n"
>  	      " --help                 display this help and exit\n"
>  	      "\nExtraction options (--extract=X is required):\n"
> -	      " --no-same-owner        extract files as yourself\n"
> -	      " --no-same-permissions  apply the user's umask when extracting permission\n"
> -	      " --same-permissions     extract information about file permissions\n"
> -	      " --same-owner           extract files about the file ownerships\n"
> -	      " --overwrite            if file already exists then overwrite\n"
> +	      " --overwrite            overwrite files that already exist\n"
> +	      " --preserve             extract with original ownerships and permissions\n"
> +	      " --preserve-owner       extract with original ownerships only\n"
> +	      " --preserve-perms       extract with original permissions only\n"
>  	      "\nSupported algorithms are: ", stderr);
>  	print_available_decompressors(stderr, ", ");
>  }
> @@ -112,10 +112,16 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>  				if (len == 0)
>  					return -EINVAL;
>  
> -				/* remove trailing slashes except root */
> -				while (len > 1 && optarg[len - 1] == '/')
> +				/* remove trailing slashes */
> +				while (len > 0 && optarg[len - 1] == '/')
>  					len--;
>  
> +				/* extracting directly to root is dangerous */
> +				if (len == 0) {
> +					erofs_err("invalid extract path: /");
> +					return -EINVAL;
> +				}
> +
>  				fsckcfg.extract_path = malloc(PATH_MAX);
>  				if (!fsckcfg.extract_path)
>  					return -ENOMEM;
> @@ -131,10 +137,11 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>  			++sbi.extra_devices;
>  			break;
>  		case 4:
> -			fsckcfg.preserve_owner = false;
> +			fsckcfg.overwrite = true;
>  			break;
>  		case 5:
> -			fsckcfg.preserve_perms = false;
> +			fsckcfg.preserve_owner = true;
> +			fsckcfg.preserve_perms = true;
>  			break;
>  		case 6:
>  			fsckcfg.preserve_owner = true;
> @@ -142,9 +149,6 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>  		case 7:
>  			fsckcfg.preserve_perms = true;
>  			break;
> -		case 8:
> -			fsckcfg.overwrite = true;
> -			break;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -465,7 +469,7 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
>  		struct stat st;
>  
>  		if (errno != EEXIST) {
> -			erofs_err("failed to create directory %s: %s",
> +			erofs_err("failed to create directory: %s (%s)",
>  				  fsckcfg.extract_path, strerror(errno));
>  			return -errno;
>  		}
> @@ -481,8 +485,11 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
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
> @@ -510,6 +517,8 @@ again:
>  				}
>  			} else if (errno == EACCES &&
>  				   chmod(fsckcfg.extract_path, 0700) < 0) {
> +					erofs_err("failed to set permissions: %s (%s)",
> +						  fsckcfg.extract_path, strerror(errno));
>  				return -errno;
>  			}
>  			tryagain = false;
> @@ -680,13 +689,13 @@ int main(int argc, char **argv)
>  
>  	erofs_init_configure();
>  
> -	fsckcfg.corrupted = false;
>  	fsckcfg.print_comp_ratio = false;
>  	fsckcfg.check_decomp = false;
>  	fsckcfg.extract_path = NULL;
>  	fsckcfg.extract_pos = 0;
> -	fsckcfg.logical_blocks = 0;
> -	fsckcfg.physical_blocks = 0;
> +	fsckcfg.overwrite = false;
> +	fsckcfg.preserve_owner = false;
> +	fsckcfg.preserve_perms = false;
>  
>  	err = erofsfsck_parse_options_cfg(argc, argv);
>  	if (err) {
> @@ -696,6 +705,9 @@ int main(int argc, char **argv)
>  	}
>  
>  	fsckcfg.umask = umask(0);
> +	fsckcfg.logical_blocks = 0;
> +	fsckcfg.physical_blocks = 0;
> +	fsckcfg.corrupted = false;
>  
>  	err = dev_open_ro(cfg.c_img_path);
>  	if (err) {
> @@ -725,7 +737,7 @@ int main(int argc, char **argv)
>  		if (!fsckcfg.extract_path)
>  			erofs_info("No error found");
>  		else
> -			erofs_info("Extract data successfully");
> +			erofs_info("Filesystem extracted successfully");
>  
>  		if (fsckcfg.print_comp_ratio) {
>  			double comp_ratio =
> -- 
> 2.30.2
