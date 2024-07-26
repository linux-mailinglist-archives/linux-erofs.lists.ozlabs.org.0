Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF4993D0AD
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 11:56:39 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YtaaSgdx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WVjnx41kBz3dDg
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jul 2024 19:56:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YtaaSgdx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WVjns54MXz2yvk
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jul 2024 19:56:33 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E54E7614DB;
	Fri, 26 Jul 2024 09:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD58FC4AF07;
	Fri, 26 Jul 2024 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721987790;
	bh=fhyq/g+G0TEX3v1BnRO3G8NSctBsT3B907kuzzS/knE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YtaaSgdxYwvRUqPGGDe8gXs3l4Aa3M1Yoa+znwWiql7hZSnY7ML+5FncQHzDxr5PT
	 3uDLhSby+W7L4Zz1VQGarYZzyVXXcZFYpFBtWOeNhomW5GJ1hPGDSj7po63JN3cT12
	 1pgFXnSOjr+BcwIBNiGGJVcfDFLIMXARMobTTe7ZibNQdI2eh1z6jBu651tP2TI8Oq
	 JXI9oE56UiB21sa+HHKOnQeKTp5pmnzi1Ym0s7bqozTKq43WR/kwWIV9OOYvAPwoQn
	 gkwvFRldGXJlcQXaoCHno5PskOV+vinQiO6DKmX/Q7vcQrVMtErf6fjcLRKXKbJz+c
	 pJ+QlM7HNxtvQ==
Message-ID: <dcc063ac-3597-41a4-a10e-6f4e9585f96f@kernel.org>
Date: Fri, 26 Jul 2024 17:56:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix race in z_erofs_get_gbuf()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
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
Cc: Chunhai Guo <guochunhai@vivo.com>, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/7/22 11:51, Gao Xiang wrote:
> In z_erofs_get_gbuf(), the current task may be migrated to another
> CPU between `z_erofs_gbuf_id()` and `spin_lock(&gbuf->lock)`.
> 
> Therefore, z_erofs_put_gbuf() will trigger the following issue
> which was found by stress test:
> 
> <2>[772156.434168] kernel BUG at fs/erofs/zutil.c:58!
> ..
> <4>[772156.435007]
> <4>[772156.439237] CPU: 0 PID: 3078 Comm: stress Kdump: loaded Tainted: G            E      6.10.0-rc7+ #2
> <4>[772156.439239] Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS 1.0.0 01/01/2017
> <4>[772156.439241] pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> <4>[772156.439243] pc : z_erofs_put_gbuf+0x64/0x70 [erofs]
> <4>[772156.439252] lr : z_erofs_lz4_decompress+0x600/0x6a0 [erofs]
> ..
> <6>[772156.445958] stress (3127): drop_caches: 1
> <4>[772156.446120] Call trace:
> <4>[772156.446121]  z_erofs_put_gbuf+0x64/0x70 [erofs]
> <4>[772156.446761]  z_erofs_lz4_decompress+0x600/0x6a0 [erofs]
> <4>[772156.446897]  z_erofs_decompress_queue+0x740/0xa10 [erofs]
> <4>[772156.447036]  z_erofs_runqueue+0x428/0x8c0 [erofs]
> <4>[772156.447160]  z_erofs_readahead+0x224/0x390 [erofs]
> ..
> 
> Fixes: f36f3010f676 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")
> Cc: <stable@vger.kernel.org> # 6.10+
> Cc: Chunhai Guo <guochunhai@vivo.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
