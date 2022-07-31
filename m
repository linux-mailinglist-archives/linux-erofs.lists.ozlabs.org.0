Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E75C585F16
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jul 2022 15:18:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lwhdq09VGz2yMk
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jul 2022 23:18:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o9gWy2KU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o9gWy2KU;
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lwhdg4dqMz2xHQ
	for <linux-erofs@lists.ozlabs.org>; Sun, 31 Jul 2022 23:18:15 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 460FFCE0F15;
	Sun, 31 Jul 2022 13:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBA0C433C1;
	Sun, 31 Jul 2022 13:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659273489;
	bh=ichplVNGiaHrZIY/a1eWBNo4Tl6r9s/ES+a8P+0lvBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o9gWy2KUYZIu6bfaDuVgb6irAcGAn9MN/l6Rf4iniDHW+WN7T2pqBY8lpOYKZ6Ldj
	 3/oi9Ey9T8XwTq8f2E19xiWtDjKkkkz+lGqz+e19YUVnxLHqqbwJib6D6rUWdO2Vyz
	 fQ067Un84Hz71RlieYSk3+euAOkqQRHQwsProCBZ3MCi8dkXtoGRZM68kM0B57APFu
	 blJxmz9AYyDhpztA6DeruXjTHGq2BM//G5DSIk+ZRQ9CjnX4pYPL+ZlhHHgOzhgwWL
	 SZU11WrbZ/W+K+KFLKabWVYT2Gt/5Gt8/qf1Hpj1qNfsRUd3ppxl737ZevOt/jp/T5
	 Vt0d4Q3U5WlGQ==
Message-ID: <368e99d1-bc41-976a-094b-816e80ef6367@kernel.org>
Date: Sun, 31 Jul 2022 21:18:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] erofs: update ctx->pos for every emitted dirent
Content-Language: en-US
To: Jeffle Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
References: <20220722082732.30935-1-jefflexu@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220722082732.30935-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/7/22 16:27, Jeffle Xu wrote:
> From: Hongnan Li <hongnan.li@linux.alibaba.com>
> 
> erofs_readdir update ctx->pos after filling a batch of dentries
> and it may cause dir/files duplication for NFS readdirplus which
> depends on ctx->pos to fill dir correctly. So update ctx->pos for
> every emitted dirent in erofs_fill_dentries to fix it.
> 
> Also fix the update of ctx->pos when the initial file position has
> exceeded nameoff.
> 
> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
