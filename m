Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 62279A13837
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 11:45:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737024344;
	bh=2FHczhcfJyHeHKOL0+MEckhTAVymHDRLseA6KgXd/pA=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=NMXXoo1AJAV193XSwrpJu83Y6ClY3cjNVUEAOmionX3wDerfiurtpbtuMohQdOvnI
	 zUbeRa/AaNKgZum1KrIDBMyMicEbvdaOhogmFKs3wvE/w4uQKy+KWsh9ynWNfhx0j5
	 1QRfxR52tDAKod0dLfNHlDNDRU+eywnlTvBbdEJnQwbdyCkMi8wxJ7qCl8ZhsQD5RA
	 209ax3KmvRhmsFkWzIwhCAgOn9suUY4OvXOJzCEQJdOKPKhhgKvblUgyMfCBGIF+we
	 qekReP1U+E76NZbOLBYdJ3wzDMLTwTJ83XxrUApyZc/uUuOhye6z2QJDMNKaF2iKuF
	 5ZaNTt8mRNhGA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYffJ1mbdz3cfy
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 21:45:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737024342;
	cv=none; b=eTk9TuQHhziTbxIl+eXGJ9wjj80D9VQuAT7CLKrHip4UkPYzExfHHX0LSq+2tftBQa4qJXkGjyJPKMXI3SGl/NyoZ3fkkrVy88+7H1Wph2BCUbMBQH9zfJa9jIC1PGjrq7ORexXROB/x/3JsvgoiHKha4OEz11r4Z2rU5CkPLY+mp9chrtBDhqplW8F8R2bamljvtG1vP9P3S01YamzttFwWVMXJCuzN34J3DhjhX7yWzSz4MUTztjpYj8DRWndvhQg0XRut7usLl+tk8gY+hWIe6PapO4plgBXUU9CXREOOkGV8gp4v3FEk0VK9QI3rThT8ANL0Z10tO+Ly5qi3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737024342; c=relaxed/relaxed;
	bh=2FHczhcfJyHeHKOL0+MEckhTAVymHDRLseA6KgXd/pA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q3ETMomwQQmnn4wpF/i4PNx8i/OSUqZXMC4yW/VUgt5JHjCbqjo7+oijDc2WUv52Ls07yLcklfzWvyrCthJ5xUnW8Gq+M9otYHLJbRkJ/TUVUaIfuBFopn2ugoQi39KHSL8aaAVUFJjp7hahw3GgmdqYIV7o//en64DZXEjBOttPNgmKMWwTG2LJqlWjBCMKqKaB9+ZwFvEzI7Lvf1t6qeExNKXVb212sA9bHY5Y0+nhh+WCCri1mzNwst2mDBI/IuW7HSlQ7Zap2/wtdOdq295BNo5dG72j5VDcVQkoEn//BEfSSaEUkidsfYoAlnRGX4ye9K7XP0dXaf4uIZyRUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oi1KiKEd; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oi1KiKEd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYffG244Wz3bhc
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 21:45:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CDF7B5C5D20;
	Thu, 16 Jan 2025 10:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55940C4CED6;
	Thu, 16 Jan 2025 10:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737024340;
	bh=knSBG7QOnfDWU6DPlN7eCld/mB5fwLV7Zb/ydbeGBFg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oi1KiKEdG+6VBEMjrNgWBa0JZV23WbYz8NDN1ltBYegyNp8+arH0FBK46dbUYYkUR
	 gGq8vwHwBt+BZS+j7OPzPbb/Gb3pcPFFHGdzd+edMAXZlEGTODBQzpfcdzR/TdytQX
	 gX6U2J2vNQhP0aXpq7I9y8IanjErHHCGErhXwaVg+cdHiL++8IaOrXH6pJeHCAxSFD
	 mAHPrDmvilhyuerkOzHml9JiLQMaeze7U24t5PWdT4TBB7oR824UEunmu+DjgUKzWL
	 PaWG7nKnc5N9tiDarTrGlRVaQxHPUhflHJUPeaqxRCFZPdbAPGZ9SSdZB9U5rPTlfU
	 EusDxNezyZp/A==
Message-ID: <8a85c2a3-7fa7-44db-9717-bc3effd4e381@kernel.org>
Date: Thu, 16 Jan 2025 18:45:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] erofs: convert z_erofs_bind_cache() to folios
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250114034429.431408-1-hsiangkao@linux.alibaba.com>
 <20250114034429.431408-4-hsiangkao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20250114034429.431408-4-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
> The managed cache uses a pseudo inode to keep (necessary) compressed
> data.
> 
> Currently, it still uses zero-order folios, so this is just a trivial
> conversion, except that the use of the pagepool is temporarily dropped.
> 
> Drop some obsoleted comments too.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
