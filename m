Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E32976527
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 11:06:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726132006;
	bh=A4eHS1sh4CKIGqGHVJl226fQvh7/Bi4n1+YKdJ97DDs=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=YI8lbW3rohH3KZkY3FbNZcHrKqoJhTxeAe3sOgD2t9zvbRHhhymDmSMO2blCAadqS
	 e72D4vIhDTJrnkxGdzVC83dJ1dcry5InEy+Khl1Y4LJw/BAw0e7bpG6DcQJuHO4B+i
	 OPKT3EjGuNBon/L+6EH5okPdH8f0RURu0w36j+iEDqbU91KzN+ODGt0oC+jAszIzOu
	 LNmcyyWJ58WboCOnYuZ7qZuPwjEPzqDk7jC6x+7yo/+1u13uomKa29hI6oWleSW4kn
	 b6NQvrC4Nux4mjSJeRt5GVaTIuq7Tr1V8TDaC51WX3HfLln5Y6x2EeE+j1n1iMQZDV
	 q0RcaZg5VQfCg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X4BQG3PXmz2yVZ
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 19:06:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726132004;
	cv=none; b=is5Iqe0LPIUMkWmFu9Q6+sNTSHXVfCHmPZe2YlONuoK2rZlxxvLgQuPfj4EEuOitPKA/w8sW5L0/y0LWHdRvchvc4QoFe3NN1SYEQIWFJMyXpn9n+q9hSCykFM+57QDItoAbeACCcrXRxQxXhmEYo6O7y8gadegFzjhwigP3F1ZxNHM3TZXiO46GCTH/aSATmQkBfOkfUuTrioNVqzDTA+1+V/7Ev9zS0unzki1hI71mAJDmoCnEYADOHfKSibs+kXnV8FGnt/h/BjwSpQNMalX/b1Aj/ABQvigosAwYuGnqhdVXp8nFuJH3MsSMpFmxdD+3m1MCUjJMwAWiYyjj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726132004; c=relaxed/relaxed;
	bh=A4eHS1sh4CKIGqGHVJl226fQvh7/Bi4n1+YKdJ97DDs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DdeO2onZb32laXZUsB2VpEfkaBo5hmt4NvOcc6E5368/MnDPCbtjvzBZrzuP+fK4OgTlCjGybO3378dF3KT2UNsoeyZlQ3+ZMNO2+1APEUM1uNxvFBBe+FBPjoy1blQNbmbTys17aoYQAmzGZkAE06eZHQQ4D4ghBpW+zpq1Gj+YD3HwBs0f25xrEF+xKyu64AG+axP1rguwvw3MoRedk0dQ8fVfu2TQ82uqIl534mgRw+pIzqmfRh4eMlLAgsV3BrDbjICGaN3PUB4Ie+R0Sz1l411o3avQUS7Ib47QvEnB4nndf969zmWhnFhH135DUo07Z/2Koh1ZtTr9Q09qSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z6v50LaW; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z6v50LaW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X4BQD14WDz2xpx
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Sep 2024 19:06:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F2223A4457B;
	Thu, 12 Sep 2024 09:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67942C4CEC3;
	Thu, 12 Sep 2024 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726131999;
	bh=ujsBFOcNrFBUxWWFDaYYBKGgdo4OV7buD0Yn7UNY6lI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Z6v50LaWqPTUjB2LLOjFKUK0gWnyefy87PcgJ1pKARj/7+6b2xR/ds+cgk4IKmK8t
	 TvHwED88ST4gze0oNXa+4FeItqyiq/meMgnXcFiwTxXhm7eWEsLRO4llr4fPtdI4F4
	 BEfoiTDAejASYTZAKSZVrsnFoVCU9MdfOaL1tMR/d7ND7nN766XWwZKyZj633Lpwqo
	 yEbgOldjx2wNVDmb4PQqLs9epviRTr/HW2DiTSW+LdPmpxS1OBA2rA1LZh0uiGs6RL
	 nQU7Iiurg0/cOM8O6DwEzscJdQR4GKjAZt7Xq5Zv86cqGnvRV2pgxGxbXWlKDfUurL
	 AffhiWde/D1Ow==
Message-ID: <e5a4dd90-3fbb-413d-94cb-41ce67d6824f@kernel.org>
Date: Thu, 12 Sep 2024 17:06:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: restrict pcluster size limitations
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240912074156.2925394-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20240912074156.2925394-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/9/12 15:41, Gao Xiang wrote:
> Error out if {en,de}encoded size of a pcluster is unsupported:
>    Maximum supported encoded size (of a pcluster):  1 MiB
>    Maximum supported decoded size (of a pcluster): 12 MiB
> 
> Users can still choose to use supported large configurations (e.g.,
> for archival purposes), but there may be performance penalties in
> low-memory scenarios compared to smaller pclusters.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
