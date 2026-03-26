Return-Path: <linux-erofs+bounces-3044-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFSMMDdBxWkU8wQAu9opvQ
	(envelope-from <linux-erofs+bounces-3044-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 15:22:47 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C2F336B78
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 15:22:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhQwG322cz2xlM;
	Fri, 27 Mar 2026 01:22:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774534958;
	cv=none; b=QaWX/HRM5THgYMJdI36bC7vV+xECOj83TdL1XHjxTnG6awREfqU74lbD3ibzu8mg9btZbyH8WxBsmG5wpL9KEzR9waUVY0qXGoE6+wuwYI1k5DxsHKSQTj/9aTx32GPxizg7TgMN2V5f9zpOGeo6bgDglbkjSYd2iDvc8n3m7RziYdFmEVm1dqSNvN6OzyI5QrC7VlnYHebql5eoI3k4qsGZC7z7yRbcRC9PgCFLiw2LzJ/HdH8cAuKNk8yNX9nsvaSflHjlbr8/Ekp0GVZWMElvhA6fXbCHGB6Dt5xO7LcqQe8PxTffU9Cp/Eolxl83eQgSDZyWN1BTNr7+HJGmhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774534958; c=relaxed/relaxed;
	bh=4GuxjtBu05AKU6vPjLN91uKmiwjkBY146mMAHOLVBfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nv6+CajZAjz64A2IDZU1TIGKnK9KXW1dVg81Rzo4l74YO4QSxIinfnKn+AhrGDYyrKSubruQemtzQ3rOpBS/f6mlpoUnppQKHfkgPNUvG2zr2PX2NJd+MW9PbGOtSjEeuClY48aRADP1NnGiwumbB7LNdy/BVj7Tl5rqdesKdSWQznXkDNo/KXfo4vUmX8dz+doeRw+WxsmudQK2EvUCELBG6nJfOjA5N23QewBQ/CBcX1cKvNtFxPl0nB+eP+Et7QlzqQDvL5IkWq+PMldJMFM1iKMaILsxBJd4FJhoeBx+s5ji2NFlG4FAbM/sUbEw45u3SQd7YyqvyGJNKfKdPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; dkim=pass (2048-bit key; unprotected) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.a=rsa-sha256 header.s=key1 header.b=aD2KrMxB; dkim-atps=neutral; spf=pass (client-ip=95.215.58.179; helo=out-179.mta1.migadu.com; envelope-from=chenxiaosong@chenxiaosong.com; receiver=lists.ozlabs.org) smtp.mailfrom=chenxiaosong.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.a=rsa-sha256 header.s=key1 header.b=aD2KrMxB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chenxiaosong.com (client-ip=95.215.58.179; helo=out-179.mta1.migadu.com; envelope-from=chenxiaosong@chenxiaosong.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 104 seconds by postgrey-1.37 at boromir; Fri, 27 Mar 2026 01:22:32 AEDT
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhQw81Nfmz2xS5
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2026 01:22:31 +1100 (AEDT)
Message-ID: <fb437a64-efa3-4284-90b3-dfff336d533b@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1774534825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GuxjtBu05AKU6vPjLN91uKmiwjkBY146mMAHOLVBfo=;
	b=aD2KrMxBMNvi7eX45TA2mMPnX+OpNAsRXdHd2hO3Y/FZBxxBH4juI5vVj9+1384jX2gnWW
	MQPGoX8eqtIORxQI5B4Ffu5wMRWB5v2OcgFpWiZ3RhsK6Tb63jJk88FVFAudIdjgyf33hA
	6UkXPdeglJvj65t97hO8QwrZml/yDEshMJijI/PNewLz/zlvnGMwIU9AC+Po5l4ttxCAY6
	W1qK3KRu13XOG4HrKN9r2OojDhQrl3iVaVmlHgl5MUG9WBBU+HQ30KfkoAVoMa7ZiLHHhQ
	V6v5O4YDl0StX6YdsEymIsoVnNdyHbqS/9J2cGDJBsD9g0au0wN5KoI4+C2Ncg==
Date: Thu, 26 Mar 2026 22:19:27 +0800
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
Subject: Re: [PATCH 25/26] netfs: Limit the the minimum trigger for progress
 reporting
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>
Cc: Paulo Alcantara <pc@manguebit.com>, Jens Axboe <axboe@kernel.dk>,
 Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 Marc Dionne <marc.dionne@auristor.com>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-26-dhowells@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20260326104544.509518-26-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chenxiaosong.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3044-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[chenxiaosong@chenxiaosong.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[manguebit.com,kernel.dk,kernel.org,samba.org,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,manguebit.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:pc@manguebit.com,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pc@manguebit.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chenxiaosong.com:dkim,chenxiaosong.com:mid]
X-Rspamd-Queue-Id: 22C2F336B78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are two "the"s in the subject.

On 3/26/26 18:45, David Howells wrote:
> [PATCH 25/26] netfs: Limit the the ...



