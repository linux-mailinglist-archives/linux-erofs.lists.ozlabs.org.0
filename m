Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AEC497923
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jan 2022 08:11:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jj1Pf1832z30MT
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jan 2022 18:11:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hGBRrWiE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hGBRrWiE; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jj1PX1jXRz2yPq
 for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jan 2022 18:11:44 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 34D4260C78;
 Mon, 24 Jan 2022 07:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90202C340E1;
 Mon, 24 Jan 2022 07:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643008299;
 bh=qWez0wGob8vUCQuD2t7DHnXvuj3jt1kWScf2tXdwuFA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hGBRrWiEj5quo0WjhP2nfBn6wWQKfe7oJ6Aw8P8ZvvVBo1r5MQpB/uP2CnWbnFDyx
 EExcWEqhDJksWvlgML+F4OLcsNhiaDW3J/0f15MgGYV5AbtMD23Wru8UDiP6xj2qnN
 he/RCQsZSFYm9FRU/PMMCmU1nw7kE8BY0DtJJfuMVa3WWnqgX28E5z9pzhaES1vR/y
 WJZO9ZlFdqfHicxsFyc0eqvEsydrM21U/VQJgTuhXL+cbA4a8pOPGrzg7sYCaaFQJL
 hgpZkv9eXXMqBb/VUHFj6AUhPbixTy5akR4R2cB7YmuZm9eiYgD2yJ69KJBV01V2uG
 uvcmCUDv8eU5g==
Message-ID: <d424369b-c559-bf63-bbb3-71886f1799c9@kernel.org>
Date: Mon, 24 Jan 2022 15:11:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] erofs: fix fsdax partition offset handling
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
References: <20220113051845.244461-1-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220113051845.244461-1-hsiangkao@linux.alibaba.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/1/13 13:18, Gao Xiang wrote:
> After seeking time on testing today upstream fsdax, I found it
> actually doesn't work well as below:
> 
> [  186.492983] ------------[ cut here ]------------
> [  186.493629] WARNING: CPU: 1 PID: 205 at fs/iomap/iter.c:33 iomap_iter+0x2f6/0x310
> 
> The problem is that m_dax_part_off should be applied to physical
> addresses and very sorry about that I didn't catch this eariler.
> 
> Anyway, let's fix it up now. Also, I need to find a way to set up
> a standalone testcase to look after this later.
> 
> Fixes: de2051147771 ("fsdax: shift partition offset handling into the file systems")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
