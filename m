Return-Path: <linux-erofs+bounces-1713-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD247D01C5A
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 10:15:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmzln2Qdtz2xcB;
	Thu, 08 Jan 2026 20:15:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767863749;
	cv=none; b=IJxEUMeF6OJ+Qrpau0LXWWpRulttjXBydimmbB+uWnDJ6pe+l7rhGSb+/zBuLOGvoPEBXGUEvuGLEaRMEbsgUTRpkSYC/7xseisIahaR6GGgBepbWpfzpcqDO5bthywU1FGklVfeSYHM+kv6TT5s2gjLWZ19Oh0ros2gJQ0KTTty6/HY6vmKHQrdNgm+2QSuaPfPC01mqZ8HhYpx31V1RB7LwUi6j5JmpvsRMYGy4DTgCXRkO6L+dJR+mVYJFLDlvdXHKjxO+evT/TFXyPHZ6bKXXNIhcd9KPtA8+ExE6Qbm7bjny0+FtkZBT16qAWnSyWu4pBc4sgZDoMfSiZ8OpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767863749; c=relaxed/relaxed;
	bh=P9A9CnNPkpLsRMHLIS50U2O5+Dp80nlM7WRY0+NXniA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lgS+zgorh9P1DEDHa9t3+mEMmzkBNCqi9KtC0TrJQL4J7KYRuXiTZCmp8+ANPalyxcelWRENrEPeOtSPYzNtTVzViJYlzGlYO1SGFNz6E1AdpgKsGkE4RkSYhCxRs1eEfvGFpaAH+VikL6aNseZgA40Quw+zZ8JNwE1bOhWBQQtIppGUFmnUdx/A/xlzAJpkjPMVDVGvNroW26hlgD7Kp1kNTMhRaQUa8WyRx7ha0PphMC0TGTXrZ4NaNd2WLx97oeVMEteOu1mTu0bCDjFPO0fkFITwmfkl3zWB8MqSwi7KKpn7K9URvkjLU0DBEbW8EeootUAbQFZ6/DrqzyzxUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=niZF/1iD; dkim-atps=neutral; spf=pass (client-ip=209.85.216.53; helo=mail-pj1-f53.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=niZF/1iD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.216.53; helo=mail-pj1-f53.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmzll5ZVGz2xZK
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 20:15:47 +1100 (AEDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c1d84781bso1853608a91.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 01:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767863685; x=1768468485; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9A9CnNPkpLsRMHLIS50U2O5+Dp80nlM7WRY0+NXniA=;
        b=niZF/1iDgKWBL2I6WAj07A5MKBGiSsL8d6B0DyilhU7heNPLZDwPZaAm1VWLT6pRPc
         pxWlR2C4yOVYeOe449rn8p2a4lHImZmrcZnywZFE6/UkvUocRVz7MOpMdrUdgQUBiF93
         mFLam9ZDRZJPVi9LPWaOiu37l9vDFcV3Di+voRcMKnkH22dJ4tVqHehjQo8eA11CvJHL
         iYQEKGIT470QL5UZ1XDOdloyxZ5OJXTdWhdvuZtrr5qxcyZUi5+Agi+O+qpSVDnl3GZv
         TpV7vx/8lXYsp89ZCYDP0mSYD8H/n870xVoHjlG+MWxQwAEM3Ubmrh8THz3Tjbr/CuJy
         6juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863685; x=1768468485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9A9CnNPkpLsRMHLIS50U2O5+Dp80nlM7WRY0+NXniA=;
        b=kJ1Q45j7W0fvniVZx/twDzdxF7MhwTNEbFFoogA0ftN2XJD0cXC4Rr40aPDl/awFuE
         iqyWuvf3DwcZArHDh58f2EuRKlEDMYDfEhhZ1GSrz6MybA9CR71sXLohZtH4m1AHyXyd
         SvWR+xGLvsBNlyADC8vW7mGiI3OMjViponxpaqH/240XhoQMSH6+MoP4ifIaTJsIBp4W
         eCJsyXLZLSWxIoAUgwey/9Gj3THl8GbcOnnQfoXWImnx7IcAzqZQxfUUskcvxmCF2Uq0
         v9Ti9un5W4ECfkOwTPA5l77jcpqx3sKoPOs3VM5nd9J49BSHNoVcK7IO/2Srhge2QDjQ
         iXhw==
X-Forwarded-Encrypted: i=1; AJvYcCWrNDW2B9lD40oyW1tY97Dn+CNxd0VxpXe8rasyemmOOvF1Z1fmwe0lYhG6l+lSAy9KxTyYXBqS+VZBsg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyY1WQ4+iMd+xlApuyLpg1f3ul9gHvlPgMcNT6rGpX2Zvs7eSkc
	4hGvCTnPBcgKEnDyLTGVtOrp3FBEuiZZCunwoRugKfm/Z6UVUo4xGDK9
X-Gm-Gg: AY/fxX7MkkiooJhUEr0sHsoe8APePg57PI4cnoK4lBHpX8w3Hn3yHyjA28Nvjm3S/r0
	Hq7Q+BnpPPDIMpRqKChGY8XtSnv1ZK0Xk086786oxyqPQntxXGSCymMQcR19A7PydVuf5PngfgI
	erVEQv3Z1nqE2VYn2c33gRdYqHBdb+4C3W8b7GLqnmiDDS678xvBRY1D22mGjw9q7ARj05mPAAH
	D6wZ0baJ6jzq1dRt5munzj8asRBTFCiDDI/QzANRlK0LbTEZReg4SRyTFsfvCy91D2HlQSTh927
	bgfOT2q8LiTzCnM/qcWcG0F21cWsq5aOU0MQqTaO/Ip6ku1ZgDGn0wEPhH5Qx4ENRfep7q9Lyng
	4fepeSw5jkJpBDuQ7jtGBBV91p4dP4c+3E80DvLcs6ZT5PKvRM2P/ND42p8qdj1lXEfB1ptiowu
	ptyO8w4Jf2k5cgaA9sQqnxmw==
X-Google-Smtp-Source: AGHT+IFN4bvajl/HnvO1CZQ3YQgySLPOlPc+6VtyxPcphHI+k8Jmt+inxmA3yYfVTtpOjwdyDkkOiA==
X-Received: by 2002:a17:90b:3852:b0:343:b610:901c with SMTP id 98e67ed59e1d1-34f68cb9036mr5855290a91.26.1767863685375;
        Thu, 08 Jan 2026 01:14:45 -0800 (PST)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f6af53004sm1950343a91.1.2026.01.08.01.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:14:45 -0800 (PST)
Message-ID: <243f57b8-246f-47e7-9fb1-27a771e8e9e8@gmail.com>
Date: Thu, 8 Jan 2026 17:14:40 +0800
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
User-Agent: Mozilla Thunderbird
Cc: shengyong2021@gmail.com, shengyong1@xiaomi.com,
 LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>
Subject: Re: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth
 increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 1/8/26 11:07, Gao Xiang wrote:
> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
> stack overflow when stacking an unlimited number of EROFS on top of
> each other.
> 
> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
> (and such setups are already used in production for quite a long time).
> 
> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
> from 2 to 3, but proving that this is safe in general is a high bar.
> 
> After a long discussion on GitHub issues [1] about possible solutions,
> one conclusion is that there is no need to support nesting file-backed
> EROFS mounts on stacked filesystems, because there is always the option
> to use loopback devices as a fallback.
> 
> As a quick fix for the composefs regression for this cycle, instead of
> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
> nesting file-backed EROFS over EROFS and over filesystems with
> `s_stack_depth` > 0.
> 
> This works for all known file-backed mount use cases (composefs,
> containerd, and Android APEX for some Android vendors), and the fix is
> self-contained.
> 
> Essentially, we are allowing one extra unaccounted fs stacking level of
> EROFS below stacking filesystems, but EROFS can only be used in the read
> path (i.e. overlayfs lower layers), which typically has much lower stack
> usage than the write path.
> 
> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
> stack usage analysis or using alternative approaches, such as splitting
> the `s_stack_depth` limitation according to different combinations of
> stacking.
> 
> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
> Reported-and-tested-by: Dusty Mabe <dusty@dustymabe.com>
> Reported-by: Timothée Ravier <tim@siosm.fr>
> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Acked-by: Alexander Larsson <alexl@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Sheng Yong <shengyong1@xiaomi.com>
> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-and-tested-by: Sheng Yong <shengyong1@xiaomi.com>

I tested the APEX scenario on an Android phone. APEX images are
filebacked-mounted correctly. And for a stacked APEX testcase,
it reports error as expected.

thanks,
shengyong

> ---
> v2->v3 RESEND:
>   - Exclude bdev-backed EROFS mounts since it will be a real terminal fs
>     as pointed out by Sheng Yong (APEX will rely on this);
> 
>   - Preserve previous "Acked-by:" and "Tested-by:" since it's trivial.
> 
>   fs/erofs/super.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..5136cda5972a 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -644,14 +644,21 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   		 * fs contexts (including its own) due to self-controlled RO
>   		 * accesses/contexts and no side-effect changes that need to
>   		 * context save & restore so it can reuse the current thread
> -		 * context.  However, it still needs to bump `s_stack_depth` to
> -		 * avoid kernel stack overflow from nested filesystems.
> +		 * context.
> +		 * However, we still need to prevent kernel stack overflow due
> +		 * to filesystem nesting: just ensure that s_stack_depth is 0
> +		 * to disallow mounting EROFS on stacked filesystems.
> +		 * Note: s_stack_depth is not incremented here for now, since
> +		 * EROFS is the only fs supporting file-backed mounts for now.
> +		 * It MUST change if another fs plans to support them, which
> +		 * may also require adjusting FILESYSTEM_MAX_STACK_DEPTH.
>   		 */
>   		if (erofs_is_fileio_mode(sbi)) {
> -			sb->s_stack_depth =
> -				file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
> -			if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> -				erofs_err(sb, "maximum fs stacking depth exceeded");
> +			inode = file_inode(sbi->dif0.file);
> +			if ((inode->i_sb->s_op == &erofs_sops &&
> +			     !inode->i_sb->s_bdev) ||
> +			    inode->i_sb->s_stack_depth) {
> +				erofs_err(sb, "file-backed mounts cannot be applied to stacked fses");
>   				return -ENOTBLK;
>   			}
>   		}


