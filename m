Return-Path: <linux-erofs+bounces-2442-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDANA6USoWlwqAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2442-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 04:42:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFB71B257A
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 04:42:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMZ011ySnz2xLv;
	Fri, 27 Feb 2026 14:42:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772163745;
	cv=none; b=c/9DdC+88fpEArtoddPHMQR6RFbFZODDOTyp/IHXtXxoSh4Bp9PvebUHybrtYqHtay8Xf3a6kW9RH+MqFgeVy6KCOKJA7qdmRuhQSDllZovzIeahthI1NapdKAFq9MuYi2I4EDFbNvlvEg4Og5Gq2D1MhZsc/t6wjLlwngl7tdekV5RxeofjMHkfX4hl7X46Lb/Rp9QglznLf3Qdy2BEjK3KU3MntAY0n7Zo8mG6+ZlRjUAf8il9P8PTIB49JZXDihv97lXnzBZjgVOgYuMAi72shw0myjuVVj6RthX0ezyfwH70yUDwUvmtXr8WwnlBDSGxLu6884H3OH0KoD8gxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772163745; c=relaxed/relaxed;
	bh=crOioJu6SFwPEaiEa8fpsovdT++/sxwD6/acncd5gFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMW1P8DuvoMwe5Xb44OpefJTfGGXyU+pPfet4AmC+zLfN36n1EpSVkpIoEjn8kVuGkIn9WsJrw5cChoFsiwc4C8eVzOdZrbxf8GNkUn99nntsCqL7oeq+Eh5TuHYuvHFm9AiTNRDpYEDze18qOaAGoMCQHkYkjbCsYeXFyTWEHQJW/PdrZ1iCvY1rct1LD81VIwCpl7gNwMaaiDlYbu33hAECJ2ZU3mhU5eqnviSKKQY5OV73hpM/bwzIxSKR2EWEvVxbsE23iJv+PnGweBOZ6gS86qHoQUZYPE9i4ICC+lLREvSA4xrx7r3FEiBwGGFqW7yIKDIeS5MPkseSGD2ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j09hpJS7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j09hpJS7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMZ001nJFz2xKh
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Feb 2026 14:42:23 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772163737; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=crOioJu6SFwPEaiEa8fpsovdT++/sxwD6/acncd5gFk=;
	b=j09hpJS7F8pCVSLwZGR7Xja8UeJtSN4UENHACqikPE+PBo+wjyEdYbI2hIfYr7gEgP7m76bd3ygKEmWTpPGLsFOwCSwO/bh1W5CyvR8TlIbVoDFl7xt4uDrvCSeBwa04Qsz5q5WP1zZj1uW29Qx3dcurMLvv5zNda9yPaer1atg=
Received: from 30.221.131.231(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wzss4rE_1772163736 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 11:42:17 +0800
Message-ID: <0fd7e92d-1d01-4ea8-82cf-8a9fad5cfb6d@linux.alibaba.com>
Date: Fri, 27 Feb 2026 11:42:16 +0800
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
Subject: Re: [PATCH 1/1] erofs-utils: mount: auto-detect platform for OCI
 recovery files
To: Chengyu <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: Chengyu Zhu <hudsonzhu@tencent.com>
References: <20260227033444.99576-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260227033444.99576-1-hudson@cyzhu.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2442-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hudson@cyzhu.com,m:linux-erofs@lists.ozlabs.org,m:hudsonzhu@tencent.com,s:lists@lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: DAFB71B257A
X-Rspamd-Action: no action



On 2026/2/27 11:34, Chengyu wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> erofsmount_write_recovery_oci() writes source->ocicfg.platform into
> recovery files directly, but it could be NULL when not explicitly
> configured, causing reattach failures.
> 
> Fix this by falling back to ocierofs_get_platform_spec().  Also
> refactor it to return a compile-time string literal instead of
> asprintf(), eliminating the need for callers to free() the result.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>

LGTM, will apply.

Thanks,
Gao Xiang

