Return-Path: <linux-erofs+bounces-3628-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u1LNG3Y0MWridwUAu9opvQ
	(envelope-from <linux-erofs+bounces-3628-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 13:33:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E3F68ECF5
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 13:33:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="WgjKow//";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3628-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3628-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gflGp0RPxz3brH;
	Tue, 16 Jun 2026 21:33:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781609585;
	cv=none; b=OYuKRH9d0pIvEgjZjJ8BFIGONNcOsCSctszG2xAwq4q5D9+dsVu5t2SBwr6azDTGeqEXbnDX8fI0JYfOt4bCf79gD1/HD1nb394EsWUcVHTPQ+6TcnXrD8lJqDmz7pvFEqPJyWAjwInXO1GLwDzYfFpFr1D8RoHdptH7on6m6tbq80pRwJRnmG0Au51lMHUtElzGYFZLdoeqD1P9B80dptfJ0WfHK9Rl8ybYT9CHuR6vOPeSaQncpGSYAGfFvMbUX83yr84AZvIFbaehFLxA/qbo1E7bvZM0o3v7vhh7ObQmc4IJgaUaCbEM4mJt278Vw0PgoxaCKiOSNY42CYrkqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781609585; c=relaxed/relaxed;
	bh=3jUacLBnaiUT8m88bzKss7QjSDoac1btVgY57AcZMV4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fUenDAO/cLEzqf9Xspe/cqULpM+B+TA95DxO9K4rJbgdgMcs0B6nXBXZtoWQgBv6Vi+4KsMfRU8yKEwZCUatBmO6vvM0SiSsVXWG2Ec1VeO2uXLq1qFFMSJpWaVn5bHH3o2gZkHPcb2kJaX+JxBRNrGnT7jQTaqbG4D6gkxM2zZlFEohv1StywR8dc4LKDILKVFwUHmZbWvFrr+dyxDIZPb7c9suK6/jkKBfnTw9V5pqTAaxTO3dWZjs6AV7Hk1QT1Uq3y/qkS9FAnyMrsor3tKP8uLOx7C4fOjhaYbFTUkWMO+TGVxrhC3JPEg9yWY0AsQCaFQ9peag0ZLQxbnajg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgjKow//; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gflGn0Fjbz3bqh
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jun 2026 21:33:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5F4314180D;
	Tue, 16 Jun 2026 11:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595771F000E9;
	Tue, 16 Jun 2026 11:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781609582;
	bh=3jUacLBnaiUT8m88bzKss7QjSDoac1btVgY57AcZMV4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=WgjKow//JXgyD/56WCfiaRtjxvaNlvsSgGjwQxbqfY4iz2B8IBBtcwob2gffp9IwJ
	 Xmni5VWtpJ7T00KneG9C5Ysy/nqL+pMgpDoAL77+NHDQ9WG3h/eUkYKuORKj7gY6zH
	 vGdBy+Q8iQSvCO0VYm8LEWbccgu5vCT+q6E3KMAumHpJZBqCdlLe3aNLtEmqkBJg6N
	 JpGwYVkwXji79LbkmONEiWvTQTnSxtaFq7WWLbhN6t4rQ2RkXsFp0e5o7A7WjNnow1
	 P+ZcHOoXLrmkuOmzwm3fETPYQVSOy1ya+p9wnWFoK03/QEZkxig1/N59puwpiQjSqW
	 BySWEL/FNYekw==
Message-ID: <09934a59-1504-4de7-811a-8cea4824c64b@kernel.org>
Date: Tue, 16 Jun 2026 11:32:59 +0000
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
 oliver.yang@linux.alibaba.com, Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH] erofs: clean up erofs_ishare_fill_inode()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20260607172132.2695176-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260607172132.2695176-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:lihongbo22@huawei.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-3628-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37E3F68ECF5

On 6/7/26 17:21, Gao Xiang wrote:
>   - Use the shorthand `si` to replace the overly long `sharedinode`;
> 
>   - Introduce erofs_warn() and get rid of barely-used _erofs_printk();
> 
>   - Get rid of the variable `hash`;
> 
>   - Simplify error paths.
> 
> Cc: Hongbo Li <lihongbo22@huawei.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

