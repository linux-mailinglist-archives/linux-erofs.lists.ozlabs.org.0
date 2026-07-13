Return-Path: <linux-erofs+bounces-3878-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id koe3NBpiVGp1lQMAu9opvQ
	(envelope-from <linux-erofs+bounces-3878-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 05:57:14 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DB08A74706D
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jul 2026 05:57:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=BsQ9aqWO;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3878-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3878-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz7tH36Jmz2xjN;
	Mon, 13 Jul 2026 13:57:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783915031;
	cv=none; b=YKySH6iyNsm3c+Dim2z79V1Lw11ep3+ClbaWwTt+V0azGDdpNgm2J/FsO+qDZiMlNxSrLRHKZvKE+AXYTkfyn2BDuwxk+DRRtyjU8a9bBcX+41FQwGXXRNGs/SKo3x6ZyHPES5J19jHb6pCrsDL3QgXEOHjQ0/NXZFAXkbow4kEp9UNvh8pgCXwHkhtSU9IOOXEw582j1guorUMquugAikYt1iWnc3CR3ijiwl7osWWI9CIOd2PFDp7XVTc9ybyA5Kg3RLcZc7zEoFjEmjRE/nMP7T442DH2tdyTkYQk8m+0+abI6hEWAGR0H/mB5iQBx6Js1PtcID1pUeLZMfjUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783915031; c=relaxed/relaxed;
	bh=ptapzLT2kC0FRZONruSP9TU30xzkIav8a6oiB+WjSOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7qrdkVO4zH0zAIecNGKRYZJeWBLktV8K7tO8ss/fnvRvBJxFl2xbp0b6WOrl6LcEM9plbvlFioDYOOq6voycXcY8nDk+pcYI6jjVPdLLu2gnzLfeJ5OVgGCExtAr1nqbPZuoDYrXES+VcLmqKOL680XWiUgyxXupEOqF2+HBTOqkK3tsN0qP3IsJfRk8139+WS9LlpkHNM5EmrP4xe59TWcR6Riob31hk7zDUJv5WX2oWZagahWVP/Z7XH5sLvyHN3uk2THOypHbFSIqpIR9btaDutyW3K2ch2lXyycYvZOUzCy0+MLBHc4Z5QUMLN9ah2zS2rEEXmaj1izwlUNGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BsQ9aqWO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz7tD5kqXz2xRw
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Jul 2026 13:57:07 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783915022; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ptapzLT2kC0FRZONruSP9TU30xzkIav8a6oiB+WjSOc=;
	b=BsQ9aqWOSWipLfGX8+tiTBOBRlHouAtLlcMIXTZsUeic8rAXbgqIJWp9kIvktgxBPCIDyOAwZX5L1plHKqeyTcMzUPKqleAwYMFx2pEylPtjozZw97PotbwUgEwdSc7LYZH+CWXrtgK7KvXlbrOfUYvm+YypGvCqHLfzrE0Towg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X6teBxS_1783915020;
Received: from 30.221.131.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6teBxS_1783915020 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jul 2026 11:57:01 +0800
Message-ID: <008358ad-beef-4086-a423-0b282746ebb2@linux.alibaba.com>
Date: Mon, 13 Jul 2026 11:57:00 +0800
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
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
To: Giuseppe Scrivano <gscrivan@redhat.com>, linux-erofs@lists.ozlabs.org
Cc: linux-fsdevel@vger.kernel.org
References: <20260711071137.4130824-1-gscrivan@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260711071137.4130824-1-gscrivan@redhat.com>
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
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3878-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid,alibaba.com:email,lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB08A74706D



On 2026/7/11 15:10, Giuseppe Scrivano wrote:
> Add fsparam_fd("source") so that userspace can pass an already-opened
> file descriptor instead of a path string.  When the fd is provided via
> fsconfig(FSCONFIG_SET_FD, "source", NULL, fd), it is stored directly
> in sbi->dif0.file and erofs_fc_get_tree() skips the filp_open() call.
> 
> This is useful for mount namespaces where the backing file may not be
> reachable by path, and for tools that already hold an fd to the image
> (e.g. composefs reusing an erofs mount's backing file).
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

