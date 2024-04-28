Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7283D8B4A1D
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Apr 2024 08:23:31 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=D+lPl8TV;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VRxH11jQWz3cSg
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Apr 2024 16:23:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=D+lPl8TV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VRxGs0sMdz2xTP
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Apr 2024 16:23:17 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2F3F66065A;
	Sun, 28 Apr 2024 06:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95446C113CC;
	Sun, 28 Apr 2024 06:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714285393;
	bh=m0OqPdtIXueXfol5rrnW7lUXAvbrctuBw6kVnWMpc9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D+lPl8TVSA8tUf/yOBrFcL/BD/PZJ9JIToOeaF+aLpdL76femwaggUwA8HEI9KYlB
	 r8Y+RhhZuZqgTY9FtH048kRavnTRFEKtJkop6rmHwJROpwEYDunI8w7Eos8OYkWO2p
	 iriNXHN+QQLtBXagTNqmqbzThHLNd5kOiUyR/bAS1mdVJbNQdvVsNBfOK7Rl38DNGq
	 Zio/olmDsdfpzanVtPJYw6j/b5B9Cr6aQihwoXM1BODE73SuvitBvbOlFzh8Lpou+/
	 CqkYtcyub2V5y8lIubq7/ev/aKZUVQi9GMAdu64zuBpChEbzh1DFURDffADVlljLzK
	 orwuSU7HgCFRA==
Message-ID: <e8b33c6d-2d9c-461d-ae47-bbd74d7f203b@kernel.org>
Date: Sun, 28 Apr 2024 14:23:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] erofs: modify the error message when
 prepare_ondemand_read failed
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org
References: <20240424084247.759432-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240424084247.759432-1-lihongbo22@huawei.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/4/24 16:42, Hongbo Li wrote:
> When prepare_ondemand_read failed, wrong error message is printed.
> The prepare_read is also implemented in cachefiles, so we amend it.
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
