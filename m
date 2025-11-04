Return-Path: <linux-erofs+bounces-1348-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8040DC2F8D7
	for <lists+linux-erofs@lfdr.de>; Tue, 04 Nov 2025 08:06:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0zyV4Rt4z3bd8;
	Tue,  4 Nov 2025 18:06:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762239986;
	cv=none; b=fm4HkAJkTv/PFwDCrX4xaxxMfpW6GyVvANWliAcvXkxn4ggw8mGYkRH3KEIqwAb5p+KSYnDqG68iP3GQnzuJRixKX/c1n+N4l40TkMAoSszTvgaA2CmffF8F0SO891cBcJkqgqUpHW9upy5zPN1ivQM0f9d+6T6lOPHdu8nzG+p8yc1JknkBlnGtV/3kEti9w265cxMwggemE3ShctypZCJkzFcNbvsR0kqG76STu7RKtEyc7YDm4WrrGHOBR/Z6UIISGs2vbxfhV7uRgNbg9f5I6O5iy3FUMtNnLlo5OD+Owp5DyKNaOX3IXfFwllvxxN4+tWcxTPG6qJUUdzoWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762239986; c=relaxed/relaxed;
	bh=4XdVTUey1xzfOsupcCUe6UD/TDvGWyGUDV/TAM+nQgc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cdzKmTODDm/Lz+uTjD9WOUv4AcnS+TSyxWGHIk3l6HL0ZK7EF+n2QQpwpIiaKHP/Cs48hKNH5S6NBDnamIS9SEccgaEUVnKObF3lhiR7/mqDnxday37o1hEaK5kgjuPq1pHqhZvvOi3z14U179MB++ypcQpfacR5afAgRajayXx0GjfxwhcP1CjgfbyU1PcH1WnIBz5IuL6rcs08Q94MWYE+6NnohFpuBxfB6t80ODbGhl4LnEmWqRpnFzdgxTDxZWwx3D2pKUyrfrf4z2mRMQepXCUPd26qDfKdKd01Jf86Wf2M7k1LKPewA9Q4xjcIlbeWPiC0hPpp9tINDb1FkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n50zHO4i; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n50zHO4i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0zyT0tjqz2yr9
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 18:06:25 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0C4C6434A1;
	Tue,  4 Nov 2025 07:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEBAC4CEF8;
	Tue,  4 Nov 2025 07:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762239976;
	bh=fIyKczNc+/gJHY3D8lZta3HSckqeCpgbj6Z3Cd+opyA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=n50zHO4ibdnL8QNAtgkvULKBfMp+LqaeRkadSgcghWqAt+V82eG5eOmEnVu1vxFbe
	 TPas0OsgPxzylaUTfP8YeZf5dkdqJl0nCA6O7AV8MybgpsN2LufXSBmh3pyjbShqUt
	 FAplT7SeU6ZFz/mHxRegLILlE5X9LRsXsGlGc0PZJxnXh+syRhr1o7cFrIlmOlKdd+
	 2adVUH9qM7aIq+AOUjDsvWS+oAdRAcCieMWdjI5DZawNT3B1D7QyfI0Hgn5nfbD4UY
	 wRmEIUL9HWpZZNGvT2cklJV0XWXxNsM3YwrtOI4NxGoUNhEvp8RaXtb4aEktufpgoy
	 u+UmTlknrPakw==
Message-ID: <1ecc25df-7009-47e5-98b8-957209763e31@kernel.org>
Date: Tue, 4 Nov 2025 15:06:11 +0800
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
 Robert Morris <rtm@csail.mit.edu>
Subject: Re: [PATCH] erofs: avoid infinite loop due to incomplete
 zstd-compressed data
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20251031054739.1814530-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251031054739.1814530-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 10/31/25 13:47, Gao Xiang wrote:
> Currently, the decompression logic incorrectly spins if compressed
> data is truncated in crafted (deliberately corrupted) images.
> 
> Fixes: 7c35de4df105 ("erofs: Zstandard compression support")
> Reported-by: Robert Morris <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/r/50958.1761605413@localhost
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

