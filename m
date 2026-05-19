Return-Path: <linux-erofs+bounces-3451-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNIaIVUgDGphWwUAu9opvQ
	(envelope-from <linux-erofs+bounces-3451-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 10:33:25 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723B857A2D8
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 10:33:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKSHW6Lvsz2yCM;
	Tue, 19 May 2026 18:18:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:192:486::2:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779178727;
	cv=none; b=JyN0z7enCk4BnaF9+CgU87bRL1oM+C8wJAxry8yc1QIMvPmxL1cZn71eS4R0ML+XqChwaof2ZTQumIN8ofTnXdyBQuMmmess2Fws35IWhH4taBS4cDs69h+brTBWELAVxPdmycE4z01YNEArwGCLO8wUzDsSLb4eN2pQtmrNEUvRUv8fAJZ1Zht2xKoeK2l/iVvx2Y8xCIGU5Kak5MjSE1ugTA62FLFraSv4CRWLqJMnkWXzoX7sFAGqBzPTWiuHHsDF91PlWEKWCGYWu08u0tIDP017ALMQ8313k3CAPfDHNhzOpgZ1JsmbNARyxHpxL1pPxc5B3fVpkUMuyDkUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779178727; c=relaxed/relaxed;
	bh=/V0uCcTkPx7SeLeHejwFFUsYezoJoa/+Lv/mTKKGzLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrEttdr7KbaFx7t8OUC30XWBs7U6a4lk7g8qka+3KfK7xy8C9+HaMeEsDtXuuJ2DpVfxPwY/qOQQZRsq5poPBBkP5hAbkTcDCV6WSRuWWXeRj7/WWZeQKBZNxaaFvNkG5cXc7MDHc1hJ2LgIhDpm7gtD5Jhu6hePi2TiVbaFDqNy8fsOfTCW8TV7HtkScskzzzV3mL4eGU1y90uC33t3MTHlnz28fGXuEqJVpN3Na1EipVcwXClSkDkByViXOJLdc52RoWlgLyeWsXp6FL5ZprCdKbESOSlE6wzvctJGMhinw7MoKcynk1NwaWlR3bmsy+EmKMmmShMAg2irsAO+TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; dkim=pass (3072-bit key; secure) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=jbVosT1Q; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:192:486::2:0; helo=hr2.samba.org; envelope-from=metze@samba.org; receiver=lists.ozlabs.org) smtp.mailfrom=samba.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (3072-bit key; secure) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=jbVosT1Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samba.org (client-ip=2a01:4f8:192:486::2:0; helo=hr2.samba.org; envelope-from=metze@samba.org; receiver=lists.ozlabs.org)
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKSHT4mF2z2xSG
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 18:18:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=/V0uCcTkPx7SeLeHejwFFUsYezoJoa/+Lv/mTKKGzLs=; b=jbVosT1QO1f9Cz7qpHgjMlsyf/
	4e27Lu3/yXnfG2P6cxGcZFyCuyo6R/904UuuUgS4YpJ9SpcrK09xs8RmAUB8yvVZSpm2BnuJjZjXQ
	936i/53btEChIGEzBwTVNoySMidn4LvxGErxmLtickMl2DJD0Ty/bBad3wzkC1iE3vApcipTdN9aK
	Dp4i/ehpjwITkuuSfxWmvIgsWl7c4j+2UMIhg2fm8hQr+6lYz7nXlTBvBda0Bib18j7XA4XdHgNbV
	+XToJwitaNLB6r8/e2M80jTehqcSgxK4OUJa5P6Pi3vpao16vZTTj75LFFEDnkKniXbTgrTgBCoC6
	+cZ9gRye8zmzFIBG6Q/QrRxhuwG56tHWzD+0ngfii4Uv3Mu00QUWhYNCnVVFDZdCckKT9JHvI4r5k
	9YA6FzYWJG6oV4jQbTGhVGUsheO0d3W2+mArrQatYOPM+FZ9TgK60aX7Iy44bEvyOpcBaYkGghQJs
	IxRS4vrPQQvJaKgUeUCku595;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wPFev-0000000A48T-2DUc;
	Tue, 19 May 2026 08:18:37 +0000
Message-ID: <682a2d95-60d7-4303-a9ea-7dbd16f20b48@samba.org>
Date: Tue, 19 May 2026 10:18:36 +0200
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
Subject: Re: [PATCH v2 12/21] cifs: Support ITER_BVECQ in
 smb_extract_iter_to_rdma()
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>
Cc: Paulo Alcantara <pc@manguebit.org>, Jens Axboe <axboe@kernel.dk>,
 Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
 Marc Dionne <marc.dionne@auristor.com>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shyam Prasad N <sprasad@microsoft.com>,
 Tom Talpey <tom@talpey.com>
References: <20260518222959.488126-1-dhowells@redhat.com>
 <20260518222959.488126-13-dhowells@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260518222959.488126-13-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [7.30 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[samba.org:s=42];
	TAGGED_FROM(0.00)[bounces-3451-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sprasad@microsoft.com,m:tom@talpey.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[metze@samba.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,microsoft.com,talpey.com];
	DMARC_POLICY_ALLOW(0.00)[samba.org,quarantine];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2404:9400:21b9:f100::1];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	ARC_ALLOW(0.00)[lists.ozlabs.org:s=201707:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,samba.org:mid,samba.org:dkim,talpey.com:email,infradead.org:email,manguebit.org:email,linux.dev:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 723B857A2D8
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Hi David,

> Add support for ITER_BVECQ to smb_extract_iter_to_rdma().
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org

Please cc me on this if you report.

Acked-by: Stefan Metzmacher <metze@samba.org>
if you change this in the commit message
cifs: to smbdirect: and smb_extract_iter_to_rdma to
smbdirect_map_sges_from_iter

Thanks!
metze


