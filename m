Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A434496CFD2
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 08:56:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725519374;
	bh=+/1n1Wq6TkyRm/r0Mb9Rjo+uCC6QOdmqjyM3fXuqoYQ=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=BgvC9oii4QrQJyExGOnbgmUOkE5Aw1W83kFLNPT/odv7hwGYjPX/KNx0MjW4gnlLB
	 GMnkONdw9ha9HwiFyC0SyAVeWBvsVrEyApwDZvDCTSLzeZUoVCoufEfkhFdzxEDmAH
	 g6GBmUyXD5eadyQG/+Hd6h5vPBaZ8WHCL2Xw0YXvcOTr1P6RpFBjzzYFHwsMsfqEFC
	 nUynMpu4sWKHrIbnh+yVQaBvvtHRVE7+d66ZPouNYgl7EhmCHY3g3A0h24ys3Ocbo0
	 ig9euM1LNnrga9U44TghZZ7/A1og3mS1u7AJlHIu/zFBwqP4CSIQLq825qIQu5FiJQ
	 CP9xYSikPKiSw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wzqrt27vWz2yst
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 16:56:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725519372;
	cv=none; b=BpZ1Nyt4FUMe0QjkQurvmr4aBykrGSc1te51KUbhXHjdpb08EWGZGjKh33bxXbIaVW6BfZP9DHjYvASWd7Xeq8b7k8oXw9Gsuy0D1tXw7RIAIZXECqtS5oXMyR2xr7QgWHd4riiP/RZiOUh4CKaiMoF/bRaJPE574Nt6Bif8zfOqSB1hKdbD/5QD5yTdQcrHf5Uyo2WArXyWqddR/zvH7Lt4Xq3cuz+OhhlKdxWLy64y9iEUmB8rKF6/aBsQUUHrvH6laFxKJZYL1BAU9RqdeAna0LzSBVtw+Zild3AFzrQ8BLZrNGmB+4DVcbZalZ2BFojfOtG5WnPocMd3flVONw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725519372; c=relaxed/relaxed;
	bh=+/1n1Wq6TkyRm/r0Mb9Rjo+uCC6QOdmqjyM3fXuqoYQ=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=g8Fhd1Aj7iYF2VO4v1GSMSE0DgAOWv6Tp7RjF6LcTgHJAgF7O2wpV+GK2CXiu6sek49jrXtyVDB3TR8Nl2e9yLhj6oNQ2finQ0e7lnk4aUC9ZpdRs8aVMqLk890CqryGkh/NZKL4BRH1548A3K0SlzH3Ppmwxi/ddc/KjhvdpPvJ5qBNMW6pTcXMsgDi8l/aL8aMvuJYpw6B14ptWHNiW6v49R+3LM4VNUJFfOxqUhLe4JPWdDUJIkxnZ9QH0AdN+tU7Hb0ShSANeTR1M/EDq0PSAL7Wp7NRPJXBvryvAPYd5HjAn8P6a4UrUDu/a7lYSDCpl/LwmnrifhB5TQWz1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FVZUVrgr; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FVZUVrgr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wzqrq5G1gz2xr2
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 16:56:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7C462A440EA;
	Thu,  5 Sep 2024 06:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7CFC4CEC4;
	Thu,  5 Sep 2024 06:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725519368;
	bh=ce025tkK3ZwkXlnplm7T9pIM5YkyJ3Sa1dTw5Wj9Ogs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FVZUVrgrWkfbhCvUFwxsxgwYyyEPKW+w6RFmXTvNS/mdZwZun6MJkom95aAVpcpfs
	 omX1MIz+t84xMs1CTR/FmP9zAIFUyUpzRgug1qLp8JkrTvHuNVZy5CnWvX+3dcteSS
	 KozR5zxzL8mFXvhcjowt9U/C2KqaL+8/TtzQqx0TZyBonp+7ej1Z8za+3YdkN/PzS5
	 rWDkruMOlkFbMo4qvG17lKgD1zHnlg1CC6nMMcEY7yeVurtyLaIGDKIW8nTTRVrEqZ
	 uF2MB/eN8zACNyFRD2MgzBbOwSAg5I+DZtcvHuw57xi9y51Xh41o3DaIjgQCwmOCXk
	 hx5HfwJe6Z0Ew==
Message-ID: <cbd52bf3-ef9b-4b1c-9342-c1a01481ff41@kernel.org>
Date: Thu, 5 Sep 2024 14:56:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: clean up erofs_register_sysfs()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240828095232.571946-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20240828095232.571946-1-hsiangkao@linux.alibaba.com>
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

On 2024/8/28 17:52, Gao Xiang wrote:
> After commit 684b290abc77 ("erofs: add support for
> FS_IOC_GETFSSYSFSPATH"), `sb->s_sysfs_name` is now valid.
> 
> Just use it to get rid of duplicated logic.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
