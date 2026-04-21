Return-Path: <linux-erofs+bounces-3344-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EILzEOck52nV4QEAu9opvQ
	(envelope-from <linux-erofs+bounces-3344-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 09:19:03 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 507BA437721
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 09:19:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0DHP24tQz2ySW;
	Tue, 21 Apr 2026 17:18:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776755937;
	cv=none; b=R5+GzN6FNQdpJb5GlRvNGdCxK6CugoAe07HKn/nVHSkWra1toMSH9fqv9jAc34dDFz9GAKuB1DCP/L0S1bafCVEBPP4zk4qrbzrAAhO9RB60AttM0QBa/jB8MsEaC0MGXSg1fjzLDQU6OTYIF8amVn/1SNjs4x0XyCht7mEK0mrT98vEXXrrX6cwMyZZay0gACPaX3P87766SPdide1ccMwl+tJGQtTmGfjfRyHXqGDz4mYgx5JFgmIuntqt/fgBGzoSDwVyTF5mzhuij45Pcmj2Huh6y666ajhE+EtdVRb2Oga7u7N0CgWwjEUDeSFye9RtXTqNsoeDhz3vxhQbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776755937; c=relaxed/relaxed;
	bh=Yj5v8822X+T0xcWU9Pegwpe+LDwEGV/nZZ4K5oY0kDs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d10bfrI7PB1mLRr6fb+KWcnPrdLEnqN2j9VGtS4pdYqZ9/xF/SjrhGwJals6KZ7aDleEKFwg+YPigK5zRgU6NjDlTFl7eDbHScPlGm9+cHyxrwjEOOq1ucpPkqutqrxYOyn8Q3dNBWliwrczFb5Z+UqE1MHF+euI3MZbb8mbnr+OodVIfoKLKLaOVMn5u7rgPYpzIdWzxYuJRmVDl/Q+MknQh1qGuW8zGWyRXNbD056VK5qzplGTUQglYedMG+dqi2sYO1MlTq4K8/qYmXm0zWM8VjDtg+tt0qNQgb5TaY7qXhKDfwLjdVd/bCQg3Y+AXUlXMccLv4e0Gi4AfvmObg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hULAVxHR; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hULAVxHR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0DHN2C2Pz2xlK
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Apr 2026 17:18:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C16506001A;
	Tue, 21 Apr 2026 07:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615CFC2BCB5;
	Tue, 21 Apr 2026 07:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776755932;
	bh=S6ukYIEa7PkKZt0aeWQsFUMV2dD52iDECI8Kl9MrcyU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=hULAVxHRy4aIDb5Ad7g3vKoJlGRKEvPgaMlRs457W+tQEkuJcbi5XXwXWPbeBd6GL
	 fpll86KYG4FB9e2yC1vHxBK2sbhpXpcp0fyW+0L/+yMUhQaNpEF6zCBM83JSvmo/Cv
	 WVddOy7TbqdGj1JRtsmUTwwz8ZIqulDYWgKNa8cSrV8bKfragjFV0aBSt5J3nbN6cy
	 60z8JQv6Mug2uVGwquPf/LNSJvg8dgDE/nP7QgdRQtc/JBlbib5wiJK6Rj9z6AfwrV
	 rEvqRRchy0smmcarGlNUj6g3WIhZiUwMvdqZ3TIkteEW29chcD5/Qd8GN/lsJ4SCdD
	 7FYcL1oiC4oFg==
Message-ID: <56b30a7d-05a4-4b79-a743-0ed4a4b510c0@kernel.org>
Date: Tue, 21 Apr 2026 15:18:49 +0800
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
 oliver.yang@linux.alibaba.com
Subject: Re: [PATCH] erofs: fix offset truncation when shifting pgoff on
 32-bit platforms
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20260420034612.1899973-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260420034612.1899973-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-3344-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email]
X-Rspamd-Queue-Id: 507BA437721
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/2026 11:46 AM, Gao Xiang wrote:
> On 32-bit platforms, pgoff_t is 32 bits wide, so left-shifting
> large arbitrary pgoff_t values by PAGE_SHIFT performs 32-bit arithmetic
> and silently truncates the result for pages beyond the 4 GiB boundary.
> 
> Cast the page index to loff_t before shifting to produce a correct
> 64-bit byte offset.
> 
> Fixes: 386292919c25 ("erofs: introduce readmore decompression strategy")
> Fixes: 307210c262a2 ("erofs: verify metadata accesses for file-backed mounts")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

