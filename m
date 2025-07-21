Return-Path: <linux-erofs+bounces-686-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A6DB0C04E
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Jul 2025 11:29:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blw7y23P4z2xKd;
	Mon, 21 Jul 2025 19:29:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753090142;
	cv=none; b=BR7lxWTpDUYoDnIEtRcKAVY3AeoRDucxiv9ObvkY2Hb1fEgBYbD4CC4Y7S22jMtEobVDLT5/m1eQOAz8jSz7xioYRbpFeCjt1c1A5wPtHb490c0jODe9K3BLCN5sYqrESLax8mjdOUxHFUOmt7nrPD6zAH+P7RKPADSNLdcMvw/D8fvgrCB0eK2ppx6ZiicsoUMPDDGy5PY6obhvBryMCsYSK7tC8zU6nJmo/NzydM1wNk0k0SZuN7F/+BgOVIwW5PjGjIZ8+aGjbEPso0TzbJNFmxtjZYtO6sv24zlCI566b30MmcLEUPJx2nC+59AGo+Fa1nkCTneInzEASAp5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753090142; c=relaxed/relaxed;
	bh=Q943YZ7xgOzw5KJIUKXobqP6l8Un40T4eZs36K3fYio=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oosX7CKnYZqBFTHvWmOmpTg1Hsp/Icp4qhh7uBziU1dQnBZOHI+vFZryIx0AtL+ZZDQVOKfbv+sLQ1eTQ4vtD0CbaVEMe4QOd489QGd0NWD+WuYt1vo/0f9KFgVMkneOJi9E0oYQuK2qfQPKeVorY47dFoFG/tquMI45qy2uP2G+Hv4CpdDKKLA+3nYyJAk8ed/elIEvObYBajCVmT61N6lKMnsoTSCp1cKn83IEtey2h8aMTzWhL0DrNS3nOyvbgfV8f6/xdmKAv3L8tm92psTaLDG15Q8mcsuJuVPerLYguXGxqAP1KrJuwBz4Wnf0zMcAK/3K/v2i6hndKDMFRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DmrxHLoc; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DmrxHLoc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blw7x4tyxz2xHY
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jul 2025 19:29:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 79E315C4D9F;
	Mon, 21 Jul 2025 09:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50857C4CEF7;
	Mon, 21 Jul 2025 09:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753090139;
	bh=e3MjNw40SX9uSql+9WWt4ZuNq+HJ7mKB5glLjQZhIwA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DmrxHLocad1e5UmD+gC/k3Kg1u3jitMAQ4eHyWaueJxvbaoneX/MGxSs/4n19lbjh
	 o+vlJ6PZ7JsUvLnXodZtV9i/mS7OJ4AWuSbLo7jKJw4sWKjiYttb0h0d8QHB2mkGVW
	 Fy9lZ4Xvty542YzW4cfGsb2mQoZ7XnjwrCdHnLW7cLl/9CdZBd7DEDlOKZ1DDxEF+q
	 j5iDY6psq/YlPU4bQeas8aIcna7BmOCyr16xC93N+1//P99DXAVIjsVIc+k/SW8Boc
	 7RVYrCtNAigPiZdX3ose8yoj37FzSujhlSofEshnIue7QqPVKkGCe4b/GuG3hr3zaR
	 LQGnnit8zr3nw==
Message-ID: <b66bc9ae-2ed9-499c-a06f-6f9817880fa8@kernel.org>
Date: Mon, 21 Jul 2025 17:28:56 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] erofs: add on-disk definition for metadata
 compression
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250716173314.308744-1-hsiangkao@linux.alibaba.com>
 <20250717070804.1446345-1-hsiangkao@linux.alibaba.com>
 <20250717070804.1446345-2-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250717070804.1446345-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 7/17/25 15:08, Gao Xiang wrote:
> Filesystem metadata has a high degree of redundancy, so it should
> compress well in the general case.
> 
> Although metadata compression can increase overall I/O latency, many
> users care more about minimized image sizes than extreme runtime
> performance.  Let's implement metadata compression in response to user
> requests [1].
> 
> Actually, it's quite simple to implement metadata compression: since
> EROFS already supports per-inode compression, we can simply treat a
> special inode (called `the metabox inode`) as a container for compressed
> inode metadata.  Since EROFS supports multiple algorithms, users can
> even specify LZ4 for metadata and LZMA for data.
> 
> To better support incremental builds, the MSB of NIDs indicates where
> the inode metadata is located: if bit 63 is set, the inode itself should
> be read from `the metabox inode`.
> 
> Optionally, shared xattrs can also be kept in `the metabox inode` if
> COMPAT_SHARED_EA_IN_METABOX is set.
> 
> [1] https://issues.redhat.com/browse/RHEL-75783
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

