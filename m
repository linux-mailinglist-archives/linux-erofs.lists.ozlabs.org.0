Return-Path: <linux-erofs+bounces-399-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D11AD82F0
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Jun 2025 08:08:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJTVL1WfPz2yfx;
	Fri, 13 Jun 2025 16:08:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749794922;
	cv=none; b=m15UiV+M3X3hL/sk3hcLUBdBYpn+AoohSJgOwSASVmgT/O3aK85vCoEre0HHOXMRL3r/Y+s+/GSwE8Itgprg/F8B2JLH4iSr9H/4F9jAvRiJdscsqkS5/DAxCUNaQiUbACsxVfvCiOb0OoUHMPdJ8qfwAuO/wabOfgCYIASEVdGDN7zbDYedI3mCzsXVTtG03w+okqOzTKmJX52AezMIwMNbyffa3rnyVVHkd+mCVgklseNnB01Ult3aqUiyeWI8shqq7XinoIPVAi8UaVWicBjwfulHmGWZVKKq39iFqjehNoeAFjLg9fKWf5725iLPVbg9eO11FxenMJAL4HZMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749794922; c=relaxed/relaxed;
	bh=U6N77Rg/y/+7iThJTzrXEJ/3VtfKAqzvXRg1gw+dPLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCm4yyddLsHCERsWGCms/bt5bQ48Rc2x114/3ia4MwRhfpo8W+RqtHreOKgApeP51ZcrChpLRgyP8oaABWqejUpCJ0V0D7glJQuP8RL3LPdFEnqhF+ma+gNRULAGX2nj/JUwoLTuA2mwKumnGuhJ63SSRDTLXYGAlCgz0/KiM68iBci4uxZehXAGm+36M5lq0QdRaupTw7GvqRMKZxjX3bRbRJHsxUH/ybsOhC0I+O77ZMX5oRxXi42/yfRc5DC/vzb+stZitblWuiefDkbqYe9jtizpgKXIK9JELgBGZlQIGPzq4wow1mQapnWFvdnt+9eykjMRRPIRyFedvRRWGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JRDPdO9b; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JRDPdO9b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJTVJ0Hy6z2yMF
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Jun 2025 16:08:38 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749794914; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=U6N77Rg/y/+7iThJTzrXEJ/3VtfKAqzvXRg1gw+dPLk=;
	b=JRDPdO9bC/kPDQdc9NcdPS0YcO4IheKnJiTrYSsrXn1GUX3ChhiJXuudUoY/vGUzKFHPsDS3Leq3oV//4HNB5dDdi9iB6LQJVLtEUDsE8Z5vP2gwU20ABifpBw3/52XobUrsYg/Poy4q4WzrTs2OSbCoVWIEzvZuq7tPjaqW78M=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WdjN4EO_1749794913 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Jun 2025 14:08:33 +0800
Message-ID: <0baf3fa2-ed77-4748-b5ee-286ce798c959@linux.alibaba.com>
Date: Fri, 13 Jun 2025 14:08:32 +0800
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
Subject: Re: Unused trace event in erofs
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
References: <20250612224906.15000244@batman.local.home>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250612224906.15000244@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Steven,

On 2025/6/13 10:49, Steven Rostedt wrote:
> I have code that will trigger a warning if a trace event is defined but
> not used[1]. It gives a list of unused events. Here's what I have for
> erofs:
> 
> warning: tracepoint 'erofs_destroy_inode' is unused.

I'm fine to remove it, also I wonder if it's possible to disable
erofs tracepoints (rather than disable all tracepoints) in some
embedded use cases because erofs tracepoints might not be useful for
them and it can save memory (and .ko size) as you said below.

> 
> Each trace event can take up to around 5K in memory regardless if they
> are used or not. Soon there will be warnings when they are defined but
> not used. Please remove any unused trace event or at least hide it
> under an #ifdef if they are used within configs. I'm planning on adding
> these warning in the next merge window.

If you don't have some interest to submit a removal patch, I will post
a patch later.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> -- Steve
> 
> [1] https://lore.kernel.org/linux-trace-kernel/20250612235827.011358765@goodmis.org/


