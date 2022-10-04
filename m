Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED815F47E5
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 18:49:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhkFW0Ph3z306m
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 03:49:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TWo6VkhG;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TWo6VkhG;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MhkFR55d6z2xtt
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Oct 2022 03:49:31 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CE3E56132D;
	Tue,  4 Oct 2022 16:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FF6C433D6;
	Tue,  4 Oct 2022 16:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664902167;
	bh=LfpkoA+sYhVuwxYQtP8704F9s0FWq5DMisAmDm0hKsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWo6VkhGMe11eAm+tTZbdg0TMI5rnx3tvk97kzysNDiMWHxRWyMuDj69K3uqlrfoH
	 1mqb1BMfrFPKflKx2B5zGx0ghyRH1c1mHfaE+nSUJmh8riH82OO8OWfDB/8fY0QQ8D
	 ugquMlBqzKG0dVVNeV7FOnZaKMRX5iDAO4iAd6MOQdw0xmIhdNzRzLSm0N5tOBHNjE
	 jagNDfwIozORaRJlcmnAD8QvQwAbGQxUFeQJtsHqYCeFLxevCSi/uvdtUnobn3/dZd
	 S/psbsHLgdoWZiog0gbJxqB5SM5GnGhkOTqjaHMcBLSTTkGfDsTuSFk4j5ImkwjTmj
	 h7/XXXQB5UysQ==
Date: Wed, 5 Oct 2022 00:49:23 +0800
From: Gao Xiang <xiang@kernel.org>
To: Naoto Yamaguchi <wata2ki@gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: Add volume-name setting support
Message-ID: <YzxkE6rN1KcZmF09@debian>
Mail-Followup-To: Naoto Yamaguchi <wata2ki@gmail.com>,
	linux-erofs@lists.ozlabs.org,
	Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
References: <YzxgPKoi9Q1scK3N@debian>
 <20221004164324.11481-1-naoto.yamaguchi@aisin.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004164324.11481-1-naoto.yamaguchi@aisin.co.jp>
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

On Wed, Oct 05, 2022 at 01:43:24AM +0900, Naoto Yamaguchi wrote:
> The erofs_super_block has volume_name field.  On the other hand,
> mkfs.erofs is not supporting to set volume name.
> This patch add volume-name setting support to mkfs.erofs.
> Option keyword is similar to mkfs.vfat.
> 
> usage:
>   mkfs.erofs -n volume-name image-fn dir
> 

commit message is not updated... also it'd be better to bump
up the patch version in the subject line like:

[PATCH v2] erofs-utils: mkfs: ...

> Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
> ---
>  include/erofs/internal.h |  1 +
>  man/mkfs.erofs.1         |  5 +++++
>  mkfs/main.c              | 13 ++++++++++++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 2e0aae8..7dc42eb 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -92,6 +92,7 @@ struct erofs_sb_info {
>  	u64 inos;
>  
>  	u8 uuid[16];
> +	char volume_name[16];
>  
>  	u16 available_compr_algs;
>  	u16 lz4_max_distance;
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index 11e8323..b65d01b 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -66,6 +66,11 @@ Pack the tail part (pcluster) of compressed files into its metadata to save
>  more space and the tail part I/O. (Linux v5.17+)
>  .RE
>  .TP
> +.BI "\-L " volume-label
> +Set the volume label for the filesystem to
> +.IR volume-label .
> +The maximum length of the volume label is 16 bytes.
> +.TP
>  .BI "\-T " #
>  Set all files to the given UNIX timestamp. Reproducible builds requires setting
>  all to a specific one.
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 594ecf9..08a4215 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -84,6 +84,7 @@ static void usage(void)
>  	      " -zX[,Y]               X=compressor (Y=compression level, optional)\n"
>  	      " -C#                   specify the size of compress physical cluster in bytes\n"
>  	      " -EX[,...]             X=extended options\n"
> +	      " -L volume-label        set the volume label (max 16 bytes).\n"

Not aligned here.

>  	      " -T#                   set a fixed UNIX timestamp # to all files\n"
>  #ifdef HAVE_LIBUUID
>  	      " -UX                   use a given filesystem UUID\n"
> @@ -212,7 +213,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  	int opt, i;
>  	bool quiet = false;
>  
> -	while ((opt = getopt_long(argc, argv, "C:E:T:U:d:x:z:",
> +	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:d:x:z:",
>  				  long_options, NULL)) != -1) {
>  		switch (opt) {
>  		case 'z':
> @@ -255,6 +256,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  			if (opt)
>  				return opt;
>  			break;
> +
> +		case 'L':
> +			if (optarg == NULL || strlen(optarg) > 16) {

					sizeof(sbi.volume_name);

> +				erofs_err("invalid volume label");
> +				return -EINVAL;
> +			}
> +			strncpy(sbi.volume_name, optarg, 16);

						sizeof(sbi.volume_name)?


Thanks,
Gao Xiang

> +			break;
> +
>  		case 'T':
>  			cfg.c_unix_timestamp = strtoull(optarg, &endptr, 0);
>  			if (cfg.c_unix_timestamp == -1 || *endptr != '\0') {
> @@ -483,6 +493,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>  	sb.blocks       = cpu_to_le32(*blocks);
>  	sb.root_nid     = cpu_to_le16(root_nid);
>  	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
> +	memcpy(sb.volume_name, sbi.volume_name, sizeof(sb.volume_name));
>  
>  	if (erofs_sb_has_compr_cfgs())
>  		sb.u1.available_compr_algs = sbi.available_compr_algs;
> -- 
> 2.25.1
> 
