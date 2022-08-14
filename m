Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23F1591EAA
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Aug 2022 08:22:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M56kt08fWz3bPP
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Aug 2022 16:21:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uB77su/3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uB77su/3;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M56kq3HzNz2xJ5
	for <linux-erofs@lists.ozlabs.org>; Sun, 14 Aug 2022 16:21:55 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3C3C160FB7;
	Sun, 14 Aug 2022 06:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136D7C433D6;
	Sun, 14 Aug 2022 06:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660458112;
	bh=2M2H4LsZhS07MhxBhpblSzaGg5eoJr/f4q3xFoYivNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uB77su/3hVIh6BM96y2W8ZN1D9d7O/HkRGSDCdXeSO6LJustzOqHFf6Y3UOr5HWFn
	 sBDTMEafE7gdHORBm9bEJFNJUUG1LMMBlJ51aUT4mM1R29mezTWNoWu3SWVjB/NIaE
	 xGOxmxHum5b7BbeZLMtZMBTz5K647tbwR0iMZpiBaSMrRctpIN2Zjflhcxs5D4Ph5y
	 jqFTFpA6BEP0qbEG5FXGGKykUBaoHF9DQ5KGPzNjhA/1THGno9Dgi7UZsSDv43hhMk
	 AVpxR7pO+TDQruUdV8IKuaYGYdFejrzxOIAiu9oNUpB69PYRU4rWebhqrDv9jK1tDN
	 z/Bl0cJkc48sw==
Date: Sun, 14 Aug 2022 14:21:33 +0800
From: Gao Xiang <xiang@kernel.org>
To: Naoto Yamaguchi <wata2ki@gmail.com>
Subject: Re: [PATCH 1/2] erofs-utils: mkfs: improvement for unprivileged
 container support
Message-ID: <YviUbcOkLJrC55PW@debian>
Mail-Followup-To: Naoto Yamaguchi <wata2ki@gmail.com>,
	linux-erofs@lists.ozlabs.org,
	Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
References: <20220814022915.7964-1-naoto.yamaguchi@aisin.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220814022915.7964-1-naoto.yamaguchi@aisin.co.jp>
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
Cc: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Aug 14, 2022 at 11:29:14AM +0900, Naoto Yamaguchi wrote:
> When developer want to use erofs at guest container rootfs, it require
> to uid/gid offsetting for each files.
> This patch add uid/gid offsetting feature to mkfs.erofs.
> 
> Example of how to use uid/gid offset:
>  In case of lxc guest image.
> 
>  Image creation:
>      mkafs.erofs --uid-offset=100000 --gid-offset=100000 file dir
> 
>  Set lxc config:
>      lxc.idmap = u 0 100000 65536
>      lxc.idmap = g 0 100000 65536
> 
> Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
> ---
>  include/erofs/config.h |  1 +
>  lib/inode.c            |  2 ++
>  mkfs/main.c            | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 0d0916c..19b7a67 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -67,6 +67,7 @@ struct erofs_configure {
>  	u32 c_dict_size;
>  	u64 c_unix_timestamp;
>  	u32 c_uid, c_gid;
> +	u32 c_uid_offset, c_gid_offset;
>  #ifdef WITH_ANDROID
>  	char *mount_point;
>  	char *target_out_path;
> diff --git a/lib/inode.c b/lib/inode.c
> index f192510..cc72c01 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -836,6 +836,8 @@ static int erofs_fill_inode(struct erofs_inode *inode,
>  	inode->i_mode = st->st_mode;
>  	inode->i_uid = cfg.c_uid == -1 ? st->st_uid : cfg.c_uid;
>  	inode->i_gid = cfg.c_gid == -1 ? st->st_gid : cfg.c_gid;
> +	inode->i_uid += cfg.c_uid_offset;
> +	inode->i_gid += cfg.c_gid_offset;
>  	inode->i_mtime = st->st_mtime;
>  	inode->i_mtime_nsec = ST_MTIM_NSEC(st);
>  
> diff --git a/mkfs/main.c b/mkfs/main.c
> index d2c9830..819b1f0 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -51,6 +51,8 @@ static struct option long_options[] = {
>  	{"blobdev", required_argument, NULL, 13},
>  	{"ignore-mtime", no_argument, NULL, 14},
>  	{"preserve-mtime", no_argument, NULL, 15},
> +	{"uid-offset", required_argument, NULL, 16},
> +	{"gid-offset", required_argument, NULL, 17},
>  #ifdef WITH_ANDROID
>  	{"mount-point", required_argument, NULL, 512},
>  	{"product-out", required_argument, NULL, 513},
> @@ -97,6 +99,8 @@ static void usage(void)
>  #endif
>  	      " --force-uid=#         set all file uids to # (# = UID)\n"
>  	      " --force-gid=#         set all file gids to # (# = GID)\n"
> +	      " --uid-offset=#        add offset # to all file uids (# = id offset)\n"
> +	      " --gid-offset=#        add offset # to all file gids (# = id offset)\n"

I will update this here to follow alphabet order as well.

Thanks,
Gao Xiang

>  	      " --help                display this help and exit\n"
>  	      " --ignore-mtime        use build time instead of strict per-file modification time\n"
>  	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
> @@ -323,6 +327,20 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  		case 10:
>  			cfg.c_compress_hints_file = optarg;
>  			break;
> +		case 16:
> +			cfg.c_uid_offset = strtoul(optarg, &endptr, 0);
> +			if (cfg.c_uid_offset == -1 || *endptr != '\0') {
> +				erofs_err("invalid uid offset %s", optarg);
> +				return -EINVAL;
> +			}
> +			break;
> +		case 17:
> +			cfg.c_gid_offset = strtoul(optarg, &endptr, 0);
> +			if (cfg.c_gid_offset == -1 || *endptr != '\0') {
> +				erofs_err("invalid gid offset %s", optarg);
> +				return -EINVAL;
> +			}
> +			break;
>  #ifdef WITH_ANDROID
>  		case 512:
>  			cfg.mount_point = optarg;
> -- 
> 2.25.1
> 
