Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF234DD46F
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 06:37:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KKXpH5XSfz30D6
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 16:37:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KKXp94Ccfz2ync
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Mar 2022 16:37:20 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R381e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V7V4phY_1647581829; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V7V4phY_1647581829) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 18 Mar 2022 13:37:11 +0800
Date: Fri, 18 Mar 2022 13:37:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Anderson <dvander@google.com>
Subject: Re: [PATCH v2] erofs-utils: mkfs: use extended inodes when ctime is
 set
Message-ID: <YjQaha1jOV5n52AY@B-P7TQMD6M-0146.local>
References: <20220318052536.1358747-1-dvander@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220318052536.1358747-1-dvander@google.com>
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

Hi David,

On Fri, Mar 18, 2022 at 05:25:36AM +0000, David Anderson via Linux-erofs wrote:
> Currently ctime is effectively ignored because most inodes are compact.
> If ctime was set, and it's different from the build time, then extended
> inodes should be used instead.
> 

Thanks for your time on this!

I will update this slightly (use mtime rather than ctime), since I will
apply the other patches first...

> To guarantee that timestamps do not cause extended inodes, a fixed
> timestamp should be used (-T). Additionally, a new --ignore-mtime option
> has been added to preserve the old behavior.
> 
> Signed-off-by: David Anderson <dvander@google.com>
> ---
>  include/erofs/config.h | 1 +
>  lib/config.c           | 1 +
>  lib/inode.c            | 5 +++++
>  man/mkfs.erofs.1       | 5 +++++
>  mkfs/main.c            | 5 +++++
>  5 files changed, 17 insertions(+)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index cb064b6..0a1b18b 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -43,6 +43,7 @@ struct erofs_configure {
>  	char c_timeinherit;
>  	char c_chunkbits;
>  	bool c_noinline_data;
> +	bool c_ignore_mtime;
>  
>  #ifdef HAVE_LIBSELINUX
>  	struct selabel_handle *sehnd;
> diff --git a/lib/config.c b/lib/config.c
> index f1c8edf..cc15e57 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -20,6 +20,7 @@ void erofs_init_configure(void)
>  	cfg.c_dbg_lvl  = EROFS_WARN;
>  	cfg.c_version  = PACKAGE_VERSION;
>  	cfg.c_dry_run  = false;
> +	cfg.c_ignore_mtime = false;
>  	cfg.c_compr_level_master = -1;
>  	cfg.c_force_inodeversion = 0;
>  	cfg.c_inline_xattr_tolerance = 2;
> diff --git a/lib/inode.c b/lib/inode.c
> index 461c797..99a4b2f 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -730,6 +730,11 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
>  		return true;
>  	if (inode->i_nlink > USHRT_MAX)
>  		return true;
> +	if ((inode->i_ctime != sbi.build_time ||
> +	     inode->i_ctime_nsec != sbi.build_time_nsec) &&
> +	    !cfg.c_ignore_mtime) {
> +		return true;
> +	}
>  	return false;
>  }
>  
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index 9c7788e..679291b 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -109,6 +109,11 @@ Set all file uids to \fIUID\fR.
>  .BI "\-\-force-gid=" GID
>  Set all file gids to \fIGID\fR.
>  .TP
> +.BI "\-\-ignore-mtime"
> +File modification time is ignored whenever it would cause \fBmkfs.erofs\fR to
> +use extended inodes over compact inodes. When not using a fixed timestamp,
> +this can reduce metadata size.
> +.TP
>  .B \-\-help
>  Display this help and exit.
>  .TP
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 3f34450..93caf67 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -49,6 +49,7 @@ static struct option long_options[] = {
>  	{"chunksize", required_argument, NULL, 11},
>  	{"quiet", no_argument, 0, 12},
>  	{"blobdev", required_argument, NULL, 13},
> +	{"ignore-mtime", no_argument, NULL, 14},
>  #ifdef WITH_ANDROID
>  	{"mount-point", required_argument, NULL, 512},
>  	{"product-out", required_argument, NULL, 513},
> @@ -95,6 +96,7 @@ static void usage(void)
>  #endif
>  	      " --force-uid=#         set all file uids to # (# = UID)\n"
>  	      " --force-gid=#         set all file gids to # (# = GID)\n"
> +	      " --ignore-mtime        use build time and ignore inode modification time\n"

				      Use build time and ignore inode modification time if possible

Since if extended inodes are really needed (e.g files more than 4GiB,
etc..), extended inodes are still necessary.

Otherwise looks good to me!
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(Will apply together with other patches later...)

Thanks,
Gao Xiang

>  	      " --help                display this help and exit\n"
>  	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
>  	      " --quiet               quiet execution (do not write anything to standard output.)\n"
> @@ -366,6 +368,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  		case 13:
>  			cfg.c_blobdev_path = optarg;
>  			break;
> +		case 14:
> +			cfg.c_ignore_mtime = true;
> +			break;
>  		case 1:
>  			usage();
>  			exit(0);
> -- 
> 2.35.1.894.gb6a874cedc-goog
