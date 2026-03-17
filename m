Return-Path: <linux-erofs+bounces-2773-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jtEqKgq4uGm8iQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2773-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 03:10:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5329A2A2BEF
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 03:10:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZb5L2Vl1z2ySB;
	Tue, 17 Mar 2026 13:10:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773713414;
	cv=none; b=DgrFboA0yV6JzQ9BzvjKCFSsXF9RV0eD/x8AdlVAOuYQAWMH4teUt6OxamP8OZTm+tyTCH4cBrNWtGcK9ni21vtbQWps31LS6l6mrIWMUnRBA7K9t4A5eULof3ixNghtSfEKJDDScHAg/bQadPcpr1fWubH4r7krzipAEMKcFGTCNXj5IGsT+hhT43IMs99MHyDzqiQAlkDR8W6vAD5fJNBYy/ZJdRM3ICUmoQy5sXWfz0mJ6X9+F7DQS7fmRZsM77j6OvQephpxmWkIX/BLHkILone+UIavIEEm2DJ/YZ20A7l2Ei34d8QJxdALjgY9+bx28aKC1RS6za3yXSh3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773713414; c=relaxed/relaxed;
	bh=Q8CKSjfOEwiyYS2a3MWKW262aZN7KU+V42ZaNMRS9bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwSk5UvFDxz6Q9weQwg+10DGCcNqrnkzY2mPYf9cQosivyYE9nLzRtoUmtXZX6NzQ7exEiDvh38Y4NQqEugxR04lULwilltHJOW5TaHUvFz1KmtMu+bt4DLBz2n9XIfOCuWxIh0Fyp54J6jt1aqZKvzLU5Pun7pPJeOtf1u6dF1qh610lBt97HdBhH8Y/H3FrrH2OC5WGMQ23B90d8lUDjJmGDB797DUebK1SYuX31Ip02IQ5HWviwpcN8bPFLI/aHxEZM2Qo9ijlzFtuXdtFetjKdzr7AViLDqGD7z1oOFNxwuorj8+GyP7Etea/5TipEl5h4C6DLLcqTwFxXXI+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KcULD7hI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KcULD7hI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZb5H2tYSz2xb3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 13:10:09 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773713403; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Q8CKSjfOEwiyYS2a3MWKW262aZN7KU+V42ZaNMRS9bc=;
	b=KcULD7hI/i4MPsZPzrxA9Wkp1BLarz2wt4jKQ+dYok7MBh5pHsyemdWP1+YRUH5U7MIgRpaQBei2L93iRizWOXAanM1Klw7l9CNmtNy75GLhMhMGFFG917cti/yUwF4cLzHXvDjRD3krOBJkqH2urysabesfHBfPE3/u5L+NEVY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.9Gvpw_1773713401;
Received: from 30.221.133.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.9Gvpw_1773713401 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 10:10:02 +0800
Message-ID: <70da1a5c-8365-46a9-8c89-a3f451a6e257@linux.alibaba.com>
Date: Tue, 17 Mar 2026 10:10:01 +0800
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
Subject: Re: [PATCH v1 1/2] erofs-utils: lib: validate ZSTD frame content size
 in decompression
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: yifan.yfzhao@foxmail.com
References: <20260316212847.57030-1-singhutkal015@gmail.com>
 <20260316212847.57030-2-singhutkal015@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260316212847.57030-2-singhutkal015@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2773-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:yifan.yfzhao@foxmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[foxmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 5329A2A2BEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/17 05:28, Utkal Singh wrote:
> ZSTD_getFrameContentSize() reads the content size from the ZSTD
> frame header in the compressed data. This is untrusted on-disk
> metadata, independent from the extent map that provides
> rq->decodedlength via z_erofs_map_blocks_iter().
> 
> A crafted EROFS image can set the extent map to claim a decoded
> length larger than the actual ZSTD frame content size. When this
> happens, a buffer of the (smaller) frame content size is allocated
> and decompressed into, but the subsequent memcpy copies
> rq->decodedlength bytes from it — a potential out-of-bounds read.
> 
> Additionally, the ZSTD_getDecompressedSize() legacy fallback
> returns 0 for frames without a content size field. This leads to
> malloc(0) followed by out-of-bounds access on the returned pointer.
> 
> Reject frames where the reported content size is zero or smaller
> than the expected decoded length.

For this kind of commits, please add reproduciable way all the time.

