Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DBD917AE2
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2024 10:26:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tFlo4sTf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8FCw38tfz3cHP
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jun 2024 18:26:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tFlo4sTf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8FCs0gdKz30W8
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jun 2024 18:26:33 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5AC27CE210F;
	Wed, 26 Jun 2024 08:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FDFC4AF07;
	Wed, 26 Jun 2024 08:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719390390;
	bh=XbiR1/BgJHYty7bevHcBo3nrwQe/zawJwGacx+h0PaM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tFlo4sTfsiO0U16eIxo0+7V/+LMf9TCi02eBP5tYY5HnnlJKFnDSCco5d0/bHF4S9
	 6CqbrA9Yix5cpgkhHZEkFCdecHIRQhL+bgTx8JvI6pox6TJTQUYrinn2Wt8vNuJ74/
	 St7iJB3SD4rBeB2Y224hPncDWeM6//3hF29ousX8mKMFnJnMO48Yj2UTbzjEz5hMze
	 Tm3zd2j8fHPFsn+0CrWjppsG9Pgwk/dcinzYr6Uiy+M98Vqcght35VmXc02wuZGbJd
	 q9q4pvBRgSefoA+Ra4jDnydt021FlMUCEh+2PeQc8F0HrYbgMWSbeHnsVdMCH7j/gE
	 F2kv0pakv4mkA==
Message-ID: <aecc0724-027e-4405-887c-1a0701517e81@kernel.org>
Date: Wed, 26 Jun 2024 16:26:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs: fix possible memory leak in z_erofs_gbuf_exit()
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Chunhai Guo <guochunhai@vivo.com>
References: <20240624220206.3373197-1-dhavale@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240624220206.3373197-1-dhavale@google.com>
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
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/6/25 6:02, Sandeep Dhavale wrote:
> Because we incorrectly reused of variable `i` in `z_erofs_gbuf_exit()`
> for inner loop, we may exit early from outer loop resulting in memory
> leak. Fix this by using separate variable for iterating through inner loop.
> 
> Fixes: f36f3010f676 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
