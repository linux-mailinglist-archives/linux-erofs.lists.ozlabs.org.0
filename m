Return-Path: <linux-erofs+bounces-3083-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFgzIS/VyWmO2wUAu9opvQ
	(envelope-from <linux-erofs+bounces-3083-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 03:43:11 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83080354A16
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 03:43:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkYt11yvQz2xly;
	Mon, 30 Mar 2026 12:43:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774834985;
	cv=none; b=ksJ/En4RCvpCU+UN71gShcZdmakBFXNRI/yJv3NlrOZtPizdSqmQWE7J8YF9gx3qUHpqbe0TWDKXTj8YbpPKQgf0EXtze3o2RJIEbTPTcZ8sR7Ukh8k2rMMmo4eGPkGeOk+j78SgowxsaY1YIG3o8ELhwAz/CuaO5MiQD3RbKD0gw4PjwTdoFuxObToJQm/RQ6FaOpO0ENvmlJypiwfa2mRkCtNqX/6n1ou9DtKC+q1i25AxYWAlIMH0xGVZ4VPBGbBk08Ez/D+1ZplnlSDoy9xyZ26mPuxeDQ/YEajJdwxC3qEP7WFedBIry3Gl5MGuRE3SwH+HSepQ0LQcQDSbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774834985; c=relaxed/relaxed;
	bh=h1jvKRVy/dYlXyLKi2q1q2tOEAh3A3BaoHxsyOiw9x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itWFYz0eCzwjyVtg3o6/lOfnjnFYioxpJCTzXcmfXc4uBwKkE63XQZer3jSgZYAJoD6pnm+J5uLoQeRcxmNEQLYBP8UR1QfjVocvqPdFQOWwcoJxegg5E6AwBwVGcOsx3GdYqZNq4i/s1yeG+vOXfkzRP7/JJGpsRhwVq1ebwsMvG9K8ZDM5aQfXECxOswKdfZ41MOqGUp07ZaYwgrSQJwMwiy3ZcdElNag2dJk9IpNhhP0azmKTL++LxtwBCIqFx0C7BWMELVYEGdqzTLiclvkyiO5FeaZioHk0EV5niqHf4MJXhm57K/lEYKplbocyxyZW8A5+z46tjE8sT7NuZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mxBrLbTv; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mxBrLbTv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkYsy1LGSz2xdV
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 12:43:00 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774834975; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=h1jvKRVy/dYlXyLKi2q1q2tOEAh3A3BaoHxsyOiw9x8=;
	b=mxBrLbTvDaIqWPH+0/pT9jxPwzOXPvTciCRu9Im7enL7gk8VPcLSFq7ocZLVMN0Z8cGiH5tBA4LUprm4vevHkiEjR7WC9cmor390obnSjrrPqMMI5LdXgkHA6IXr3a+L8snJyWC/7+Si3/UX3/ddEubZCYc5zJWs2HbHjZZkMCU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.toMlf_1774834974;
Received: from 30.221.131.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.toMlf_1774834974 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Mar 2026 09:42:54 +0800
Message-ID: <ff4b7e1c-2370-471c-b461-f66dcd28967b@linux.alibaba.com>
Date: Mon, 30 Mar 2026 09:42:53 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: switch ZSTD decompression to streaming
 API
To: Utkal Singh <singhutkal015@gmail.com>,
 Nithurshen <nithurshen.dev@gmail.com>
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org
References: <20260323052257.11377-1-singhutkal015@gmail.com>
 <20260323111901.44548-1-nithurshen.dev@gmail.com>
 <CAGSu4WO+q_zwjp_c3Bbk6eGEDiEpjhHf-8BOiKLaW02mJwS5Jg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGSu4WO+q_zwjp_c3Bbk6eGEDiEpjhHf-8BOiKLaW02mJwS5Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3083-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:nithurshen.dev@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 83080354A16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/30 04:25, Utkal Singh wrote:
> Gentle ping on this — happy to revise if there are concerns
> about the approach or the streaming API choice.

Again, I prioritize all patches according to the impacts.

Thanks,
Gao Xiang

> 
> Regards,
> Utkal Singh
> 
> On Mon, 23 Mar 2026 at 16:49, Nithurshen <nithurshen.dev@gmail.com> wrote:
>>
>> Hi Xiang,
>>
>> Can I test and verify this patch?
>>
>> Thanks,
>> Nithurshen


