Return-Path: <linux-erofs+bounces-249-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AB590A9F43C
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Apr 2025 17:18:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZmRsc3X4rz3064;
	Tue, 29 Apr 2025 01:18:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745853492;
	cv=none; b=I2JiytcIpklXv3b0KV6b4YcYypfLYdnwn2vcwuit/4Du7+xXznQwpR23x4WtE/nFjnlgmS7m/lmSYzBDA8Qo9PckoHXpdww3/5b8El2z1568425s+rW4f5hVXyc9GVRpVpb8pEacvwSqHir0yJjLFNKxlVGGhiMI4XphIEvdPK03rKLbe7wf71qBLUPyarOSW53ms9m2VLRpDrW9ZZNP42aVai5BpJqt/YfLle8EYsnjV2YdTMApD/UHW/NoBKemIlzpRBYeukOx3wIiGKH7B6qUo7cXbL73otnME4cVelsXr4OciO34nk2ecLpemlGIIOmOb0q+s4e0F8mknp3AAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745853492; c=relaxed/relaxed;
	bh=zz0OwfUHedCQiTy4RL46gpqtmPf9VrB1yVPpphpkBZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEEJyUyUYMrv1tGuXj0kzBcXrQjf5yB9Kngj46f/U1skqPNG1wyuG0oFDIosA3MgDFsZnSgkob2lMldMiAxkFlZvIxJvzSc7W3vzR3fAJeM7M/u+5dfInkv0ea6AkK/kZnasnwejjWhO9nW1KYmCsF6PEYSPsDSb6bD+/JVLjDf7yprL1A7zATtcSeIklCMkP1YK6Y37TdeY603sNi3wfyAPxhkffwPV10xMVv/yyayzZeDOGWEz+s20zWaqc6v5KAC71X9ecqaOPPlsuDabHBqn+m8/tK1OiZ6libHVHinR5Ndk0nt0Y38VaQE2GHgGWXfQih5CcIhK0T0bKyumXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OM2D782X; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OM2D782X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZmRsb61BVz3055
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 01:18:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2300A4A547;
	Mon, 28 Apr 2025 15:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EADEC4CEE4;
	Mon, 28 Apr 2025 15:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745853489;
	bh=0QaZy3x9iZ+hVcd/x8o7A0W/pgFKdMUgTsqmMwkaCSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OM2D782XSDdLRIq2ieqOHPLD1hOcs5bva6n2UnFdZX8gOZ3pKKgGvTBeNInln1x/C
	 UjVr4X/Lt7irzYQ+a34LIeNhXw2XwCKSF4GPHLlmDFkttVlXFYIhOMvXIKzVtfBQmA
	 ECg6D6Lv1omDioGpP1E76hW4OHtMeNMe0JsYAeVMGAE7D7A2VVprmrNWoNS+LVN34F
	 D4VYfHA9IsMZyJsCTrzXmv4ZaRVTgI+ZPzFUFNcrQqbCWKlb/LdiVOWtCZn08VopT+
	 EKVOLOpW7qDLShNBfYegcH6GAtt+kmQbmRgc42zx16jVe/oJWNb99XrIy/gWX9KQkE
	 fQq97LuMAgDrw==
Date: Mon, 28 Apr 2025 23:17:59 +0800
From: Gao Xiang <xiang@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: xiang@kernel.org, chao@kernel.org, zbestahu@gmail.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: remove unused enum type
Message-ID: <aA+cJ+aMfWdfMBWH@debian>
Mail-Followup-To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org,
	chao@kernel.org, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
	dhavale@google.com, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20250428142631.488431-1-lihongbo22@huawei.com>
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
In-Reply-To: <20250428142631.488431-1-lihongbo22@huawei.com>
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Apr 28, 2025 at 02:26:31PM +0000, Hongbo Li wrote:
> Opt_err is not used in EROFS, we can remove it.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  fs/erofs/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index c1c350c6fbf4..fd365a611f13 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -356,8 +356,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>  
>  enum {
>  	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
> -	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio,
> -	Opt_err
> +	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio

We'd better to leave the trailing ',' so that we don't need to change
this line again if a new line is introduced.

Otherwise LGTM.

Thanks,
Gao Xiang

>  };
>  
>  static const struct constant_table erofs_param_cache_strategy[] = {
> -- 
> 2.22.0
> 

