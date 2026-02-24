Return-Path: <linux-erofs+bounces-2374-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JdUEzM+nWlUNwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2374-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 06:59:15 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B71823F0
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 06:59:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKn9C3dDmz3cF8;
	Tue, 24 Feb 2026 16:59:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771912751;
	cv=none; b=AapeS4ETGMFk0fe8Ani0OJpnZ7eX0FWo8Cw/DZnQ920pfl94YTHYf5/ALFqRHexqWMFKZaNYhqH0wVFVTkMbm7wtQZiEtZOYvmBpO1WAF5k5mahi/J/r6KOeiSGZLn8cCNN2vkdHMDgI1A1g0QptDqFH1cB4UuSLhif3Fz6UIXfu6JOrTeW/IczdOJk2I4FP6atSC4j2kwTuNebHiougFM/6+tooa1HkgWnx34iYsHvYNk1/GNnzftrJLjhFdPOvp48boZ6Z0bazXruTIZJJAinnIpLAnLMvy0zk9U9p6LE8rgEsb4YF+W/+ZddZ5edHBt/nl+tCKofLTOhTVM3l1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771912751; c=relaxed/relaxed;
	bh=jFKUCLSR9HnxfCK9tiiOoezNo1xsrPFk4sNth07JOV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9GtOQZvHlwOmONAeXx5cVcdFae87kI6hJH46PHLyF5sFJrk4YiwEQgwTji8OT10ff58aM0zSq+iqpzUd0M6oHU2schqzoYjZRP9IUmxktcKPy4r43iawyzph6310tBiYydDJ3wqxWutowNY/wuX65buLXQZbjGmGb8ZdfGMz+I0wGxYwkx1Vu48Y0znrFPFiClMZ7TH4cepcrVFHXsAnsXsNl6yfqtCD934HtgfvNJzKtleu91iWsc7Cx2cZNa8KqITAEmo6g6WLfZmiwIZV1GC/uz2LVTIo7M+PcRFpCIExPOAjOyGT0fHTsHY59xiDPjteC1pkfGo4sMcHnSH6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tOliXWbf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tOliXWbf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKn9925C7z3cDg
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 16:59:08 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771912743; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jFKUCLSR9HnxfCK9tiiOoezNo1xsrPFk4sNth07JOV8=;
	b=tOliXWbf48PkJEyoepet98uRF3T2QcXdEg96h8hWWI6h7IXyAsuT/ah0s2P02BdoWjFP9lbZGI5FyDtLtiLwFsAwS/4XxFQHhnqBy04UvTKrk91xx+yZ5Jfd5vVQrAbjgHHxz9CAlfNhD30y1E/sEcGnW8Zm0V+8gDNesa5wzSw=
Received: from 30.221.130.254(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WziN6ov_1771912368 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Feb 2026 13:52:49 +0800
Message-ID: <184101bb-9606-4e2a-9e35-6b3a1eafb4da@linux.alibaba.com>
Date: Tue, 24 Feb 2026 13:52:48 +0800
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
Subject: Re: [question] GSoC Proposal 2026
To: Saalim Quadri <danascape@gmail.com>
Cc: linux-erofs@lists.ozlabs.org
References: <20260221214258.129214-1-danascape@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260221214258.129214-1-danascape@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:danascape@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2374-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 590B71823F0
X-Rspamd-Action: no action

Hi Saalim,

On 2026/2/22 05:42, Saalim Quadri wrote:
> Hi everyone, I am Saalim Quadri an undergrad student at Dayananda Sagar College of Engineering, pursuing Electronics and Communications.
> I wish to participate in the GSoC 2026 as a part of the EROFS filesystem.
> 
> I have been contributing to the Linux Kernel and have more than 10 accepted patches.
> I have also worked with Android Linux Ecosystem in the past years, and have worked on several subsystems, backports and fixes.
> 
> I started looking into https://erofs.docs.kernel.org/en/latest/roadmap.html, and I am interested in expanding erofs-utils to stabilize liberofs APIs.
> 
> In that sense, I would like to know if anyone in the community could provide with some suggestions for my proposal, and a positive impact.
> Any suggestion or hint is appreciated!

Sorry for late reply since I was in the vacation.

"expanding erofs-utils to stabilize liberofs APIs." is of course
part of TODOs, but I'm not sure if it's a gSOC project since:
  - It's not an independent feature, much like just rearranging
    code instead;

  - Currently we don't have enough mentors to trace too many
    formal gSOC projects.

The formal gSOC projects are still under discussion, but I do
hope we could have some improvements in:

  - Multi-threaded userspace decompression;

  - BSD kernel support.

But if you're interested in erofs development, contribution is
always welcome!

Thanks,
Gao Xiang

> 
> Sincerely,
> Saalim Quadri


