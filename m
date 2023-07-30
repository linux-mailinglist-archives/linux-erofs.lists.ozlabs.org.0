Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3317B768566
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 15:06:23 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r6cZSmaS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RDM7x0gQfz2yFD
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jul 2023 23:06:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r6cZSmaS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RDM7p49H7z2yDr
	for <linux-erofs@lists.ozlabs.org>; Sun, 30 Jul 2023 23:06:14 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 42D4760C1F;
	Sun, 30 Jul 2023 13:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C272AC433C7;
	Sun, 30 Jul 2023 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690722371;
	bh=yUFX0JNmhulifpf7JRLBOEUmmVr+WQ7QQNQgsvMOT/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r6cZSmaSk45hHvXEloRDO7/3v2X4PoGlY8Wycw27kY6FHxdc+0RM/etuyYRRxSTjR
	 +7t3UkEjMFvPwBhJUpd9UpNSsllsHHBswd4CaRsAq27wiZrIE8eJb1cUai/0g+URKx
	 FOGXUYDoPQYdf2MhqPWOoODU3l4VOgvFEHZ8M/Fu4HHQXfyD3U5jh8wUmqMoegUODB
	 F3ad9aQFaVo/D4FxedY3B8VL99B8KYwVL97ETdoQc/GsAmHds7lbnJ7iscYT+5I73k
	 HYf3xj47j6/ykzHTQ30UeqR/Yq8Z5utbSCsG00mJVhZ8A+glq3QGKTfuktQ3XKtMFy
	 PdkBYqsKwRMOQ==
Message-ID: <e452ec90-7eb9-146b-e627-d912b1b46ef9@kernel.org>
Date: Sun, 30 Jul 2023 21:06:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: fix wrong primary bvec selection on deduplicated
 extents
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230719065459.60083-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230719065459.60083-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Shijie Sun <sunshijie@xiaomi.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/7/19 14:54, Gao Xiang wrote:
> When handling deduplicated compressed data, there can be multiple
> decompressed extents pointing to the same compressed data in one shot.
> 
> In such cases, the bvecs which belong to the longest extent will be
> selected as the primary bvecs for real decompressors to decode and the
> other duplicated bvecs will be directly copied from the primary bvecs.
> 
> Previously, only relative offsets of the longest extent was checked to
> decompress the primary bvecs.  On rare occasions, it can be incorrect
> if there are several extents with the same start relative offset.
> As a result, some short bvecs could be selected for decompression and
> then cause data corruption.
> 
> For example, as Shijie Sun reported off-list, considering the following
> extents of a file:
>   117:   903345..  915250 |   11905 :     385024..    389120 |    4096
> ...
>   119:   919729..  930323 |   10594 :     385024..    389120 |    4096
> ...
>   124:   968881..  980786 |   11905 :     385024..    389120 |    4096
> 
> The start relative offset is the same: 2225, but extent 119 (919729..
> 930323) is shorter than the others.
> 
> Let's restrict the bvec length in addition to the start offset if bvecs
> are not full.
> 
> Reported-by: Shijie Sun <sunshijie@xiaomi.com>
> Fixes: 5c2a64252c5d ("erofs: introduce partial-referenced pclusters")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
