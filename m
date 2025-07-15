Return-Path: <linux-erofs+bounces-621-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 27578B04DE6
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Jul 2025 04:40:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bh3MM0rG7z3by2;
	Tue, 15 Jul 2025 12:40:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752547231;
	cv=none; b=ccg5p82tOjPqk3u9hH370BAiNsFHLyJfojcLFknilzmJpUjIk1r0HKxcEepxsgunEYeNYj1/mqrRXA7riqQ8Sg2celseWcOA4lG+n4r6XCLM9JIaNEgu/Hmi0NljCyHiKGdddSCDfVdBzzgAH6oDMB7/ignUiMb21gNSigQpvGYyo4oo4/5fSosBk5bguWktxKSH6oJh77NX66s0TXcHeTetN2XGTBE40/vwCKhQFHQaDqoI+uDpC61IwNBCYH9jH7BdU5hCDbbOFtDb+mGKffaf4rNLA0Jqd6gyH/hzZPVWOHiNFobQ7IJ5DcZ05ZAA+ms7mXj70tUvsds/LQJQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752547231; c=relaxed/relaxed;
	bh=tf0HustrcNkcZlJHE1sowMOL58DqM4XmeBJFBFU5yUw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SwQNMQHe467n7mqBkKDx4Gqz40J8/42l2F8s1Gyk6ROOx1MPJ/erNQmMx6PDa0zvBiyr9rV1wbOPazRnqqQtGlTUv/Dzu1VmatipOZZU+qdxFzLsGoYks1uzPIRgw5uH9n8cdtba7/fyGYf1W/Z+JHNIL2nRPYaIEjd7rPotnUVAY89iUJuBkeTvqqFmEdvfjLronMeShPLC/J40tG+iqGfyBk09Oj0gKMq4kzCVzpiyk/JXSWnUGr/VpQjCtZRguEB5bO3/uGqScyoEO06YumS43+L/Jf8B5s0jMzqc3l3uPYUiV//5qtnpg+D8/krK3jKelpJcRRpl4E6dhL/xMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gAWJCr5Q; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gAWJCr5Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bh3ML4CyXz3bxJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Jul 2025 12:40:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 467765C138B;
	Tue, 15 Jul 2025 02:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA4FC4CEED;
	Tue, 15 Jul 2025 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752547227;
	bh=zG7a8e7HCQT3UlfAY8UglLJDThyVbih17GkbrYPpo8Y=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gAWJCr5QzaHhkk8GAZZ1Gu2aobAVaKCcbaBfhA4Cix7I+YfBMxGysFpl8oZH3JvOj
	 xkLbArBdM3r+IikHNl3xhWUjStqlCVcMhnhKrvFEd4T2JC40aH6J4WQIPFbye0A8uL
	 7+YopS7V+a+XDO4b904qRSheZGnGsl3BTle1ZLiGNHdJ/L10263sB9ENRp6nTJxlSt
	 wIlJKz8wAsLG3S9qGEUB74cmnpK/Up05xwYLMJJ1bzTNUnlvwDEE9vMEblzYwcr8Yj
	 zuPl0cj1tVx5/DN9iCBR3KEamxZVj3T1UpDSG+Ez5GsammmiB7hRzDzqVv+NcXoMig
	 riDrVW0Pv90Iw==
Message-ID: <c9261d4f-635b-4c40-8d55-f973a35f5496@kernel.org>
Date: Tue, 15 Jul 2025 10:40:24 +0800
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
Subject: Re: [PATCH 2/2] erofs: unify meta buffers in z_erofs_fill_inode()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250714090907.4095645-1-hsiangkao@linux.alibaba.com>
 <20250714090907.4095645-2-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250714090907.4095645-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 7/14/25 17:09, Gao Xiang wrote:
> There is no need to keep additional local metabufs since we already
> have one in `struct erofs_map_blocks`.
> 
> This was actually a leftover when applying meta buffers to zmap
> operations, see commit 09c543798c3c ("erofs: use meta buffers for
> zmap operations").
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

