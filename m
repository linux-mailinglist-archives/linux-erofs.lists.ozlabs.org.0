Return-Path: <linux-erofs+bounces-3282-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEhkN8oa2Wk1mQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3282-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 17:44:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1180F3D9998
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 17:44:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsh1M45WGz2ybQ;
	Sat, 11 Apr 2026 01:44:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775835847;
	cv=none; b=eH/lb2n4rYj8RByLXKRBJpF7s01q0fm6T0fOzUVIJoRPWslH2RhqwmsYOMTnuhQz3fDe4B7lsgXB0f0jw22WXGrg83zPPdtaxJf/3c9hPAmhUfnrIz9ILReJO62vksp6gr/i7Ujckr2wdlkTbONUY4mvAj+Mi6bm4UTUAUCJML/ux2fwHJ+bBU/jiOgo3+JEzZWYW8CmFvnWvzkcr7B4TudPIJsuKJFgfKOYT0XcV9jVd8G2L7WUKZ2Onc64fOTqFBuYXHOG/6QXBJJEGaJORQiYU3xiMXurjcWCBnzm67z4R138IXFMSttpZJpTTp30qo6q7DLe4UPCmliL+V9NZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775835847; c=relaxed/relaxed;
	bh=uzBjKauimcNkCmJqc+wHQN1oYZwt8Xn/+9mNyLG5eNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PTNRupTrqB8uH7N4wz27JQ0Q944s2E8qklyux5cKFEJeJPrdc0yvXNj3Jc0LP6XQXLMNURwme/OOQwEd/rC9nHpDyUnpHeiPyvK7PknJgM/euhmRHAtVY3iJWd+fYKafZ2dDHmrVLwGJZ41A45HX7KTP1TxJJh5YM1H+Znq9VFYgCGsPgpkjni2NAmA41HRDPPZq5a9IMS17+Lklyh0E8SAxYYVTRG50o6lMdRAS8iq/oMyxSnubdzaZwy2wfql/OOdRQxZ+mpCeI7T9+aBA7t/Dau26oUs/JbGY99hlUoYqBSRoWiED3RJbwA16sR3RdOhWSJJh7W/h8CZ2aEhrmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GcfKFEV8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GcfKFEV8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsh1L4lzNz2yZ6
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Apr 2026 01:44:06 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775835842; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uzBjKauimcNkCmJqc+wHQN1oYZwt8Xn/+9mNyLG5eNY=;
	b=GcfKFEV89f6o66JOUAt5gFbqOLP5cb75vI8Mb4mUUC4izyX7dOGGz43qplr3TDEZCTh4RiECbUS3/ATB9CdOmUqOGSjJ7YIZAdN99sgMUmVNwxzurOziwdK+RA7YrdVLTdzGGVvowzPGhdGAMIuRAsIbwvDUIwYgl2E8UKHkR0k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X0lcA7z_1775835841;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0lcA7z_1775835841 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 23:44:01 +0800
Message-ID: <67764de1-3eb7-4e61-a382-d5f0bdcd3a30@linux.alibaba.com>
Date: Fri, 10 Apr 2026 23:44:01 +0800
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
Subject: Re: [PATCH v2] erofs-rs: fix inline xattr size for tail offsets
To: priyena.programming@gmail.com, linux-erofs@lists.ozlabs.org
References: <20260409154835.18533-1-priyena.programming@gmail.com>
 <20260410154136.16916-1-priyena.programming@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260410154136.16916-1-priyena.programming@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
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
	TAGGED_FROM(0.00)[bounces-3282-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:priyena.programming@gmail.com,m:linux-erofs@lists.ozlabs.org,m:priyenaprogramming@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 1180F3D9998
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Please submit PR directly to  Dreamacro/erofs-rs.

