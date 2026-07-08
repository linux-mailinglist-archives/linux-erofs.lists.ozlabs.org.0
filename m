Return-Path: <linux-erofs+bounces-3862-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zvWsJoxGTmojKAIAu9opvQ
	(envelope-from <linux-erofs+bounces-3862-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 14:46:04 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8928D7266DC
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 14:46:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ViWKUrbP;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3862-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3862-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwHrn3CLRz2xll;
	Wed, 08 Jul 2026 22:46:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783514761;
	cv=none; b=FG3/yiSFYn8CyoZDC9xmNhPkjrtvo5cW9LztP8mquj5KpDWZNaKPYj2Vpj38BhwC0XqZtYm5mwVb0BZx1QCrvhUO+a4F1LyXL6Ju02kWIsUYQXxDzfRmfYmEwI2w7b/M79CJPv6iRrOGLBa8Z/Br/rdj8gybeNn873+9gImYsV5HJqq1rMqZvrPJWZ1dfWYqb/85GgzNjIu+0VFscXQhqzvxt+RbP2Jtbcpk9wykKC+BeH/S7XEt4B816OOcdtgxfsAXp0PjyUoxpThTN+BV4k3ftMJv7CO1WHUD+1V7ZtpmidJSMbjFXWtn0gp+F6JojMW/8L5IOSLLORUbzg14Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783514761; c=relaxed/relaxed;
	bh=8gLUISXsEXXGsVU+VRbdg+Y0WurMokiwbBe+bVS6deY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq7eS1rKYVWUndNm352QxDFOFNofFfIStCdhXmQ+C2QbnyJVDHfNtO2Y9I2Jx+HS26mNepbyEMeTR2w8srhG5/l90L3dovsyGKUPgcUOaS/NnLGvcjccHGnViZtckJ/1YeFuvrGBHjfvSkUiKsldcGCI9p5St8hY0jv8RgP2eA5CrOTcUaBHpEdPe67YYnJO+mORZMZ8Tw0Q2aTNkWFZGm6FVrAmB9Ttf28JBHitT/vqfYwYsWwI9TSG0S4EwK+TNeF8QFiDz9rNvrt2NLm+FdKCJ9UpCUwpVujorelI6Sda6++XHNAe1lRzFYQf67LBMoHmMYAvcSoAED7FJvDgWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViWKUrbP; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwHrm2cXhz2xKh
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Jul 2026 22:46:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B06266001D;
	Wed,  8 Jul 2026 12:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC791F000E9;
	Wed,  8 Jul 2026 12:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783514757;
	bh=8gLUISXsEXXGsVU+VRbdg+Y0WurMokiwbBe+bVS6deY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ViWKUrbPIizs80Rz3N4C70+BqKOA2tb6XGtUwaY8ZH0W3n3U20OGv3MEBxzEu5xqc
	 wDSL61U4QmH8SglpVXRSqDp4hQlSRV4fMgojpRhwIgvfTKG8CCOctaNyMQwXnRoeDy
	 VorRkFO1g98HYMRA/fZ00+5HoR9BQHHvQ5+b73piIx3WericW+PvW6gaoqHvPIXxQ9
	 qatt15qsHuT7RzwAk6jVcPzaUukl6nxr1ve+d6m8n+sOY8EN0R0tzHBgDuNdqr2j/g
	 7tWCneeq8Bb6hPmmhbM9Rnpv4SxKIhgl15a3huxxyOdg/Q7aMYguxV2jaPElWsEbsh
	 9FEWQvrU1DpSA==
Date: Wed, 8 Jul 2026 20:45:50 +0800
From: Gao Xiang <xiang@kernel.org>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] erofs: accept source file descriptor via fsconfig
Message-ID: <ak5GfvVfWLJU1EwK@debian>
Mail-Followup-To: Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
References: <20260708093446.3370200-1-gscrivan@redhat.com>
 <20260708093446.3370200-2-gscrivan@redhat.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708093446.3370200-2-gscrivan@redhat.com>
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3862-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8928D7266DC

