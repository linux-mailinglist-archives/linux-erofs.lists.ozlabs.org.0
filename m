Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 17187785C0A
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 17:26:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Xn+o1kwJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW96j6xsMz3c5K
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Aug 2023 01:26:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Xn+o1kwJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW96g2f4Fz2yhZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Aug 2023 01:26:35 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AD93D64FE5;
	Wed, 23 Aug 2023 15:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECBDC433C8;
	Wed, 23 Aug 2023 15:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692804393;
	bh=mKd/HsM9CgrNwIqwTu7sxZhwSfKPBXrjTmhcYrAzpYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xn+o1kwJdSq0vwWxx6/FNh0GkKg4HlBAsuRxQQ0v4xGljhuU2b15XMMYOpqcQm4nm
	 BJPHrbcg92x5H8sRVipDkm0bzj+Q9R0g1FX/7qR6Lu2DagWOqEyCLQawsaYsULF3yK
	 iHe2P5CkxdebRIr76kYKc9nuBTDphH9tFZh4Zo21zu/ZfgX5cczUU9RdawH357qmSc
	 BYWi+rC7ysWy82asDcTdvLtDvA81vbPV91m2LMNxTbdUJx84PJko6e6EX62rYIuatq
	 yri3+np1Qst+KSyU8iTPL3sehe5QX8MkHXfJd5pObgWthb8bLfj09WwxpaBRS7IK0u
	 JNWmq4OHN7RJg==
Message-ID: <0dd3c1a7-5f17-2490-775f-ea08c407313d@kernel.org>
Date: Wed, 23 Aug 2023 23:26:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: release ztailpacking pclusters properly
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, hsiangkao@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
References: <20230822110530.96831-1-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230822110530.96831-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/8/22 19:05, Jingbo Xu wrote:
> Currently ztailpacking pclusters are chained with FOLLOWED_NOINPLACE and
> not recorded into the managed_pslots XArray.
> 
> After commit 7674a42f35ea ("erofs: use struct lockref to replace
> handcrafted approach"), ztailpacking pclusters won't be freed with
> erofs_workgroup_put() anymore, which will cause the following issue:
> 
> BUG erofs_pcluster-1 (Tainted: G           OE     ): Objects remaining in erofs_pcluster-1 on __kmem_cache_shutdown()
> 
> Use z_erofs_free_pcluster() directly to free ztailpacking pclusters.
> 
> Fixes: 7674a42f35ea ("erofs: use struct lockref to replace handcrafted approach")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
