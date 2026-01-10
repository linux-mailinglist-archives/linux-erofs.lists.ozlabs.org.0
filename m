Return-Path: <linux-erofs+bounces-1801-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C35FCD0CC03
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jan 2026 02:45:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dp1gf1HdFz2xRv;
	Sat, 10 Jan 2026 12:45:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768009550;
	cv=none; b=Nrf4r16RB0V2TsqdfmSDJmOJnfNRxBTSJaHvLj2/2xnlV5LP6jhXl4iUtIQh3PtddwnlJMD2V5Uld5LFUhij+7e9nkuTUgOBq0NbzGAnMvDZZXJR9mjlrSEE/FqsIn5mi0/0EnvPjkKXM+Ov5DcqiZ9hup5a98DMgM5C8z0WoF4yFGIB2lAOR+uOoSDjvQpam9PKjrdKwqtsIBxHGMnXkVTc4f7eUMbFXlTemcWRb1oHGB30Gyqen5ulzijPqSgfVFrC2oAuc5q4akaHcqKkCFEfkPLKWDoaDSmtfM/mPtlEn0g2SQH760X08IyG5DMSbvWkwGUHf+R2q3XjHTEwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768009550; c=relaxed/relaxed;
	bh=QUJJb2X3+YvJnrg5suNFdSEq74i9+pLmkc6KlyfXSeA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mw6N7QpoOStMqiq52qohD8l4W/dL6Lb65ahpj7rZwrcCNqjqyIKRyHnmWKuXqCHWTKN07WVCPprJaNbYKO0c2iapeX/0NbkXE4PYlYeoHoB4WH1bBgjovh3pcevRAtAEVnCtBHAwD+412ovIMzmnXWfGZwNG5Qsz15HvC6CLoIAS7wWQ4UJZoyAWdMo/s4f7pdNkyUdaI41LajI77i0215MQ0x2nvJC6QlSe3e4NHOjilP96/fkPzU0JS0ekoe+4fXd56/EupLH2kwF3+zYzHqhheZ8pSYhKpus7RbUsE6Wcqqp1xtvFPMTqX01K+5yFHGpXM5RkzBBxCHvhPzFWcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i1hwaVl4; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i1hwaVl4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dp1gc6M94z2x9W
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 12:45:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DE71C60052;
	Sat, 10 Jan 2026 01:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041DBC4CEF1;
	Sat, 10 Jan 2026 01:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768009545;
	bh=nueUKQeE8eABviDIYLH468NZYrZZr1YRYAGw27ULbJ0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=i1hwaVl4RJlM92xX9Gl1Q/jvG9XgiWwW7RVb7fbPOhlUGj8SN80KzLjFvAIcGWcyj
	 X6o4J03LzA+ZElKxt7+E173ywxHVhc1GAL3Uyb74Qy/IVMSd0qJm4dlfr4VVFyNtyw
	 C/TRbSzmtJS4qk8yjU43lgVsDR/CgixjSphafixIx0JQEvQ+3b6Zedj6IOdTYk4pNe
	 SoRC2x6jmVS2ZOaY5sMxgBng56rYZf0USTqg+9BE9cDtkLfbdwC5q28B4foRm8z26m
	 JOUg8J22zimKg1a3s5WOkS4zqCLFzvQpytPrbiCkuF8cDsmDZfTFAn/HiqG80bYDyO
	 ZFXjJ61UlitEA==
Message-ID: <8d82106d-cb20-4034-aab2-3696dd5486c7@kernel.org>
Date: Sat, 10 Jan 2026 09:45:56 +0800
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
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Sheng Yong <shengyong1@xiaomi.com>,
 Zhiguo Niu <niuzhiguo84@gmail.com>
Subject: Re: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth
 increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 1/8/2026 11:07 AM, Gao Xiang wrote:
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

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

