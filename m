Return-Path: <linux-erofs+bounces-2405-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKZOLDNdnmmIUwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2405-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 03:23:47 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC9E190DB6
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 03:23:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLJL61K9cz3dJw;
	Wed, 25 Feb 2026 13:23:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771986222;
	cv=none; b=LEFR7jtKLt4pUmdsmD8i5P42MFO6DeFeBzIarwB7+WSTPkg4hx+yM94LwD9Oxyb8GKlijcJhPa6tvRItxpCB7G0lym6n9HFWiRtWTn0xTKPMjC7AE1SINEliFZwNBm6ozKdeu9LIX2hYkafnP/xGxEr2fpvwMyGAPEpU9a5SJNc/SmdM6NyTNnp3783dpEQf5pGoV5KbHDQa4DY8Nsi9iWmt/MjHqRt26lwoVhK4bBwN9V92sbLcKeUW4BWsSIbD4iWfx2xpDczbcgOPTm0Dr7xoVjqDf1IxERvTDUSkBKIZa84mNrMO/YXaCPi8lgQbvdd4xHfOl7jNtdsQwiT8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771986222; c=relaxed/relaxed;
	bh=5IeQWShbexQQqZX6+JDsBvsl8Xp9jcNc0yotflXjUxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f53QCLftOLWba6d1My6qsmdTnZ7rcLy4KrtBsyz7gkubFFmmp9Zl01szMiFgrCGtRMXBgkqG+0wpXRddCqWHOAQld1MBDsyofktE7hgcpxlurx9ZTOeoMB9DnTkxlaQFR6myytLwK/GTu6NvGN6tzsRI8tAbdKnLuhzB5ULoavaYeeIpF910KNCk7upPNvJxsXyZIq1Do6u+weGiihdR78FOJS3dVAaQpp956fJvt1dZhOhB+Plcgf6bA/+trFr1naTLNvayGXIr1RqtcMbVp2vbWNOXEAuq+JJ14BnLH5edwsFm0UGNfRm31PjoKVnI0HVEsMYmequ1kJW6HqozAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NGZXaRGu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NGZXaRGu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLJL25H3Dz3dJg
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 13:23:36 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771986210; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5IeQWShbexQQqZX6+JDsBvsl8Xp9jcNc0yotflXjUxs=;
	b=NGZXaRGuPyNVpQyFYZQMUME0pSTHD/lLmPPUbp/Ba59SJEHXL9seUEfa5Kjy0TpVYoQAeTqIyKo4jk2ldyEIVgTc99CV5BsLcXMtXq7+BBKcbIlICxu5xIskJloucxVvp5DXWbOsaPlUSpdVJvJEATVPqAZ9i4vgdsFx5gcG/20=
Received: from 30.221.131.204(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wzkp4G6_1771986209 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 10:23:29 +0800
Message-ID: <af4bff1e-1893-4a09-a5ed-27dca9ec7767@linux.alibaba.com>
Date: Wed, 25 Feb 2026 10:23:28 +0800
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
Subject: Re: [PATCH] erofs-utils: Raise maximum block size for aarch64
To: Matthew Lear <matthew.lear@raspberrypi.com>, linux-erofs@lists.ozlabs.org
References: <CAPrOGNB56AjZ8C8fRChucWHHhLHQoim7xPpz3eyFXwDCPJ02YA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAPrOGNB56AjZ8C8fRChucWHHhLHQoim7xPpz3eyFXwDCPJ02YA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:matthew.lear@raspberrypi.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2405-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9CC9E190DB6
X-Rspamd-Action: no action



On 2026/2/25 01:02, Matthew Lear wrote:
> Ensure MAX_BLOCK_SIZE is at least 16384 on aarch64 so that native block
> sizes can be used without the sub-page fallback.
> 
> Signed-off-by: Matthew Lear <matthew.lear@raspberrypi.com>

Thanks, applied.

Thanks,
Gao Xiang

