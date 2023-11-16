Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4199B7EE488
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Nov 2023 16:43:30 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hU6BdJg3;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SWPSw1DBwz3cc6
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Nov 2023 02:43:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hU6BdJg3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SWPSq3TfRz2ydW
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Nov 2023 02:43:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E33A061A5A;
	Thu, 16 Nov 2023 15:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6437DC433C8;
	Thu, 16 Nov 2023 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700149399;
	bh=6PvNxag/PtrEd6ZbP3D3MlKB6dZg474tgXDyiaR7m0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hU6BdJg38E6/94aqQOlgURgF1ZdxXZ9nHFv7ozWjKi+NnHAhYyg2RVIRE1X4xKNWa
	 hwwtDLUDb1Pb6UqSKkqjJP7+dhhoTdag1I5u069++1Cwpzf/iLwK4jEwiQNSF0s3tU
	 6nscPU3gyeuZhg0IHdDJ7hwokCCh6/uJ+TZo1clQhD/99gcgn3ngvw/r7GSgGuRFo4
	 D8NFfOpcBebRyzQDwNadwZ/DvNd1LZxC5vqJ2JsWhW4jBCOSFw02Eqft5MNKsko32x
	 /u95RvNR+nsvHeDQh9ZOFE6zauov99hON4/CaZmSgdOFg5JCCPZpx0/GZFudBeONBQ
	 pHxoQUUuM3M8A==
Message-ID: <03d5e283-3998-7db3-30ae-8a64685c17d1@kernel.org>
Date: Thu, 16 Nov 2023 23:43:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] erofs: simplify erofs_read_inode()
Content-Language: en-US
To: Ferry Meng <mengferry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20231109111822.17944-1-mengferry@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231109111822.17944-1-mengferry@linux.alibaba.com>
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

On 2023/11/9 19:18, Ferry Meng wrote:
> After commit 1c7f49a76773 ("erofs: tidy up EROFS on-disk naming"),
> there is a unique `union erofs_inode_i_u` so that we could parse
> the union directly.
> 
> Besides, it also replaces `inode->i_sb` with `sb` for simplicity.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
