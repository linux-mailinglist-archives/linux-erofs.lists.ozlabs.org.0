Return-Path: <linux-erofs+bounces-1426-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E114C7EB83
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Nov 2025 01:44:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dF6XM5hK5z2yvP;
	Mon, 24 Nov 2025 11:44:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763945059;
	cv=none; b=QGX9BU6bzjZ6aGmg4Jx3CVLxQL3XYzHo90ddGakx+Oha0HKxMTUBuOakrvldT6hJaPzSAku2K1togb83YTjsWq7gyljA7ggoWObqdDn38XdalQWMRYkNsqaEm8H8IeVUwlj9B4aEYnl2UShGMEoYabM1y1STqYgKC4UpH6sMOBhspUATjelBrSGACIR2vxeWG/HjGE+Y6mRC+e7oeX9GbaG+8Sk0HoW27o7NCyPu7e8qjDBmFjT9hq8rBPHR4UJ2VS3Yj0jpc6UZFmyAujNv8zuTp+fbuNknlQDFFtsiTltPpTTXT44vj5pEPtfMPtT62zGaflxc0iIBAfyH2FP8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763945059; c=relaxed/relaxed;
	bh=jInptYNJQCMXi6dQpZN9EZtWiflKlEngrfnRFvSI2/Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oB1/mBGQH/CyOzIH+m6kBAz2Ye3VUMFUaWL7ihahum6iPZ4KFS1nWIedempjELluF+/InTfVnGRhxTD3ik0D5uuB+IC2Iwkko/HXj22U7slO3xopteJppAHQ6Gz93OeeoYjWR8JuEfN0F775QttlZYJZW6amRwdne09yrznsCelWEvh0BWTAOe9a7dUIEtGfqqJXj/wekEHtWo0XyQSJO9XXDvLtKiNz27HBAj8WFh4ITD96v6CUR1vAqz6lPNSaOfUlqh4TOyyWxTspMTuOk2ehixRIFeI9yEQ/0GghCPfj+s4euNoWRzBJMyoI2l1Cm7nlFnhe0egOB93ZWTFqgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qatSm75X; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qatSm75X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dF6XM1gLKz2xS2
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Nov 2025 11:44:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 38E904322F;
	Mon, 24 Nov 2025 00:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8C5C113D0;
	Mon, 24 Nov 2025 00:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763945056;
	bh=F1jtxFmXqezT3lBxnvIzHZ3jxljgpcwImean9FI7r10=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qatSm75XE5O3EZEwVbcjZCD/AqEE3/VnKprTk8lj0Vlv6l5aK2KFVg2Hm6esoF7MY
	 uucMb0schX6I6WVNDNVxs81dhJnLPnoe+yC99RRZubsCTnKDX92sZCa5h2jgzBqlqU
	 T3qs7OYtLV+nRg154qlCZ1MgaNNqm3/r1LqXUBxnT4uubL/Rqzf5H2mybhwnAOwMoC
	 NY//mqEZyc6L0/XxGMQpVxrEE3fJBHr8tgLMBD8BMEKDpBeuzbupC9+ncj0E9IVmEx
	 7mcRkC1fPstneR/yx5wtQy7ZzP4craYLMlP0NdQihkKWm63gZauVtgcRBlSQYMf/IG
	 ZMO7hLf6aJ/mw==
Message-ID: <b8b27003-2366-41c9-871f-6e04ea74c309@kernel.org>
Date: Mon, 24 Nov 2025 08:44:18 +0800
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
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org,
 syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com,
 Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: Re: [PATCH] erofs: correct FSDAX detection
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <691af9f6.a70a0220.3124cb.0097.GAE@google.com>
 <20251117115729.626525-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251117115729.626525-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 11/17/2025 7:57 PM, Gao Xiang wrote:
> The detection of the primary device is skipped incorrectly
> if the multiple or flattened feature is enabled.
> 
> It also fixes the FSDAX misdetection for non-block extra blobs.
> 
> Fixes: c6993c4cb918 ("erofs: Fallback to normal access if DAX is not supported on extra device")
> Reported-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/691af9f6.a70a0220.3124cb.0097.GAE@google.com
> Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

