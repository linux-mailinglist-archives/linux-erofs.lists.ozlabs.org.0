Return-Path: <linux-erofs+bounces-2499-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OgAMDjEqGk2xAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2499-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 00:46:00 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D525320918F
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 00:45:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR8SP0Tjdz3bf8;
	Thu, 05 Mar 2026 10:45:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772667957;
	cv=none; b=SBEhZJTySSRQYvWMT1v02eh8We4DszvdOjZIB/STGB/Y0IVUWmjdcnINxGUVmw1Gcw3sVAC8v3WI6IMOdIVjSaugPRIYyUiDD9/6Y7FzJ1rpzIxOE5OEWjmkIzEyp1QNXCk/Q235bnLhvzji7PeQ6Z/GF5LBLGxQa3gvzWtjuwi5WU2Z2DHIuCC92Nx5VbcWL0DCC5zUg16mhvoJptcEA4TCvPYOISqXiL2+8fQhTwZi0dAnkq0HOJ6ddxRWi7noStFMVRaZvmOyNWCrOue1DoQUYZUWerYYgRtUAFGQ5cefVh4El2FMZWU58dmFmLiiZbefFAXAOVrBy5m8fiXRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772667957; c=relaxed/relaxed;
	bh=3krd2qGrrcCizQCFNXsOs3H6jSWeb7RC6T93zge34XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nT5sHrbYNFKMbF8e87tNcJliE/EsHksOlYWKCgbtq6tETIJCWrDqtBmVEosJl7AsYLfcPWolkUc4nc+Tm3vtmUrkx+A/g5fDcFyFobAPsyzQkjqKTPMo/Cs0fKsktoMh9PSV8j3S0OvzqyuoORdX0vSloZHvp7CPHk3UR1s5ZoFF8G3fXpGrayRork6vcAzZnLr6m7cqUBK1zKOMEdFbV8Uci52VQN8pygdk6nQyH81xdGHy+fXsdfjXNHsBjMm2zOB4wzc59Znp5mi7AhD9f+ih9cV101D6EYSc75EGpwQ97L/tUpFLJ+eEzLsrKCWyyV4ShvYTQ5Hd+oRU6rZefg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sbobuqYi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sbobuqYi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fR8SM4NFTz30FF
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 10:45:54 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772667950; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3krd2qGrrcCizQCFNXsOs3H6jSWeb7RC6T93zge34XE=;
	b=sbobuqYiIEFQbCUMVNn+V+JrDMjmIPgo/JmZqHHMV+SAl5rhScXA7ELT3uG/kG+sLqMIBeBzChWkyH/DD6LsuIjyoNQ5RWlPoQ56riBlJcxV2dowUu1T5m6zIPoIJJekXgYHRECvJ5E3dvOHq/DKpMilY1bP6PTzvmJBJanEnSk=
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-GMF-0_1772667948 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Mar 2026 07:45:49 +0800
Message-ID: <a1f7d481-238f-468f-8b75-f069d523e497@linux.alibaba.com>
Date: Thu, 5 Mar 2026 07:45:48 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: validate inode offset bounds in
 erofs_read_inode_from_disk()
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <20260304182121.44834-1-singhutkal015@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260304182121.44834-1-singhutkal015@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: D525320918F
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2499-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action



On 2026/3/5 02:21, Utkal Singh wrote:
> A crafted EROFS image can contain an out-of-range node ID in directory
> entries or the superblock root_nid that causes erofs_iloc() to compute
> an inode offset beyond the image size. This leads to out-of-bounds
> reads in erofs_read_metabuf(), potentially crashing fsck.erofs,
> erofsfuse, or dump.erofs.

Do you have a reproducible image?

I think in that way, erofs_io_read or something should fail
instead, we don't need such check against
sbi->primarydevice_blocks.

