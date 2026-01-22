Return-Path: <linux-erofs+bounces-2189-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AtoNOpScmnpfAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2189-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 17:40:10 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC66A22F
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 17:40:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxmxz3gjsz2ySb;
	Fri, 23 Jan 2026 03:40:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769100007;
	cv=none; b=kEWX/leCzGtg8701D/Fz4hebzvkXhzX3kkqnizaMNn612yB9mDqlz80An4q1BKaSvj0e0sEqwEzU4KC3voJ6mvhhUYuIslfKgyQJzuVy8hdJFE4H89Dv8ggb3Vi7lo2Z7ObvEs8bxJbsHfm7W/C3GEiivHYNsEqjPxcfjxeKNtIjLp5SUomNeXNcxEhQgDdCEkg16QR9Z2FgbWyNRE8t5h0410YGjxfXjMp1tyXoomUaaouoJuPUYHcPW2DAluCU3NDwd2J2g+T4UXytWSQBt3lPziZ2ahWAjbGo+WC1vebYCj+DLGfyjbioSR2W8IaPLwxRQteRgf+F/3WSyqcQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769100007; c=relaxed/relaxed;
	bh=RSY/JnmKMfJRsvDnjCG+dfJqjElkzKdq9scoQDm8tCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W61g3bRc5TDqyIqaAtEZ5V2m/w5jgT21ZZrJGH03SKv84D75EMLcX01rKljbpR5oOt3Id9CENYLqM0NaEnvG9Psu65L8YXT1amVfJddoboz2puUJ5HZA9Wii2b4fz6qaxKscFubVxr7DJwNKpRMjb4wxJwDkLYnT72RD7smeOIDvcwe0z0z4STZBsBSczHDF9Uzlt2YqB+BrRrlRc9up7iLUZelVzM4Dvrik7bBSDs+WS9x9Dd4/gCREHTiLRMT+gTMwzn5UN4lY1nz//uYc2DfaXivPusDN/Kquug2KDD6qfA6l8wHy9m4rEbhVrvV8QrG48UJwCnfxYJ4iTgPTew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qDkEOquo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qDkEOquo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxmxv4sH3z2xl0
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 03:40:01 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769099997; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RSY/JnmKMfJRsvDnjCG+dfJqjElkzKdq9scoQDm8tCM=;
	b=qDkEOquoK9hXZWOtAMBuaDdpQJ0F57gMCc2unasLwCr0RWAl7W6na08EkWgTfwVN6jJpYwD84+L2RT4olTXnITGn2lQNzSNZqpLX09avR+BqQzfuAPcosbbjqRuruqvL3xjQCR9MGOGiZXuS4VdHuOlIfeuUeNGRgI0MUr8kmbc=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxcxUuY_1769099996 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 00:39:57 +0800
Message-ID: <6caf418e-b261-4354-9ddb-77daaadab045@linux.alibaba.com>
Date: Fri, 23 Jan 2026 00:39:56 +0800
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
Subject: Re: [PATCH v17 08/10] erofs: support unencoded inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hch@lst.de, djwong@kernel.org, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <20260122153406.660073-1-lihongbo22@huawei.com>
 <20260122153406.660073-9-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260122153406.660073-9-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2189-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lihongbo22@huawei.com,m:hch@lst.de,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:chao@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: EAEC66A22F
X-Rspamd-Action: no action



On 2026/1/22 23:34, Hongbo Li wrote:
> This patch adds inode page cache sharing functionality for unencoded
> files.
> 
> I conducted experiments in the container environment. Below is the
> memory usage for reading all files in two different minor versions
> of container images:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     241     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     872     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     2771    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     926     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     390     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     924     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |     474     |      49%      |
> +-------------------+------------------+-------------+---------------+
> 
> Additionally, the table below shows the runtime memory usage of the
> container:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      35     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     149     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     1028    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  2.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     155     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      25     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     186     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |      98     |      48%      |
> +-------------------+------------------+-------------+---------------+
> 
> Co-developed-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

