Return-Path: <linux-erofs+bounces-2109-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP0aGNdicGkVXwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2109-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 06:23:35 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 619F151767
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 06:23:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwszl6bGYz2yFg;
	Wed, 21 Jan 2026 16:23:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768973011;
	cv=none; b=ERANpk2dOcKGczvI7z8Np6AijA6JnFTYYENvgJL8HJxVyDB1W1HzcFRxaRkyM2Tpj2SAYBUdUH0bqNCFX+siK7tf8NhAsV4KgcSyAHIHM48xanyj2rlSUORA/5HJErbU/0RLom9w2ivIFpnt/PAIMYbh48yXJkQI7seLZt1KjJFsZm46snRfYY8oGQDWNY/xaqgm/QQqvA4GYkbVE9ZA3keePIe92HC83ZweuLI7EX+30d2QzfdbQ3ddXK3rUD8GLzj0K/YemWgGpdkihSJaReOLpy9QB1jRGG8ccUU7uQJLCBAY/T/g0RAWeElUamVt725de2i6/Thqo5s7ZRNWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768973011; c=relaxed/relaxed;
	bh=XELRupvEWGRYwGCJIC9STtRM2bBc/e+UPbESJEin4hk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XkD/5zfamb8wmK4KffIL6qgyI93FU6M3uLhVFpKoeltSVqJ1stIXGhuk7akyl4De/7o8AbKG2TwKvlEcYEYdanhdKZ1NkPk+0xos2rLv5uRepUUMwS9C02XAvawrjT/dzIk8iBPO8imosS5iV+FcWSTvcFQUcSeuE6syJ3Bt503gADmlIuFLFKHzOV/VEUPqvMm2OJJ/rvqvI1JYbBXpuk+RboPXHgEj8h3Rwo3netjq2XEl3YrY0cPACXlo1SFEyooHBRVenZnzLEg9Ju3Vjs465y4NWizgWKL6S1PkpNh9dPjIKS72vI+7YHl1jagKPW2OPXCW3CfiYbTwUlnDsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iSra//tN; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iSra//tN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwszl2qcvz2xqD
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jan 2026 16:23:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2A9ED43A59;
	Wed, 21 Jan 2026 05:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF13EC116D0;
	Wed, 21 Jan 2026 05:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768973009;
	bh=Wb7ux9lPwXTWQpGJrwDdWLozj3EIWQgaSIOcFprtfxU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=iSra//tNAwvU+7Fut1gEgGr2ujiTU1KqwmWBEjmI0jgANirIlAmjeBpq6j/TL3S5e
	 uXtQ+RFZHvIqaVOkOHPqrYqHTy0amaYt4hCqTNjGklaG84a4JS4ZGQhgLlsS6GCxsd
	 upBYVrCBZ5MqRtfa8YIaCjjvH/+abSJ0T8vtuibb/EXMEe7y78xqynKZyR748n0olW
	 PF/jkUKfbXqOK59vJs475x1BcSFQyl5XCboAKQAJAfsolor0CYyT4a14hQtYHXb3e+
	 aVE/AOvJVpTUUbNut14QWfJPpXermrIKDz7cWhqBjuR46kloSKpezteMasfHd5+d8A
	 qUEAUxVvkuP/w==
Message-ID: <25ccc2ee-07d4-4be6-b6d7-10186d922c5c@kernel.org>
Date: Wed, 21 Jan 2026 13:23:24 +0800
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
Subject: Re: [PATCH] erofs: make z_erofs_crypto[] static
To: Ferry Meng <mengferry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20251216082141.108624-1-mengferry@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251216082141.108624-1-mengferry@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-2109-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:mengferry@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,alibaba.com:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 619F151767
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2025/12/16 16:21, Ferry Meng wrote:
> Reduce the scope of 'z_erofs_crypto[]' that is not used outside of
> 'decompressor_crypto.c'.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512102025.4mWeBSsf-lkp@intel.com/
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

