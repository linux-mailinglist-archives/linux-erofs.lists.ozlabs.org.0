Return-Path: <linux-erofs+bounces-2250-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fSJ3NDBngWl5GAMAu9opvQ
	(envelope-from <linux-erofs+bounces-2250-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Feb 2026 04:10:40 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFBCD3FD8
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Feb 2026 04:10:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4pQM0FCrz30BR;
	Tue, 03 Feb 2026 14:10:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=47.90.199.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770088234;
	cv=none; b=D6Q3x3OBDdxSAw28LYg9xLkbHxKZd9ri2DUQwBmc2XbnkkA8GUz6G6g6ldYQvptMMaZWR7R8HHqUkc4iKn86BFmkYK9PAxzvIN1EIA2QnlTekteExZiy5ZARiNs22AOLRbUvj02x3Qyy2F9uNLU+aUznzniclzLmiuthl9Yk/awkCXA64IV/pko0OxkeE61DdFBJfCzNIp0ijidyzpr74F4+L7LV+L3DZWkxcqces4UKrIhVm3gFi4Xaunww0WnpVGKPixyzlGuyAkoAMhTz7P5GeYgrwLdHLx3kcxlYt1eRC4/Zw35Dc/MVtKR5Eh5eJbAg0MOSaS1K2Vruni2yLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770088234; c=relaxed/relaxed;
	bh=JBLVbqIKUxtyamunn2KsQ5HUkAEuIy+RRv7LpcxM7uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ky+KqpFWBJCu5nsNL271gxA1x9WF2hBADDfgMYcrCoSU9S6BV0Oi0vH5IOm1CFNZPgIX7XA7D3eGXlykKLYFtn2lgwD6G8gIyY76OIH8MlUewW8id+IJugY1XfsdMl6Jny9SqVB5e33wtkvgDrO0YWbE5xK2ldc8g3k9MVNiv/Ujpp7JcWdGAMUrXMeNAwiJrkMYMypk2ik0/kLzlMKyWzSbJOx2b2XJZ4/bMH+xHbbxYeZ8Cx8NzxhHbEBznO3toatFvybOjM0mdXEIvOZvnGT91XI2Pcfv36awG5H+XF05nZ6IGBqEE9Mz/EU/L4CT84EV5mqfOURFUwOEgUw7DA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bfyZtECg; dkim-atps=neutral; spf=pass (client-ip=47.90.199.5; helo=out199-5.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bfyZtECg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.5; helo=out199-5.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4pQJ0ZvFz309y
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Feb 2026 14:10:30 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770088088; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JBLVbqIKUxtyamunn2KsQ5HUkAEuIy+RRv7LpcxM7uM=;
	b=bfyZtECg+JdC4azeV0G2xYz0vlHFZO18sA1IkawUAPgetprP4a5JW0cerSu4kSruIs5X20RyGtgeP2jlIXNKkM5zJofcV3yjyW5q0JErkx4ITTM5AfMzhpMd1bZqClUq7FG8tlWFGk0fep9d5xGqoM61xIZ/NBKoi9Y03KZuWLs=
Received: from 30.221.131.235(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WyRONth_1770088073 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Feb 2026 11:07:53 +0800
Message-ID: <b2f0f754-a1e7-496f-a3e8-6200b722c85a@linux.alibaba.com>
Date: Tue, 3 Feb 2026 11:07:52 +0800
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
Subject: Re: [PATCH] erofs: avoid some unnecessary #ifdefs
To: Ferry Meng <mengferry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260202030909.128365-1-mengferry@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260202030909.128365-1-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2250-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mengferry@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 7AFBCD3FD8
X-Rspamd-Action: no action



On 2026/2/2 11:09, Ferry Meng wrote:
> They can either be removed or replaced with IS_ENABLED().
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

