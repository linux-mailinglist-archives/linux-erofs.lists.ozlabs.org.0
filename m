Return-Path: <linux-erofs+bounces-61-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DB4A6333B
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Mar 2025 02:50:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZFgzR6FCmz2ybQ;
	Sun, 16 Mar 2025 12:50:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742089827;
	cv=none; b=QTlPG0FSbu2kiQf0/eBnsLuc+yTYTY0wVfCIgNdMF/yql5ObGrfUfIJYgTGW5ZQRlyIAPedaPoWF7vUCMfJZH0iDgqYWn2kctxz7wnGMZcvMNgpaKg9kTfm/uw8Wp8elNQ1b9ZgBUvmZnvxhXQzuiEtKSoqrLIzYSUc17lkktC/frapNShdrs8vlcZRJf/yXVArF4YKsJbUdCMxb7MOJzn6a4O3lKmpRDfT/lpGs+HFYvLZ7BKfYS1fEZtsSr+H/qPy4IqD1VYvh+jxYTaXNsRscpfkXbzEfE7gYpJZ7kXInbGoNYTd+qpYysXlD3C7Oao89fMKtSa6Lpmyr9Rn0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742089827; c=relaxed/relaxed;
	bh=6YLtUzMiB8B2900lJ53Wzk7qyDdAA58T8stGPUaZdpE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=biU9cOI+DHT69cptTFQjyuHL90Sy5iAAauuHXosd65bV6Z6jhkzPaIIHcbpSUdezrmEF03Rme76tzkfZG+iQI+bgxToGHVgJPnvzZCGYOphJaa+O8Iig2ALY0unckEOz0Lgv52TZsUba4Vw6ivDVg4Ec6hZzmTT6vadk+OQWs6y65b9Cok2xhUAfmd+FGdRevp9u6OEJyhbtrECyGqbsFuY8nX+08wxN3YVeN+HrevEE4IfMHkpgqp/TnELqfhrbAL/XO9AKCt9eCpCLJKGRWJRcPDoY4pYbOiYBuc6RWnigsX2GEhnFkB56gxtIFjSig7wRZTGhU5z5KJQ+SFmv1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oifEFh0d; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oifEFh0d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZFgzR15Nkz2ySZ
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Mar 2025 12:50:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 83CC1A48B8E;
	Sun, 16 Mar 2025 01:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F329FC4CEE5;
	Sun, 16 Mar 2025 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742089824;
	bh=FkM6WT3iJf9hal3Xv0VStWrbVOjhBOTnWWcC//OIGtY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oifEFh0d/XHcaN8tvZpwrwfNLOOFpkf56lx9YgYvXXJY9zs9iZg4Pzi+cAb28WUHV
	 KcqvSynqqTFMtdxYuWKsRcQelAQ1NZmMxRPCdF8gFBDRKaUQ9WjfxW2eIHjapNla2C
	 4wz/hb66FNuMqfWmw83BPa3Qr4eVilDLC1sxxK19uVQ5ewcuPSY04kgnj4wUJmBcaj
	 h5l3tGbrYQK48leaoWZe5rV64+ULePpRTvLSHNDyJO2X6b/5967SCvncG4lJYPso4K
	 yqeD1yt5S5OYz+hKSbPp8LagJXHpasoJwRL3hqO303ihF9xrqVakrLYHzxAiyMZhcF
	 4QwmoRHPhhmiQ==
Message-ID: <83afcdb6-61cb-483a-8b8a-97fa58e0ad20@kernel.org>
Date: Sun, 16 Mar 2025 09:50:22 +0800
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
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] erofs: clean up header parsing for ztailpacking
 and fragments
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250224123747.1387122-1-hsiangkao@linux.alibaba.com>
 <20250224123747.1387122-2-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250224123747.1387122-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/2/24 20:37, Gao Xiang wrote:
> Simplify the logic in z_erofs_fill_inode_lazy() by combining the
> handling of ztailpacking and fragments, as they are mutually exclusive.
> 
> Note that `h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT` is handled
> above, so no need to duplicate the check.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

