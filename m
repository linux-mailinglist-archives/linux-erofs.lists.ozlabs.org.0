Return-Path: <linux-erofs+bounces-2431-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKkNFrHen2kxegQAu9opvQ
	(envelope-from <linux-erofs+bounces-2431-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 06:48:33 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679F1A1199
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 06:48:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM0qr6B7fz2yFc;
	Thu, 26 Feb 2026 16:48:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772084904;
	cv=none; b=VFxOznnm8LXDp4YjqJDnIGi1D7zJ5QpZjU6lLU0ZsnFJiEQCONFhyMzdGlqNmj6Lb+qX5x1R78Miakmv0UC3NYWSTjTIk4zNDbInmaer9J11JQxaH1YxYB14Zz+mnwXz6fUzoRdLfj8J6wxZ6GxGp45hp49LhTYgW1bRkjB7coGMb6uBfFuviIfU1IoU6Hd12WZCtPWnJcRzWrLzscrNAp1RKU4fuqGi713hd2NTDxIYZ1mKbY2dwNoXY8v/VTmuBQPYUldOP/d4bE1UdvyKkb6i3/hMWC+SrRD6LYav31mA9eRtfhfD9U9PNz7UTrvUdP78CXNKk7O6zxq9D7yyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772084904; c=relaxed/relaxed;
	bh=ER4yX50OmoQjWSP27sl4LnCf3N5gdaVBekgRs/O6vsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AXenRgTPcDDySNAh8JmvX+y+fooR76PO1BZ/AqbTGHTdfvygIJsy1ungiCVNAMRwL0fC9eN1t7oYBOV+EF0YBJtsZccV6QIjaUrGb1L5Fl7qaFjL96FwHKM9DlRHzCOGHeqtxKsE6G+Vnf8I0/shk8YOvPOr3KuiPjQgoLESjObyYfTRcSorNlG0va87C5YKE3bN3tekql3y2xrdxdb3Y9K3UTMF8LdFIzKBEUEDLShR3gi1UBAoxVHvehpr8NkXGanYGbtCGKmWKdoLJLfEpqKYtGRoDqAR0XZAc7reHiWQ9mrPVXHF4Eqf9vwDZ/4la3+tgxjor1NiUootpbky1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JvHeI9SD; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JvHeI9SD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM0qp3DJdz2x99
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 16:48:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772084894; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ER4yX50OmoQjWSP27sl4LnCf3N5gdaVBekgRs/O6vsc=;
	b=JvHeI9SDmtnny2WR9jYJi8f0eWgTsntdxh7Q7UKpGqY+VWxmSaJaEkdsTV5+ft+gQHnRQYuA0vBS1nFgUWuXJAU9doiuGVPYc6JjKVYDKbpG2nvz64rNMyQL8EIlufpBQXWHUi+79heId720M7eSrGuShCliz3gIjxbfrc02dMI=
Received: from 30.221.131.221(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzqE-N-_1772084892 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Feb 2026 13:48:13 +0800
Message-ID: <c8a12f01-bb30-4a43-988c-38f9ad103913@linux.alibaba.com>
Date: Thu, 26 Feb 2026 13:48:12 +0800
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
Subject: Re: [PATCH v2] erofs-utils: fsck: support extracting subtrees
To: Inseob Kim <inseob@google.com>, linux-erofs@lists.ozlabs.org
References: <20260226040024.3917012-1-inseob@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260226040024.3917012-1-inseob@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:inseob@google.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2431-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
X-Rspamd-Queue-Id: 6679F1A1199
X-Rspamd-Action: no action



On 2026/2/26 12:00, Inseob Kim wrote:
> Add --nid and --path options to fsck.erofs to allow users to check
> or extract specific sub-directories or files instead of the entire
> filesystem.
> 
> This is useful for targeted data recovery or verifying specific
> image components without the overhead of a full traversal.
> 
> Signed-off-by: Inseob Kim <inseob@google.com>
> 
> ---
> 
> v2: retrieve pnid correctly rather than pnid == nid hack

Applied to -experimental branch but could you update
the manpage as well as the next version?

Thanks,
Gao Xiang

