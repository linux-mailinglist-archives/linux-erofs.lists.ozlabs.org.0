Return-Path: <linux-erofs+bounces-2135-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEQGK//ncWkONAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2135-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 10:03:59 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5D642C6
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 10:03:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxZqZ5JrVz30Sv;
	Thu, 22 Jan 2026 20:03:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769072634;
	cv=none; b=Xm+8FKdExXpuqvzPEMCn4Vf7hgteJpDFs6DwRa08PsXHwtP0IwAmsZiAltvrmqP58Un4UQaSSZvUmTZ043f09tPqLe89TXrQMCk4ASfz2THpMNDlio/DdP8RZTXBCzUWVn0pPPgYlR247A28CMDMIdNLqsuQoT1blSD9BlKfNuWTpzIbACoxW5t8nojENuTKdNuCh7hYYBCRMZ0d/Zt7vuh3/M5+drShw/IZggg3lU8ciHF9LuQziyhYdcYPHne23QX10ZCeLrARve/wQjjknH1xKIQZ40LZJbGsMk2Tfj8//u+YV6PlIGmGz6HCfpxPjsguDCMCYGNfsNtM+dUuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769072634; c=relaxed/relaxed;
	bh=fLiIg3L5mbty6GrCoTGT0ujnFzpEt/bUEww8Pr9VKc0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AdT77rUhVWOrm8gyPijulB4bPHSLV9KxB+hS7F0kSjji6yU0gI9wGBIzq6dT/z4J3j/TcYCUS/vXopMQc44472Tq/AVJYNTYFFk29+3tf/FPwt+Fy81GhaYFAEaCUMbPQKWhKY4K6sIzk3hj33LzKkyd8U/66wHY9k8aUeEQVKQVwoppBxZUH+UYDXA6Spz21sQri9JAkn8/8CqRUn36o6kvt9RK9V0hv6b+RptAxSEGpXAFMPNvrK37xGM9phfrlJMFN6EK9Om3xzbNtSX12XqI2rO+w+F8v0i69Nr5QdJWk9PNPefeiB3HhcW5SjgbWTAQyVQxj9w1ZgTXo9H8+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BTHau0+w; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BTHau0+w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxZqY601zz2xS5
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jan 2026 20:03:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D903439FE;
	Thu, 22 Jan 2026 09:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C49C16AAE;
	Thu, 22 Jan 2026 09:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769072630;
	bh=IwmNN/CotEikf4vO0cGIVoOEgPE72A3hg52bQZoAXzE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BTHau0+w2IkUSeFjLl1rA67UVL7yGQzOUwq5gRKmsf/T9BApHoZR2A/VeOupoNeT4
	 6MDrv9YfSbZKBA42gKOgYnRisTnWWGQZlxfzicxCBTin29vV5LHtSqgiRDMzZSU8tM
	 zXwyx5j8x14RfWQA7vMPrirlF55Wqb/CL64RzxYJDKV1jL4Gjj5d6USlBFcWb/+1e9
	 cY4CLGEcOEUq4Q82woyeY+GYKCbah52mZQP7I7Ts7gZ0HuIZuZ8+p2b9X4PQ1r8rN7
	 MkImgPiJg0SYn/cNu3fGLxNU/Ge9+HcKFlSG4LjqeDzDkQ0WG9M9IrPY+aQTuoYCV3
	 G2iL1dFa5XJfQ==
Message-ID: <62cc89b9-a70d-4506-826b-28eb4010e372@kernel.org>
Date: Thu, 22 Jan 2026 17:03:52 +0800
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
Subject: Re: [PATCH] erofs: avoid noisy messages for transient -ENOMEM
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20251226060945.786901-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251226060945.786901-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2135-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: EFE5D642C6
X-Rspamd-Action: no action

On 12/26/2025 2:09 PM, Gao Xiang wrote:
> EROFS may allocate temporary pages using GFP_NOWAIT | GFP_NORETRY
> when pcl->besteffort is off (e.g., for readahead requests).
> 
> If the allocation fails, the original request will fall back to
> synchronous read, so the failure is transient.
> 
> Such fallback can frequently happen in low memory scenarios, but since
> these failures are expected and temporary, avoid printing error
> messages like below:
> 
> [ 7425.184264] erofs (device sr0): failed to decompress (lz4) -ENOMEM @ pa 148447232 size 28672 => 26788
> [ 7426.244267] erofs (device sr0): failed to decompress (lz4) -ENOMEM @ pa 149422080 size 28672 => 15903
> [ 7426.245508] erofs (device sr0): failed to decompress (lz4) -ENOMEM @ pa 138440704 size 28672 => 39294
> ...
> [ 7504.258373] erofs (device sr0): failed to decompress (lz4) -ENOMEM @ pa 93581312 size 20480 => 47366
> 
> Fixes: 831faabed812 ("erofs: improve decompression error reporting")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

