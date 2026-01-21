Return-Path: <linux-erofs+bounces-2110-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMKiIuBjcGkVXwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2110-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 06:28:00 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D95451828
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 06:27:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwt4r70qrz2yFg;
	Wed, 21 Jan 2026 16:27:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768973276;
	cv=none; b=hbqMHB/CqXcYxcfTeWdETjlddS0lwS7QwsawXwY2QrUvpbzI7+Zh7Mu4VoEAzcyQVTBR5zwgYxQXdV045nwX34S32RHi2d/0c02/3QJy7YMaAzJuY+//KPcG201qMyfs1hSrAxRLE9I7+9LCwggqgTuc9W5U0V0BG/bi4KU9tp10WjMIdTQ0fxyn5lNoxrVypxzs9NSVsF6UwMM6OJFjFL+eb28wP9CCkeZj71ZX/uTIUwnUP2wrB4mzvAcqEWVLB6U5YCFPEdKk9pWHOFTT/xybirNdS0gLp3k1Llz7BnyVVCTs9TMLqeATBgTqvq5/ED1S9lDqAPylvB43RpMeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768973276; c=relaxed/relaxed;
	bh=L7ffSaFY9hSUNrn0s0Ysn3AOzLg+Gr1klNNeJEG6A7Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I5gkF8lhH4j2LRbFNBeVA8daF0s27CEgJmxr+fA2HwAQlynKYh+MNGQEWwpiP6icfqFe68I5Hiq0K6VvGId3nrXOn3vF22WjG+n6bBnlefZB47DZnq8HXJhVuNuNaftXriDL57NcGR2f7mVN3R45JzQJfXruOPtmdKrpMDKh3SPljl4f5r1KMQ4tkHUQcr002I5+7ErlKhnnsyZ+12CJ3aMmF6yG5ydkUko2ct3rKgZLd0Og50kNBli9Q5BZx9Ujps4WS2m4DZFvZ3sIRaXYas0BLKsv3OE8idO7ZzofSmDhkgmVMyjnkJNilYZQEW0YmVtWOHDutbuYv0l7bBAeVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qoVh/no/; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qoVh/no/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwt4r1xN1z2xqD
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jan 2026 16:27:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 09DCC600B0;
	Wed, 21 Jan 2026 05:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20008C116D0;
	Wed, 21 Jan 2026 05:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768973273;
	bh=nHpg1EF7HJpdf31CrEqfhqk/uUlLjRPE/a6P5BwdKFA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qoVh/no/u81tp5Ur32XJDjCtubqxYW5j9GLoKuRbERwx4/Fo7N7tSK/bGqj2XIH6m
	 JHMrTrQxSBamlFDh0FBZHIvxq28ZW2q/0uX/VYWL1yCFZA+aB5jEjyqkFhx4QNNxbA
	 1vnD0VHRu4z132CnRGy9zNpxwVi0uygN1I3GzrmPhjYNEIhwz1xEpFCtaGy7LlsfuS
	 5DPMdDlX8/fVwbQ3vR/k+ZvqDd3Kt0QLzxNwa95Ge/qScwJWwcawqY+IGNv+iKKHRR
	 G/FRZQdL2bFEQN3O3OOA+sjEN6ezvEe+A2c0ParbGZeTlheO6+fz+WmhK56XXis65t
	 CA93NknIp5dgw==
Message-ID: <6735574e-9def-49a9-b44c-641329960a75@kernel.org>
Date: Wed, 21 Jan 2026 13:27:46 +0800
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
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] erofs: simplify the code using for_each_set_bit
To: Yuwen Chen <ywen.chen@foxmail.com>, xiang@kernel.org
References: <tencent_2F5DAC4517DCA2E354AE3BE70379BF5F9108@qq.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <tencent_2F5DAC4517DCA2E354AE3BE70379BF5F9108@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:huyue2@coolpad.com,m:jefflexu@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:ywen.chen@foxmail.com,m:xiang@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[foxmail.com,kernel.org];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2110-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 8D95451828
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2025/12/18 12:19, Yuwen Chen wrote:
> When mounting the EROFS file system, it is necessary to check the
> available compression algorithms. At this time, the for_each_set_bit
> function can be used to simplify the code logic.
> 
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

