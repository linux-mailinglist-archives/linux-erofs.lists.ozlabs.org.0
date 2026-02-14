Return-Path: <linux-erofs+bounces-2319-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG6MA0jij2npUAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2319-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Feb 2026 03:47:36 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0AB13AD0F
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Feb 2026 03:47:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fCYNj00Q4z2xln;
	Sat, 14 Feb 2026 13:47:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771037252;
	cv=none; b=L/6BdaIfZgDHeXaXznWM3HJZNWq4Ca9mS8zab9NlVs6EGkunTgW6V85FzYGdGlnSeYDnJV3SRyhh0cPwcBz7K8Pvgh+akyiso3BAAI7zdJNlhsJ9X4tyb6zry6mUHjkEvbqw6Tta+ORqV6BckokzUAQvtyeL0Ya0pGJ7oZlvsGsYe1pT/kxS+pkVAGQmCuO5gdLicru+7SCzTsjkAOJv+8r1ByV79RsZFTvbESod6K2vtS3VD+kTFhRvecu/vU7GB2OiIR2qWfKN4AQXvFKkObmo3jTR/h0Bi7kPVnlygz74VtxwkWp88yYysBob1RNwDa9yMdTM9xLgWGqMmhANKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771037252; c=relaxed/relaxed;
	bh=rxnO6xvMekaP3B+SGBLoYdQtw+BHVWiM9ptTQFp5NGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ4WWZ4pJ4WZFRoit+eZ7Sq4ZjwRWvoJaVfuECwANG6AZ4vrVR91YK2qu73QMRCSao44Ag4aqwV3rUAz3M6++Z4LpSIaC4biQuSGhRhACHXqjNUWTjnFPv+lCBrIU8y15+0KouwXu164BprizPDtLZdgSR/MpTw39mPKQAUYct20rRfYcfe7SVx99kfWwg+BgJGFkcy0Ysu9hnek79Ye+wo3JO82Wew93UMFFnh+DLQhfb2SWEoaKgY8jpsS8Ggdykxz6SJ944mt2aBkxVIbDKsmV/3O28i3FK/D39nwbEgY4A8jweKGShx2WD0CANEyaMUsJRPQFj1YOLEEoSKLOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kD0C6ydv; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kD0C6ydv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fCYNh2yzdz2xSF
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Feb 2026 13:47:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 38C0B60054;
	Sat, 14 Feb 2026 02:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374D5C116C6;
	Sat, 14 Feb 2026 02:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771037248;
	bh=hSa5wD9TjRVNfCnM8eGAKjyOk77Gq18nb+e7l5tSe2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kD0C6ydvg6Rb1Jq1maEvIphEZNMFfHE5cjluPZ9VfUIlIj7qPW5GFe90VSTQVCyha
	 N77MONf3ZhF7d7gotxEg3vLqdFaWfSXMp6G7W/LVknhbn2hrg2p9DFgQxnnGqaMjzB
	 2pjkE7E/EaE3ouj/mZQrZrz5u+g68jmgLBZT2bvYv0vzr1bhW2xr7CuHvt1G89CIOk
	 agfhmagd5mf2puUApjaxy/+oI4w4hzAv4j+5cPhZm2R6LHW8Y+nqfwRZP2Uq6/izIY
	 +xcUFDbzhcWtNWLzdica6dO1pe4x2/uUNVFYBkIWzkMlbYvaPi0us5KHVefAzO4H8f
	 2RNgf3cOFQLHQ==
Date: Sat, 14 Feb 2026 10:47:23 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yifan Zhao <zhaoyifan28@huawei.com>
Cc: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com,
	jingrui@huawei.com, wayne.ma@huawei.com, zhukeqian1@huawei.com
Subject: Re: [PATCH 2/2] erofs-utils: mkfs: validate source and dataimport
 mode combinations
Message-ID: <aY_iO5zcsITyYrhI@debian>
Mail-Followup-To: Yifan Zhao <zhaoyifan28@huawei.com>,
	linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com,
	jingrui@huawei.com, wayne.ma@huawei.com, zhukeqian1@huawei.com
References: <20260213073241.525158-1-zhaoyifan28@huawei.com>
 <20260213073241.525158-2-zhaoyifan28@huawei.com>
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
In-Reply-To: <20260213073241.525158-2-zhaoyifan28@huawei.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:jingrui@huawei.com,m:wayne.ma@huawei.com,m:zhukeqian1@huawei.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2319-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 3B0AB13AD0F
X-Rspamd-Action: no action

Hi Yifan,

On Fri, Feb 13, 2026 at 03:32:41PM +0800, Yifan Zhao wrote:
> This patch adds validation for all combinations of source mode and
> dataimport mode, and prints corresponding error/warning messages.
> It should have no impact on external behavior.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>  mkfs/main.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 131 insertions(+), 13 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index a948b2e..e369347 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -169,7 +169,7 @@ static void usage(int argc, char **argv)
>  	}
>  	printf(
>  		" -C#                    specify the size of compress physical cluster in bytes\n"
> -		" -EX[,...]              X=extended options\n"
> +		" -EX[,...]              X=extended options, see mkfs.erofs(1) manual for details\n"
>  		" -L volume-label        set the volume label (maximum 15 bytes)\n"
>  		" -m#[:X]                enable metadata compression (# = physical cluster size in bytes;\n"
>  		"                                                     X = another compression algorithm for metadata)\n"
> @@ -300,6 +300,10 @@ static struct ocierofs_config ocicfg;
>  static bool mkfs_oci_tarindex_mode;
>  
>  enum {
> +	/* XXX: the "DEFAULT" mode is actually source-dependent,
> +	 * meaning BLOB_INDEX for rebuild mode and FULLDATA for others.
> +	 * Consider refactoring this...
> +	 */
>  	EROFS_MKFS_DATA_IMPORT_DEFAULT,
>  	EROFS_MKFS_DATA_IMPORT_FULLDATA,
>  	EROFS_MKFS_DATA_IMPORT_RVSP,
> @@ -314,6 +318,118 @@ static enum {
>  	EROFS_MKFS_SOURCE_REBUILD,
>  } source_mode;
>  
> +static int erofs_mkfs_validate_source_datamode(void)
> +{

Honestly, I don't like a unique place to deal with all arbitrary
combinations, but we could add test cases to test all valid
combinations.

Also I don't think I will treat this for the upcoming
erofs-utils since it may cause potential regression, let's address
this after erofs-utils 1.9 is out.

Thanks,
Gao Xiang

