Return-Path: <linux-erofs+bounces-2131-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APhZDc+lcWmjKwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2131-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 05:21:35 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5128A61AE6
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 05:21:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxSYj1ZDXz2yFm;
	Thu, 22 Jan 2026 15:21:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769055689;
	cv=none; b=Wd+NUywmjn+4kHoC375wCqTuf+e4T6DMFrY9i4qlfs+l18Ha9Ds1w+4ciDZpVeenydwPUIj+HxooBkyxBCsJq7Zmn2VyUpFwixcwQ2/TP+i/iKHPPQ5MB0oB5vAUjSTs8kVj1Vcu+qiSC+3cq47g9fbyKt4MORLuTRUTLsLetY7x3ZKNz6vgAa4hVOclrsEZQBUhYCW+NixkyOmqIg4StPErY4pj7R5+q/YAy97oowU6BE94864QSxqTWmaCy/Oh1p6WPIEe3FwVqVWIN2AkJCkVbw7FzUWFU0D0RAVEzGwuhAy3o9eblWrS97eKNhTLjRkjZ8dN22NmAJXOPgMzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769055689; c=relaxed/relaxed;
	bh=vHQLw+o7Iz8Y/2eg+iebRg/Ie1Uu7uMmhvQTrRsL23A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=deWN87nJXMXS9xkZzOqTXo1f4BiftbB5IAdZh9HiSlEwcCS1ZPzODSdnu/1v5vn6nPC68ZznArSFOQzV1OuDQ9QircaONtF/tKCxbDHj9V5Gj8yQnHRxFV7L6Y9vmnEDzOvw/dsz2Wtf5rCvglPHk2b8J6vq7aj40VWXwEvlRGVxJf/jcdDrrcY86rpoPV3f4XZA15+uMODN7IvLSWT82PNAscVUbUd8aNZ1c+3+WwLPtDa1aAxLl1eRzU09RIDlycFZlfRCDKgw4uZY+PJb8PtK4W0EeHeosg+O0zzRvX5fDd7hw8N4gF2tAW01MG2yf7ynIt299JEEYEOmcmV/pA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mtOV18ZE; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mtOV18ZE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxSYh2VFqz2xS5
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jan 2026 15:21:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E199243A2E;
	Thu, 22 Jan 2026 04:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E2FC116C6;
	Thu, 22 Jan 2026 04:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769055685;
	bh=PnCFLDk3rvEhNj2n5M073CcTOotus4sbq8LaiP3P8O8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=mtOV18ZEQiu1ZcgbhK1vU/XF45dx5yD/hB5eTY0+HLKdyK0dhDruMRzBb+8PcRGsN
	 D8wNaKQqg7bL6xgHg9FoHvf/rV56sQU+3sDKOmnrc3laE8WSDLh+PSSw6JrQ/UbGa/
	 IjQWR7wEtUjls/tb0RTvdV+8Qv9ACep+XbO+AJ3F3u7nGrArJnwYpMWzii5oNJFqFf
	 /K5Lg3YjdtXG84xn84dkyLV9dAdjfpnO1jJrqLgP/KAX0n6hJv/YWxgyNUbo1GixaG
	 /kkaNk1Ub6V6Hmyt+DQ2hmV2afrAErTJ65MC2KkvAZLk/9h0fSE16JnsQNhjMOQXrZ
	 +JplV6wLcAPtA==
Message-ID: <f3e2e867-7572-4b27-ab9b-401aad13da05@kernel.org>
Date: Thu, 22 Jan 2026 12:21:28 +0800
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
Subject: Re: [PATCH] erofs: improve LZ4 error strings
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20251219064336.684930-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251219064336.684930-1-hsiangkao@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2131-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5128A61AE6
X-Rspamd-Action: no action

On 12/19/2025 2:43 PM, Gao Xiang wrote:
> Just like what was done for other algorithms, let's propagate detailed
> error reasons for LZ4 instead of just -EFSCORRUPTED to users:
> 
>   "corrupted compressed data":
>      the compressed data is malformed or
>        destination buffer is not large enough
> 
>   "unexpected end of stream":
>      the compressed stream ends normally, but without producing enough
>      decompressed data.
> 
>   "compressed data start not found":
>      can be returned by z_erofs_fixup_insize().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

