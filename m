Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCD34A92A4
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Feb 2022 04:15:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JqgdK37nYz3bT5
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Feb 2022 14:15:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NAR3D0Eb;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NAR3D0Eb; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JqgdB00lBz2yLv
 for <linux-erofs@lists.ozlabs.org>; Fri,  4 Feb 2022 14:14:53 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EC89DB83650;
 Fri,  4 Feb 2022 03:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8342C340E8;
 Fri,  4 Feb 2022 03:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643944487;
 bh=iEuUG3yFFN2BJhIISW8KmMv88Mk0Nz7kMwG+L/vQIMs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NAR3D0EbcYDgb0VJ2NvMi/LN4scHsbUGO3g7sb2f81Jvm0jUIwdzc7morj9B1nVH9
 9fEebkxOyS0uWNkQYD5+fvKpng7Yy2mn+j8AM7nQmx7vbbny4aXekp9Kb5AZePIiTV
 TnsaFqWaLQUu8DUJoXBHzO9mYJTe1MvvvKiolnyxMb/XfVCO2E7i6dw9is/ocC9h8D
 FENRZpfAmjFdShyuXaUrzsFaPC88iBbQUrlyV4GdXF9DmpgkuZrCO0vJAYcQCuZ8EN
 2RcfPOYuHnH+phVibunKCh4AM/oRK9hCOaK+vBPYGgZN9IMwHuoT/PLzhxhI1cu8N3
 PZIUIDKV9hTxg==
Message-ID: <e556fddf-c103-c658-51d2-32ee44041d6d@kernel.org>
Date: Fri, 4 Feb 2022 11:14:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] erofs: fix small compressed files inlining
Content-Language: en-US
To: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20220203190203.30794-1-xiang@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220203190203.30794-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/2/4 3:02, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Prior to ztailpacking feature, it's enough that each lcluster has
> two pclusters at most, and the last pcluster should be turned into
> an uncompressed pcluster if necessary. For example,
>    _________________________________________________
>   |_ pcluster n-2 _|_ pcluster n-1 _|____ EOFed ____|
> 
> which should be converted into:
>    _________________________________________________
>   |_ pcluster n-2 _|_ pcluster n-1 (uncompressed)' _|
> 
> That is fine since either pcluster n-1 or (uncompressed)' takes one
> physical block.
> 
> However, after ztailpacking supported, the game is changed since the
> last pcluster can be inlined now. And such case above is quite common
> for inlining small files. Therefore, in order to inline such files
> more effectively, special EOF lclusters are now supported which can
> have three parts at most, as illustrated below:
>    _________________________________________________
>   |_ pcluster n-2 _|_ pcluster n-1 _|____ EOFed ____|
>                                     ^ i_size
> 
> Actually similar code exists in Yue Hu's original patchset [1], but I
> removed this part on purpose. After evaluating more real cases with
> small files, I've changed my mind.
> 
> [1] https://lore.kernel.org/r/20211215094449.15162-1-huyue2@yulong.com
> Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
