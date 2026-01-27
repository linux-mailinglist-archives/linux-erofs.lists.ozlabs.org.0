Return-Path: <linux-erofs+bounces-2220-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ87I4wzeGlRowEAu9opvQ
	(envelope-from <linux-erofs+bounces-2220-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jan 2026 04:39:56 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155CA8FA9D
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jan 2026 04:39:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f0WPN49zsz2xcB;
	Tue, 27 Jan 2026 14:39:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769485192;
	cv=none; b=ng0Kt+1jqCHgObsMjY7g4PRVMzaoybJwy6hWNYgJwb3qL2Uv3DG8lMPI484w/pfVAlgmblgtwb4/TLjvI1ny3vZruDPjeSXkJUvw2TllT/h9DKreppZaz648NUT3S1iACAIGgsReKjH+VIGcJKTydJdOd0Vn2WOvn1UB9yVJglQDlSs///OzYCB+CpucERJbfre3ZWGKRgz6QF0lD4triurTejNXm4SvQAF8bJGga/BRDhVNJNypqcidi4oVBfdoFEUtEA1mHUYPAizNQovgKeC0EEK01stCiEnATagdvcpNeIYjKmYaJJbe88NOksqCCnqGsYsF030uQBEUNwoc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769485192; c=relaxed/relaxed;
	bh=JXX/+UhJQ3V1KOHJlhTwhRIDR47qF0HW0feoeATTwOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CD3GjX7p4BUTdsmd8WiLIcGbHv1EbpyWbhRQ1WFjkRLsNWHmpHkKX8Z0x5JC9Ai7zlwcd4M2XcovqXf4m4R6nIIlJFIN1vLmNCCC5Km3oIMquqYG6ZOdTAPxflxDRUqSqofMpVtDWInRwY6TlXRFDbfZ08Wr/RLhF9f4huX90ZNwTToPgfBq7HH1RwsO4i8nxywzm8vUH0hjXs3N1DUKlxJmYn8b/7SdgPwD8SUG/2ejMIL9UjLkP5pwdFLWzqHeBSff2iE8UFfLUIlHsgyLoGtwbTYQPTwGpCbUeT/B1vxn2EF3tEH3d2R05gBQ38q2Mgz0FI+a0mIlbIZoo6IiWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r3BX92s+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r3BX92s+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f0WPK5pF6z2xJF
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jan 2026 14:39:47 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769485182; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JXX/+UhJQ3V1KOHJlhTwhRIDR47qF0HW0feoeATTwOU=;
	b=r3BX92s+MVHfrSk3i7qHK7MRbKceyX/55jhbJtstcKOKi3oeFWpoWVIbMsqVyWjODpLc4KdDUCiPuWMhsH3TqQYvZsC1sXbbZ5fmVMZwRAKPF3huddWZgGktP5/eeTJqFzoPFM0TqujZW0DBqOArGOBKKvQ4u7VaA58SSvdnKsg=
Received: from 30.221.133.109(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wy-HAhn_1769485179 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Jan 2026 11:39:40 +0800
Message-ID: <191f6576-ba2f-490a-824d-d27b22350921@linux.alibaba.com>
Date: Tue, 27 Jan 2026 11:39:38 +0800
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
Subject: Re: [PATCH v19 04/10] erofs: add erofs_inode_set_aops helper to set
 the aops
To: Hongbo Li <lihongbo22@huawei.com>, brauner@kernel.org, chao@kernel.org
Cc: amir73il@gmail.com, djwong@kernel.org, hch@lst.de,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260123013132.662393-5-lihongbo22@huawei.com>
 <20260123075239.664330-1-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260123075239.664330-1-lihongbo22@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2220-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lihongbo22@huawei.com,m:brauner@kernel.org,m:chao@kernel.org,m:amir73il@gmail.com,m:djwong@kernel.org,m:hch@lst.de,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lst.de,lists.ozlabs.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 155CA8FA9D
X-Rspamd-Action: no action



On 2026/1/23 15:52, Hongbo Li wrote:
> Add erofs_inode_set_aops helper to set the inode->i_mapping->a_ops
> and use IS_ENABLED to make it cleaner.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Sorry, forget to reply this:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

btw, I've pushed the series into erofs -dev branch for
-next testing now.

Thanks,
Gao Xiang