Hi Giuseppe,

On Wed, Jul 08, 2026 at 11:34:26AM +0200, Giuseppe Scrivano wrote:
> Add fsparam_fd("source") so that userspace can pass an already-opened
> file descriptor instead of a path string.  When the fd is provided via
> fsconfig(FSCONFIG_SET_FD, "source", NULL, fd), it is stored directly
> in sbi->dif0.file and erofs_fc_get_tree() skips the filp_open() call.
> 
> This is useful for mount namespaces where the backing file may not be
> reachable by path, and for tools that already hold an fd to the image
> (e.g. composefs reusing an erofs mount's backing file).
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
>  fs/erofs/super.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 86fa5c6a0c70..8ad1689f74b2 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>  enum {
>  	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>  	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
> +	Opt_source_fd,
>  };
>  
>  static const struct constant_table erofs_param_cache_strategy[] = {
> @@ -413,6 +414,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>  	fsparam_flag_no("directio",	Opt_directio),
>  	fsparam_u64("fsoffset",		Opt_fsoffset),
>  	fsparam_flag("inode_share",	Opt_inode_share),
> +	fsparam_fd("source",		Opt_source_fd),
>  	{}
>  };
>  
> @@ -524,6 +526,15 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>  		else
>  			set_opt(&sbi->opt, INODE_SHARE);
>  		break;
> +	case Opt_source_fd:
> +		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE)) {
> +			errorfc(fc, "source fd option not supported");

Thanks for the patch!
For this commit, it looks good to me overall, just some nits:

I guess we could just move this one into erofs_fc_get_tree(), see below.

> +			return -EINVAL;
> +		}
> +		if (sbi->dif0.file)

Do we need to allow multi-shot source_fd?

I guess we could just bail out directly instead.

> +			fput(sbi->dif0.file);
> +		sbi->dif0.file = get_file(param->file);
> +		break;
>  	}
>  	return 0;
>  }
> @@ -752,14 +763,18 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  static int erofs_fc_get_tree(struct fs_context *fc)
>  {
> -	int ret;
> +	struct erofs_sb_info *sbi = fc->s_fs_info;

Nit:

	struct file *file = sbi->dif0.file;

>  
> -	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
> -		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
> -			GET_TREE_BDEV_QUIET_LOOKUP : 0);
> -	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && ret == -ENOTBLK) {
> -		struct erofs_sb_info *sbi = fc->s_fs_info;
> +	if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) || !sbi->dif0.file) {

	if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) || !file) {

>  		struct file *file;
> +		int ret;
> +
> +		ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
> +			IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
> +				GET_TREE_BDEV_QUIET_LOOKUP : 0);
> +		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ||
> +		    ret != -ENOTBLK)
> +			return ret;
>  
>  		if (!fc->source)
>  			return invalf(fc, "No source specified");
> @@ -767,12 +782,11 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>  		if (IS_ERR(file))
>  			return PTR_ERR(file);
>  		sbi->dif0.file = file;
> -
> -		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
> -		    sbi->dif0.file->f_mapping->a_ops->read_folio)
> -			return get_tree_nodev(fc, erofs_fc_fill_super);
>  	}
> -	return ret;
> +	if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
> +	    sbi->dif0.file->f_mapping->a_ops->read_folio)
> +		return get_tree_nodev(fc, erofs_fc_fill_super);
> +	return -EINVAL;

Currently we don't support bdev-backed mounts for this, so I'm fine to
support file-backed mounts only for now.

So nit:

	if (!S_ISREG(file_inode(file)->i_mode) ||
	    !file->f_mapping->a_ops->read_folio) {
		errorfc(fc, "source is unsupported");
		return -EINVAL;
	}
	return get_tree_nodev(fc, erofs_fc_fill_super);

Thanks,
Gao Xiang

>  }
>  
>  static int erofs_fc_reconfigure(struct fs_context *fc)
> -- 
> 2.55.0
> 
> 

