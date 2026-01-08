Return-Path: <linux-erofs+bounces-1703-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F082D00AA5
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 03:27:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmphx55p2z2yG7;
	Thu, 08 Jan 2026 13:27:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767839265;
	cv=none; b=eOCFisn+x/jgJU7FiEwvPm+3DPLFAsWyFcdPXnJGTIR85rIP45GTMS3D9sJ8fBB0jn8Lvg4R58CuZreoYkHz7B6qIBMyEqmWDnTro15kNtOSoCZZqKMRIWKbIo9futzVph+HYFqpuo6NVjsf9I0PnqqtdRuEUFF0sFj7bqPQ5uMf31sUabZIB5TNk0riHWFh/iBRhK2f5l3stuhWMUJN6xEI4U1RgdL7eenEH+Z1+0mA5LseULvMlvq1+mCLDcJcLQK7wRnomlVv6UM3QGfTNgx4kU7PKQpT6fsQ8oyQ5WaoclPCWQxzbH4XFTTBqDev5MgFIVt9DmPTkOI/QTzPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767839265; c=relaxed/relaxed;
	bh=SlkG/EJNtxTQbmqNLHdB90183ZHhg2gpdFgNQmGYHqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQsSmNoqkT4kR/kgy6RRxLtvruIMtpMFRN5Aahhr2fDiFpcUr8g8F3mwcl9Z2ZXLjjNTNdYOCm+SbL3KaRx5DttT0OTuhCWqXJ3yMgvoS7vAMxSN4qTkFk/O4R+751ly+JfduImewMS4M+Zh8SitsqBj1IX8lL4MAEcL2nR9lxRBYquj3pESn8SmIR2nVUlWN1qrCwodyK+MhgZdk/aPHKG/lSdbX3VIuIYlSAicRkSo1Z/zEaftUXIRntWX7OQOI54qjeh0svxs+O6Ybzxe/YYlHbgC2zyWCiQh3Zc2cJszZof0pXKq/dyKbvJN1E4WghmfLiH/AEnFvzZzEz0xQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=beUhhFfY; dkim-atps=neutral; spf=pass (client-ip=209.85.215.171; helo=mail-pg1-f171.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=beUhhFfY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.215.171; helo=mail-pg1-f171.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmphw25H9z2yG3
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 13:27:44 +1100 (AEDT)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b98983bae80so1455253a12.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 07 Jan 2026 18:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839202; x=1768444002; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SlkG/EJNtxTQbmqNLHdB90183ZHhg2gpdFgNQmGYHqw=;
        b=beUhhFfYhUYkghSweSjkoknvWajmGwrRDR/MOwGqfbLeh+vThfUT4ApVkIQayyINYz
         47U7DIIDFjHclJJCsVLjWRORXxBjv4dun05F84H9FXOkQnWBzPBjzFcOKmaBcTFRIpSd
         50pUN1vNgba3GSJwtk7kCeR4i4A8kSBlkO9ekaOKUbuySDRc5F5QMaY4UK7Oyks8wTuS
         AXDCnDEaIbMmx2DKfMuvvt97WQw3OvNC35lW009uijs1nk5xWj+ys/VXKJM7SGpNUf2i
         vbLWh2DTM7jxfpGUeh1kGte3mwe4Nl8HvDgQ3IRaYEiF0qMPFEhNZWbm5e35nuYtpPeU
         wO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839202; x=1768444002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlkG/EJNtxTQbmqNLHdB90183ZHhg2gpdFgNQmGYHqw=;
        b=saV7nsx3CRCsEFlmzj13lbqdYLxyWWRN3AsXBLUuM2K8Nm2E0Kb7GRdkiLZQcmhHEP
         Yo4UJ4D+SqQs4aqBESdD6Ml7Y7xs17oCpuk+0C510AwTX7MdyDLkaCVncRHotteT0wIa
         2hvG5uXXKQDvJG/UWi7KrkP/mFAi03imjQKf4us1pqRpeHkziFf7rxEkH/JYZpPR+e4d
         2ABra8ChjcwbVWU8uUftd736oAX9e3Zl6fpaWnr/jSRVWjas4KVk/JpWd3u9vy1xVyYZ
         3xxPCYXUWv7tW4pXtBgCSvVMmx4JjkG4QVQDNmnt5L2Tx2ij0OPkHR1sWcMsNCVhRhbU
         GXbw==
X-Forwarded-Encrypted: i=1; AJvYcCVhyZNfj5gf4x//q0JHWnRS5BbzHBVdI2wV1v0QuqF5cBvO0bMFeVxaIpEI3jQIHiwBiceRht6uNcbbcQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzy94iuL6i0JtYJ22VRP3v2yLsdtMsNs/rxKwL1es1nDREoFXZa
	9dl7yKhR1pF4rodz4eddavAcslyOP0SixAjTRxhm8bjjrawZ1AdqHMGO
X-Gm-Gg: AY/fxX7691kLFCFb7V5NFGeVF4SFOxRt+bKUjNvV0rajLOirTN/Td7PXZ5drbS75WmR
	mgvcWtzeG0/EWkLcdDGS9ZY9vzy/sWCEV9ZpQw1CqU2eReuF/Z0BMbbM/JMdIQnX7kHPam3DsFl
	+OtTSgiJXb2MuaNnJKSMW3r8ukjjkQeY9c3sUD6mhKEApxbPb/clP/dgWhQXf8hFPk2rwo671BO
	R8qR1ahjo+5ZCw8ek+TzFmvVX2/EZOscndiuB5mrbNRJOJua03ebcYXdedSvAQqmYN0SVO7LfQC
	CVEInKBW40PZPedFaitEtn04tpPkmmXy/Ekfm8kj2WN6O4cfk6FNEkk1TdaKq4nIA+UU0n42xeB
	xVYKBn5HgsWTWGDy1P6Zq2GuyDxX2cbaSh3Xj/OOnWrNkKHjlVHidQTMWdAb3y8aIVkJb1ToSvm
	41bIMFE4FRD6IvQOGZOSbzkg==
X-Google-Smtp-Source: AGHT+IEGa+ws2SHQIi5xy8NLYinApzL2ZD35WLB81CyXBtazqNT3JFCWjfqFBKIDmDkCcdskllaiiA==
X-Received: by 2002:a17:903:2292:b0:2a1:2ed4:ca1e with SMTP id d9443c01a7336-2a3ee4b72e8mr39060825ad.34.1767839201831;
        Wed, 07 Jan 2026 18:26:41 -0800 (PST)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a303sm61626365ad.5.2026.01.07.18.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 18:26:41 -0800 (PST)
Message-ID: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
Date: Thu, 8 Jan 2026 10:26:37 +0800
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
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing for
 now
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>,
 shengyong2021@gmail.com, shengyong1@xiaomi.com
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
 <20260106170504.674070-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <20260106170504.674070-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 1/7/26 01:05, Gao Xiang wrote:
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
> Reported-by: Dusty Mabe <dusty@dustymabe.com>
> Reported-by: Timothée Ravier <tim@siosm.fr>
> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Cc: Alexander Larsson <alexl@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Sheng Yong <shengyong1@xiaomi.com>
> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2:
>   - Update commit message (suggested by Amir in 1-on-1 talk);
>   - Add proper `Reported-by:`.
> 
>   fs/erofs/super.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..0cf41ed7ced8 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -644,14 +644,20 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
> +			if (inode->i_sb->s_op == &erofs_sops ||

Hi, Xiang

In Android APEX scenario, apex images formatted as EROFS are packed in
system.img which is also EROFS format. As a result, it will always fail
to do APEX-file-backed mount since `inode->i_sb->s_op == &erofs_sops'
is true.
Any thoughts to handle such scenario?

thanks,
shengyong

> +			    inode->i_sb->s_stack_depth) {
> +				erofs_err(sb, "file-backed mounts cannot be applied to stacked fses");
>   				return -ENOTBLK;
>   			}
>   		}


