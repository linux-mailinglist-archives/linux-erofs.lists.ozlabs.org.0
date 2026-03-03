Return-Path: <linux-erofs+bounces-2481-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EPCKBtcpmlnOgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2481-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 04:57:15 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D2E1E89B2
	for <lists+linux-erofs@lfdr.de>; Tue, 03 Mar 2026 04:57:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQ27B42bnz2yFY;
	Tue, 03 Mar 2026 14:57:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772510230;
	cv=none; b=OAo5K3loTtTilV3XnGkrj2b1mdH4GnChT4zKX3/QJSwMeYV0s4Ps0ymq2MFw/T36J2YrRRupqITw6NYAH4fh9YY6rElpwXYRTdKEYcvjpp2W2vixzSYg2OLeDCSoVnfLmZ4ubtKNy5SLUTcv+O0nAsWZ6aCXioN5QWygr+nq82iTTN86ja64Pt802TzzBOdCT+36YWEqXHgtXJknyJvAsZBX0XIFDFUWNJdTWKyEfOGy6CuzDQJxfve7xb/461UXZCRyBXNJr6cYz+NdFvqD0YzlH5pJeWQM/4hy0Pa2DriVPBrQaHn8VNvouqIa+j/6+6I1bAb7xfIQUFtC0XFyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772510230; c=relaxed/relaxed;
	bh=XJYFeUaFxymFSDqQXfR10PedD/CATVy/n+lhJTutmnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=No6E2cahzOaD3dlsMC42ekjIaVjma9wtzpTuV/S1fOZ0ne+MkifdQbu4kf49DlTBAE1UEe3rphoyOamP2A52a9EEIX10ZXxkfhdSVpAn3iqZ1QZW0lSCR3WI9XI8XtcrHCyGeH1AKm6oPAaVysriFB/3lvhRx8qeA8WilyWX8fFrR9BpmsCmX17MDdh0BR5u01o/FO6cnfkssGF6ScXT5ju655/j4TiunLtyYs7SYT4FTE6Bc005qdgtbB6qa6/Wnae44CL6sFejKyjmOIjCrkGg5ZruoOaxKMKKqhCLLdnXv6aQ98o6lHynjYbwP6ZW7ASjw+Q2Mxl82xHCdYMfyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aONCJcdK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aONCJcdK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQ2790S1xz2xpk
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 14:57:07 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772510223; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XJYFeUaFxymFSDqQXfR10PedD/CATVy/n+lhJTutmnc=;
	b=aONCJcdK5JzNgGRbpF/DL2skFrEfcRfNbf4gyzepHAb4D1UMMtkjkV9OxiLoylmI1HTYnUaH9drdAvJwmRPvqeogOzFDhKszH3VP2tfxk3NkRI9QQJ7Z1E/U5P4DS4Rz3NZzci7fHew4bfnOXsegAUASERMitIXALK0bmFRX38g=
Received: from 30.221.132.55(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-8SKrD_1772510221 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 11:57:02 +0800
Message-ID: <a749c491-d37d-4c76-ab01-8795e88f225a@linux.alibaba.com>
Date: Tue, 3 Mar 2026 11:57:00 +0800
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
Subject: Re: [PATCH v2] erofs-utils: lib: fix xattr crash in rebuild path when
 source has xattr
To: Lucas Karpinski <lkarpinski@nvidia.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, zhaoyifan28@huawei.com,
 lishixian <lishixian8@huawei.com>
References: <20260302130356.769479-1-lishixian8@huawei.com>
 <20260303023911.792454-1-lishixian8@huawei.com>
 <9fb745b7-6944-4773-843e-099ee598557d@linux.alibaba.com>
 <c4d3b1fa-5044-4243-a339-e15c32d5e085@nvidia.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <c4d3b1fa-5044-4243-a339-e15c32d5e085@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: A4D2E1E89B2
X-Rspamd-Server: lfdr
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
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2481-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lkarpinski@nvidia.com,m:linux-erofs@lists.ozlabs.org,m:jingrui@huawei.com,m:zhaoyifan28@huawei.com,m:lishixian8@huawei.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action



On 2026/3/3 11:45, Lucas Karpinski wrote:
>> Hi Lucus,
>>
>> Can you confirm it that fixes your issue too?
>> I will merge this for the bandaid solution, but after erofs-utils 1.9.1
>> is released, rebuild and xattr codebase need to be fixed instead.
>>
>> Thanks,
>> Gao Xiang
> Yes, confirmed that it does fix my issue as well.

Ok, I will add your Tested-by: tag, thanks!

Thanks,
Gao Xiang

