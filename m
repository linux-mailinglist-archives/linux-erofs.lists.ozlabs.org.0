Return-Path: <linux-erofs+bounces-2922-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILcgF8dgv2ma3wMAu9opvQ
	(envelope-from <linux-erofs+bounces-2922-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 04:23:51 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCBE2E81DE
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 04:23:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdhTr2s8Wz2ySb;
	Sun, 22 Mar 2026 14:23:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774149824;
	cv=none; b=Xwl+ILF1gohAl965FkxwkBiUMqy0luIiHld5l6EeR5KuSzN/QAPzpR1k0CmEnF9eRz8w/FaHj9FyqMB5h2es9cs0arVA3Zx+zX+eLeyBsssVHs6xRzBmbCCXsXWy+qxKqP2v/dkb/apXG8pFrZ2W3ip0BBrg0fX5bjGdR113+h/KMwW4r5XUwJEVCmw421mr15GKw+mksvmCdgw8EQhvMXZWjH0DCnaXOdiWNnIAoMNlHrmgX+/ZRVMpRWuACkUb6MJItFIH0Uk6uqiOocbZ1AFp18x9Bbn6PzvlPpIzB02taLJAzzDADQp1ULWb2aad/iln90Er/HOsTPDxoqvsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774149824; c=relaxed/relaxed;
	bh=yZ/oZpAH8Ly7FZmgZgz/O7qqreQydpcKA9xSuweE2GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=HGBTE5nPxSOXraxauXdAG8b3SPzkn6qhIxWJJSi4Nqu8Ciizlrm5V+MCuwE7G+jPUL61FQghYNlDBefG+p7C85M9DZkYHps4lMv2/0jJF6z2Awh4VHmAeVvJoQfBt/E6eg1UG8Ovlc17jib3bh1d5ptaoSlC//PcdJ7WYYs/HvQdpikEv07OKarVnzQ/d6aUCCKRM/25M1H7DxL8SF+yDvobBMFVAydiHD6QWyUbwbKjuEedhAxwj3pdXFEjkslqn+/yAYTrlbDC5/S6DN5JzTTJrGZD79TS9dBEgXOB7+Rj+ekWSAjjnhVri1f/NDX87ovHKkktl6Da8vRA59feeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pieBtnhk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pieBtnhk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdhTn2bZbz2xlr
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 14:23:38 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774149813; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yZ/oZpAH8Ly7FZmgZgz/O7qqreQydpcKA9xSuweE2GU=;
	b=pieBtnhkpWb5pJ6PRYqjv2dEKEYHIUlZAkrHpNQpTO22w9aOwQEbbBjCE73JKELVm7cDNDGWSe8inECZAizu2LLdPK6OuhgPAps7UnqBztx6GDpms+rQ95WSLGCV5poeEhRJiexCDHW3z6pE/s+oip7CRYVtdq5liMpAFSK5OYw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X.Q8ld2_1774149811;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.Q8ld2_1774149811 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 22 Mar 2026 11:23:31 +0800
Message-ID: <0aa12846-f5f5-44a3-8370-b1fd74ebc529@linux.alibaba.com>
Date: Sun, 22 Mar 2026 11:23:30 +0800
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
Subject: Re: [PATCH v2] erofs-utils: lib: fix infinite loop on EOF in
 erofs_io_xcopy
To: Ajay Rajera <newajay.11r@gmail.com>
References: <20260320185034.1008-1-newajay.11r@gmail.com>
 <3bbe41da-553b-4a28-95e4-376963da97e7@linux.alibaba.com>
 <CAMhhD9iWO7p+wSG2D8F0r6RAnfVLComSjjt9wZwCc7hx60ZJzQ@mail.gmail.com>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAMhhD9iWO7p+wSG2D8F0r6RAnfVLComSjjt9wZwCc7hx60ZJzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:newajay11r@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2922-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email]
X-Rspamd-Queue-Id: 8DCBE2E81DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/21 11:42, Ajay Rajera wrote:
> Thank you, I appreciate it.
> 
> best regards,
> Ajay Rajera
> 
> On Sat, 21 Mar 2026 at 08:41, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2026/3/21 02:50, Ajay Rajera wrote:
>>> erofs_io_xcopy() has a fallback do-while loop for when the
>>> kernel fast-paths (copy_file_range/sendfile) do not handle all
>>> the data.  The loop does:
>>>
>>>       ret = erofs_io_read(vin, buf, ret);
>>>       if (ret < 0)
>>>           return ret;
>>>       if (ret > 0) { ... pos += ret; }
>>>       len -= ret;
>>>     } while (len);
>>>
>>> When erofs_io_read() returns 0 (EOF -- source exhausted before
>>> all bytes were copied), only the ret < 0 and ret > 0 branches
>>> were handled.  Since ret == 0, `len -= ret` is a no-op and
>>> `while (len)` stays true, causing the loop to spin forever at
>>> 100% CPU with no error and no progress.
>>>
>>> This can be triggered when building an EROFS image from an input
>>> file that is shorter than expected -- e.g. a truncated source
>>> file, a pipe/FIFO that closes early, or a file being modified
>>> concurrently during mkfs.
>>>
>>> Fix it by treating a zero return as an error (-EIO) so the
>>> caller fails cleanly instead of hanging indefinitely.
>>>
>>> Also fix the long-standing 'pading' -> 'padding' typo in the
>>> short-read diagnostic message of erofs_dev_read().
>>>
>>> Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
>>
>> Look good to me, will apply.

This patch cause a regression which can cause build failure:
https://github.com/erofs/erofsnightly/actions/runs/23392598146/job/68049898517

It can be reproduced by:
$ mkfs/mkfs.erofs --zfeature-bits=78 foo.erofs linux-5.4.140

I dropped this patch.

Thanks,
Gao Xiang

>>
>> Thanks,
>> Gao Xiang


