Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B304AE65B
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 02:48:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JtjTH48pjz30jV
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 12:48:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JtjTC1VWwz2yNv
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 12:48:29 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R281e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V3yQUNL_1644371300; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V3yQUNL_1644371300) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 09:48:22 +0800
Date: Wed, 9 Feb 2022 09:48:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH] erofs-utils: Print program name and version to stdout
Message-ID: <YgMdZH05kom9TEvx@B-P7TQMD6M-0146.local>
References: <20220209005307.1288161-1-pcc@google.com>
 <20220209005307.1288161-2-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220209005307.1288161-2-pcc@google.com>
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

On Tue, Feb 08, 2022 at 04:53:07PM -0800, Peter Collingbourne wrote:
> The program name and version is not an error message, so it should
> go to stdout, not stderr.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>

Applied, thanks!

Thanks,
Gao Xiang

> ---
>  dump/main.c | 2 +-
>  fsck/main.c | 2 +-
>  fuse/main.c | 2 +-
>  mkfs/main.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index b7560ec..ad1b62e 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -109,7 +109,7 @@ static void usage(void)
>  
>  static void erofsdump_print_version(void)
>  {
> -	fprintf(stderr, "dump.erofs %s\n", cfg.c_version);
> +	printf("dump.erofs %s\n", cfg.c_version);
>  }
>  
>  static int erofsdump_parse_options_cfg(int argc, char **argv)
> diff --git a/fsck/main.c b/fsck/main.c
> index aefa881..2ebc5e9 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -43,7 +43,7 @@ static void usage(void)
>  
>  static void erofsfsck_print_version(void)
>  {
> -	fprintf(stderr, "fsck.erofs %s\n", cfg.c_version);
> +	printf("fsck.erofs %s\n", cfg.c_version);
>  }
>  
>  static int erofsfsck_parse_options_cfg(int argc, char **argv)
> diff --git a/fuse/main.c b/fuse/main.c
> index 255965e..b7760e4 100644
> --- a/fuse/main.c
> +++ b/fuse/main.c
> @@ -210,7 +210,7 @@ int main(int argc, char *argv[])
>  	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
>  
>  	erofs_init_configure();
> -	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
> +	printf("%s %s\n", basename(argv[0]), cfg.c_version);
>  
>  #if defined(HAVE_EXECINFO_H) && defined(HAVE_BACKTRACE)
>  	if (signal(SIGSEGV, signal_handle_sigsegv) == SIG_ERR) {
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 58a6441..4325ab4 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -548,7 +548,7 @@ int parse_source_date_epoch(void)
>  void erofs_show_progs(int argc, char *argv[])
>  {
>  	if (cfg.c_dbg_lvl >= EROFS_WARN)
> -		fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
> +		printf("%s %s\n", basename(argv[0]), cfg.c_version);
>  }
>  
>  int main(int argc, char **argv)
> -- 
> 2.35.0.263.gb82422642f-goog
