Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD8474F365
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 17:28:16 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AFUTQ/vf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0lBQ4cNnz3bZF
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jul 2023 01:28:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AFUTQ/vf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0lBM3GgCz2xm3
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 01:28:11 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AAC9A61360;
	Tue, 11 Jul 2023 15:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75584C433C9;
	Tue, 11 Jul 2023 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689089289;
	bh=245DlscCQ+6MIO/PrS2VsppGM4QHcezpBj0+leo6GaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AFUTQ/vfJT0QBPWWlpBs0UwtalY9+e+2JXnefqaz2aKS0rteQ1jJc7I1JNVHvvr27
	 DfX30pnysioQlfqfAVprFNFcym7h79qLYCLFqPk7SHNQPR13DP8sZr6I7FN7jt0cF1
	 2BlOU+oDoDbws9fQy7rwENnnWjJKDZjVmAZo1MzQxloPoIo17d8ZebVThUMhRd4ImM
	 tuBFCixobirvrBNejOpBJE97gWMhUvv6VfK7roDLxBglqGxQuhBvq6Fb+Uj/WHk4Mr
	 yRefCk6JCgI9anDUngn0xieDjJjzVu/JYTLH50qUi7pJCDPvwc4TauOMnQiZ9gwdBI
	 cZ17HYGtJMTGQ==
Message-ID: <8e196b07-6cb5-0bc7-bcb1-7239144f7975@kernel.org>
Date: Tue, 11 Jul 2023 23:28:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] erofs: simplify z_erofs_transform_plain()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
 <20230627161240.331-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230627161240.331-2-hsiangkao@linux.alibaba.com>
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

On 2023/6/28 0:12, Gao Xiang wrote:
> Use memcpy_to_page() instead of open-coding them.
> 
> In addition, add a missing flush_dcache_page() even though almost all
> modern architectures clear `PG_dcache_clean` flag for new file cache
> pages so that it doesn't change anything in practice.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
