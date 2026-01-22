Return-Path: <linux-erofs+bounces-2139-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DaqGyrpcWkONAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2139-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 10:08:58 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0DD643F1
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 10:08:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxZxM1l03z2yFm;
	Thu, 22 Jan 2026 20:08:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769072935;
	cv=none; b=DVxRPdYssfOgom06lges7ksO1cU/JZXZdqhL8UFix4alI+Q05eBRW5OMcKN04JnTMN0h/OrQYaQnz4zD8cZwgcr+7cnC1/WjyLmvPF0IdBUnCaB+lfUuuM6dZQJHKAFS4pVmx5I5MM2AV+CqydxAG1CJoo5dCIREDotREDQ0yfrvQTtqBvtqT34rbHow4pL88VRgJa/xyKiHHZ2bhuJcgVjljTmmuJMRL9r73IeCUoLrF6jhKHIo42eu/BPcS3RMv6DfpaNsfu+FEb6nA8HKatWvtO/6nXKAfqYHhlcBFWMy0dgzfcBex0zmVnCbjSvH7YnOQL4Cus5FJaizdumA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769072935; c=relaxed/relaxed;
	bh=EQpyXJCeYPZa2QeahxVTTKgW38exZKGF0s33W9jen+U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hw4Dv8Whpbqro0HhbZxvT3xJI9kJ/ZMk+v8jDKvfy2M3lP6+ie0qlgjZZMTgFi6lfaPoM+Kv6R9NiwQHpwdAbaIZuaGbd5SbsYVSVHsgOlBSstJRF7sB9mQwdQG5JbgEJdML9QHoOTn3dACsiq1GUtzz4UOnwKwdoceTCmetBhlML+R+a8gsrwFhprLPXbg9sb8EPVfIjPRiQHAcXO4NY1EKgV1ECpo9w4AK5+tBF2OJ7CKkfXEu6Q+4IT5frtXX3gvKnx0x221vIvZPYzJ8+VCsMttVjA1l8AiurHfE8rx1aQ7bMbKI/Jor18PvHoKWen8uriVGfYpAr5kpyy/oLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tnDeBWSQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tnDeBWSQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxZxL44MTz2xS5
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jan 2026 20:08:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 07AC1434AC;
	Thu, 22 Jan 2026 09:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9117C116C6;
	Thu, 22 Jan 2026 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769072931;
	bh=oFWeUc979XjnbOTIUmgcBQ2/3cjEDV4wO66JLs7fCko=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=tnDeBWSQTf8KSqWsyWQORg1rHGRMqlDX9brGdM47xtX/5xRuTFvLb787QN5LUKI2L
	 v4ZolKmKdK0r4XHW3IIV8b5ZjgNamVp3WAfNhD0aqsOotu30uqnMvjpnmMk9mfyIlx
	 fpE2mm/4EVmlrkNCWYjdBNazc5ew2fWzaYmEseO2s9nP2744gEZWcrIWU9nqHtb8zO
	 Qwa2wNce4BefbCVlvMgXohxJ4mUYqOvE2Zou8aljrTVoUJTom1jnioy89hHi8MtWGT
	 o0MB+snN+818JTzkh/5ZbOxsMikaXEpf1YQQNQfyV7nrx+z2onfVSn3NauvrIiAgT/
	 5l6hf0vEtiQ2w==
Message-ID: <075199b8-40f4-4ba7-94a5-a336e1b7ad7a@kernel.org>
Date: Thu, 22 Jan 2026 17:08:55 +0800
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
 Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH v2 4/4] erofs: unexport erofs_xattr_prefix()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20251229092949.2316075-4-hsiangkao@linux.alibaba.com>
 <20251231045736.1552300-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251231045736.1552300-1-hsiangkao@linux.alibaba.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:lihongbo22@huawei.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2139-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 7F0DD643F1
X-Rspamd-Action: no action

On 12/31/2025 12:57 PM, Gao Xiang wrote:
> It can be simply in xattr.c due to no external users.
> 
> Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

