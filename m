Return-Path: <linux-erofs+bounces-2939-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FRxLUi1wGkQKQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2939-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 04:36:40 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C303E2EC3D5
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 04:36:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffJk800pwz2ySb;
	Mon, 23 Mar 2026 14:36:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774236991;
	cv=none; b=EmLSigYgB0xRZ7H4wJjn4uX/FjIeNhB0/SkVB1bE8I0RMpw0x2IT0CrdJlu5ZHZxhF87tRP8QwNkRnDSiaDoIC++8Sc833zDBz0BV1XiWpHj/mdg0R4k/Dvaqr1fFa+lmdOKt8+smvoNtMLeWe44O0h5UgGJJl1EHTyTWL4zpneY8oSTLPlBL0kj2isXv71qIBLieLPjx5AfntvlEaZx+2FnbSvcHkI/SZjCb5Lnym+uA5qZ5heBKlKhCuZKFyX0qsnDVKHqzkYZyRW+FgIvT3zwADJBV2JeBdAx9P5eIuUpGr6RiTPsqlgjMlm+Q5aSsgRpUC4bHhkwRE72d62jsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774236991; c=relaxed/relaxed;
	bh=hA6C3jQd4m0QVLC+JxyRoTwUaXIqYK4Fk66F34NoccE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k95HBVtYM/O84EH5eidrmhkOlWaBE2P9Qa1xlNvpoKUon3kp4SybmiB9XReRqDbxTRxWnrh9oGW9xA7w7iSgZx/qDGcXCMWiSz4eBkjhomH3YLDihySMqcC7xBxEtl/K/Iff5uvFX03LKVSe3+qRsYYYxXCYqgiW7XmaT94MAI4x1q4jQzqEBYYvCzFWIUMh8YAPGzFS5kRYl+nmo+lhnyS84xfYBBCZBvJ5eh2ahbawqIfqFyTko7Tbf+vltsH8IctMuFyzDZeasamePMyuBIbWGhzDXcbO+IcFOh9DzkuM++wfYk/INZ4EcG0FS1F4RYUIygGUlxYlyz4PcPQoGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fwU/dV57; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fwU/dV57;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffJk42vkDz2xd6
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 14:36:27 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774236982; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hA6C3jQd4m0QVLC+JxyRoTwUaXIqYK4Fk66F34NoccE=;
	b=fwU/dV57iJa6ORazpLaaIuugTW/HRYWqNYgoBz5dLjjSuZ0ewWf5J/zDuxjrgrJ1JS3rqhiwy9tCV+dZnCPiM5AfmC028Ow1O8UtXdKKiFeoM9OI3jJYDkI3i0N4iPd/2LsbC0liywkz2r6vYNO2LBA+mY2RMI7M11QPYgEvlio=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.SGmXh_1774236979;
Received: from 30.221.131.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.SGmXh_1774236979 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 11:36:20 +0800
Message-ID: <491c421e-90a5-488a-b0ba-9ee0e9be4ec6@linux.alibaba.com>
Date: Mon, 23 Mar 2026 11:36:19 +0800
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
Subject: Re: [PATCH] erofs-utils: fsck: check symlink size before allocation
To: Nithurshen <nithurshen.dev@gmail.com>, ch@vnsh.in
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
References: <20260321183638.43353-1-ch@vnsh.in>
 <20260323033204.97472-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260323033204.97472-1-nithurshen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2939-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:ch@vnsh.in,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vnsh.in];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: C303E2EC3D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/23 11:32, Nithurshen wrote:
> Hi Xiang,
> 
> This patch LGTM.
> 
> I manually verified this by compiling with `-O0 -g` on macOS (arm64)
> and using lldb for fault injection. I stepped through
> erofs_extract_symlink() and allowed erofs_verify_inode_data() to pass
> with normal metadata. Right before the buffer allocation, I artificially
> inflated inode->i_size to 0xffffffffffffffff (SIZE_MAX).
> 
> Without the patch, bypassing the OS read limits with this size causes
> a predictable heap buffer overflow and an EXC_BAD_ACCESS crash. With
> the patch applied, the bounds check successfully catches the malformed
> size, gracefully bails out with -EOVERFLOW, and prevents the memory
> corruption.

This patch doesn't look good to me.
I will submit another patch instead.

> 
> Tested-by: Nithurshen <nithurshen.dev@gmail.com>
> Reviewed-by: Nithurshen <nithurshen.dev@gmail.com>


