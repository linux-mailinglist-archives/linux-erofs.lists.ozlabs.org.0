Return-Path: <linux-erofs+bounces-248-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 79813A9F431
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Apr 2025 17:16:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZmRqM1Fjpz2xKN;
	Tue, 29 Apr 2025 01:16:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745853375;
	cv=none; b=T5VOESOzPJqo5bOS2/a7ecGgs3er2PjtIsTz991nQcaIvFDTfa92zXxfG0KfHmX2+iOm04vveP8dKIvwGFP1/3HoZa3eV+2S6aS+/3HAyzCESq4F5F5v7+eSBaYo0J4EMit+OjUtI0N5i64/xF0ejT2jrZ4kIcwim43O8GDMh1pZUsZZefTnqIf3tgRSwifpKlgstXSL++sCvZg2ci7XjAvXZ+OlchT+avPGKLTQetP8PsWOA3GlQduzCjTM2aMSwHvNXMwh/A3DougHKEo3XLaToL5iqlitEGh6x42YlkDZc4YPSw+DqWI8k8fiZVnz/Yrkoe6/cuja7OX8yq8sdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745853375; c=relaxed/relaxed;
	bh=+4TP/vOOqK0+ANtWn9LasfGAUghAo4D8hy/H5EabMDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOA/mb+5eYL+KUSMygpFtdDJqVQH1730G7zBl2Z39JPblFDS/aHsndtWwjV1haZ75aG5uMipz7qzT+JS5Nc1tjhYDP7F1D72P5+fsDA/TfZV1cUwz4f2WKNiASSNL27j3ixbTIqUd9TCgAF/jnkVUnOmPwFQjgBbrZWywh3b08J1IvHFHRYHsR97wkjnrMhKXeOfsCvnbDJ7QEmigH2+nNuuGsMaAWDFRmADfKoqX0mtSgw14Rl9fMnLqDkOl/WPKJ9Vkm9uf5FkFaDBU4o3ZGgFiF4AmW+0VtM/G+eOGKfkCBp4nYlF/5gIumuRKjLvEZDrw8BwEHv8OyOu6+oyAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h5VwCP2e; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h5VwCP2e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZmRqK3v6Zz3050
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 01:16:13 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 86E066115B;
	Mon, 28 Apr 2025 15:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71A1C4CEE4;
	Mon, 28 Apr 2025 15:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745853370;
	bh=ixHI9t3N23ED6dDVYDV0WmtU+0Xqf66gQA70/o/CM7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5VwCP2eCrsMhRGLALQAhjED1V4kxIWySGNE/2hR2rK7E+iVDift/Qqex+2NtL+y9
	 wXydoh+a9z/bv7/ANuvmGqCeYVoTZUxPWy1S9S8PG6BcCaI/3zaoUEt8lLPaJkiQFh
	 XrIH5qNzoEVvPc/Y5gQ8oVdS8ODxaeKB1XgxcTUhIz718uROh69XESoTAlp72kdVVh
	 7g89J/0BnEH07Nj8NR8IaSosWylRB5gI/HZ36jx0RVRIeGzyUVLbv+TrecvbJmufjG
	 xCXdU9OLkVP4F3bYZjeMhyYo2UVnrV95OX1ACeKy6ecvgEo7gVFGbJZsxNesNNVYWl
	 TarGHbdtH1nuw==
Date: Mon, 28 Apr 2025 23:16:03 +0800
From: Gao Xiang <xiang@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: xiang@kernel.org, chao@kernel.org, zbestahu@gmail.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: reject unknown option if it is not supported
Message-ID: <aA+bsw09PHTQWUXK@debian>
Mail-Followup-To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org,
	chao@kernel.org, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
	dhavale@google.com, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20250428142545.484818-1-lihongbo22@huawei.com>
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
In-Reply-To: <20250428142545.484818-1-lihongbo22@huawei.com>
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Apr 28, 2025 at 02:25:45PM +0000, Hongbo Li wrote:
> Some options are supported depending on different compiling config,
> and these option will not fail during mount if they are not
> supported. This is very weird, so we can reject them if they are
> not supported.
> 

If it's an invalid option, we should reject it immediately.

But for unsupported options, I don't think we always error
out. e.g. for some options like (acl, noacl) ext4 will just
ignore if ACL is unsupported.

I think EROFS should follows that, otherwise users might use
"noacl" to disable ACL explicitly, but it will fail unexpectedly
if unsupported.

But I agree that for "fsid", "domain_id" and "directio", we
could error out instead.

> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  fs/erofs/super.c | 39 ++++++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index cadec6b1b554..c1c350c6fbf4 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -374,16 +374,26 @@ static const struct constant_table erofs_dax_param_enums[] = {
>  };
>  
>  static const struct fs_parameter_spec erofs_fs_parameters[] = {
> +#ifdef CONFIG_EROFS_FS_XATTR
>  	fsparam_flag_no("user_xattr",	Opt_user_xattr),
> +#endif

Another thing is that I'm not sure if "user_xattr" option is really
needed, we might just kill this option since all recent fses don't
have such configuration and user_xattrs should be supported by default.

Thanks,
Gao Xiang

