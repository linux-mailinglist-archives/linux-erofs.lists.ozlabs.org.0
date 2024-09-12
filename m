Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A37976B41
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 15:54:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726149270;
	bh=kvZiZ7FpLo/BaP81J51KdaPy7tXxkeFMbSHVAB7lkh4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TM9Da9Fz5Nm2eOnQcKvmwSu6aFUo9RHCzuVuGaU2KL326YTAqguwc9esFRp8ZDyLK
	 Lf7Sc+/J+j3bTRwkLQX1Jpck5aC5LIURfQpVZGKqAqmQJrrYtboqIudt4JDYvKfzxa
	 eG/UAgNCaQ96ACuUHN9MkJpDZptg/1h3AUkrJW5rPCV+NNE/sY0V6C5Jg7/INGvWst
	 z3S1hssPohteOZz5/OmG9mkf/wRbrHwXZC+6Cj6/il2Ig+wi+10i0p8LIzKosSzKmD
	 cQSbjDWXZqhBuvSSQmdmnohJHSolXC7EjOon6IQxuYOcxAOYQ4nyLuyZmexuN1uoBJ
	 f3SarxMhIiJxg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X4JpG2tpHz2yZ0
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 23:54:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726149267;
	cv=none; b=jHV07tyY1ojYU55GmbsHvI4GL/1JYFb9evscUnzuAAvTrgmAnhL4b3G+hdeh5InHTFaI/zVHNqz8FSb/eVMJOeEQ3iEmY3l3rXGXYleP9sLfBRq6SFzKRzgFcyXpGbLap6opgoGK39K3mYmJ0owXQ2KfaWU/l/jSgn/5psNtLodvq7srRz8yIxaFI8hRbFl4G59vtKPEHY5KI7zVCdhpf26ViFzKu+ROx1kvo8NgDc8vyYF9ATIfKR0U1B4lgV5k+2j7R6bVd6DHCNAulcIqR+agTa0rJTy/18ZQ6Ej2uvJuDfvPMzButxS+7gjOMhaaCpC68ZNiKEineIM1J3lmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726149267; c=relaxed/relaxed;
	bh=kvZiZ7FpLo/BaP81J51KdaPy7tXxkeFMbSHVAB7lkh4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c4Ligv1Z6uBeIhaE41oaWQ4ly6PT/XJelFEeUEpEYcxsHnwXtu/v2DEmuo4GCo4+CS2PseyGYZryn6lMVTuoi8/wCV6Hj4Fxc3/c3p71uZeSU0Agx8Jx3LZrdO5igV3SgMzTRR9e6RiIZ7TaH+AgCBwxFvxYpNWVlinJip74TSQBTEtHIpw1+b9d2A4R2ZLnVWGMIgmQwdZ2lK/O9WQIP/XonvqIxfG9wzEy2t097fMBVqihLh85sOOvJ8AwZX0kvyv7hFvaKg8m27x0fgIpX5tvQ50VX4ZCYuU4pQD6GcFa9TPZeORQeZwqAZ4FThGLfOTAxZOCEASBE6bCLmnsJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W2EJosOI; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W2EJosOI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X4JpC2N7Bz2xJF
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Sep 2024 23:54:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D52875C06CB;
	Thu, 12 Sep 2024 13:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B60C4CEC3;
	Thu, 12 Sep 2024 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726149263;
	bh=jTcPnc49GsN25dkCxxl2DcKJrvvY/afL8rIHM1XxCEw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=W2EJosOIDwj6IJ3ETQq/LuLmZXEQFdrjyuEe2cZT8Q8aaa/35/wmhOi7N3N+UxpuX
	 D1YotbHQTWDcm2mO0RrtUktWS//mIFGktYF+CcISrRjxVZ3309eNTFINdMuCR9vv8B
	 Wjf3WK2qHHlTdLInx2U0warBamtZI4mZqafu8HfQEdDcoNLGnWW6/+pAAYPGgaWRZf
	 NKX23h15mPSl9JXdyNz02I53r4YHlWWKkuUnzrsQ7gMsBoL2W7isM94P5Qk1f2sgtT
	 rh/ztZrc5iJcgOZBmgkMgp5C3lP1CP3DgeVuSEnOwXBWVLYP5XIwAx9bIzzrltFS3l
	 o1QvBVeh1T8jA==
Message-ID: <1387dab3-c61f-4f76-8c1f-ac8bdd44df24@kernel.org>
Date: Thu, 12 Sep 2024 21:54:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: allocate more short-lived pages from reserved pool
 first
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240906121110.3701889-1-guochunhai@vivo.com>
Content-Language: en-US
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <20240906121110.3701889-1-guochunhai@vivo.com>
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/9/6 20:11, Chunhai Guo wrote:
> This patch aims to allocate bvpages and short-lived compressed pages
> from the reserved pool first.
> 
> After applying this patch, there are three benefits.
> 
> 1. It reduces the page allocation time.
>   The bvpages and short-lived compressed pages account for about 4% of
> the pages allocated from the system in the multi-app launch benchmarks
> [1]. It reduces the page allocation time accordingly and lowers the
> likelihood of blockage by page allocation in low memory scenarios.
> 
> 2. The pages in the reserved pool will be allocated on demand.
>   Currently, bvpages and short-lived compressed pages are short-lived
> pages allocated from the system, and the pages in the reserved pool all
> originate from short-lived pages. Consequently, the number of reserved
> pool pages will increase to z_erofs_rsv_nrpages over time.
>   With this patch, all short-lived pages are allocated from the reserved
> pool first, so the number of reserved pool pages will only increase when
> there are not enough pages. Thus, even if z_erofs_rsv_nrpages is set to
> a large number for specific reasons, the actual number of reserved pool
> pages may remain low as per demand. In the multi-app launch benchmarks
> [1], z_erofs_rsv_nrpages is set at 256, while the number of reserved
> pool pages remains below 64.
> 
> 3. When erofs cache decompression is disabled
>     (EROFS_ZIP_CACHE_DISABLED), all pages will *only* be allocated from
> the reserved pool for erofs. This will significantly reduce the memory
> pressure from erofs.
> 
> [1] For additional details on the multi-app launch benchmarks, please
> refer to commit 0f6273ab4637 ("erofs: add a reserved buffer pool for lz4
> decompression").
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
