Return-Path: <linux-erofs+bounces-2878-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UERvM6YTvWnG6QIAu9opvQ
	(envelope-from <linux-erofs+bounces-2878-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 10:30:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CDC2D8089
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 10:30:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fccjZ0fV5z2yYY;
	Fri, 20 Mar 2026 20:30:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773999009;
	cv=none; b=mYirNl60AaPoIqAv9yZdoEQtGtOWXPNpvf20m51cvO2DELVEyxAvj7KzeAnTA8Z5tJH94wN4+VPmlEMEfjTW78VgeWrED+Rx07nGrvgfXzRpStiaP/qw3RMmTrpCRFyCOms34qgz13K21FQF5U8MFg2VV6rgAPQvhEJPJG9RNA4f0Rk6UqcMVQTivOo2nUI2LavYsUXCOwfwO8DksfSDz1H4D10R50QBjBn+WnugUr0OBdSstwKGTl48ZOC6G/8ssRW9bIJaVQ8yaodFKx9oab0vsQoN4KSha5pk+u+hOD8uRwKrPUKDrcicc7YgMUbcAJH3S9fFCDQCDCNjOfbGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773999009; c=relaxed/relaxed;
	bh=fDLOt3CmRL0kr1Y5856MreB9fCVuSdb7kVMvtJ3eLP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJQYTFdiV9Qm3go00Z9ELkjiEhp1otITMud78fH6RGJnGaPellcwsXcOM/okoXy8PfuqJMAA99YhCMXeUD9k2gRyvauiC62Iugqfs876fMM653lsHCOwcD8AyNyoUTXLt6jy+KAe/cFraQzR4noLlrRf9HMSTnnHkRO7ucnidz61A0cEBe8ViHjvgeQBor7CxDj899R+wVh/o/bbHwJBkrCvSBFATV48in/I9zjRBjPWx2NWgPcl8O7+qczBi4cO0Jnsqj/lHsMc2GA5y9CeI2v3OVzskJZwBUOfrR+GyFBbG4xy1X1S+LxJM0K0B50OOfaR6tGsHqqZtCXv+djWsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CVjBD8qV; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CVjBD8qV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fccjW50KTz2yY1
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 20:30:05 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773999000; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fDLOt3CmRL0kr1Y5856MreB9fCVuSdb7kVMvtJ3eLP4=;
	b=CVjBD8qVwXMXrVJOXLBMFD6Ha4lyKHnVpB4rqsKhQh0HsXOkcyHMz7Hb3l431iKHvKZuMIqo9P/2vUTrgEfSv3N70+NPAwZcDUvUZfuTJVCEFLwu/jd6vuVWxgxwg+GjN+yI94TCKqbU3MIq4JJnPkCHm815jZnHWvjA7hCY3Mg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.LcAit_1773998998;
Received: from 30.221.131.211(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.LcAit_1773998998 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 17:29:59 +0800
Message-ID: <97dcdb5f-44b0-4105-bd7a-414a5ec5d361@linux.alibaba.com>
Date: Fri, 20 Mar 2026 17:29:57 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: return error on ZSTD decompression
 length mismatch
To: Nithurshen <nithurshen.dev@gmail.com>, singhutkal015@gmail.com
Cc: linux-erofs@lists.ozlabs.org
References: <20260319101721.17105-1-singhutkal015@gmail.com>
 <20260320082641.61679-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260320082641.61679-1-nithurshen.dev@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2878-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
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
X-Rspamd-Queue-Id: 16CDC2D8089
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/20 16:26, Nithurshen wrote:
> Hi Utkal,
> 
> This patch LGTM.
> 
> Reviewed-by: Nithurshen <nithurshen.dev@gmail.com>
> Tested-by: Nithurshen <nithurshen.dev@gmail.com>

I merge another patch of him instead, which assigns ret
as 0 on success.

Thanks,
Gao Xiang

