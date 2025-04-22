Return-Path: <linux-erofs+bounces-211-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D2957A96D6C
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Apr 2025 15:50:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZhkCC3nJGz30WR;
	Tue, 22 Apr 2025 23:50:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745329831;
	cv=none; b=nRKV5kAR6+GDVJFVK/REG0AD6DvEPM4+lu4TgtQ628TF0NVHxeXFJVmkrGzAN5mjWS9yzOw9o91AXQU2QpR1w5VoT5IHnhFQwecvjxfvEs/ssJjB+O85S8UINv4pYfEc1rLdPvFQAUt/4emQCO8wciHxsYAN7wiiB3P4kEOSjdLBWd+Bys+96acz6ZXkvDh6HEn6O/EQujTRD1NH6872qv1zhIxeKUDhSM8mOrcS+wn5xXmp02PucnCY7lrzoC/xTfCRuSKLaqJ9RjISnuoGZ0rjp2FXeioSCwEjhyS8d0M6w5Z7Tb+E/JReKSdraoQCb8ZnnW6hjpRthORj2jhDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745329831; c=relaxed/relaxed;
	bh=qhmm0QWcIXPBwHsw9YCmGO/a752w/KBDrSHiA+BX6mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqslzqGInULmrf8i8E66N6aG0sYRM0ozwuGM2YoFiacej7DAHaQlfhWtB/LdOxqHhpDH2ooXZiXtTNA4JgJzbEEKzZfjVEGRrIJ2vv2Hv4VAL9yFlElEpBWA/9HAetQRVyGmm0yntscn/wHBi9RDgbu0Sz94dsspZa+6yd/iz5/IL4ktA7CfE5RORiZJn0ti28wKEZYJDFl/196spB0ovvDFK5zvgkFxNqAM66u/zedw9L6vog7GHUFahGSqBzAU3DKtxh4QPykOAq2WMUe4SOzK762L4gts9UIFWp3JAKHrvM+asqre+jBIHOEr6YRBXIcLOWVbHJLxEx2KEgkezg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jK/6aAgh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jK/6aAgh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZhkC941FYz2yGf
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Apr 2025 23:50:27 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745329823; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qhmm0QWcIXPBwHsw9YCmGO/a752w/KBDrSHiA+BX6mw=;
	b=jK/6aAghYipTfG8kQwnOHmbg3ES3yPjTlGEbjMqBFXCi40eSkerrZxn2FxhZOMl9jjUdviQMWp20ol6mguHA477SSuww9CdQfb4HwB+/f7wGccIZekt1LmmLY2hvGVtC/MDwRcnPNaCcviDjm4AL5jeGmflFhlMpBVKNOPaJl9w=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WXp3p7I_1745329820 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Apr 2025 21:50:21 +0800
Message-ID: <2408568f-a9e6-4e32-83b2-e79aee83a55a@linux.alibaba.com>
Date: Tue, 22 Apr 2025 21:50:20 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] erofs-utils: Add --meta_fix and --meta_only
 format options
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250422123612.261764-1-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250422123612.261764-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Hongbo,

On 2025/4/22 20:36, Hongbo Li wrote:
> In this patchset, we have added two formatting options --meta_fix and
> --meta_only to extend the ability of EROFS. In the case of using OBS,
> we can convert the directory tree structure from OBS into the erofs
> image and implement on-demand loading logic based on this. Since OBS
> objects are often large, we need to separate the metadata area from
> the data area, which is the reason we introduce the --meta_fix option.
> To accelerate the formatting process, we can skip the formatting of
> the raw data by adding --meta_only option.

Thanks for the patches!

I wonder if it's possible to reuse blobchunk.c codebase for
such usage in the short term.

Also I hope there could be some better option knobs for these
new features.

> 
> A simple usage example is as follows:
>    1. Build one xattr with OBS key in s3fs.
>    2. mkfs.erofs --meta_fix --meta_only data.img /mnt/s3fs to format
>    3. Implement the loading logic in kernel or userspace.
> 
> Based on the above logic, we can easily expose the directory tree
> from OBS to users in the form of the EROFS file system and implement
> on-demand data loading for large OBS objects.

BTW, It's possible to upstream OBS implementation to erofs-utils
if any chance?

Thanks,
Gao Xiang

