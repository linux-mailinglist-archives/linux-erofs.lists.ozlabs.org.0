Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409CCA13558
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 09:32:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737016323;
	bh=rN0J1+seu0kQL0TljnKp9L4eqo2t0IggsjyZGXWUoVU=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TpRcY+FSbTbYJvKuJLJnK8+3r0DaQgQ72aaR2bOq2u0JF5kkJISENGCOg/FP9LYI8
	 8a0HjXyO1+6eqYgULl6PD8Yu07snWgIUftlDnUDrQp91lf+Lh/vUwHVwm6qHyBS3yq
	 pEK8UQymZ/UfGYcNoFhcA//20VC0WtxwDuJNu14cS5c4euDxi6t/hpZCXhbBFXQEER
	 V2BY2NQkYS2KXJGyOnazoWRhTDikBsnGfz+/qXDLJr9phezAV/bS+LENvSsrtKP4ca
	 ZLiT7Ch3iTET+8H7U/Cfs3GNAOEmARhptubNC8BJVbh9hvjbYkU6GsAKnkYPbGNUp0
	 7MRTuPHwVVrUg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYbh34shTz3by8
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 19:32:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737016321;
	cv=none; b=T4cVEZ+cv8gJNi+Y3yZ3vMv0EVnkT/QZ8sRUuxdqF/uD8Hc7lEU49rQJ1hi/DFO4yNkNRLowz4b26xFYymk2cYxt3afwQWDLk9QX24WL15V7Pe/skMWAcRJ4aJWNPbYRBKyJus6oKueLUr9mTns7C/+vhAORTyy+qLtb5nGnzTIu7Zz+Wti2oqW1BWneyzF78EyCYDzttmJpDbeCFRU+TGWnrd2Z3IGicMo+bd0Vl5t8qNBnjIIg0AbNpoc6IMcLS/axn54kkkQ+VgkIWI73ixBWfA94HMIcrJGN8iTKbqfwsGONFOSpjUMyJiFAWqC9R+9GmBPBQ97V53TarEr4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737016321; c=relaxed/relaxed;
	bh=rN0J1+seu0kQL0TljnKp9L4eqo2t0IggsjyZGXWUoVU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WzkH3gb5Y6AqwjXRQ4JLfGuqVvCtcpd+ELpqKQvGMiXv0fnELN1+E1LBWxUU1TvTCEQUU4ZdGaQXnNfS68iitoq85I3nixUq+/TnY4gKwTzkCR0GHH4NKQaj2t8biuW8vTIC7wOW/PhBTajS1wQcYjvWzZz0yOjxQtY4hRvbapVUOXe3sK/MZGG3YP55Pa5ej51iaKIREbryUuItAqE46wQoRQsD+rDSJJo+7bd1jiXbUSbqn9qhbesmSm1Q8jgjWgWYvHavj+wfTHZcFE98k96nI8ByOzuB3ZELPhHEYbBhT4H5P4yZV7rZ2+TRc75c2MxKEmeGeifCiL+gRPca4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q98Qk1Sa; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q98Qk1Sa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYbh12hVvz2ysc
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 19:32:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 48A45A4116E;
	Thu, 16 Jan 2025 08:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A5FC4CED6;
	Thu, 16 Jan 2025 08:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737016318;
	bh=nM3Q7CZXxvDLM64A/7/nEQ//gngY5Eok3yDCRO4vquQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Q98Qk1SaKAQ+0j09MuNoD375OlLzgR4MHhRxHC/4pqc31xV1KDn7ySLBXNSxkCvdV
	 2nSSizY1xDC2qFUgPn9qQUgJ1jPTCmSnOwo76U+ULs6iMvgOXVc+XyapuiHNHn76ru
	 2DVsgntk/L2Evs04b18UU7Jr6HIfuvYuuGidc0Xx+wLTSDGH18pPhIjPhrKHgvq7Ro
	 /jk07ITsY+2SzIKduYSZtrsztUJxyq7ejIkFDzKQ5cLir4OpJrQIaJV7rJmal6yZ/3
	 Tu5ckx3iXFXKaMnNgiqqwOMkk458+pMvNgcKbzUcvDfmR3ZDNKVQjUnngLy11Niaeo
	 cHy+f8Ub50/JA==
Message-ID: <11ffcd03-c3ce-4d2b-8360-1968092f72c1@kernel.org>
Date: Thu, 16 Jan 2025 16:31:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix potential return value overflow of
 z_erofs_shrink_scan()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250114040058.459981-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20250114040058.459981-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 1/14/25 12:00, Gao Xiang wrote:
> z_erofs_shrink_scan() could return small numbers due to the mistyped
> `freed`.
> 
> Although I don't think it has any visible impact.

Agreed, it's an extreme case...

> 
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
