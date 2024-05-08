Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F878BFE0C
	for <lists+linux-erofs@lfdr.de>; Wed,  8 May 2024 15:12:20 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Zli46Lmz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VZFtB2dJyz3c6n
	for <lists+linux-erofs@lfdr.de>; Wed,  8 May 2024 23:12:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Zli46Lmz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VZFt51F0Bz30T8
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 May 2024 23:12:13 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9F6B3CE18DA;
	Wed,  8 May 2024 13:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2004C113CC;
	Wed,  8 May 2024 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715173929;
	bh=B3TgV7Y3rTI5Noe3tkOwqLHVTgwR6y+7ORa3V8o6LiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zli46LmzOgx3rEIiaYn6jn7kCfP0tbqiDDeP6vtA4+26SLGK5dLwu1hROw3mYGJ0f
	 ZRMgeugngdrCNOA6oyS92bQAhpfT499itVEHiXvg+KkQeqLSa7dO3UPgvnVVamFa4U
	 UKZ6/9A6gddDJHKet34th+2MyHYNbMUjYz/s+r4YeZpFTU7mZc4FEZlG7w2CHkNEef
	 Uzcl5LYbZ+qQxPFuXOUgaCVIwtRn4v8Z6ieEtJt05LK0dDpIpcaIOeynKPmWbDFUJP
	 x8TYG/YVTUX+keDYnNIS2SBjvGsQNH1eCxysaCR53TRQeHIXSi3ZjkwEb/m/5+t6lJ
	 2K0KorBaXLr5A==
Message-ID: <39cc1370-a80b-427d-86e7-6903ed1ce868@kernel.org>
Date: Wed, 8 May 2024 21:12:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: Zstandard compression support
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240508090346.2992116-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240508090346.2992116-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/5/8 17:03, Gao Xiang wrote:
> Add Zstandard compression as the 4th supported algorithm since it
> becomes more popular now and some end users have asked this for
> quite a while [1][2].
> 
> Each EROFS physical cluster contains only one valid standard
> Zstandard frame as described in [3] so that decompression can be
> performed on a per-pcluster basis independently.
> 
> Currently, it just leverages multi-call stream decompression APIs with
> internal sliding window buffers.  One-shot or bufferless decompression
> could be implemented later for even better performance if needed.
> 
> [1] https://github.com/erofs/erofs-utils/issues/6
> [2] https://lore.kernel.org/r/Y08h+z6CZdnS1XBm@B-P7TQMD6M-0146.lan
> [3] https://www.rfc-editor.org/rfc/rfc8478.txt
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
