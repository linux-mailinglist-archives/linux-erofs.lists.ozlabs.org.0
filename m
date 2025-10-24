Return-Path: <linux-erofs+bounces-1284-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95255C0465D
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Oct 2025 07:29:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ctBL011V1z301K;
	Fri, 24 Oct 2025 16:29:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761283784;
	cv=none; b=ApJdDKcS96EkCD/C4XANphUZo7zEgkL6xBetLko8qMOtAPKXJu2eWV20m4pXr2RGNpvE4sngnlNkhSZ9/TSwFkJbmjq88dXcAKuHRTzN2xp5En5pAYKVsmp7t4LVrlqy/VmU0WR/BV28iTP8iYnkf6Hp2dX+0R07OEJAx2xxNaFzxCdtWLFqHj27a8i6D7zAuBBG0OF9OB7i/SIXyLx8ykcAr4IFXB7kG9Ajsm5qail7W4bySGUxzLC0U4ftJ0vzNZSaR39mmo/elCkwPjSjbNSSNnXP/qm9VkawCmol4/Vpv0JEGqkOKBcmRhVplj4ypR18wJRs6Ex670RbQ6PaeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761283784; c=relaxed/relaxed;
	bh=vswZ7lbJVqXKvCysyzHOTMJzO3vls8MTpu5ohK5lgiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fC+DGAM0kqE8dlAwzhoxZ6USi0RwUlE7WWEB4u32GtY+cylYLHl5GnNmxAiPolie2lNM7CGc8do0ToGLE9lHhbDMQKGGeo1QXaDEflVTuJMjrHAZENsl0wYPHd1RqCQlUcSWOluOCqNll3KIYq61yB3SMpXeuodmITACKg95FsLROnquSmgG0RGz/xarSOjKKUOR689Dap6icVNGXVnlmzJBwh+UHg7khxrOz5KJQk2M+8DkAxUDEeJYZxl25wtdEunDLW4lEcjOE3t/9fJeIjwKMwrgUEBVfEYA2yhVTwS2HVLbji5xpwWimBIXVUWkSQXw0d6eNmVEqLOB8bYmDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nyrL9wng; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nyrL9wng;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ctBKy1b9Dz2yl2
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Oct 2025 16:29:40 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761283776; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vswZ7lbJVqXKvCysyzHOTMJzO3vls8MTpu5ohK5lgiA=;
	b=nyrL9wngUYVL5qD3DyakW0ZdIShkKtStJ7HWf0hUaCpl/VHtnboyXSeZacaowLqnIBanreoZcCIrPi9LALAo3G6eqbnfTfTEJGJPBLuf9+IgL6ia2RSEC9l/8yv8IUvK4ndalEM9XHWiCmHmaI9qzMLvUdwD4DztLQ18Qm/WN6U=
Received: from 30.221.130.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wqt4op4_1761283774 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 13:29:35 +0800
Message-ID: <05bc66ff-1afd-4ff5-9e3a-330138d330b3@linux.alibaba.com>
Date: Fri, 24 Oct 2025 13:29:32 +0800
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
Subject: Re: [PATCH v1] erofs-utils: mkfs: Add 'no-deduplication' option
To: Friendy Su <friendy.su@sony.com>, linux-erofs@lists.ozlabs.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>, Daniel Palmer <daniel.palmer@sony.com>
References: <20251023080142.991914-1-friendy.su@sony.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251023080142.991914-1-friendy.su@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Friendy,

On 2025/10/23 16:01, Friendy Su wrote:
> Add an option to disable dedupliation at format.
> This option is mandatory if mount erofs with DAX.

Is it possbile to introduce `E^dedupe` for this?

I mean, change the defualt bahavior into DEDUPE_AUTO
(or DEDUPE_UNSPECIFIED) rather than DEDUPE_OFF.

If `--chunk-size` is specified, DEDUPE_AUTO will be
DEDUPE_ON, but `-E^dedupe` can disable it.

If `--chunk-size` is non-specified, DEDUPE_AUTO will
be DEDUPE_OFF instead.

see TIMESTAMP_UNSPECIFIED for an example,

Thanks,
Gao Xiang

