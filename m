Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A2EA1357F
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 09:36:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737016609;
	bh=1geOIHEV/0ZsOumT2ehKUSc0O9lVmX81FDga++f4YPk=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=MRsdUJN5kVScUl/ZjZiNJT9LoO8CEJiHOgd6lp9wOKPPgOfRoAws+Ju5bjs5lreur
	 Xo4zVILTBxF5l9BT8XxzLYJgIo/2uEEFKpqoUxeLYxq4KJTRjTymPqCeU4C2dTV2Rl
	 AjoFWaeC7C9LTauDKFJ+025kR8Cesnk3ftaNf/Ss2FYzGfGwKLfexzlqeG/vlAEPfP
	 /bFZ+pHN45d1QFXGEBZnUjLz3towOw4oDPyA9dXgSwb7FwSdXHmZJJo2sdp2SqmGhz
	 4i2JBcvzy0zpKN4bGooXTsYchjFq4bfppJpXYiF/GGsO+moOhGPUm9LKwbpkoH26iV
	 iguLpf1RonWxA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYbnY0zJMz3c6n
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 19:36:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737016607;
	cv=none; b=L2SFjWYR8HezoV+NdvLKlpumfeXXZ+tt0vEBIqUI7l67kQOyz9Tyjz6iBs+m8zOVk8rP0ha9G05sR/23wSuk/EvZHhw8s11Zz5o7bbN1crfwLjWvja7q5o2D7lqVHQcjyZPeQjzLullQYAw+n4HkDeo8xdj1TDda0JSiUDfYEMihM9sjMi1IcA5MhUakY8rX2UICgC1naXIu/PpsewHN/U2qNqgP7zYojbI/gV0dK1+qMHM0cpYc77S/eHQvfLBkvfi4Z69cSVi23mnbKpBNKJhAO4aK5A2Vau+PC6zFng14dyzFGfcp18zPYd5d8ifT7Kk0cxn2HCqq6dzgNH7QGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737016607; c=relaxed/relaxed;
	bh=1geOIHEV/0ZsOumT2ehKUSc0O9lVmX81FDga++f4YPk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DgFDd3erewl2trwpuP70QWKUelxjoHAV/SxaoPthytl1mllZCW6nFQNn8fIih4SO+i5WgEXuqftDdSu3TPgfVq4vbhAVoo+O54fwvWumWjqDbPlrdqDeOVdAuS/u2w36y32U/DpGaXDCsocbNsfSBSxsl47dSUpKZ7ZJO+T33vjXppNK/+3eBB+xdS0FdO6ijSBA2O0GoSXVN8T13okzuPnP0w0ujE4iI0t7Ltv2y99g4jXFrp7TLp5udi0MRs2dHtA1thOf6jwawNFdBDljR6e+EOy3elA/d0cIg8qhWd1lM92YJ0eLHdryhXqnFXq2FSLVvd9bMRc8e/DW16goRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JCwkSVaT; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JCwkSVaT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYbnV72DBz2yvs
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 19:36:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C1924A41211;
	Thu, 16 Jan 2025 08:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E89C4CED6;
	Thu, 16 Jan 2025 08:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737016604;
	bh=mZi7Nge/C5KNAdttqxMcIO4HjMK1pfEBHsp6TwIupQo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=JCwkSVaTo79ylGYXtZKqj58idlAJOHhkAxlTut0dm4xgo0aJ2koflGA9IH9IB/OFn
	 ztLKNhDw/RJWPpa0drtjTmEOPhVxCfDf30SoN1kJrwGghIw2AXMvEpEHZ00kgDlqoC
	 8pgxz4BH/p/ydNdoE0ukf+f78b4rdcExsrzaWUHnaiCwrs1ZjFP8sRHrmNd6j7f82/
	 uPwMMFYiFUhmMRj5kuOsnwByFDBa7HnPXZ1buioeOy6oBe7h5NDbV+SBcPnl9BAnI5
	 Zhztj/ALXjoGJ1umx6K8KjkQNo5RrlrDJ/pdChLarMqyALCk6oS7T2AB5+H7limHQy
	 GGdiD3JpSwbWQ==
Message-ID: <78d57523-e75b-4bfb-8819-2d2c78234032@kernel.org>
Date: Thu, 16 Jan 2025 16:36:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] erofs: simplify z_erofs_load_compact_lcluster()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250114034429.431408-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20250114034429.431408-1-hsiangkao@linux.alibaba.com>
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

On 1/14/25 11:44, Gao Xiang wrote:
>   - Get rid of unpack_compacted_index() and fold it into
>     z_erofs_load_compact_lcluster();
> 
>   - Avoid a goto.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
