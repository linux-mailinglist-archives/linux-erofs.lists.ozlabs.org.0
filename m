Return-Path: <linux-erofs+bounces-3112-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJHUNKQ5ymkv6wUAu9opvQ
	(envelope-from <linux-erofs+bounces-3112-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 10:51:48 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A573F357853
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 10:51:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fklNc3pdlz2xpt;
	Mon, 30 Mar 2026 19:51:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774860704;
	cv=none; b=iK/PR9hpOhXjvUpeNj5MYjREL/S8LB6+WWQDsmv20SqZ47PPnFeGAZJDxVi0J+XxQvl8mvhd+axJdeOB3NaIk6ZPMCDPUfEiv9qk1KyQmtI54EVRDxWwevJEej0V4inLC6lt1vwdkMyI5B01OyuLQqTZpmpiNUDsN2ZlXHWIS74hdAThH6lhtxyaV8DOGYAJi/yeBerMfRxgJR4UXRTLJENtkF2tI8rv1vwZa2G83YE42bTrDwmVb2mrKUKR4ajr/Mjw/gr6203XZ98iVigrT8jElKub5Wiiwsyu9bjaajJhHPOjEm6PbkdfgbhWAoCn5zEVm8GspUkf1TjOQtPD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774860704; c=relaxed/relaxed;
	bh=sksvTwu+SyyEsCrpTPCQ/SP+FtrsmIoIUQ5MnisbLUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZBZcBZNfME7VH78LLwQoUj02lttYdBSteYHIjkNl7vhmxLEHFN9uIuTbv3TTY4onc+cr/hE7wdGABS+CSUlhO/Ja2gMbDqiUbOry1Rf9saKDBycsax7cmL4yWa1a3XUNxijIOzAEoGPZbWhGGvpXxdBhZwa7o+lgZyh50vg5H9l5CKRJ4MhQxrw1jJoFkJa6a8m6pCY3NAORPrH+lanT4kNoTRo6EQnxFpvyoM5MZAZHAOHtD9KoEbAD0LG5lJ27ekNyBrvjqMDdPLsr2BMzHuWwBWjAsABMVpk8BbbsLxQYU52Q1rkAuqr3ltYBAa/n3kzRpgcakxc82qUZNi68A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tZD8RJT2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tZD8RJT2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fklNZ2V1Sz2xT6
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 19:51:41 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774860696; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sksvTwu+SyyEsCrpTPCQ/SP+FtrsmIoIUQ5MnisbLUo=;
	b=tZD8RJT2J6VBgk9dNzAS3ePbyECOL1eZ6HjAqSiq5Adx/eMw/lNwzlk9oL4n+4Obqjc6K9wihPDr9vtBqxZFKgb3pTrqUtGjix+d47dRqoeAgf6NRnhMe1urYOGhFzlv1rExjDXLzlO8aMWxgHLFlZXED0d4pvsYgkFTio8wqhY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.x6sJS_1774860694;
Received: from 30.221.131.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.x6sJS_1774860694 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Mar 2026 16:51:35 +0800
Message-ID: <c73c558d-6582-44b4-ae7f-36669e98928b@linux.alibaba.com>
Date: Mon, 30 Mar 2026 16:51:34 +0800
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
Subject: Re: [PATCH v1] erofs: remove the guard of showing domain_id and fsid
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: Hongbo Li <lihongbo22@huawei.com>
References: <20260330073235.3328579-2-Yuezhang.Mo@sony.com>
 <bc6ac6ae-ef88-4ff9-96ff-3395f84ce4ef@linux.alibaba.com>
 <TY0PR04MB63282B4D6BAEF754115502548152A@TY0PR04MB6328.apcprd04.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <TY0PR04MB63282B4D6BAEF754115502548152A@TY0PR04MB6328.apcprd04.prod.outlook.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3112-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Yuezhang.Mo@sony.com,m:linux-erofs@lists.ozlabs.org,m:lihongbo22@huawei.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,sony.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: A573F357853
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/30 16:48, Yuezhang.Mo@sony.com wrote:
>> On 2026/3/30 15:32, Yuezhang Mo wrote:
>>> This change fixes an issue where domain_id was not shown when
>>> CONFIG_EROFS_FS_PAGE_CACHE_SHARE is enabled, as this configuration
>>> is mutually exclusive with CONFIG_EROFS_FS_ONDEMAND.
>>>
>>> Both domain_id and fsid fields are present in struct erofs_sb_info
>>> regardless of configuration. They are not set if the configurations
>>> are not enabled, and remain NULL. Therefore, the conditional guard
>>> in erofs_show_options() are unnecessary and can be removed.
>>>
>>> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
>>> Reviewed-by: Friendy Su <friendy.su@sony.com>
>>> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
>>
>> `domain_id` is a user-sensitive information for the page cache
>> sharing feature (much like passwd), so it shouldn't be shown
>> in the mount option by design, and only the mounter should
>> know what it was set.
> 
> Oh, this is part of the design, not a bug. Thank you for your explanation.

Yes, if you need that information in the follow-up steps,
you should keep somewhere in the userspace: but the proper
permission is needed (e.g. like /etc/shadow).

Thanks,
Gao Xiang


