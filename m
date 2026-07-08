Return-Path: <linux-erofs+bounces-3856-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NygNJXu2TWp29QEAu9opvQ
	(envelope-from <linux-erofs+bounces-3856-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 04:31:23 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0B37212B3
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 04:31:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=LZZOQd5W;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3856-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3856-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw2CX3StQz306S;
	Wed, 08 Jul 2026 12:31:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783477880;
	cv=none; b=A9Fl3v40Ds0Yr+nZxugUod+YsdvcplKNbZTGp/QytsCSLZgTvfdNWYvCOgl9naAZGFEjiTfIBEN7qMiByf53eGv8QM/+8BtWtcJxpw4srIP95BzqF7S+H71LhAi2Ra+eu16wYOLxTtlmqsFdG2yYuaiJyZupPwNAqNE+KGPo/Z7EbaT8ZlwBPwfKl8S9WSfTQa+RLXnhuaXUH9vL/rKCIC7BgjL8LZG4tbhvlUQ3SU228mIoLj1wMf1J9LNjgVNuh3rMp9cDZ7c+vF7VLjXQ2kafkaC4Gt1FDgRJt4nyEa6ZFrr19y8Wp3VRZP7UQ4URBGQtQdSTMaVd3RnPzRNHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783477880; c=relaxed/relaxed;
	bh=ZS+cpNRTVvjKVTiSg9Hay84yMNFzz/Iq0gsJUwZ2bIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVuGMfCbSnNe2RFxtQP8mRikQm99CzkwKPP7vErsun2nRBHAVv0N1EPOTJzC22I1u4CY1ToF81yi2/xGHYhki6wLHD8icyCJ0CVuX9Fp4dXvdYnf3Pe4IKfEGFTXZyGi7yyVXCYI1d2Kw4PgBLm0twAdckKhwDcfeKPDMvk+uA4hG9taQqqOdhJE3amFOCQP9rJxGyUSPSdo03k5YFRYPN45TmEZ8nFdYpkuTtfNVzAvPP3at6vYyX9/MSwsRLk3boR3DN+8kuvrONFIJv+Gut+AMS24y2eZ+HFyY0orkRqy4fGF88XSol+S3FQAJ+ct1I5LVeS4mr4hgs/gdOEJQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LZZOQd5W; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw2CV5c1fz3046
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Jul 2026 12:31:16 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783477872; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZS+cpNRTVvjKVTiSg9Hay84yMNFzz/Iq0gsJUwZ2bIg=;
	b=LZZOQd5WMJJ9/1lN6L0GYGspatgDsF3b7ZUV1bZ4wPSKIhkZt9hNNVIgZOHeB3ZDXVuE0cPqByN4/cZbMi/JUaVN4X3ecy61oBwVml9vsvI6+w6o4N2gR8Ve9C+rEJx+0pQKZGN9dWXtoLRG6oP9eSVEELAxDqhmuaB9ZV0zJ3I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X6g.GSX_1783477870;
Received: from 30.221.130.153(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6g.GSX_1783477870 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 10:31:11 +0800
Message-ID: <8e8871ed-5d29-4875-a86e-b86b18467481@linux.alibaba.com>
Date: Wed, 8 Jul 2026 10:31:10 +0800
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
Subject: Re: [PATCH 1/2 v3] fsck.erofs: add multi-threaded decompression
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
References: <20260706060525.14018-1-nithurshen.dev@gmail.com>
 <20260706061048.16349-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260706061048.16349-1-nithurshen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3856-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E0B37212B3



On 2026/7/6 14:10, Nithurshen wrote:
> Hi Xiang,
> 
> Please find the updated multi-threaded decompression implementation for
> fsck.erofs. This version introduces an algorithm-aware asynchronous
> worker pool, dynamically sized based on system CPUs, to significantly
> accelerate the extraction of computationally expensive images.
> 
> Benchmarks were performed on an ARM64 environment, extracting the 8.2 GB
> Linux repository downloaded from Github.
> 
> Extraction Time (Seconds):
> 
> | Algorithm | 4k | 8k | 16k | 32k | 64k |
> | --- | --- | --- | --- | --- | --- |
> | lz4hc(MT) | 9.36 | 8.31 | 8.27 | 8.54 | 6.94 |
> | lz4hc(ST) | 4.40 | 5.77 | 3.65 | 5.45 | 3.36 |
> | zstd(MT) | 9.26 | 8.68 | 8.89 | 8.11 | 7.94 |
> | zstd(ST) | 5.23 | 4.52 | 4.62 | 4.11 | 4.02 |
> | lzma(MT) | 23.72 | 24.79 | 25.90 | 26.92 | 27.77 |
> | lzma(ST) | 56.37 | 65.06 | 71.07 | 74.69 | 81.63 |
> 
> Performance Analysis:
> The implementation provides a significant speedup for LZMA (up to 2.9x)
> as the heavy decompression workload effectively amortizes the thread
> synchronization overhead.
> 
> However, for fast algorithms like LZ4 and ZSTD, the current MT overhead
> (futex contention and scheduling) leads to slower performance compared
> to the synchronous baseline.
> 
> I have tried various batch sizes for fast algorithms, but the time did
> not improve. (I tried from 32 to 256 batch sizes)
> 
> Can we fall back to synchronous extraction here?

Sorry for delay.

We cannot, that is why we need to find a proper way to batch
the pclusters and reschedule.

And that is why I asked you to benchmark each commit.

Thanks,
Gao Xiang

> 
> Verification:
> 
> * Deadlocks/Race Conditions: Verified via GDB backtrace analysis and
> stress testing.
> * Memory Leaks: Verified via rigorous buffer ownership tracking and
> ensuring all task resources are cleaned up upon worker completion.
> * Integrity: All configurations passed bit-for-bit integrity checks
> between the extracted and original directory for all algorithms and
> chunk sizes.
> 
> All concurrency primitives and memory paths have been verified to the
> best of my knowledge.
> 
> Thanks,
> Nithurshen


